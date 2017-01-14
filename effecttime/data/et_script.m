% clear;clc;%close all

tic

recdate='Nov_21_13';
cellnum='B';
module='effecttime';
load([module '_' recdate '_' cellnum])
% trials=1:numel(whos)-3;
trial=1;
sample_rate=10000;   % Sample rate in Hz
delay=2;
pulse_length=20;
first_pause=0.01;
second_pause=0.05;
increments=6;
% saveit=1;

[rate_all,numberspikes,imp]=...
    et_rate(module,recdate,cellnum,trial,sample_rate,delay,pulse_length,first_pause,second_pause,increments);

% if saveit~=0
%     save([module '_' recdate '_' cellnum '_et'],'rate_all','numberspikes','imp')
% end

% close all

toc