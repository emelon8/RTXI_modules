clear;%clc;%close all

tic

recdate='Mar_24_15';
cellnum='A';
module='fi_curves';
% trials=1:numel(whos)-3;
trial=4;
sample_rate=10000;   % Sample rate in Hz
delay=2;
pulse_length=20;
pause_length=10;
increments=11;
windowsize=3; %Size of window in seconds
slidesize=.3; %Size of window sliding in seconds
saveit=0;

[rate_all,numberspikes,mean_v,imp]=...
    sliding_rate(module,recdate,cellnum,trial,sample_rate,delay,pulse_length,...
    pause_length,increments,windowsize,slidesize);

if saveit~=0
    save([pwd '\..\..\F_I_curves\data\voltage_dependency_analysis\' module '_' recdate '_' cellnum '_voltage_dependency'],'rate_all','numberspikes','mean_v','imp')
end

% close all

toc