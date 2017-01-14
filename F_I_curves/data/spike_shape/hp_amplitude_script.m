clear

recdate='Sep_28_11';
cellnum='A';
trials_control=1;
trials_propofol=1;
conc_propofol='100';
increments=2;
delay=10;            % Delay in seconds
pulse_duration=50;
pause_duration=20;
sample_rate=10000;   % Sample rate in Hz.

hp_amplitude(recdate,cellnum,trials_control,trials_propofol,conc_propofol,delay,...
    pulse_duration,pause_duration,sample_rate,increments)