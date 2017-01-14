clear;clc;%close all

tic

recdate='Mar_19_13';
cellnum='B';
module='fi_curves';
load([module '_' recdate '_' cellnum])
% trials=1:numel(whos)-3;
trials=[2 5];
sample_rate=10000;   % Sample rate in Hz
shouldplotFI=1; % Should the function plot the F-I curves? 1 for yes, 0 for no.
shouldplotISI=0;
shouldplotspikeform=0;
shouldplotsegmenter=0;
saveit=0;

[rate_all,ISI,rate_init,rate_accom,spikeform,imp,gain_ratio,pulse_duration,pause_duration,...
    delay,increments,currents,pf_init,pf_accom,sigfit_init,sigfit_accom,sigslope_init,sigslope_accom]=...
    ISI_rate(module,recdate,cellnum,trials,sample_rate,shouldplotFI,shouldplotISI,shouldplotspikeform);

% [rate_all,ISI,rate_init,rate_accom,spikeform,imp,gain_ratio,pulse_duration,pause_duration,...
%     delay,increments,currents,pf_delay,pf_init,pf_accom,sigfit_delay,sigfit_init,sigfit_accom,...
%     sigslope_delay,sigslope_init,sigslope_accom]=...
%     delay_ISI_rate(module,recdate,cellnum,trials,sample_rate,shouldplotFI
%     ,shouldplotISI,shouldplotspikeform);

% Cuts the trials up into segments
% segmented_trials=segmenter(module,recdate,cellnum,trials,delay,pulse_duration,pause_duration,increments,sample_rate,shouldplotsegmenter);

if saveit~=0
    save([pwd '\..\..\F_I_curves\data\rates_analysis\' module '_' recdate '_' cellnum '_rates'],'rate_all','rate_init','rate_accom',...
        'spikeform','imp','gain_ratio','pulse_duration','pause_duration','delay',...
        'increments','currents','pf_init','pf_accom') %,'pf_delay','sigfit_delay',...
    %         'sigfit_init','sigfit_accom','sigslope_delay','sigslope_init','sigslope_accom')
end

% close all

toc