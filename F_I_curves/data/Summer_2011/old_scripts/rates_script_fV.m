clear

recdate='Sep_02_11';
cellnum='B';
trials_control=3;
trials_propofol=3;
conc_propofol='100';
start_current=10;    % Starting current in pA
finish_current=150;  % Finishing current in pA
increments=15;
delay=12;            % Delay in seconds
pulse_duration=5;
pause_duration=10;
sample_rate=10000;   % Sample rate in Hz.

count_rate_fV(recdate,cellnum,trials_control,trials_propofol,conc_propofol,delay,...
    pulse_duration,pause_duration,sample_rate,increments)