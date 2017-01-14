/*
 * gA -- from Fernando's imagination
 * Jan 2007
 */

#include <math.h>
#include <default_gui_model.h>

class gA : public DefaultGUIModel
{
    
    public:
    
        gA(void);
        virtual ~gA(void);
        
        virtual void execute(void);
        
    protected:
    
        virtual void update(DefaultGUIModel::update_flags_t);
    
    private:
    
        // parameters
        double EK;
        double GK;
        double tauK_temp;
        double tauKhVonehalf;
        double tauKhk;
        double aVonehalf;
        double ak;
        double iVonehalf;
        double ik;
        
        // input / output
        double Vm;  
        double I;   

	// states
	double s;
	double s_inf;
	double sh;
	double sh_inf;
         
        // rtxi things, i think
        double period;
        double rate;
        int steps;
    
};


extern "C" Plugin::Object *createRTXIPlugin(void) {
    return new gA();
}

static DefaultGUIModel::variable_t vars[] = {
    {
        "Vm",
        "mV",
        DefaultGUIModel::INPUT,
    },
    {
        "I",
        "pA",
        DefaultGUIModel::OUTPUT,
    },
    {
        "EK",
        "mV",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "GK",
        "nS",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "Time Constant of Activation",
        "sec",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "V1/2 for Time Constant of Inactivation",
        "mV",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "k for Time Constant of Inactivation",
        "mV",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "V1/2 for Activation Curve",
        "mV",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "k for Activation Curve",
        "mV",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "V1/2 for Inactivation Curve",
        "mV",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "k for Inactivation Curve",
        "mV",
        DefaultGUIModel::PARAMETER | DefaultGUIModel::DOUBLE,
    },
    {
        "s",
        "The S Variable",
        DefaultGUIModel::STATE,
    },
    {
        "s_inf",
        "s infinity",
        DefaultGUIModel::STATE,
    },
    {
        "sh",
        "The Sh Variable",
        DefaultGUIModel::STATE,
    },
    {
        "sh_inf",
        "sh infinity",
        DefaultGUIModel::STATE,
    },
};

static size_t num_vars = sizeof(vars)/sizeof(DefaultGUIModel::variable_t);

gA::gA(void): DefaultGUIModel("gA",::vars,::num_vars) {

     createGUI( vars, num_vars ); // Added by Francis for new RTXI version, builds GUI

    // rtxi timing stuff
    period = RT::System::getInstance()->getPeriod()*1e-6;
    steps = static_cast<int>(ceil(period/25e-3));
    
    // parameters
    EK = -82.2833;
    GK = 50.0;
    tauK_temp = 0.134; // time constant of activation
    tauKhVonehalf = -3.07; // V1/2 for time constant of inactivation
    tauKhk = 17.08; // k for time constant of inactivation
    aVonehalf = -25.85; // V1/2 for activation curve
    ak = 8.11; // k for activation curve
    iVonehalf = -60.04; // V1/2 for inactivation curve
    ik = -5.12; // k for inactivation curve

    // states
    s = 0.0;
    s_inf = 0.0;
    sh = 0.0;
    sh_inf = 0.0;
    
    update(INIT);
    refresh();
}

gA::~gA(void) {}


void gA::execute(void) {

    double tauK, tauKh, s_inf, IK_s;
    
    // convert input to mV
    Vm = input(0)*1e3; // - 10 junction potential
    
    tauK = tauK_temp * 1000; // time constant of activation
    tauKh = (4.65 + 134.49 * exp(-pow((tauKhVonehalf - Vm) , 2.0) / pow(tauKhk , 2) )) * 1000; // time constant of inactivation
    
    // compute conductance
    s_inf = 1.0/ (1.0 + exp((aVonehalf - Vm) / ak));
    s  = s_inf + (s - s_inf) * exp(-period / tauK);

    // new variables (inactivation)
    sh_inf = 1.0 / (1.0 + exp((iVonehalf - Vm) / ik));
    sh  = sh_inf + (sh - sh_inf) * exp(-period / tauKh);

    // nS * mV = pA
    IK_s = sh * s * GK * (EK - Vm);    

    // send output converted to Amps
    output(0) = IK_s / 1e12;  
}

void gA::update(DefaultGUIModel::update_flags_t flag) {
    switch(flag) {
    case INIT:
        
        setParameter("EK",EK);
        setParameter("GK",GK);
        setParameter("Time Constant of Activation",tauK_temp);
        setParameter("V1/2 for Time Constant of Inactivation",tauKhVonehalf);
        setParameter("k for Time Constant of Inactivation",tauKhk);
        setParameter("V1/2 for Activation Curve",aVonehalf);
        setParameter("k for Activation Curve",ak);
        setParameter("V1/2 for Inactivation Curve",iVonehalf);
        setParameter("k for Inactivation Curve",ik);

	setState("s", s);
	setState("s_inf", s_inf);
	setState("sh", sh);
	setState("sh_inf", sh_inf);

	s = 0.0;
	s_inf = 0.0;
	sh = 0.0;
	sh_inf = 0.0;
        
        break;
    case MODIFY:
        
        EK            = getParameter("EK").toDouble();
        GK            = getParameter("GK").toDouble();
        tauK_temp     = getParameter("Time Constant of Activation").toDouble();
        tauKhVonehalf = getParameter("V1/2 for Time Constant of Inactivation").toDouble();
        tauKhk        = getParameter("k for Time Constant of Inactivation").toDouble();
        aVonehalf     = getParameter("V1/2 for Activation Curve").toDouble();
        ak            = getParameter("k for Activation Curve").toDouble();
        iVonehalf     = getParameter("V1/2 for Inactivation Curve").toDouble();
        ik            = getParameter("k for Inactivation Curve").toDouble();

	s = 0.0;
	s_inf = 0.0;
	sh = 0.0;
	sh_inf = 0.0;
        
        break;
    case PERIOD:
        
        period = RT::System::getInstance()->getPeriod()*1e-6;
        steps = static_cast<int>(ceil(period*getParameter("rate").toUInt()/1000.0));
        
        break;
    default:
        break;
    }
}
