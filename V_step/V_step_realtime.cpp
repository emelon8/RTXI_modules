/*
 * RTXI module for generating voltage clamp experiments. Adapted from F_Istep_realtime.cpp by Eric Melonakos, 2012.
 * First set cell to a resting voltage, then to a range of prestep voltages, and finally to a step voltage.
 * Works with the MultiClamp 700B amplifier.
 */

#include <V_step_realtime.h>
#include <iostream>
#include <sstream>
     

extern "C" Plugin::Object *createRTXIPlugin(void) {
    return new V_step();
}

static DefaultGUIModel::variable_t vars[] = {
    {
        "Iin",
        "",
        DefaultGUIModel::INPUT, // input(0); doesn't really do anything in this case
    },
    {
        "Vout",
        "",
        DefaultGUIModel::OUTPUT, // output(0)
    },
    {
        "Starting Voltage (mV)",
        "The starting voltage to clamp the cell to (default = -70)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "First Prestep Voltage (mV)",
        "The first voltage prestep value (default = -90)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Last Prestep Voltage (mV)",
        "The last voltage prestep value (default = 10)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Increments",
        "How many total increments from the first to the last prestep voltage? (default = 11)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::UINTEGER,
    },
    {
        "Step Voltage (mV)",
        "The voltage to step to after the prestep (default = 0)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Starting Time (sec)",
        "How long the starting voltage lasts (default = 2)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Prestep Time (sec)",
        "How long each step should last (default = 1)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Step Time (sec)",
        "How long does the step last? (default = 1)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Acquire?",
        "0 or 1",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Record Length (sec)",
        "Length of Data Record, in seconds, to record",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Cell (#)",
        "",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "File Prefix",
        "",
        DefaultGUIModel::PARAMETER,
    },
    {
        "File Info",
        "",
        DefaultGUIModel::PARAMETER
    },
    {
        "Percent Done",
        "",
        DefaultGUIModel::STATE | DefaultGUIModel::DOUBLE,
    },
};

static size_t num_vars = sizeof(vars)/sizeof(DefaultGUIModel::variable_t);

V_step::V_step(void)
    : DefaultGUIModel("V_step",::vars,::num_vars), dt(RT::System::getInstance()->getPeriod()*1e-6),
      start_V(-70.0), prestep_V1(-90), prestep_V2(10), Nsteps(11), step_V(0.0), start_t(2.0), prestep_t(1.0), step_t(1.0) {

      createGUI( vars, num_vars ); // Added for new version of RTXI, builds GUI

    //This is for recording
      cols = 3;
      acquire = 1;
      maxt = 180;
      prefix = "v_step";
      info = "no comment";
      path  = "/home/eric/Dropbox/Documents/School/rtxi/Modules/V_step/data/";
      cellnum = 1;
      pdone = 0;

      tcnt = 0.0;

      data = new RealTimeLogger((int)(((maxt*1000)/dt)*cols), cols, path);
      data->newcell(cellnum);
      data->setDSRate(1);
      data->setPrint(1);


      setParameter("Record Length (sec)",maxt);
      setParameter("Acquire?",acquire);
      setParameter("Cell (#)",cellnum);
      setParameter("File Prefix", prefix);
      setParameter("File Info", info);
      setState("Percent Done", pdone);

    update(INIT);
    refresh();
}



V_step::~V_step(void) {}



void V_step::execute(void) {
    I = input(0);

    //Do all time keeping in seconds.
    if (step <= Nsteps) {
        if (age >= (step * (start_t + prestep_t + step_t))) {
            step++;
        }
        else if (age < (step * (start_t + prestep_t + step_t) - (prestep_t + step_t))) {
            Vout = start_V;
        }
        else if (age < (step * (start_t + prestep_t + step_t) - step_t)) {
            Vout = prestep_V1 + (step - 1) * deltaV;
        }
        else {               // else if (age < step * (start_t + prestep_t + step_t)) {
            Vout = step_V;
        }
    }
    else {
        Vout = start_V;
        
    }

    age += dt / 1000;

    output(0) = Vout * 1e-3; // output voltage is in mV

    // Also for data recording
        if (acquire && tcnt < maxt) {

            data->insertdata(tcnt);
            data->insertdata(input(0));
            data->insertdata(output(0));

            tcnt += dt / 1000.0;
            pdone = (tcnt / maxt * 100);

        } else if (acquire && tcnt > maxt) {
            // set counters to 0 before the RT-breaking writebuffer
            tcnt = 0;
            acquire = 0;
            cout << "End of trial" << endl;


            data->writebuffer(prefix, info);
            cout << "Buffer written" << endl;
            data->resetbuffer();
            cout << "Buffer reset" << endl;

            // setParameter("Acquire?", 0.0);
        //      refresh();
        }
}



void V_step::update(DefaultGUIModel::update_flags_t flag) 
{
    switch(flag) {
        case INIT:
            setParameter("Starting Voltage (mV)",start_V);
            setParameter("First Prestep Voltage (mV)",prestep_V1);
            setParameter("Last Prestep Voltage (mV)",prestep_V2);
            setParameter("Increments",Nsteps);
            setParameter("Step Voltage (mV)",step_V);
            setParameter("Starting Time (sec)",start_t);
            setParameter("Prestep Time (sec)",prestep_t);
            setParameter("Step Time (sec)",step_t);
            break;
        case MODIFY:
            start_V      = getParameter("Starting Voltage (mV)").toDouble();
            prestep_V1   = getParameter("First Prestep Voltage (mV)").toDouble();
            prestep_V2   = getParameter("Last Prestep Voltage (mV)").toDouble();
            Nsteps       = getParameter("Increments").toInt();
            step_V       = getParameter("Step Voltage (mV)").toDouble();
            start_t      = getParameter("Starting Time (sec)").toDouble();
            prestep_t    = getParameter("Prestep Time (sec)").toDouble();
            step_t       = getParameter("Step Time (sec)").toDouble();

            // data acquisition
            maxt = getParameter ("Record Length (sec)").toDouble ();
            acquire = getParameter ("Acquire?").toUInt();
            tempcell = getParameter ("Cell (#)").toInt();
            prefix = getParameter ("File Prefix").data();
            info = getParameter ("File Info").data();

            data->deleteBuffer();
            data->setBufferLen((int)((maxt*1000)/dt*cols));
            if (tempcell != cellnum) {
                data->newcell(tempcell);
                cellnum=tempcell;
            }
          
            cout << "maxt: " << maxt << " dt: " << dt << " #cols: " << cols << endl;

            // reset time counter
            tcnt = 0.0;

            break;
        case PAUSE:
            output(0) = 0;
        case PERIOD:
            dt = RT::System::getInstance()->getPeriod()*1e-6; // in ms
        default:
            break;
    }

    // Some Error Checking

    if (start_t < 0) {
        start_t = 0;
        setParameter("Delay (sec)",start_t);
    }

    if (prestep_t < 0) {
        prestep_t = 1;
        setParameter("Prestep Time (sec)",prestep_t);
    }

    if (step_t < 0) {
        step_t = 1;
        setParameter("Step Time (sec)",step_t);
    }

    //Define deltaV based on params
    if (Nsteps > 1) {
       deltaV = (prestep_V2 - prestep_V1) / (Nsteps - 1);
    }
    else {
       deltaV = (prestep_V2 - prestep_V1);
    }

    //Initialize counters
    age   = 0;
    step  = 1;
}
