clear;clc;close all

tic

dates_all={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'... don't include for threshold measurements: 'May_31_13'
    'May_31_13' 'May_31_13' 'Jun_24_13' 'Jun_24_13' 'Jul_03_13' 'Jul_03_13'...
    'Jul_29_13' 'Jul_29_13' 'Aug_05_13' 'Aug_16_13' 'Sep_05_13' 'Sep_16_13'... don't include for threshold measurements: 'Aug_05_13'
    'Oct_08_13' 'Oct_08_13' 'Mar_18_14'}; % Used synaptic blockers: 'Sep_10_13' 'Apr_29_15' 'May_01_15' 'May_04_15'
% Different range of currents (but still included above): 'Mar_19_13' 'Mar_21_13'
cellnum_all={'B' 'A' 'B' 'A' 'A' 'B'... don't include for threshold measurements: 'B'
    'C' 'D' 'A' 'B' 'A' 'B'...
    'A' 'B' 'A' 'A' 'A' 'A'... don't include for threshold measurements: 'A'
    'A' 'B' 'A'}; % Used synaptic blockers: 'A' 'E' 'C' 'C'
trials_all=[2 5;3 4;2 3;2 3;2 3;2 3;... don't include for threshold measurements: 2 3;
    2 3;2 3;2 3;2 3;2 3;2 3;...
    2 3;4 5;2 3;2 3;2 3;3 2;... don't include for threshold measurements: 2 3;
    3 2;3 2;1 2;]; % Used synaptic blockers: 2 3;3 4;4 5;1 2;
points_all=[23 51 24 51;15 30 20 34;28 51 35 51;20 43 26 51;39 51 37 51;23 51 22 42;... don't include for threshold measurements: 23 51 22 42;
    24 51 28 51;18 45 20 48;37 51 44 49;30 51 37 51;24 51 29 46;26 51 33 47;...
    34 51 33 51;45 51 44 51;30 51 31 51;20 33 22 51;21 51 23 44;25 51 21 51;... don't include for threshold measurements: 30 51 31 51;
    13 51 7 24;18 51 18 51; 24 51 27 49;]; % Used synaptic blockers: 26 51 30 51;1 2 1 2;1 2 1 2;1 2 1 2;

for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    module='fi_curves';
    % trials=1:numel(whos)-3;
    trials=trials_all(k,:);
    points=points_all(k,:);
    sample_rate=10000;   % Sample rate in Hz
    shouldplotFI=0; % Should the function plot the F-I curves? 1 for yes, 0 for no.
    saveit=1;
    
    [rate_all,peakrate,nofailrate,mean_holdingvoltage,mean_r_m,std_r_m,mean_time_constant,std_time_constant,mean_c_m,std_c_m,...
        numberspikes,thresholds,imp,pulse_duration,pause_duration,delay,increments,currents,pf_all]=...
        fi_rate(module,recdate,cellnum,trials,points,sample_rate,shouldplotFI);
    
    if saveit~=0
        save([pwd '\..\..\F_I_curves\data\fi_analysis\' module '_' recdate '_' cellnum '_fi'],'rate_all','peakrate','nofailrate','mean_holdingvoltage','mean_r_m','std_r_m',...
            'mean_time_constant','std_time_constant','mean_c_m','std_c_m','thresholds','imp','pulse_duration',...
            'pause_duration','delay','increments','currents','pf_all')
    end
end

% close all

toc