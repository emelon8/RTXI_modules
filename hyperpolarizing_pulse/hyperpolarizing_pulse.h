/*
 * Adapted from Istep.h by Eric Melonakos, 2011.
 */

#include <default_gui_model.h>
#include "./RealTimeLogger.h"
#include <string>

class hyperpolarizing_pulse : public DefaultGUIModel
{

public:

    hyperpolarizing_pulse(void);
    virtual ~hyperpolarizing_pulse(void);
    virtual void execute(void);

protected:

    virtual void update(DefaultGUIModel::update_flags_t);

private:
    double       V, Iout;

    double       dt;
    double       delay;
    double       stepi;
    unsigned int Nsteps;
    double       pulse_duration;
    double       pause_duration;
    double       hyperpolarizingi;
    double       hyperpolarizingt;
    double       hyperpolarizingpause;
    unsigned int hyperpolarizingsteps;
    double       offset;

    double       age;
    unsigned int step;
    unsigned int hstep;
    
    // DataLogger
    RealTimeLogger *data;
    double maxt, tcnt,  Vpost, iout;
    int acquire, cols;
    int cellnum, tempcell;
    string prefix, info, path;
    double pdone;

};
