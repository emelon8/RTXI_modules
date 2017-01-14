clear;clc;close all

tic
recdate='Aug_25_14';
cellnum='A';
module='hyperpolarized_OUSynD';
load([module '_' recdate '_' cellnum])
outime=10;
pauset=5;
reps=1;
% trials=1:numel(whos)-3;
trials=[14];
sample_rate=10000; % Sample rate in Hz
saveit=0;

[phases,rate,spikeform,length_meanvector,frequency,mean_voltage]=...
    hyperpolarized_OU_phase(module,recdate,cellnum,outime,pauset,reps,trials,sample_rate);

if saveit~=0
    save([module '_' recdate '_' cellnum '_phases'],'phases','rate','spikeform',...
        'length_meanvector','frequency','mean_voltage')
end

% close all

toc