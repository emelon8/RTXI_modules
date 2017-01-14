/*
 * Adapted from V_clamp_resistance_realtime.h by Eric Melonakos, 2014.
 */

#include <default_gui_model.h>
#include "./RealTimeLogger.h"
#include <string>
class recovery_time_realtime : public DefaultGUIModel
{

public:

    recovery_time_realtime(void);
    virtual ~recovery_time_realtime(void);
    virtual void execute(void);

protected:

    virtual void update(DefaultGUIModel::update_flags_t);

private:
    double I, Vout;

    double       dt;
    double       pulse_V;
    double       pulse_t;
    double       recovery_V;
    double       starting_recovery_t;
    unsigned int increments;
    double       recovery_pulse_V;
    double       recovery_pulse_t;
    double       pause_V;
    double       pause_t;
    double       total_recovery;

    double       deltaV;
    double       age;
    unsigned int step;
    
    // DataLogger
    RealTimeLogger *data;
    double maxt, tcnt,  Vpost, iout;
    int acquire, cols;
    int cellnum, tempcell;
    string prefix, info, path;
    double pdone;

};
