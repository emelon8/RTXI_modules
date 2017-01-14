clear;%clc;%close all

tic

recdate='Dec_03_13';
cellnum='B';
module='effecttime2';
load([module '_' recdate '_' cellnum])
% trials=1:numel(whos)-3;
trial=1;
sample_rate=10000;   % Sample rate in Hz
delay=2;
pulse_length=60;
pause=10;
windowsize=3; %Size of window in seconds
slidesize=.3; %Size of window sliding in seconds
saveit=1;

[rate_all,numberspikes,imp]=...
    et2_rate(module,recdate,cellnum,trial,sample_rate,delay,pulse_length,pause);

[sliding_rate_all,numberspikes,imp,coeff,rsqr]=...
    sliding_rate(module,recdate,cellnum,trial,sample_rate,delay,pulse_length,pause,windowsize,slidesize);

if saveit~=0
    save([module '_' recdate '_' cellnum '_et2'],'rate_all','numberspikes','imp',...
        'sliding_rate_all','numberspikes','imp','coeff','rsqr')
end

% close all

toc