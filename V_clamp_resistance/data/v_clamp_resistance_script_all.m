clear;clc;close all

tic

dates_all={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'...
    'May_31_13' 'May_31_13' 'Jun_24_13' 'Jun_24_13' 'Jul_03_13' 'Jul_03_13'};
cellnum_all={'B' 'A' 'B' 'A' 'A' 'B'...
    'C' 'D' 'A' 'B' 'A' 'B'};
trials_all=[2 5;3 4;2 3;2 3;2 3;2 3;...
    2 3;2 3;2 3;2 3;2 3;2 3];
points_all=[23 51 24 37;15 51 20 51;28 51 35 51;20 43 26 44;39 51 37 51;23 51 22 27;...
    24 51 28 38;18 51 20 48;37 51 45 51;30 51 37 50;24 51 29 51;26 51 33 51];

for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    module='fi_curves';
    load([module '_' recdate '_' cellnum])
    % trials=1:numel(whos)-3;
    trials=trials_all(k,:);
    points=points_all(k,:);
    sample_rate=10000;   % Sample rate in Hz
    shouldplotFI=1; % Should the function plot the F-I curves? 1 for yes, 0 for no.
    saveit=1;
    
    [rate_all,numberspikes,imp,pulse_duration,pause_duration,delay,increments,currents,pf_all]=...
        fi_rate(module,recdate,cellnum,trials,points,sample_rate,shouldplotFI);
    
    if saveit~=0
        save([module '_' recdate '_' cellnum '_fi'],'rate_all','imp','pulse_duration',...
        'pause_duration','delay','increments','currents','pf_all')
    end
end

% close all

toc