clear;clc;close all
tic


recdate_all={'Feb_06_14' 'Feb_06_14' 'Feb_13_14' 'Feb_14_14' 'Feb_19_14' 'Feb_27_14'...
    'Feb_27_14' 'Feb_27_14' 'Mar_03_14' 'Mar_04_14' 'Mar_04_14' 'Mar_13_14'}; % Not good data 'Feb_19_14'
cellnum_all={'B' 'B' 'B' 'A' 'A' 'A'...
    'B' 'C' 'A' 'A' 'C' 'A'}; % 'A'
trial_all=[1 2 1 1 1 1 ...
    1 1 1 1 1 1]; % 2
prestep_V_all=-30*ones(1,12); % Voltages are in volts
prestep_t_all=5*ones(1,12);
starting_step_V_all=[-50 -60 -50 -50 -65 -65 ...
    -65 -65 -65 -65 -65 -65]; % -65
finishing_step_V_all=[-100 -110 -130 -130 -100 -100 ...
    -90 -90 -90 -90 -90 -90]; % Times are in seconds % -100
increments_all=[11 11 11 16 15 4 ...
    11 9 11 11 11 11]; % 4
resistance_increments_less_than_increments_all=[0 0 0 1 0 0 ...
    0 1 0 0 0 0]; % 0
step_t_all=[10 10 10 10 10 10 ...
    10 10 5 5 5 5]; % 10
pause_t_all=30*ones(1,12);
measure_t_all=[0.005 0.01 0.015 0.005 0.005 0.01 ...
    0.009 0.005 0.005 0.01 0.008 0.005];

for k=1:numel(recdate_all)
    recdate=recdate_all{k};
    cellnum=cellnum_all{k};
    trial=trial_all(k);
    module='ion_species';
    prestep_V=prestep_V_all(k); % Voltages are in volts
    prestep_t=prestep_t_all(k);
    starting_step_V=starting_step_V_all(k);
    finishing_step_V=finishing_step_V_all(k); % Times are in seconds
    increments=increments_all(k);
    resistance_increments_less_than_increments=resistance_increments_less_than_increments_all(k);
    step_t=step_t_all(k);
    pause_t=pause_t_all(k);
    measure_t=measure_t_all(k);
    sample_rate=10000;   % Sample rate in Hz
    saveit=0;
    
    [mean_starting,max_step,step_voltages,linfit,xintercept]=...
        ion_species(module,recdate,cellnum,trial,prestep_V,prestep_t,starting_step_V,...
        finishing_step_V,increments,step_t,pause_t,sample_rate,resistance_increments_less_than_increments,measure_t);
    
    if saveit~=0
        save([module '_' recdate '_' cellnum num2str(trial) '_iv'],'mean_starting',...
            'max_step','step_voltages','linfit','xintercept')
    end
end

% close all

toc