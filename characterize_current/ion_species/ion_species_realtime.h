/*
 * Adapted from V_clamp_resistance_realtime.h by Eric Melonakos, 2014.
 */

#include <default_gui_model.h>
#include "./RealTimeLogger.h"
#include <string>
class ion_species_realtime : public DefaultGUIModel
{

public:

    ion_species_realtime(void);
    virtual ~ion_species_realtime(void);
    virtual void execute(void);

protected:

    virtual void update(DefaultGUIModel::update_flags_t);

private:
    double I, Vout;

    double       dt;
    double       prestep_V;
    double       prestep_t;
    double       starting_step_V;
    double       finishing_step_V;
    unsigned int increments;
    double       step_t;
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
