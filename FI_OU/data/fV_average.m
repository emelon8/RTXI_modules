clear;clc;%close all

%no noise cases

dates_all={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'...
    'May_31_13' 'May_31_13' 'Jun_24_13' 'Jun_24_13' 'Jul_03_13' 'Jul_03_13'...
    'Jul_29_13' 'Jul_29_13' 'Aug_05_13' 'Aug_16_13' 'Sep_05_13' 'Sep_16_13'...
    'Oct_08_13' 'Oct_08_13' 'Mar_18_14'};
cellnum_all={'B' 'A' 'B' 'A' 'A' 'B'...
    'C' 'D' 'A' 'B' 'A' 'B'...
    'A' 'B' 'A' 'A' 'A' 'A'...
    'A' 'B' 'A'};

avg_sub_voltage_hyper=NaN(numel(dates_all),51);
avg_sub_voltage_de=NaN(numel(dates_all),51);

for k=1:numel(dates_all)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_curves_' dates_all{k} '_' cellnum_all{k} '_fV.mat;'])
    gains_all(k,1)=pf_all{1}.beta(2);
    gains_all(k,2)=pf_all{2}.beta(2);
    rsq_all(k,1)=pf_all{1}.rsquare;
    rsq_all(k,2)=pf_all{2}.rsquare;
    threshold_all(k,:)=threshold;
    avg_voltage_hyper_all(k,:)=avg_voltage{1};
%     avg_voltage_de_all(k,:)=avg_voltage{2};
    currents_hyper_all(k,:)=currents{1};
%     currents_de_all(k,:)=currents{2};
    rate_hyper_all(k,:)=rate_all{1};
%     rate_de_all(k,:)=rate_all{2};
    if sum(rate_hyper_all(k,:)>=2)
        hyper_2threshold(k)=find(rate_hyper_all(k,:)>=2,1);
        avg_sub_voltage_hyper(k,1:hyper_2threshold(k)-1)=avg_voltage_hyper_all(k,1:hyper_2threshold(k)-1);
    else
        hyper_2threshold(k)=NaN;
        avg_sub_voltage_hyper(k,:)=avg_voltage_hyper_all(k,:);
    end
%     if sum(rate_de_all(k,:)>=2)
%         de_2threshold(k)=find(rate_de_all(k,:)>=2,1);
%         avg_sub_voltage_de(k,1:de_2threshold(k)-1)=avg_voltage_de_all(k,1:de_2threshold(k)-1);
%     else
%         de_2threshold(k)=NaN;
%         avg_sub_voltage_de(k,:)=avg_voltage_de_all(k,:);
%     end
end

mean_gains=mean(gains_all);
std_gains=std(gains_all);
mean_threshold=mean(threshold_all);
std_threshold=std(threshold_all);

% diff_voltage_all=avg_voltage_hyper_all-avg_voltage_de_all;

mean_avg_voltage_hyper=mean(avg_voltage_hyper_all);
std_avg_voltage_hyper=std(avg_voltage_hyper_all);
ste_avg_voltage_hyper=std_avg_voltage_hyper/sqrt(numel(dates_all));
% mean_avg_voltage_de=mean(avg_voltage_de_all);
% std_avg_voltage_de=std(avg_voltage_de_all);
% ste_avg_voltage_de=std_avg_voltage_de/sqrt(numel(dates_all));
% mean_diff_voltage=mean(diff_voltage_all);
% std_diff_voltage=std(diff_voltage_all);
% ste_diff_voltage=std_diff_voltage/sqrt(numel(dates_all));


%noise cases

noise_dates_all={'Oct_03_14' 'Oct_06_14' 'Oct_06_14' 'Oct_14_14' 'Oct_14_14' 'Oct_14_14'...
    'Oct_15_14' 'Oct_23_14' 'Oct_24_14' 'Oct_24_14' 'Nov_26_14' 'Jan_27_15'...
    'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Feb_10_15'};
noise_cellnum_all={'B' 'A' 'C' 'A' 'B' 'C'...
    'A' 'A' 'A' 'B' 'A' 'A'...
    'B' 'A' 'B' 'C' 'B' 'C'};
noise_trials_all=[4 3 3 2 1 1 ...
    1 1 2 2 2 1 ...
    1 1 1 1 1 1]';

avg_sub_voltage_hyper=NaN(numel(dates_all),20);
% avg_sub_voltage_de=NaN(numel(dates_all),51);

for k=1:numel(noise_dates_all)
    eval(['load FI_OU_' noise_dates_all{k} '_' noise_cellnum_all{k} num2str(noise_trials_all(k)) '_fV.mat;'])
    noise_gains_all(k,1)=pf_all{1}.beta(2);
    noise_gains_all(k,2)=pf_all{2}.beta(2);
    noise_rsq_all(k,1)=pf_all{1}.rsquare;
    noise_rsq_all(k,2)=pf_all{2}.rsquare;
    noise_threshold_all(k,:)=threshold;
    noise_avg_voltage_hyper_all(k,:)=avg_voltage{1};
%     noise_avg_voltage_de_all(k,:)=avg_voltage{2};
    noise_currents_hyper_all(k,:)=currents{1};
%     noise_currents_de_all(k,:)=currents{2};
    noise_rate_hyper_all(k,:)=rate_all{1};
%     noise_rate_de_all(k,:)=rate_all{2};
    if sum(noise_rate_hyper_all(k,:)>=2)
        noise_hyper_2threshold(k)=find(noise_rate_hyper_all(k,:)>=2,1);
        noise_avg_sub_voltage_hyper(k,1:noise_hyper_2threshold(k)-1)=noise_avg_voltage_hyper_all(k,1:noise_hyper_2threshold(k)-1);
    else
        noise_hyper_2threshold(k)=NaN;
        noise_avg_sub_voltage_hyper(k,:)=noise_avg_voltage_hyper_all(k,:);
    end
