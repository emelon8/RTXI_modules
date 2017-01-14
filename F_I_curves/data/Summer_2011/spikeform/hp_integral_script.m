clear

recdate='Oct_13_11';
cellnum='B';
trials_control=1;
trials_propofol=1;
conc_propofol='0';
increments=2;
delay=10;            % Delay in seconds
pulse_duration=50;
pause_duration=20;
sample_rate=10000;   % Sample rate in Hz.

hp_integral(recdate,cellnum,trials_control,trials_propofol,conc_propofol,delay,...
    pulse_duration,pause_duration,sample_rate,increments)