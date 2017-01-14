clear;clc;close all

tic

dates_all={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'...
    'May_31_13' 'May_31_13' 'Jun_24_13' 'Jun_24_13' 'Jul_03_13' 'Jul_03_13'...
    'Jul_29_13' 'Jul_29_13' 'Aug_05_13' 'Aug_16_13' 'Sep_05_13' 'Sep_16_13'...
    'Oct_08_13' 'Oct_08_13' 'Mar_18_14'};
cellnum_all={'B' 'A' 'B' 'A' 'A' 'B'...
    'C' 'D' 'A' 'B' 'A' 'B'...
    'A' 'B' 'A' 'A' 'A' 'A'...
    'A' 'B' 'A'};
trials_all=[2 5;3 4;2 3;2 3;2 3;2 3;...
    2 3;2 3;2 3;2 3;2 3;2 3;...
    2 3;4 5;2 3;2 3;2 3;3 2;...
    3 2;3 2;1 2;];

for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    module='fi_curves';
    % trials=1:numel(whos)-3;
    trials=trials_all(k,:);
    sample_rate=10000;   % Sample rate in Hz
    saveit=1;
    
    [rate_all,ISI,rate_init,spike1avg,spike2avg,spike3avg,spikelastavg,spikelastriseavg,pulse_duration,pause_duration,delay,...
        increments,currents]=first_three_spikes(module,recdate,cellnum,trials,sample_rate);
    
    if saveit~=0
        save([pwd '\..\..\F_I_curves\data\spikes_analysis\' module '_' recdate '_' cellnum '_spikes'],'rate_init',...
            'spike1avg','spike2avg','spike3avg','spikelastavg','spikelastriseavg','pulse_duration',...
            'pause_duration','delay','increments','currents')
    end
end

% close all

toc