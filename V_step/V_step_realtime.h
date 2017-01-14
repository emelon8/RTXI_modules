/*
 * Adapted from F_Istep_realtime.h by Eric Melonakos, 2012.
 */

#include <default_gui_model.h>
#include "./RealTimeLogger.h"
#include <string>

class V_step : public DefaultGUIModel
{

public:

    V_step(void);
    virtual ~V_step(void);
    virtual void execute(void);

protected:

    virtual void update(DefaultGUIModel::update_flags_t);

private:
    double I, Vout;

    double dt;
    double start_V;
    double prestep_V1;
    double prestep_V2;
    int    Nsteps;
    double step_V;
    double start_t;
    double prestep_t;
    double step_t;

    double deltaV;
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
