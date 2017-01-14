clear;clc;%close all

tic

recdate='Feb_03_15';
cellnum='B';
module='FI_OU';
load([module '_' recdate '_' cellnum])
% trials=1:numel(whos)-3;
trials=[1 2];
points=[3 4 3 4];
sample_rate=10000;   % Sample rate in Hz
shouldplotFV=1; % Should the function plot the F-V curves? 1 for yes, 0 for no.
% saveit=0;

[rate_all,numberspikes,imp,pulse_duration,pause_duration,delay,increments,currents,pf_all,threshold]=...
    fV_rate(module,recdate,cellnum,trials,points,sample_rate,shouldplotFV);

% if saveit~=0
%     save([module '_' recdate '_' cellnum '_fV'],'rate_all','imp','pulse_duration',...
%         'pause_duration','delay','increments','currents','pf_all','threshold')
% end

% close all

toc