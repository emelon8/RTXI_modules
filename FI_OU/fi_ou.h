#ifndef OUSYN_H
#define OUSYN_H

/**
 * Record a Single trace
 */

#include <default_gui_model.h>
#include "../include/DataLogger.cpp"
#include <gsl/gsl_rng.h>
#include "RealTimeLogger.h"
#include <string>

class FI_OU : public DefaultGUIModel
{

public:

    FI_OU(void);
    virtual ~FI_OU(void);
    virtual void execute(void);
    void updateA();

protected:

    virtual void update(DefaultGUIModel::update_flags_t);

private:
    double delay;
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
    double mode;
    string mode_direction;
    double correlation;
    double Asyn;
    double Dsyn;
    double outime;
    double pauset;
    double starti;
    double finishi;
    double deltaI;
    int reps;
    double age;
    double isteps;
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
