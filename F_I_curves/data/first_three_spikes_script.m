clear;clc;close all

tic

recdate='Mar_19_13';
cellnum='B';
module='fi_curves';
% trials=1:numel(whos)-3;
trials=[2 5];
sample_rate=10000;   % Sample rate in Hz
saveit=0;

[rate_all,ISI,rate_init,spike1avg,spike2avg,spike3avg,spikelastavg,spikelastriseavg,pulse_duration,pause_duration,delay,...
    increments,currents]=first_three_spikes(module,recdate,cellnum,trials,sample_rate);

if saveit~=0
    save([pwd '\..\..\F_I_curves\data\spikes_analysis\' module '_' recdate '_' cellnum '_spikes'],'rate_init',...
        'spike1avg','spike2avg','spike3avg','spikelastavg','spikelastriseavg','pulse_duration',...
        'pause_duration','delay','increments','currents')
end


% close all

toc