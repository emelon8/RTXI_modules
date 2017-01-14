/*
 * RTXI module for generating F-I curves. Adapted from Istep.cpp by Eric Melonakos, 2011.
 * First set cell to -65 mV resting voltage by using current clamp in the
 * MultiClamp 700A software and then run this program for getting the desired
 * current range. Record the voltage output.
 */

#include <F_Istep.h>
     

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
};

static size_t num_vars = sizeof(vars)/sizeof(DefaultGUIModel::variable_t);

F_Istep::F_Istep(void)
    : DefaultGUIModel("F_Istep",::vars,::num_vars), dt(RT::System::getInstance()->getPeriod()*1e-6),
      starti(10.0), finishi(150.0), Nsteps(15), pulse_duration(0.5), pause_duration(5), offset(0.0) {


    update(INIT);
    refresh();
}




F_Istep::~F_Istep(void) {}




void F_Istep::execute(void) {
    V = input(0);

    //Do all time keeping in seconds.
    if (step <= Nsteps) {
        if (age <= step * (pulse_duration + pause_duration) - pause_duration) {
            Iout = offset + starti + (step - 1) * deltaI;
        }
        else if (age > step * (pulse_duration + pause_duration)) {
            step++;
        }
        else {
            Iout = offset;
        }
    }
    age += dt / 1000;

    output(0) = Iout * 1e-12; // output current is in pA
}



void F_Istep::update(DefaultGUIModel::update_flags_t flag) 
{
    switch(flag) {
        case INIT:
            setParameter("Starting Current (pA)",starti);
            setParameter("Finishing Current (pA)",finishi);
            setParameter("Increments",Nsteps);
            setParameter("Pulse Duration (sec)",pulse_duration);
            setParameter("Pause Duration (sec)",pause_duration);
            setParameter("Offset (pA)",offset);
            break;
        case MODIFY:
            starti         = getParameter("Starting Current (pA)").toDouble();
            finishi        = getParameter("Finishing Current (pA)").toDouble();
            Nsteps         = getParameter("Increments").toInt();
            pulse_duration = getParameter("Pulse Duration (sec)").toDouble();
            pause_duration = getParameter("Pause Duration (sec)").toDouble();
            offset         = getParameter("Offset (pA)").toDouble();
            break;
        case PAUSE:
            output(0) = 0;
        case PERIOD:
            dt = RT::System::getInstance()->getPeriod()*1e-6; // in ms
        default:
            break;
    }

    // Some Error Checking

    if (Nsteps < 0) {
        Nsteps = 1;
        setParameter("Increments",Nsteps);
    }

    if (pulse_duration < 0) {
        pulse_duration = 0.5;
        setParameter("Pulse Duration (sec)",pulse_duration);
    }

    if (pause_duration < 0) {
        pause_duration = 5;
        setParameter("Pause Duration (sec)",pause_duration);
    }

    //Define deltaI based on params
    if (Nsteps > 1) {
       deltaI = (finishi-starti)/(Nsteps-1);
    } else {
       deltaI = starti;
    }
    
    //Initialize counters
    age   = 0;
    step  = 1;
}
