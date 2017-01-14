/*
 * RTXI module for generating voltage clamp experiments. Adapted from V_clamp_resistance_realtime.cpp by Eric Melonakos, 2014.
 * First set cell to a resting voltage, then to a range of prestep voltages, and finally to a step voltage.
 * Works with the MultiClamp 700B amplifier.
 */

#include <activation_inactivation_realtime.h>
#include <iostream>
#include <sstream>


extern "C" Plugin::Object *createRTXIPlugin(void) {
    return new activation_inactivation_realtime();
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
        "Activation Step Starting Voltage (mV)",
        "The starting voltage to clamp the cell to in order to find the activation curve (default = 10)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Activation Step Finishing Voltage (mV)",
        "The finishing voltage to clamp the cell to in order to find the activation curve (default = 50)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Increments",
        "How many total increments from the first to the last prestep voltage? (default = 9)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::UINTEGER,
    },
    {
        "Activation Step Time (sec)",
        "How long the activation step lasts (default = 180)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Inactivation Step Voltage (mV)",
        "The voltage that it steps to in order to find the inactivation curve (default = 50)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Inactivation Step Time (sec)",
        "How long the inactivation step lasts (default = 5)",
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

activation_inactivation_realtime::activation_inactivation_realtime(void)
    : DefaultGUIModel("activation_inactivation_realtime",::vars,::num_vars), dt(RT::System::getInstance()->getPeriod()*1e-6),
      activation_step_starting_V(10.0), activation_step_finishing_V(50.0), increments(9), activation_step_t(180), inactivation_step_V(50.0), inactivation_step_t(5), pause_t(180) {

      createGUI( vars, num_vars ); // Added for new version of RTXI, builds GUI

    //This is for recording
      cols = 3;
      acquire = 1;
      maxt = 15;
      prefix = "activation_inactivation";
      info = "no comment";
      path  = "/home/eric/Dropbox/Documents/School/rtxi/Modules/characterize_current/activation_inactivation/data/";
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



activation_inactivation_realtime::~activation_inactivation_realtime(void) {}



void activation_inactivation_realtime::execute(void) {
    I = input(0);

    //Do all time keeping in seconds.
    if (step <= increments) {
        if (age >= (step * (pause_t + activation_step_t+inactivation_step_t))) {
            Vout = 0;
            step++;
        }
        else if (age < (step * (pause_t + activation_step_t + inactivation_step_t) - (activation_step_t + inactivation_step_t))) {  // The voltage during the prestep
            Vout = 0;
        }
        else if ((age < (step * (pause_t + activation_step_t + inactivation_step_t) - inactivation_step_t)) && (age >= (step * (pause_t + activation_step_t + inactivation_step_t) - (activation_step_t + inactivation_step_t)))) {  // The voltage during the activation step
                Vout = activation_step_starting_V + (step - 1) * deltaV;
        }
        else {
            Vout = inactivation_step_V;
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



void activation_inactivation_realtime::update(DefaultGUIModel::update_flags_t flag) 
{
    switch(flag) {
        case INIT:
            setParameter("Activation Step Starting Voltage (mV)",activation_step_starting_V);
            setParameter("Activation Step Finishing Voltage (mV)",activation_step_finishing_V);
            setParameter("Increments",increments);
            setParameter("Activation Step Time (sec)",activation_step_t);
            setParameter("Inactivation Step Voltage (mV)",inactivation_step_V);
            setParameter("Inactivation Step Time (sec)",inactivation_step_t);
            setParameter("Pause Time (sec)",pause_t);
            break;
        case MODIFY:
            activation_step_starting_V  = getParameter("Activation Step Starting Voltage (mV)").toDouble();
            activation_step_finishing_V = getParameter("Activation Step Finishing Voltage (mV)").toDouble();
            increments                  = getParameter("Increments").toUInt();
            activation_step_t           = getParameter("Activation Step Time (sec)").toDouble();
            inactivation_step_V         = getParameter("Inactivation Step Voltage (mV)").toDouble();
            inactivation_step_t         = getParameter("Inactivation Step Time (sec)").toDouble();
            pause_t                     = getParameter("Pause Time (sec)").toDouble();

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

    if (activation_step_t < 0) {
        activation_step_t = 1;
        setParameter("Activation Step Time (sec)",activation_step_t);
    }

    if (inactivation_step_t < 0) {
        inactivation_step_t = 1;
        setParameter("Inactivation Step Time (sec)",inactivation_step_t);
    }

    //Define deltaV based on params
    if (increments > 1) {
       deltaV = (activation_step_finishing_V - activation_step_starting_V) / (increments - 1);
    }
    else {
       deltaV = (activation_step_finishing_V - activation_step_starting_V);
    }

    //Initialize counters
    age        = 0;
    step       = 1;
}
