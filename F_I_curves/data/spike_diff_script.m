clear;clc;%close all

tic
recdate='Oct_08_13';
cellnum='A';
module='fi_curves';
load([module '_' recdate '_' cellnum])
% trials=1:numel(whos)-3;
trials=[3 2];
sample_rate=10000;   % Sample rate in Hz
% saveit=0;

[imp,pulse_duration,pause_duration,delay,increments,currents,first_spike_diff,...
    pf_hyperpolarized,pf_depolarized]=...
    spike_diff(module,recdate,cellnum,trials,sample_rate);

% if saveit~=0
%     save([pwd '\..\..\F_I_curves\data\spike_diff_analysis\' module '_' recdate '_' cellnum '_spike_diff'],'first_spike_diff',...
%         'pf_hyperpolarized','pf_depolarized',...
%         'imp','pulse_duration','pause_duration','delay',...
%         'increments','currents')
% end

% close all

toc