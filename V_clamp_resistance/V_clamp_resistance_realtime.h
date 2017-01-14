/*
 * Adapted from V_step_realtime.h by Eric Melonakos, 2013.
 */

#include <default_gui_model.h>
#include "./RealTimeLogger.h"
#include <string>

class V_clamp_resistance : public DefaultGUIModel
{

public:

    V_clamp_resistance(void);
    virtual ~V_clamp_resistance(void);
    virtual void execute(void);

protected:

    virtual void update(DefaultGUIModel::update_flags_t);

private:
    double I, Vout;

    double       dt;
    double       start_V;
    double       prestep_V1;
    double       prestep_V2;
    unsigned int Nsteps;
    double       step_V;
    double       resis_V;
    double       start_t;
    double       prestep_t;
    double       step_t;
    double       resis_pulse_t;
    double       resis_pause_t;
    unsigned int Nresis;

    double       deltaV;
    double       age;
    unsigned int step;
    unsigned int resis_step;
    
    // DataLogger
    RealTimeLogger *data;
    double maxt, tcnt,  Vpost, iout;
    int acquire, cols;
    int cellnum, tempcell;
    string prefix, info, path;
    double pdone;

};
