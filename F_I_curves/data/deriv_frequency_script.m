clear;clc;close all

tic
recdate='Mar_21_13';
cellnum='A';
module='fi_curves';
load([module '_' recdate '_' cellnum])
% trials=1:numel(whos)-3;
trials=[3 4];
sample_rate=10000;   % Sample rate in Hz
saveit=1;

[rate,ISI,imp,pulse_duration,pause_duration,delay,increments,currents,deriv_rate]=...
    deriv_frequency(module,recdate,cellnum,trials,sample_rate);

if saveit~=0
    save([pwd '\..\..\F_I_curves\data\deriv_freq_analysis\' module '_' recdate '_' cellnum '_deriv_freq'],'rate','ISI','imp',...
        'pulse_duration','pause_duration','delay','increments','currents','deriv_rate')
end

toc