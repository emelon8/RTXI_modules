/*
 * Adapted from V_clamp_resistance_realtime.h by Eric Melonakos, 2014.
 */

#include <default_gui_model.h>
#include "./RealTimeLogger.h"
#include <string>
class activation_inactivation_realtime : public DefaultGUIModel
{

public:

    activation_inactivation_realtime(void);
    virtual ~activation_inactivation_realtime(void);
    virtual void execute(void);

protected:

    virtual void update(DefaultGUIModel::update_flags_t);

private:
    double I, Vout;

    double       dt;
    double       activation_step_starting_V;
    double       activation_step_finishing_V;
    unsigned int increments;
    double       activation_step_t;
    double       inactivation_step_V;
    double       inactivation_step_t;
    double       pause_t;

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