%     if sum(noise_rate_de_all(k,:)>=2)
%         noise_de_2threshold(k)=find(noise_rate_de_all(k,:)>=2,1);
%         noise_avg_sub_voltage_de(k,1:noise_de_2threshold(k)-1)=noise_avg_voltage_de_all(k,1:noise_de_2threshold(k)-1);
%     else
%         noise_de_2threshold(k)=NaN;
%         noise_avg_sub_voltage_de(k,:)=noise_avg_voltage_de_all(k,:);
%     end
end

noise_mean_gains=mean(noise_gains_all);
noise_std_gains=std(noise_gains_all);
noise_mean_threshold=mean(noise_threshold_all);
noise_std_threshold=std(noise_threshold_all);

% noise_diff_voltage_all=noise_avg_voltage_hyper_all-noise_avg_voltage_de_all;

noise_mean_avg_voltage_hyper=mean(noise_avg_voltage_hyper_all);
noise_std_avg_voltage_hyper=std(noise_avg_voltage_hyper_all);
noise_ste_avg_voltage_hyper=noise_std_avg_voltage_hyper/sqrt(numel(noise_dates_all));
% noise_mean_avg_voltage_de=mean(noise_avg_voltage_de_all);
% noise_std_avg_voltage_de=std(noise_avg_voltage_de_all);
% noise_ste_avg_voltage_de=noise_std_avg_voltage_de/sqrt(numel(noise_dates_all));
% noise_mean_diff_voltage=mean(noise_diff_voltage_all);
% noise_std_diff_voltage=std(noise_diff_voltage_all);
% noise_ste_diff_voltage=noise_std_diff_voltage/sqrt(numel(noise_dates_all));


% noise_sub_resistance_hyper=(diff(noise_avg_sub_voltage_hyper')'/(noise_currents_hyper_all(k,2)-noise_currents_hyper_all(k,1)))/1e-9; % find the resistance in ohms
% noise_sub_resistance_de=(diff(noise_avg_sub_voltage_de')'/(noise_currents_de_all(k,2)-noise_currents_de_all(k,1)))/1e-9;
% noise_diff_sub_resistance=noise_sub_resistance_hyper-noise_sub_resistance_de;

% noise_mean_sub_resistance_hyper=nanmean(noise_sub_resistance_hyper);
% noise_std_sub_resistance_hyper=nanstd(noise_sub_resistance_hyper);
% noise_nh=length(noise_sub_resistance_hyper(:,1))-sum(isnan(noise_sub_resistance_hyper));
% noise_ste_sub_resistance_hyper=noise_std_sub_resistance_hyper./sqrt(noise_nh);
% noise_mean_sub_resistance_de=nanmean(noise_sub_resistance_de);
% noise_std_sub_resistance_de=nanstd(noise_sub_resistance_de);
% noise_nd=length(noise_sub_resistance_de(:,1))-sum(isnan(noise_sub_resistance_de));
% noise_ste_sub_resistance_de=noise_std_sub_resistance_de./sqrt(noise_nd);
% noise_mean_sub_diff_resistance=nanmean(noise_diff_sub_resistance);
% noise_std_sub_diff_resistance=nanstd(noise_diff_sub_resistance);
% noise_ndiff=length(noise_diff_sub_resistance(:,1))-sum(isnan(noise_diff_sub_resistance));
% noise_ste_sub_diff_resistance=noise_std_sub_diff_resistance./sqrt(noise_ndiff);


figure;shadedErrorBar(-50:5:200,mean_avg_voltage_hyper,ste_avg_voltage_hyper,'k')
hold on;shadedErrorBar(10:10:200,noise_mean_avg_voltage_hyper,noise_ste_avg_voltage_hyper,'r')
title('I-V Curves for Hyperpolarized (Black) and Hyperpolarized with Noise (Red)')

% figure;shadedErrorBar(-50:5:200,noise_mean_diff_voltage,noise_ste_diff_voltage)
% title('Difference Between I-V Curves (Hyperpolarized - Depolarized)')

% figure;shadedErrorBar(-45:5:200,noise_mean_sub_resistance_hyper,noise_ste_sub_resistance_hyper)
% hold on;shadedErrorBar(-45:5:200,noise_mean_sub_resistance_de,noise_ste_sub_resistance_de,'r')
% title('Resistance Curves for Hyperpolarized (Black) and Depolarized (Red)')

% figure;shadedErrorBar(-45:5:200,noise_mean_sub_diff_resistance,noise_ste_sub_diff_resistance)
% title('Difference Between Resistance Curves (Hyperpolarized - Depolarized)')

% [noise_gainsttest(1),noise_gainsttest(2)]=ttest(gains_all(:,1),gains_all(:,2));
% [noise_thresholdttest(1),noise_thresholdttest(2)]=ttest(noise_threshold_all(:,1),noise_threshold_all(:,2));

% figure;errorbar(1:2,noise_mean_gains,noise_std_gains/sqrt(numel(noise_dates_all)),'or','LineWidth',2);
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/mV]')
% xlabel('Hyperpolarized vs. Depolarized')
% % axis([0.8 2.2 0 0.25])
% 
% figure;errorbar(1:2,noise_mean_threshold,noise_std_threshold/sqrt(numel(noise_dates_all)),'or','LineWidth',2);
% title('History-Dependent Change in Threshold')
% ylabel('Threshold [mV]')
% xlabel('Hyperpolarized vs. Depolarized')
% % axis([0.8 2.2 0 0.25])