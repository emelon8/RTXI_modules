clear;clc;close all
tic


recdate='May_14_14';
cellnum='C';
trial=3;
module='recovery_time';
pulse_V=-30; % Voltages are in millivolts
pulse_t=20;
recovery_V=-60;
starting_recovery_t=0.005; %time in seconds
increments=13;
recovery_pulse_V=-30; % Times are in seconds
recovery_pulse_t=5;
pause_V=-80;
pause_t=20;
EK=-82.2833;
recovery_pulse_begintimes=0.003*ones(1,increments); %[0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01];
recovery_begintimes=0.05*ones(1,increments);
sample_rate=10000;   % Sample rate in Hz
saveit=0;

[this_recovery,mean_recovery,max_recovery_pulse,normalized_recovery_pulse,recovery_fit]=...
    recovery_time(module,recdate,cellnum,trial,pulse_V,pulse_t,recovery_V,...
    starting_recovery_t,increments,recovery_pulse_V,recovery_pulse_t,pause_V,pause_t,...
    EK,recovery_pulse_begintimes,recovery_begintimes,sample_rate);

if saveit~=0
    save([module '_' recdate '_' cellnum num2str(trial) '_recovery_time'],...
        'this_recovery','max_recovery_pulse','normalized_recovery_pulse','recovery_fit')
end

% close all

toc