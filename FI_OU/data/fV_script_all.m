clear;clc;close all

tic

dates_all={'Oct_03_14' 'Oct_03_14' 'Oct_06_14' 'Oct_06_14' 'Oct_06_14' 'Oct_06_14'...
    'Oct_14_14' 'Oct_14_14' 'Oct_14_14' 'Oct_14_14' 'Oct_15_14' 'Oct_23_14'...
    'Oct_23_14' 'Oct_23_14' 'Oct_24_14' 'Oct_24_14' 'Nov_26_14' 'Jan_27_15'...
    'Jan_27_15' 'Jan_27_15' 'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_03_15'...
    'Feb_10_15' 'Feb_10_15' 'Mar_03_15'};
cellnum_all={'B' 'B' 'A' 'A' 'C' 'C'...
    'A' 'A' 'B' 'C' 'A' 'A'...
    'A' 'A' 'A' 'B' 'A' 'A'...
    'A' 'B' 'B' 'A' 'B' 'C'...
    'B' 'C'};
trials_all=[4 5 3 4 3 4 ...
    2 4 1 1 1 1 ...
    2 3 2 2 2 1 ...
    2 2 1 1 1 1 ...
    1 1]';
points_all=repmat([1 21],size(trials_all));
% points_all=[13 20;15 20;11 18;14 20;4 17;5 14;...
%     6 20;6 18;8 16;5 19;6 18;3 13;...
%     7 11;3 11;5 19;3 16;4 20;6 14;...
%     10 16;5 17;6 10;5 17;6 19;4 20;...
%     1 21;1 21;];% ### fix these numbers

for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    module='FI_OU';
    % trials=1:numel(whos)-3;
    trials=trials_all(k,:);
    points=points_all(k,:);
    sample_rate=10000;   % Sample rate in Hz
    shouldplotFV=0; % Should the function plot the F-V curves? 1 for yes, 0 for no.
    saveit=0;
    
    [rate_all,numberspikes,imp,pulse_duration,pause_duration,delay,increments,currents,pf_all,threshold,avg_voltage,avg_voltage_trunc]=...
        fV_rate(module,recdate,cellnum,trials,points,sample_rate,shouldplotFV);
    
    if saveit~=0
        save([module '_' recdate '_' cellnum num2str(trials) '_fV'],'rate_all','imp','pulse_duration',...
        'pause_duration','delay','increments','currents','pf_all','threshold','avg_voltage','avg_voltage_trunc')
    end
end

% close all

toc