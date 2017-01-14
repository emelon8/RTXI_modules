clear;clc;%close all

tic

recdate='Jul_03_13';
cellnum='B';
module='fi_curves';
load([module '_' recdate '_' cellnum])
% trials=1:numel(whos)-3;
trials=[5 3];
points=[29 51 2 32];
sample_rate=10000;   % Sample rate in Hz
shouldplotFV=1; % Should the function plot the F-V curves? 1 for yes, 0 for no.
% saveit=0;

[rate_all,numberspikes,imp,pulse_duration,pause_duration,delay,increments,currents,pf_all,threshold]=...
    fV_rate(module,recdate,cellnum,trials,points,sample_rate,shouldplotFV);

% if saveit~=0
%     save([pwd '\..\..\F_I_curves\data\fV_analysis\' module '_' recdate '_' cellnum '_fV'],'rate_all','imp','pulse_duration',...
%         'pause_duration','delay','increments','currents','pf_all','threshold')
% end

% close all

toc