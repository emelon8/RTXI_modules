/**
 * 
 */

#include "fi_ou.h"
#include <iostream>
#include <sstream>
#include <stdlib.h>
#include <cmath>
#include <gsl/gsl_randist.h>
#include <gsl/gsl_rng.h>
#include <math.h>
     
#define EPS 1e-9

extern "C" Plugin::Object *createRTXIPlugin(void) {
    return new FI_OU();
}

static DefaultGUIModel::variable_t vars[] = {
    {
        "Vin",
        "Cell's Voltage",
        DefaultGUIModel::INPUT,
    },
    {
        "I Out",
        "Excitatory Conductance",
        DefaultGUIModel::OUTPUT,
    },
    {
        "Isyn",
        "Synaptic Current",
        DefaultGUIModel::STATE,
    },
    {
        "Record length (s)",
        "How many seconds to record for",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Acquire?",
        "Acquire data 0 = no, 1 = yes",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::UINTEGER,
    },
    {
        "Cell number",
        "1-26",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::UINTEGER,
    },
    {
        "Percent done",
        "",
        DefaultGUIModel::STATE | DefaultGUIModel::DOUBLE,
    },
    {
        "Oscillation freq",
        "",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Oscillation gain",
        "",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Mean Synaptic",
        "Mean Value of the Synaptic OU Process",
        DefaultGUIModel::PARAMETER,
    },
    {
        "Tau Synaptic",
        "Time constant of Synaptic OU Process",
        DefaultGUIModel::PARAMETER,
    },
    {
        "STD Synaptic",
        "Standard Deviation for Isyn",
        DefaultGUIModel::PARAMETER,
    },
    {
        "Mode",
        "If 1, it will convert all synaptic currents above the mean synaptic value to the mean synaptic value. If 0, it will not",
        DefaultGUIModel::PARAMETER,
    },
    {
        "Mode Direction",
        "If \"down\", it will get rid of synaptic currents above the mean synaptic value. If \"up\", it will get rid of synaptic currents below the mean synaptic value",
        DefaultGUIModel::PARAMETER,
    },
    {
        "OU Time",
        "Amount of time to give the cell the OU process (sec)",
        DefaultGUIModel::PARAMETER,
    },
    {
        "Pause Time",
        "Amount of time to hold the cell hyperpolarized between OU processes (sec)",
        DefaultGUIModel::PARAMETER,
    },
    {
        "Starting Current Step",
        "Starting current to give the cell (pA)",
        DefaultGUIModel::PARAMETER,
    },
    {
        "Finishing Current Step",
        "Finishing current to give the cell (pA)",
        DefaultGUIModel::PARAMETER,
    },
    {
        "Increments",
        "Number of current steps, including the starting and finishing steps",
        DefaultGUIModel::PARAMETER,
    },
    {
        "File prefix",
        "",
        DefaultGUIModel::PARAMETER,
    },
};

static size_t num_vars = sizeof(vars)/sizeof(DefaultGUIModel::variable_t);

FI_OU::FI_OU(void)
    : DefaultGUIModel("FI_OU",::vars,::num_vars) { 
        createGUI( vars, num_vars ); // Added for new version of RTXI, builds GUI

        dt = (RT::System::getInstance()->getPeriod()*1e-6);

        len = 10.0;
        acquire = 0;
        cellnum = 1;
        prefix = "FI_OU";

        tcnt = 0;
        cols = 5;
        comment = " ";
        pctDone = 0;
        downsample = 1;
        path = "/home/eric/Dropbox/Documents/School/rtxi/Modules/FI_OU/data/";

        data = new RealTimeLogger((int)(((len*1000)/dt)*cols), cols, path);
        data->newcell(cellnum);
        data->setDSRate(downsample);        
        data->setPrint(0);




        gain = 0;
        freq = 1;
        
        tausyn = 10.0;
        STDsyn = 0.0;
        meansyn = 0.0;
        mode = 1;
        mode_direction = "down";
        outime = 10.0;
        pauset = 5.0;
        starti = -50.0;
        finishi = 200.0;
        reps = 26.0;
        sample = 1.0;
        Asyn = 0.0;
	Dsyn = 0.0;
        vec = new double [sample];

        Isyn = 0.0;

        // random number generators
        rng = gsl_rng_alloc(gsl_rng_gfsr4);
        //rng = gsl_rng_alloc(gsl_rng_default);

        srand(time(NULL));
        gsl_rng_set(rng, rand());
        vec[0] = gsl_ran_gaussian(rng, 1);

        setState("Isyn", Isyn);
        setState("Percent done", pctDone);

        update(INIT);
        refresh();
    }




FI_OU::~FI_OU(void) {
    delete(vec);
//    delete(data);
    if(rng) {
        gsl_rng_free(rng);
    }
}

