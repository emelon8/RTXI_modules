/*
 * RTXI module for generating voltage clamp experiments. Adapted from V_clamp_resistance_realtime.cpp by Eric Melonakos, 2014.
 * First set cell to a resting voltage, then to a range of prestep voltages, and finally to a step voltage.
 * Works with the MultiClamp 700B amplifier.
 */

#include <recovery_time_realtime.h>
#include <iostream>
#include <sstream>
#include <math.h>


extern "C" Plugin::Object *createRTXIPlugin(void) {
    return new recovery_time_realtime();
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
        "Pulse Voltage (mV)",
        "The voltage to clamp the cell to in order to inactivate the current (default = 50)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    
    {
        "Pulse Time (sec)", // This is the one you change to see how different voltages effect it
        "How long to pulse in order to inactivate the current (default = 20)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Recovery Voltage (mV)",
        "The voltage to clamp the cell to in order to recover the current (default = 0)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Starting Recovery Time (sec)",
        "The length of the first recovery time period (default = 0.05)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Increments",
        "How many total increments, including the starting recovery time, increasing by 2x each step? (default = 10)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::UINTEGER,
    },
    {
        "Recovery Pulse Voltage (mV)",
        "Voltage to pulse to in order to see how much current has been recovered (default = 50)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Recovery Pulse Time (sec)",
        "How long to pulse in order to see how much current has been recovered (default = 5)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Pause Voltage (mV)",
        "The voltage to clamp the cell to during the pause between the recovery pulse and the inactivating pulse (default = 0)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Pause Time (sec)",
        "How long to pause between the recovery pulse and the inactivating pulse (default = 20)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Acquire?",
        "0 or 1",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::UINTEGER,
    },
    {
        "Record Length (sec)", // 505 seconds with default parameters
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

recovery_time_realtime::recovery_time_realtime(void)
    : DefaultGUIModel("recovery_time_realtime",::vars,::num_vars), dt(RT::System::getInstance()->getPeriod()*1e-6),
      pulse_V(50), pulse_t(20), recovery_V(0), starting_recovery_t(0.05), increments(10), recovery_pulse_V(50), recovery_pulse_t(5), pause_V(0), pause_t(20) {

      createGUI( vars, num_vars ); // Added for new version of RTXI, builds GUI

    //This is for recording
      cols = 3;
      acquire = 1;
      maxt = 15;
      prefix = "recovery_time";
      info = "no comment";
      path  = "/home/eric/Dropbox/Documents/School/rtxi/Modules/characterize_current/recovery_time/data/";
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



recovery_time_realtime::~recovery_time_realtime(void) {}



void recovery_time_realtime::execute(void) {
    I = input(0);

    //Do all time keeping in seconds.
    if (step <= increments) {
        if (age >= (step * (pause_t + pulse_t + recovery_pulse_t) + total_recovery)) {
            Vout = pause_V;
            step++;
            total_recovery+=starting_recovery_t*pow(2,step-1);
        }
        else if (age < (step * (pause_t + pulse_t + recovery_pulse_t) + total_recovery - (starting_recovery_t*pow(2,step-1) + recovery_pulse_t + pulse_t))) {  // The voltage during the pause
            Vout = pause_V;
        }
        else if ((age < (step * (pause_t + pulse_t + recovery_pulse_t) + total_recovery - (starting_recovery_t*pow(2,step-1) + recovery_pulse_t))) && (age >= (step * (pause_t + pulse_t + recovery_pulse_t) + total_recovery - (starting_recovery_t*pow(2,step-1) + recovery_pulse_t + pulse_t)))) {  // The voltage during the pulse
                Vout = pulse_V;
        }
        else if ((age < (step * (pause_t + pulse_t + recovery_pulse_t) + total_recovery - recovery_pulse_t)) && (age >= (step * (pause_t + pulse_t + recovery_pulse_t) + total_recovery - (starting_recovery_t*pow(2,step-1) + recovery_pulse_t)))) {  // The voltage during the recovery period
                Vout = recovery_V;
        }
        else {
            Vout = recovery_pulse_V; // The voltage during the recovery pulse
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



void recovery_time_realtime::update(DefaultGUIModel::update_flags_t flag) 
{
    switch(flag) {
        case INIT:
            setParameter("Pulse Voltage (mV)",pulse_V);
            setParameter("Pulse Time (sec)",pulse_t);
            setParameter("Recovery Voltage (mV)",recovery_V);
            setParameter("Starting Recovery Time (sec)",starting_recovery_t);
            setParameter("Increments",increments);
            setParameter("Recovery Pulse Voltage (mV)",recovery_pulse_V);
            setParameter("Recovery Pulse Time (sec)",recovery_pulse_t);
            setParameter("Pause Voltage (mV)",pause_V);
            setParameter("Pause Time (sec)",pause_t);
            break;
        case MODIFY:
            pulse_V             = getParameter("Pulse Voltage (mV)").toDouble();
            pulse_t             = getParameter("Pulse Time (sec)").toDouble();
            recovery_V          = getParameter("Recovery Voltage (mV)").toDouble();
            starting_recovery_t = getParameter("Starting Recovery Time (sec)").toDouble();
            increments          = getParameter("Increments").toUInt();
            recovery_pulse_V    = getParameter("Recovery Pulse Voltage (mV)").toDouble();
            recovery_pulse_t    = getParameter("Recovery Pulse Time (sec)").toDouble();
            pause_V             = getParameter("Pause Voltage (mV)").toDouble();
            pause_t             = getParameter("Pause Time (sec)").toDouble();

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

    //Initialize counters
    age            = 0;
    step           = 1;
    total_recovery = starting_recovery_t;
}
