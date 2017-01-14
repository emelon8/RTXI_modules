clear;clc;close all

tic

dates_all={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'...
    'May_31_13' 'May_31_13' 'Jun_24_13' 'Jun_24_13' 'Jul_03_13' 'Jul_03_13'};
cellnum_all={'B' 'A' 'B' 'A' 'A' 'B'...
    'C' 'D' 'A' 'B' 'A' 'B'};
trials_all=[2 5;3 4;2 3;2 3;2 3;2 3;2 3;2 3;2 3;2 3;2 3;2 3;];
% points_all=[1 2 3 4;;;;;;;;;;;];

for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    module='fi_curves';
    load([module '_' recdate '_' cellnum])
    % trials=1:numel(whos)-3;
    trials=trials_all(k,:);
    sample_rate=10000;   % Sample rate in Hz
    shouldplotFI=1; % Should the function plot the F-I curves? 1 for yes, 0 for no.
    shouldplotISI=0;
    shouldplotspikeform=0;
    shouldplotsegmenter=0;
    saveit=0;
    
%     [rate_all,ISI,rate_init,rate_accom,spikeform,imp,gain_ratio,pulse_duration,pause_duration,...
%         delay,increments,currents,pf_init,pf_accom,sigfit_init,sigfit_accom,sigslope_init,sigslope_accom]=...
%         ISI_rate(module,recdate,cellnum,trials,sample_rate,shouldplotFI,shouldplotISI,shouldplotspikeform);
%     
%     [rate_all,ISI,rate_init,rate_accom,spikeform,imp,gain_ratio,pulse_duration,pause_duration,...
%         delay,increments,currents,pf_delay,pf_init,pf_accom,sigfit_delay,sigfit_init,sigfit_accom,...
%         sigslope_delay,sigslope_init,sigslope_accom]=...
%         delay_ISI_rate(module,recdate,cellnum,trials,sample_rate,shouldplotFI,shouldplotISI,shouldplotspikeform);
%     
%     % Cuts the trials up into segments
%     segmented_trials=segmenter(module,recdate,cellnum,trials,delay,pulse_duration,pause_duration,increments,sample_rate,shouldplotsegmenter);
    
    [rate_all,ISI,rate_init,spikes,pulse_duration,pause_duration,delay,...
        increments,currents]=first_three_spikes(module,recdate,cellnum,trials,sample_rate,shouldplotspikeform);
    
    if saveit~=0
        save([pwd '\..\..\F_I_curves\data\rates_analysis\' module '_' recdate '_' cellnum '_rates'],'rate_all','rate_init','rate_accom',...
            'spikeform','imp','gain_ratio','pulse_duration','pause_duration','delay',...
            'increments','currents','pf_init','pf_accom') %,'pf_delay','sigfit_delay',...
        %         'sigfit_init','sigfit_accom','sigslope_delay','sigslope_init','sigslope_accom')
    end
end

% close all

toc