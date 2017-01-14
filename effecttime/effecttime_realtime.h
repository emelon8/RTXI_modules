/*
 * Adapted from Istep.h by Eric Melonakos, 2011.
 */

#include <default_gui_model.h>
#include "./RealTimeLogger.h"
#include <string>

class effecttime : public DefaultGUIModel
{

public:

    effecttime(void);
    virtual ~effecttime(void);
    virtual void execute(void);

protected:

    virtual void update(DefaultGUIModel::update_flags_t);

private:
    double V, Iout;

    double dt;
    double delay;
    double initial_pulse;
    double hyperpolarizing_pulse;
    double pulse_length;
    double first_pause;
    double second_pause;
    double thispause;
    double totalpause;
    int    increments;

    double deltaI;
    double age;
    int    step;
    
    // DataLogger
    RealTimeLogger *data;
    double maxt, tcnt,  Vpost, iout;
    int acquire, cols;
    int cellnum, tempcell;
    string prefix, info, path;
    double pdone;

};
