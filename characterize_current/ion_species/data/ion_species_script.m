clear;clc;close all
tic


recdate='Mar_13_14';
cellnum='A';
trial=1;
module='ion_species';
load([module '_' recdate '_' cellnum])
prestep_V=-30; % Voltages are in volts
prestep_t=5;
starting_step_V=-65;
finishing_step_V=-90; % Times are in seconds
increments=11;
resistance_increments_less_than_increments=0;
step_t=5;
pause_t=30;
sample_rate=10000;   % Sample rate in Hz
saveit=1;

[mean_starting,max_step,step_voltages,linfit,xintercept]=...
    ion_species(module,recdate,cellnum,trial,prestep_V,prestep_t,starting_step_V,...
    finishing_step_V,increments,step_t,pause_t,sample_rate,resistance_increments_less_than_increments);

if saveit~=0
    save([module '_' recdate '_' cellnum num2str(trial) '_iv'],'mean_starting',...
        'max_step','step_voltages','linfit','xintercept')
end

% close all

toc