/*
 * Adapted from Istep.h by Eric Melonakos, 2011.
 */

#include <default_gui_model.h>
#include <string>

class F_Istep : public DefaultGUIModel
{

public:

    F_Istep(void);
    virtual ~F_Istep(void);
    virtual void execute(void);

protected:

    virtual void update(DefaultGUIModel::update_flags_t);

private:
    double V, Iout;

    double dt;
    double starti;
    double finishi;
    int    Nsteps;
    double pulse_duration;
    double pause_duration;
    double offset;

    double deltaI;
    double age;
    int    step;
    
    
};
