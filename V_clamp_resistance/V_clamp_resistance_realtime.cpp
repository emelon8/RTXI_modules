/*
 * RTXI module for generating voltage clamp experiments. Adapted from V_step_realtime.cpp by Eric Melonakos, 2013.
 * First set cell to a resting voltage, then to a range of prestep voltages, and finally to a step voltage.
 * Works with the MultiClamp 700B amplifier.
 */

#include <V_clamp_resistance_realtime.h>
#include <iostream>
#include <sstream>
     

extern "C" Plugin::Object *createRTXIPlugin(void) {
    return new V_clamp_resistance();
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
        "The last voltage prestep value (default = -60)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Increments",
        "How many total increments from the first to the last prestep voltage? (default = 11)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::UINTEGER,
    },
    {
        "Step Voltage (mV)",
        "The voltage to step to after the prestep (default = -60)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Resistance Pulse Voltage (mV)",
        "The voltage that it steps to during the resistance pulse (default = -65)",
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
        "Resistance Pulse Time (sec)",
        "How long does each resistance pulse last? (default = 0.001)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Resistance Pause Time (sec)",
        "How long does each resistance pulse last? (default = 0.001)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Number of Resistance Pulses",
        "How many resistance pulses are there? (default = 3)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::UINTEGER,
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

V_clamp_resistance::V_clamp_resistance(void)
    : DefaultGUIModel("V_clamp_resistance",::vars,::num_vars), dt(RT::System::getInstance()->getPeriod()*1e-6),
      start_V(-70.0), prestep_V1(-90), prestep_V2(-60), Nsteps(11), step_V(-60), resis_V(-65), start_t(2), prestep_t(2), step_t(2), resis_pulse_t(0.05), resis_pause_t(0.05), Nresis(3) {

      createGUI( vars, num_vars ); // Added for new version of RTXI, builds GUI

    //This is for recording
      cols = 3;
      acquire = 1;
      maxt = 15;
      prefix = "v_clamp_resistance";
      info = "no comment";
      path  = "/home/eric/Dropbox/Documents/School/rtxi/Modules/V_clamp_resistance/data/";
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



V_clamp_resistance::~V_clamp_resistance(void) {}



void V_clamp_resistance::execute(void) {
    I = input(0);

    //Do all time keeping in seconds.
    if (step <= Nsteps) {
        if (age >= (start_t + step * (prestep_t + step_t))) {
            Vout = prestep_V1 + step * deltaV;
            step++;
            resis_step=1;
        }
        else if (age < start_t) {  // The voltage at the very beginning of the trial
            Vout = start_V;
        }
        else if (age < (start_t + step * (prestep_t + step_t) - step_t)) {  // The voltage during the prestep
            Vout = prestep_V1 + (step - 1) * deltaV;
        }
        else if ((age < (start_t + step * (prestep_t + step_t))) && (resis_step <= Nresis)) {  // The voltage during the step, including the resistance test pulses
            if (age < (start_t + step * (prestep_t + step_t) - step_t + resis_step * (resis_pulse_t + resis_pause_t) - resis_pulse_t)) { // The voltage during the step
                Vout = step_V;
                }
            else if (age < (start_t + step * (prestep_t + step_t) - step_t + resis_step * (resis_pulse_t + resis_pause_t))) { // The voltage during the resistance tests
                Vout = resis_V;
                }
            else {
                Vout = step_V;
                resis_step++;
                }
        }
        else {
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



void V_clamp_resistance::update(DefaultGUIModel::update_flags_t flag) 
{
    switch(flag) {
        case INIT:
            setParameter("Starting Voltage (mV)",start_V);
            setParameter("First Prestep Voltage (mV)",prestep_V1);
            setParameter("Last Prestep Voltage (mV)",prestep_V2);
            setParameter("Increments",Nsteps);
            setParameter("Step Voltage (mV)",step_V);
            setParameter("Resistance Pulse Voltage (mV)",resis_V);
            setParameter("Starting Time (sec)",start_t);
            setParameter("Prestep Time (sec)",prestep_t);
            setParameter("Step Time (sec)",step_t);
            setParameter("Resistance Pulse Time (sec)",resis_pulse_t);
            setParameter("Resistance Pause Time (sec)",resis_pause_t);
            setParameter("Number of Resistance Pulses",Nresis);
            break;
        case MODIFY:
            start_V       = getParameter("Starting Voltage (mV)").toDouble();
            prestep_V1    = getParameter("First Prestep Voltage (mV)").toDouble();
            prestep_V2    = getParameter("Last Prestep Voltage (mV)").toDouble();
            Nsteps        = getParameter("Increments").toUInt();
            step_V        = getParameter("Step Voltage (mV)").toDouble();
            resis_V       = getParameter("Resistance Pulse Voltage (mV)").toDouble();
            start_t       = getParameter("Starting Time (sec)").toDouble();
            prestep_t     = getParameter("Prestep Time (sec)").toDouble();
            step_t        = getParameter("Step Time (sec)").toDouble();
            resis_pulse_t = getParameter("Resistance Pulse Time (sec)").toDouble();
            resis_pause_t = getParameter("Resistance Pause Time (sec)").toDouble();
            Nresis        = getParameter("Number of Resistance Pulses").toUInt();

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

    if (step_t < Nresis * (resis_pulse_t + resis_pause_t)) {
        step_t = Nresis * (resis_pulse_t + resis_pause_t);
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
    age        = 0;
    step       = 1;
    resis_step = 1;
}
