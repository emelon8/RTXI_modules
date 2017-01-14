/*
 * RTXI module for generating F-I curves. Adapted from F_Istep_realtime.cpp by Eric Melonakos, 2013.
 * First set cell to -65 mV resting voltage by using current clamp in the
 * MultiClamp 700A software and then run this program for getting the desired
 * current range. Record the voltage output.
 */

#include <effecttime2_realtime.h>
#include <iostream>
#include <sstream>
     

extern "C" Plugin::Object *createRTXIPlugin(void) {
    return new effecttime2();
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
        "How long to wait until the current steps start (default = 2)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Initial Pulse (pA)",
        "Size of the first current step (default = 50)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Hyperpolarizing Pulse (pA)",
        "Size of the hyperpolarizing current step (default = -100)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Pulse Length (sec)",
        "How long each step should last (default = 10)",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Pause Length (sec)",
        "How long the pause should last (default = 1)",
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

effecttime2::effecttime2(void)
    : DefaultGUIModel("effecttime2",::vars,::num_vars), dt(RT::System::getInstance()->getPeriod()*1e-6),
      delay(2.0), initial_pulse(50.0), hyperpolarizing_pulse(-100.0), pulse_length(10.0), pause(1.0) {

      createGUI( vars, num_vars ); // Added for new version of RTXI, builds GUI

    //This is for recording
      cols = 3;
      acquire = 1;
      maxt = 180;
      prefix = "effecttime2";
      info = "no comment";
      path  = "/home/eric/Dropbox/Documents/School/rtxi/Modules/effecttime2/data/";
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



effecttime2::~effecttime2(void) {}



void effecttime2::execute(void) {
    V = input(0);

    //Do all time keeping in seconds.
    if ((age > delay) && (age <= delay + pulse_length)) {
        Iout = initial_pulse;
    }
    else if (age > delay + pulse_length && age <= delay + pulse_length + pause) {
        Iout = hyperpolarizing_pulse;
    }
    else if (age > delay + pulse_length + pause && age <= delay + 2 * pulse_length + pause) {
        Iout = initial_pulse;
    }
    else {
        Iout = 0;
    }

    age += dt / 1000;

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



void effecttime2::update(DefaultGUIModel::update_flags_t flag) 
{
    switch(flag) {
        case INIT:
            setParameter("Delay (sec)",delay);
            setParameter("Initial Pulse (pA)",initial_pulse);
            setParameter("Hyperpolarizing Pulse (pA)",hyperpolarizing_pulse);
            setParameter("Pulse Length (sec)",pulse_length);
            setParameter("Pause Length (sec)",pause);
            break;
        case MODIFY:
            delay                 = getParameter("Delay (sec)").toDouble();
            initial_pulse         = getParameter("Initial Pulse (pA)").toDouble();
            hyperpolarizing_pulse = getParameter("Hyperpolarizing Pulse (pA)").toDouble();
            pulse_length          = getParameter("Pulse Length (sec)").toDouble();
            pause                 = getParameter("Pause Length (sec)").toDouble();

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

    if (delay < 0) {
        delay = 0;
        setParameter("Delay (sec)",delay);
    }
    
    //Initialize counters
    age        = 0;
}
