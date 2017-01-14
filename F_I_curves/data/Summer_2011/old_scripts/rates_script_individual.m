% count_rate_individual(VARIABLE,DELAY,PULSE,PAUSE,SAMPLE,#STEPS,START,FINISH)
var_name=fi_curves_Apr_11_12_C4;
delay=2;
pulse_time=0.5;
pause_time=1;
sample_rate=10000;
increments=80;
start_current=-50;
finish_current=350;

% count_rate_individual(var_name,delay,pulse_time,pause_time,sample_rate,increments,start_current,finish_current)

ISI_rate_individual(var_name,delay,pulse_time,pause_time,sample_rate,increments,start_current,finish_current)