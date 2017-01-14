clear;clc;%close all

tic

dates_all={'Nov_21_13' 'Nov_21_13' 'Nov_26_13' 'Oct_24_13' 'Oct_31_13'...
    'Jan_06_15' 'Jan_06_15' 'Jan_06_15' 'Mar_24_15' 'Mar_28_15'}; % 'Nov_19_13'
cellnum_all={'A' 'B' 'A' 'B' 'A'...
    'A' 'B' 'C' 'A' 'A'}; %'A'
trials_all=[1 1 1 1 1 ...
    1 1 1 1 1]; % 1

for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    module='effecttime';
    trial=trials_all(k);
    sample_rate=10000;   % Sample rate in Hz
    delay=2;
    pulse_length=20;
    first_pause=0.01;
    second_pause=0.05;
    increments=6;
    saveit=1;
    
    windowsize=3;
    slidesize=0.3;
    
%     [rate_all,numberspikes,imp]=...
%         et_rate(module,recdate,cellnum,trial,sample_rate,delay,pulse_length,first_pause,second_pause,increments);

    [rate_all,numberspikes,imp,mean_v]=...
        sliding_rate(module,recdate,cellnum,trial,sample_rate,delay,pulse_length,first_pause,second_pause,increments,windowsize,slidesize);
    
    if saveit~=0
        save([module '_' recdate '_' cellnum '_et'],'rate_all','numberspikes','imp','mean_v')
    end
end

% close all

toc