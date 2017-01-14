clear

recdate='Mar_21_12';
cellnum='A';
trials_control=1;
trials_propofol=0;
conc_propofol='100';
start_current=10;    % Starting current in pA
finish_current=150;  % Finishing current in pA
increments=10;
delay=2;            % Delay in seconds
pulse_duration=5;
pause_duration=10;
sample_rate=10000;   % Sample rate in Hz.

count_rate(recdate,cellnum,trials_control,trials_propofol,conc_propofol,delay,...
    pulse_duration,pause_duration,sample_rate,increments)

ISI_rate(recdate,cellnum,trials_control,trials_propofol,conc_propofol,delay,...
    pulse_duration,pause_duration,sample_rate,increments)