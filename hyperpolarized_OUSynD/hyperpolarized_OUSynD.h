#ifndef OUSYN_H
#define OUSYN_H

/**
 * Record a Single trace
 */

#include <default_gui_model.h>
#include <gsl/gsl_rng.h>
#include "RealTimeLogger.h"

class hyperpolarized_OUSynD : public DefaultGUIModel
{

public:

    hyperpolarized_OUSynD(void);
    virtual ~hyperpolarized_OUSynD(void);
    virtual void execute(void);
    void updateA();

protected:

    virtual void update(DefaultGUIModel::update_flags_t);

private:
    int sample;
    double *vec;
    double V, Iout;
    double len;
    double dt;

    double gain, freq, sineI;
    //ou parameters
    double tausyn;
    double STDsyn;
    double meansyn;
    double Asyn;
    double Dsyn;
    double outime;
    double pauset;
    double pausei;
    unsigned int reps;
    double age;
    int step;

    // currents
    double Isyn;
    
    // DataLogger
    RealTimeLogger *data;

    int acquire;
    double  tcnt, pctDone;
    int cellnum, tempcell, cols, downsample;
    
    string prefix, comment, path;
    char tempstr[100];

    // random
    gsl_rng *rng;
    
};

#endif