void FI_OU::execute(void) {

    // do nothing more than save a trace
    V = input(0) * 1e3;
    
    if (step <= reps) {
        if (age >= (pauset + outime) * step - outime && age < (pauset + outime) * step) {

            sineI = gain*sin(2.0*M_PI*freq*tcnt);

            // get randn
            double randn1 = 0.0;
            randn1 = gsl_ran_gaussian(rng, 1);

            // compute OU Processes
            Isyn = (meansyn + (Isyn - meansyn) * exp(-dt / tausyn) + Asyn * randn1);

            if (mode) {
                if (mode_direction == "up") {
                    if (Isyn < meansyn) Isyn=meansyn;
                }
                else {
                    if (Isyn > meansyn) Isyn=meansyn;
                }
            }
    
            //if (randn1 > 3) {
            //    printf("Voltage: %f\n", V);
            //    printf ("Isyn: %f);
            //}
    
            age += dt / 1000.0;
            isteps = starti + (step - 1.0) * deltaI;
            output(0) = (Isyn + sineI + isteps) * 1e-12;
        }
        else if (age >= (pauset + outime) * (step-1) && age < (pauset + outime) * step - outime) {
            age += dt / 1000.0;
            Isyn = sineI = isteps = 0.0;
            output(0) = 0.0;
        }
        else {
            step++;
            Isyn = sineI = isteps = 0.0;
            output(0) = 0.0;
        }
    }
    else {
        age += dt / 1000.0;
        isteps = 0.0;
        output(0) = 0.0;
    }

    // Data Logging
    if (tcnt < (len - EPS)) {

        // count forward make sure we are using seconds
        tcnt += dt / 1000.0;
        pctDone = tcnt/len;

        // log data if needed
        if (acquire) {
            data->insertdata(tcnt);
            data->insertdata(V);
            data->insertdata(isteps*1e-12);
            data->insertdata(Isyn*1e-12);
            data->insertdata(output(0));
        }
    } else if (acquire) {


        sprintf(tempstr, "%4.2f", tausyn);
        comment = "Tau_syn = " + string(tempstr);
        sprintf(tempstr, "%4.2f", meansyn);
        comment = comment + "  Mean_syn = " + string(tempstr);
        sprintf(tempstr, "%4.2f", STDsyn);
        comment = comment + "  STD_syn = " + string(tempstr);




        acquire = 0;
        data->writebuffer(prefix, comment);
        data->resetbuffer();
    }
}



void FI_OU::update(DefaultGUIModel::update_flags_t flag) 
{

    if (flag == INIT) {
        // recording params
        setParameter("Record length (s)", len);
        setParameter("Acquire?", acquire);
        setParameter("Cell number", cellnum);

        setParameter("Oscillation freq", freq);
        setParameter("Oscillation gain", gain);
        
        // ou paramters
        setParameter("Mean Synaptic", meansyn);
        setParameter("Tau Synaptic", tausyn);
        setParameter("STD Synaptic", STDsyn);
        setParameter("Mode", mode);
        setParameter("Mode Direction", mode_direction);
        setParameter("OU Time", outime);
        setParameter("Pause Time", pauset);
        setParameter("Starting Current Step", starti);
        setParameter("Finishing Current Step", finishi);
        setParameter("Increments", reps);
        setParameter("File prefix", prefix);

        // compute Ae and Ai
        updateA();

    } else if(flag == MODIFY) {               
        len = getParameter("Record length (s)").toDouble();

        acquire = getParameter("Acquire?").toInt();
        tempcell = getParameter("Cell number").toInt();

        if (tempcell != cellnum) {
            data->newcell(tempcell);
            cellnum = tempcell;
        }

        data->deleteBuffer();
        cout << "len " << len << "  dt " << dt << " cols " << cols << endl;
        data->setBufferLen((int)((len*1000)/dt*cols));
        data->resetbuffer();
        tcnt = 0;

        freq = getParameter("Oscillation freq").toDouble();
        gain = getParameter("Oscillation gain").toDouble();

        // ou params
        meansyn = getParameter("Mean Synaptic").toDouble();
        tausyn = getParameter("Tau Synaptic").toDouble();
        STDsyn = getParameter("STD Synaptic").toDouble();
        mode = getParameter("Mode").toDouble();
        mode_direction = getParameter("Mode Direction").data();
        outime = getParameter("OU Time").toDouble();
        pauset = getParameter("Pause Time").toDouble();
        starti = getParameter("Starting Current Step").toDouble();
        finishi = getParameter("Finishing Current Step").toDouble();
        reps = getParameter("Increments").toInt();
        prefix = getParameter("File prefix").data();
        sample=(int)(delay/dt) + 1;

        delete(vec);
        vec = new double [sample];
        for (int i = 0; i<sample; i++) {

            vec[i] = gsl_ran_gaussian(rng, 1);
        }

        // compute Asyn
        updateA();

    } else if(flag == PAUSE) {
        output(0) = 0.0;

    } else if(flag == PERIOD) {
        dt = RT::System::getInstance()->getPeriod()*1e-6;
        updateA();
    }

    // Some Error Checking for fun
    if (len < 0.0) {
        setParameter("Record Length (s)", 0.0);
        refresh();
    }

    //Define deltaI based on params
    if (reps > 1) {
       deltaI = (finishi-starti)/(reps-1);
    } else {
       deltaI = starti;
    }

    // Initialize counters
    age = 0.0;
    step = 1.0;

}

void FI_OU::updateA() {
    // compute Asyn
    //Asyn = sqrt((Dsyn * tausyn / 2) * (1 - exp(-2 * dt / tausyn)));
	Dsyn=(STDsyn * STDsyn) / tausyn * 2.0;

    Asyn = sqrt((Dsyn * tausyn / 2.0) * (1.0 - exp(-2.0 * dt / tausyn)));
}
