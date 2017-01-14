clear;clc;close all

tic

dates_all={'Jul_03_13' 'Sep_05_13' 'Sep_10_13' 'Oct_08_13'}; %'Jul_03_13' Used different number of increments so much be analyzed separately, but data still good
cellnum_all={'B' 'A' 'A' 'B'}; %'B'
trials_all=[5 6;4 5;4 5;5 4;]; %5 6;
points_all=[29 51 47 61;14 51 24 36;21 51 26 47;16 51 17 46;]; %29 51 47 61;

for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    module='fi_curves';
    % trials=1:numel(whos)-3;
    trials=trials_all(k,:);
    points=points_all(k,:);
    sample_rate=10000;   % Sample rate in Hz
    shouldplotFV=0; % Should the function plot the F-I curves? 1 for yes, 0 for no.
    saveit=1;
    
    [rate_all,numberspikes,imp,pulse_duration,pause_duration,delay,increments,currents,pf_all,threshold,avg_voltage,avg_voltage_trunc]=...
        fV_rate(module,recdate,cellnum,trials,points,sample_rate,shouldplotFV);
    
    if saveit~=0
        save([pwd '\..\..\F_I_curves\data\fV_4AP_analysis\' module '_' recdate '_' cellnum '_fV_4AP'],'rate_all','imp','pulse_duration',...
        'pause_duration','delay','increments','currents','pf_all','threshold','avg_voltage','avg_voltage_trunc')
    end
end

% close all

toc