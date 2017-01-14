clear;clc;figure%close all

tic

recdate='Sep_10_13';
cellnum='B';
trial=1;
module='v_clamp_resistance';
% load([module '_' recdate '_' cellnum])
starting_v=-0.07; % Voltages are in volts
first_prestep_v=-0.09;
last_prestep_v=-0.07;
increments=5;
step_v=-0.06;
resistance_v=-0.065;
starting_t=2; % Times are in seconds
prestep_t=2;
step_t=2;
resistance_pulse_t=0.05;
resistance_pause_t=0.05;
number_resistance=5;
sample_rate=10000;   % Sample rate in Hz
saveit=0;

[mean_difference,mean_resistance]=...
    v_clamp_resistance(module,recdate,cellnum,trial,starting_v,first_prestep_v,...
    last_prestep_v,increments,step_v,resistance_v,starting_t,prestep_t,step_t,...
    resistance_pulse_t,resistance_pause_t,number_resistance,sample_rate);

if saveit~=0
    save([module '_' recdate '_' cellnum num2str(trial) '_resistance'],'mean_difference','mean_resistance')
end

% close all

toc