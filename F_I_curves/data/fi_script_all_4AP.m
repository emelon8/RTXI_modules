clear;clc;close all

tic

dates_all={'Jul_03_13' 'Sep_05_13' 'Sep_10_13' 'Oct_08_13' 'Apr_29_15' 'May_01_15'}; %'Jul_03_13' Used different number of increments so much be analyzed separately, but data still good
% 'May_04_15' drift between hyperpolarized and depolarized
% Used synaptic blockers after 2013
cellnum_all={'B' 'A' 'A' 'B' 'E' 'C'}; %'B'
% 'C'
trials_all=[5 6;4 5;4 5;5 4;5 6;6 7;]; %5 6;
% 3 4;
points_all=[29 51 47 61;14 51 24 36;21 51 26 47;16 51 17 46;1 2 1 2;1 2 1 2;]; %29 51 47 61;
% 1 2 1 2;

for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    module='fi_curves';
    % trials=1:numel(whos)-3;
    trials=trials_all(k,:);
    points=points_all(k,:);
    sample_rate=10000;   % Sample rate in Hz
    shouldplotFI=1; % Should the function plot the F-I curves? 1 for yes, 0 for no.
    saveit=1;
    
    [rate_all,peakrate,nofailrate,mean_holdingvoltage,mean_r_m,std_r_m,mean_time_constant,std_time_constant,mean_c_m,std_c_m,...
        numberspikes,thresholds,imp,pulse_duration,pause_duration,delay,increments,currents,pf_all]=...
        fi_rate(module,recdate,cellnum,trials,points,sample_rate,shouldplotFI);
    
    if saveit~=0
        save([pwd '\..\..\F_I_curves\data\fi_4AP_analysis\' module '_' recdate '_' cellnum '_fi_4AP'],'rate_all','peakrate','nofailrate','mean_holdingvoltage','mean_r_m','std_r_m',...
            'mean_time_constant','std_time_constant','mean_c_m','std_c_m','thresholds','imp','pulse_duration',...
            'pause_duration','delay','increments','currents','pf_all')
    end
end

% close all

toc