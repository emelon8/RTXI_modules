clear;%clc;%close all

tic

dates_all={'Nov_26_13' 'Dec_03_13' 'Dec_17_13' 'Dec_17_13' 'Dec_17_13' 'Dec_18_13'...
    'Mar_24_15' 'Mar_28_15'}; %'Jul_03_13' Used different number of increments so much be analyzed separately, but data still good
cellnum_all={'A' 'B' 'A' 'B' 'C' 'A'...
    'A' 'A'}; %'B'
trials_all=[1 1 1 1 1 1 ...
    1 1]';

for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    module='effecttime2';
    trial=trials_all(k,:);
    sample_rate=10000;   % Sample rate in Hz
    delay=2;
    pulse_length=60;
    pause=10;
    windowsize=3; %Size of window in seconds
    slidesize=.3; %Size of window sliding in seconds
    saveit=0;
    
    [rate_all,numberspikes,imp,hpv]=...
        et2_rate(module,recdate,cellnum,trial,sample_rate,delay,pulse_length,pause);
    
    [sliding_rate_all,numberspikes,imp,coeff,rsqr]=...
        sliding_rate(module,recdate,cellnum,trial,sample_rate,delay,pulse_length,pause,windowsize,slidesize);
    
    if saveit~=0
        save([module '_' recdate '_' cellnum '_et2'],'rate_all','numberspikes','imp',...
            'sliding_rate_all','numberspikes','imp','hpv','coeff','rsqr')
    end
    
end

% close all

toc