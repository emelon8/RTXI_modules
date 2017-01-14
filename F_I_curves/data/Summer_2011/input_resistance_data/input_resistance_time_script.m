clear

recdate='Nov_25_11';
cellnum='A';
trials_control=7;
start_current=-55;    % Starting current in pA
finish_current=20;  % Finishing current in pA
increments=20;
delay=2;            % Delay in seconds
pulse_duration=1;
pause_duration=1;
sample_rate=10000;   % Sample rate in Hz.

input_resistance_time(recdate,cellnum,trials_control,delay,...
    pulse_duration,pause_duration,sample_rate,increments)