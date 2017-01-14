clear

recdate='Sep_28_11';
cellnum='A';
conc_propofol='100';
start_current=90;    % Starting current in pA
finish_current=100;  % Finishing current in pA
increments=2;
delay=10;            % Delay in seconds
pulse_duration=50;
pause_duration=20;
sample_rate=10000;   % Sample rate in Hz.

sf_count_rate(recdate,cellnum,conc_propofol,delay,pulse_duration,pause_duration,...
    sample_rate,increments)