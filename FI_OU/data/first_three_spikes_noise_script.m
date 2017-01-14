clear;clc;close all

tic

recdate='Oct_03_14';
cellnum='B';
module='FI_OU';
% trials=1:numel(whos)-3;
trials=[4];
sample_rate=10000;   % Sample rate in Hz
saveit=0;

[rate_all,ISI,rate_init,spike1avg,spike2avg,spike3avg,spikelastavg,spikelastriseavg,pulse_duration,pause_duration,delay,...
    increments,currents]=first_three_spikes_noise(module,recdate,cellnum,trials,sample_rate);

if saveit~=0
    save([module '_' recdate '_' cellnum '_spikes'],'rate_init',...
        'spike1avg','spike2avg','spike3avg','spikelastavg','spikelastriseavg','pulse_duration',...
        'pause_duration','delay','increments','currents')
end


% close all

toc