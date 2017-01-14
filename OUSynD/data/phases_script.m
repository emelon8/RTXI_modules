clear;clc;close all

tic
recdate='Jul_02_14';
cellnum='A';
module='OUSynD';
load([module '_' recdate '_' cellnum])
trials=1:numel(whos)-3;
% trials=[1];
sample_rate=10000; % Sample rate in Hz
saveit=1;

[phases,rate,spikeform,length_meanvector,frequency,mean_voltage]=...
    OU_phase(module,recdate,cellnum,trials,sample_rate);

if saveit~=0
    save([module '_' recdate '_' cellnum '_phases'],'phases','rate','spikeform',...
        'length_meanvector','frequency','mean_voltage')
end

% close all

toc