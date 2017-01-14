% clear;clc;close all

tic

dates_all={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'...
    'May_31_13' 'May_31_13' 'Jun_24_13' 'Jun_24_13' 'Jul_03_13' 'Jul_03_13'...
    'Jul_29_13' 'Jul_29_13' 'Aug_05_13' 'Aug_16_13' 'Sep_05_13' 'Sep_10_13'...
    'Sep_16_13' 'Oct_08_13' 'Oct_08_13'};
cellnum_all={'B' 'A' 'B' 'A' 'A' 'B'...
    'C' 'D' 'A' 'B' 'A' 'B'...
    'A' 'B' 'A' 'A' 'A' 'A'...
    'A' 'A' 'B'};
trials_all=[2 5;3 4;2 3;2 3;2 3;2 3;...
    2 3;2 3;2 3;2 3;2 3;2 3;...
    2 3;4 5;2 3;2 3;2 3;2 3;...
    3 2;3 2;3 2;];

for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    module='fi_curves';
    load([module '_' recdate '_' cellnum])
    % trials=1:numel(whos)-3;
    trials=trials_all(k,:);
    sample_rate=10000;   % Sample rate in Hz
    saveit=1;
    
    [imp,pulse_duration,pause_duration,delay,increments,currents,first_spike_diff,...
        pf_hyperpolarized,pf_depolarized]=...
        spike_diff(module,recdate,cellnum,trials,sample_rate);
    
    if saveit~=0
        save([pwd '\..\..\F_I_curves\data\spike_diff_analysis\' module '_' recdate '_' cellnum '_spike_diff'],'first_spike_diff',...
            'pf_hyperpolarized','pf_depolarized',...
            'imp','pulse_duration','pause_duration','delay',...
            'increments','currents','linfit_hyperpolarized','linfit_depolarized')
    end
    
%     figure;eval(['plot(fi_curves_' recdate '_' cellnum num2str(trials_all(k,1)) '(:,1))'])
%     figure;eval(['plot(fi_curves_' recdate '_' cellnum num2str(trials_all(k,2)) '(:,1))'])
end
% 
% first_spike_slopes=NaN(numel(dates_all),2);
% 
% for k=1:numel(dates_all)
%     eval(['load fi_curves_' dates_all{k} '_' cellnum_all{k} '_spike_diff.mat;'])
%     first_spike_slopes(k,:)=[pf_hyperpolarized(1) pf_depolarized(1)];
% end
% 
% mean_slope=mean(first_spike_slopes);
% std_slope=std(first_spike_slopes);
% 
% 
% figure;errorbar(1:2,mean_slope,std_slope/sqrt(numel(dates_all)),'o');
% title('History-Dependent Change in the Slope of the First Spike Slope vs. Current')
% ylabel('Slope [(mV/ms)/pA]')
% xlabel('Hyperpolarized vs. Depolarized')
% % axis([0.8 2.2 -1 1])
% 
% % close all
% 
% toc