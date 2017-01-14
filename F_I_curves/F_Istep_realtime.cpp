/*
 * RTXI module for generating F-I curves. Adapted from Istep.cpp by Eric Melonakos, 2011.
 * First set cell to -65 mV resting voltage by using current clamp in the
 * MultiClamp 700A software and then run this program for getting the desired
 * current range. Record the voltage output.
 */

#include <F_Istep_realtime.h>
#include <iostream>
#include <sstream>
     

extern "C" Plugin::Object *createRTXIPlugin(void) {
    return new F_Istep();
}

static DefaultGUIModel::variable_t vars[] = {
    {
        "Vin",
        "",
        DefaultGUIModel::INPUT, // input(0); doesn't really do anything in this case
    },
    {
        "Iout",
        "",
        DefaultGUIModel::OUTPUT, // output(0)
    },
    {
        "Delay (sec)",
        "How long to wait until the current steps start (default = 5)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Starting Current (pA)",
        "Size of the first current step (default = 10)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Finishing Current (pA)",
        "Size of the last current step (default = 150)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Increments",
        "Number of steps including the starting current and the finishing current, linearly spaced (default = 15)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::UINTEGER,
    },
    {
        "Pulse Duration (sec)",
        "How long each step should last (default = 0.5)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Pause Duration (sec)",
        "How long to wait after a step finishes before starting a new one (default = 5)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Offset (pA)",
        "DC offset to add (default = 0)",
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

F_Istep::F_Istep(void)
    : DefaultGUIModel("F_Istep",::vars,::num_vars), dt(RT::System::getInstance()->getPeriod()*1e-6),
      delay(10.0), starti(10.0), finishi(150.0), Nsteps(15), pulse_duration(1.0), pause_duration(10.0), offset(0.0) {

      createGUI( vars, num_vars ); // Added for new version of RTXI, builds GUI

    //This is for recording
      cols = 3;
      acquire = 1;
      maxt = 180;
      prefix = "fi_curves";
      info = "no comment";
      path  = "/home/eric/Dropbox/Documents/School/rtxi/Modules/F_I_curves/data/";
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



F_Istep::~F_Istep(void) {}



void F_Istep::execute(void) {
    V = input(0);

    //Do all time keeping in seconds.
    if (step <= Nsteps) {
        if (age > delay && age <= delay + step * (pulse_duration + pause_duration) - pause_duration) {
            Iout = offset + starti + (step - 1.0) * deltaI;
        }
        else if (age > delay + step * (pulse_duration + pause_duration)) {
            step++;
            if (step > Nsteps) {
            Iout = offset;
            }
            else {
            Iout = offset + starti + (step - 1.0) * deltaI;
            }
        }
        else {
            Iout = offset;
        }
    }
    age += dt / 1000.0;

    output(0) = Iout * 1e-12; // output current is in pA

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



void F_Istep::update(DefaultGUIModel::update_flags_t flag) 
{
    switch(flag) {
        case INIT:
            setParameter("Delay (sec)",delay);
            setParameter("Starting Current (pA)",starti);
            setParameter("Finishing Current (pA)",finishi);
            setParameter("Increments",Nsteps);
            setParameter("Pulse Duration (sec)",pulse_duration);
            setParameter("Pause Duration (sec)",pause_duration);
            setParameter("Offset (pA)",offset);
            break;
        case MODIFY:
            delay          = getParameter("Delay (sec)").toDouble();
            starti         = getParameter("Starting Current (pA)").toDouble();
            finishi        = getParameter("Finishing Current (pA)").toDouble();
            Nsteps         = getParameter("Increments").toUInt();
            pulse_duration = getParameter("Pulse Duration (sec)").toDouble();
            pause_duration = getParameter("Pause Duration (sec)").toDouble();
            offset         = getParameter("Offset (pA)").toDouble();

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

    if (delay < 0.0) {
        delay = 0.0;
        setParameter("Delay (sec)",delay);
    }

    if (Nsteps < 0) {
        Nsteps = 1;
        setParameter("Increments",Nsteps);
    }

    if (pulse_duration < 0.0) {
        pulse_duration = 0.5;
        setParameter("Pulse Duration (sec)",pulse_duration);
    }

    if (pause_duration < 0.0) {
        pause_duration = 5.0;
        setParameter("Pause Duration (sec)",pause_duration);
    }

    //Define deltaI based on params
    if (Nsteps > 1) {
       deltaI = (finishi-starti)/(Nsteps-1);
    } else {
       deltaI = starti;
    }
    
    //Initialize counters
    age   = 0.0;
    step  = 1.0;
}
