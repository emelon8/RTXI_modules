/*
 * RTXI module for generating voltage clamp experiments. Adapted from activation_inactivation_realtime.cpp by Eric Melonakos, 2014.
 * First set cell to a resting voltage, then to a range of prestep voltages, and finally to a step voltage.
 * Works with the MultiClamp 700B amplifier.
 */

#include <ion_species_realtime.h>
#include <iostream>
#include <sstream>


extern "C" Plugin::Object *createRTXIPlugin(void) {
    return new  ion_species_realtime();
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
        "Prestep Voltage (mV)",
        "The voltage to clamp the cell to during the prestep (default = 50)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Prestep Time (sec)",
        "How long the activation step lasts (default = 180)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Starting Step Voltage (mV)",
        "The voltage to clamp the cell to during the starting step (default = 50)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Finishing Step Voltage (mV)",
        "The voltage to clamp the cell to during the finishing step (default = -20)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Increments",
        "How many total increments from the first to the last step voltage? (default = 15)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::UINTEGER,
    },
    {
        "Step Time (sec)",
        "How long the step lasts (default = 5)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Pause Time (sec)",
        "How long to pause between activation steps (default = 180)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Acquire?",
        "0 or 1",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::UINTEGER,
    },
    {
        "Record Length (sec)",
        "Length of Data Record, in seconds, to record",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Cell (#)",
        "",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::INTEGER,
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

ion_species_realtime::ion_species_realtime(void)
    : DefaultGUIModel("ion_species_realtime",::vars,::num_vars), dt(RT::System::getInstance()->getPeriod()*1e-6),
      prestep_V(50), prestep_t(180.0), starting_step_V(50), finishing_step_V(-20), increments(15), step_t(5), pause_t(180) {

      createGUI( vars, num_vars ); // Added for new version of RTXI, builds GUI

    //This is for recording
      cols = 3;
      acquire = 1;
      maxt = 15;
      prefix = "ion_species";
      info = "no comment";
      path  = "/home/eric/Dropbox/Documents/School/rtxi/Modules/characterize_current/ion_species/data/";
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



ion_species_realtime::~ion_species_realtime(void) {}



void ion_species_realtime::execute(void) {
    I = input(0);

    //Do all time keeping in seconds.
    if (step <= increments) {
        if (age >= (step * (pause_t + prestep_t+step_t))) {
            Vout = 0;
            step++;
        }
        else if (age < (step * (pause_t + prestep_t + step_t) - (prestep_t + step_t))) {  // The voltage during the prestep
            Vout = 0;
        }
        else if ((age < (step * (pause_t + prestep_t + step_t) - step_t)) && (age >= (step * (pause_t + prestep_t + step_t) - (prestep_t + step_t)))) {  // The voltage during the activation step
                Vout = prestep_V;
        }
        else {
            Vout = starting_step_V + (step - 1) * deltaV;
        }
    }
    else {
        Vout = 0;
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

        }
        else if (acquire && tcnt > maxt) {
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



void ion_species_realtime::update(DefaultGUIModel::update_flags_t flag) 
{
    switch(flag) {
        case INIT:
            setParameter("Prestep Voltage (mV)",prestep_V);
            setParameter("Prestep Time (sec)",prestep_t);
            setParameter("Starting Step Voltage (mV)",starting_step_V);
            setParameter("Finishing Step Voltage (mV)",finishing_step_V);
            setParameter("Increments",increments);
            setParameter("Step Time (sec)",step_t);
            setParameter("Pause Time (sec)",pause_t);
            break;
        case MODIFY:
            prestep_V        = getParameter("Prestep Voltage (mV)").toDouble();
            prestep_t        = getParameter("Prestep Time (sec)").toDouble();
            starting_step_V  = getParameter("Starting Step Voltage (mV)").toDouble();
            finishing_step_V = getParameter("Finishing Step Voltage (mV)").toDouble();
            increments       = getParameter("Increments").toUInt();
            step_t           = getParameter("Step Time (sec)").toDouble();
            pause_t          = getParameter("Pause Time (sec)").toDouble();

            // data acquisition
            maxt = getParameter ("Record Length (sec)").toDouble();
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

    if (prestep_t < 0) {
        prestep_t = 1;
        setParameter("Prestep Time (sec)",prestep_t);
    }

    if (step_t < 0) {
        step_t = 1;
        setParameter("Step Time (sec)",step_t);
    }

    if (pause_t < 0) {
        pause_t = 1;
        setParameter("Pause Time (sec)",pause_t);
    }

    //Define deltaV based on params
    if (increments > 1) {
       deltaV = (finishing_step_V - starting_step_V) / (increments - 1);
    }
    else {
       deltaV = (finishing_step_V - starting_step_V);
    }

    //Initialize counters
    age        = 0;
    step       = 1;
}
