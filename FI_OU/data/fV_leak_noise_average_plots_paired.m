clear;clc;%close all

%% Hyperpolarized (5 sec pulse, 1 sec pause)
% For Depolarized

dates_all_hypervde={'Dec_22_14' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Feb_10_15' 'Mar_03_15'...
    'Mar_06_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15'...
    'Mar_16_15' 'Mar_16_15' 'Mar_16_15' 'Mar_17_15' 'Mar_17_15' 'Mar_18_15'...
    'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15'...
    'Apr_03_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15' 'Apr_08_15'...
    'Apr_08_15' 'Apr_08_15'};
cellnum_all_hypervde={'C' 'A' 'B' 'B' 'C' 'A'...
    'A' 'A' 'C' 'D' 'B' 'A'...
    'B' 'C' 'D' 'A' 'B' 'A'...
    'B' 'B' 'C' 'D' 'E' 'B'...
    'B' 'B' 'A' 'C' 'D' 'C'...
    'D' 'E'};
trials_all_hypervde=[1 1 1 1 1 1 ...
    1 3 1 1 3 3 ...
    7 1 3 1 1 5 ...
    3 1 1 1 1 3 ...
    6 5 5 5 3 3 ...
    6 4]';

% for k=1:numel(dates_all_hypervde)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_hypervde{k} '_' cellnum_all_hypervde{k} num2str(trials_all_hypervde(k)) '_fV.mat;'])
%     #peakrate_all_hypervde(k,:)=peakrate;
%     #nofailrate_all_hypervde(k,:)=nofailrate;
%     gains_all_hypervde(k,1)=pf_all{1}.beta(2);
% %     gains_all_hypervde(k,2)=pf_all{2}.beta(2);
%     rsq_all_hypervde(k,1)=pf_all{1}.rsquare;
% %     rsq_all_hypervde(k,2)=pf_all{2}.rsquare;
%     rate_all_hypervde(k,:)=rate_all{1};
%     imp_all_hypervde(k,:)=imp;
%     #holdingvoltage_all_hypervde(k,:)=mean_holdingvoltage;
% %     hold on;plot([1 2],gains_all_hypervde(k,:),'or')
% end
% 
% gains_all_hypervde(isnan(rsq_all_hypervde))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_hypervde=nanmean(peakrate_all_hypervde);
% std_peakrate_hypervde=nanstd(peakrate_all_hypervde);
% mean_nofailrate_hypervde=nanmean(nofailrate_all_hypervde);
% std_nofailrate_hypervde=nanstd(nofailrate_all_hypervde);
% mean_gains_hypervde=nanmean(gains_all_hypervde);
% std_gains_hypervde=nanstd(gains_all_hypervde);
% ste_gains_hypervde=std_gains_hypervde/sqrt(sum(~isnan(gains_all_hypervde)));
% mean_imp_hypervde=nanmean(imp_all_hypervde);
% std_imp_hypervde=nanstd(imp_all_hypervde);
% mean_holdingvoltage_all_hypervde=nanmean(holdingvoltage_all_hypervde);
% std_holdingvoltage_all_hypervde=nanstd(holdingvoltage_all_hypervde);
% 
sub_currents_hyper_all=NaN(numel(dates_all_hypervde),21);
sub_currents_de_all=NaN(numel(dates_all_hypervde),21);
avg_sub_voltage_hyper=NaN(numel(dates_all_hypervde),21);
avg_sub_voltage_de=NaN(numel(dates_all_hypervde),21);
sup_currents_hyper_all=NaN(numel(dates_all_hypervde),21);
sup_currents_de_all=NaN(numel(dates_all_hypervde),21);
avg_sup_voltage_hyper=NaN(numel(dates_all_hypervde),21);
avg_sup_voltage_de=NaN(numel(dates_all_hypervde),21);
smooth_sub_resistance_hyper=NaN(numel(dates_all_hypervde),21);
smooth_sub_resistance_de=NaN(numel(dates_all_hypervde),21);
smooth_voltages_hyper=NaN(numel(dates_all_hypervde),21);
smooth_voltages_de=NaN(numel(dates_all_hypervde),21);
bin_size=10; %in mV
bins=-90:bin_size:-30; %in mV
binned_resistances_hyper=NaN(numel(dates_all_hypervde),numel(bins));
binned_resistances_de=NaN(numel(dates_all_hypervde),numel(bins));

for k=1:numel(dates_all_hypervde)
    eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_hypervde{k} '_' cellnum_all_hypervde{k} num2str(trials_all_hypervde(k)) '_fV.mat;'])
    gains_all(k,1)=pf_all{1}.beta(2);
    rsq_all(k,1)=pf_all{1}.rsquare;
    threshold_all(k,1)=threshold;
    avg_voltage_hyper_all(k,:)=avg_voltage{1};
    currents_hyper_all(k,:)=currents{1};
    rate_hyper_all(k,:)=rate_all{1};
    if sum(rate_hyper_all(k,:)>=1)
        hyper_2threshold(k)=find(rate_hyper_all(k,:)>=1,1);
        sub_currents_hyper_all(k,1:hyper_2threshold(k)-1)=currents_hyper_all(k,1:hyper_2threshold(k)-1);
        avg_sub_voltage_hyper(k,1:hyper_2threshold(k)-1)=avg_voltage_hyper_all(k,1:hyper_2threshold(k)-1);
        sup_currents_hyper_all(k,hyper_2threshold(k):end)=currents_hyper_all(k,hyper_2threshold(k):end);
        avg_sup_voltage_hyper(k,hyper_2threshold(k):end)=avg_voltage_hyper_all(k,hyper_2threshold(k):end);
    else
        hyper_2threshold(k)=NaN;
        sub_currents_hyper_all(k,:)=currents_hyper_all(k,:);
        avg_sub_voltage_hyper(k,:)=avg_voltage_hyper_all(k,:);
    end
    for h=1:numel(avg_sub_voltage_hyper(k,:))-3
        smooth_voltages_hyper(k,h)=mean(avg_sub_voltage_hyper(k,h:h+3));
        resistance_hyper_fit=polyfit(currents_hyper_all(k,h:h+3),avg_sub_voltage_hyper(k,h:h+3),1);
        smooth_sub_resistance_hyper(k,h)=resistance_hyper_fit(1);
    end
    for p=1:numel(bins)-1
        binned_resistances_hyper(k,p)=mean(smooth_sub_resistance_hyper(k,smooth_voltages_hyper(k,:)<bins(p+1) & bins(p)<smooth_voltages_hyper(k,:)));
    end
end


% Depolarized (5 sec pulse, 1 sec pause)
% For Hyperpolarized

% Good quality data only
dates_all_devhyper={'Dec_22_14' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Feb_10_15' 'Mar_03_15'...
    'Mar_06_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15'...
    'Mar_16_15' 'Mar_16_15' 'Mar_16_15' 'Mar_17_15' 'Mar_17_15' 'Mar_18_15'...
    'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15'...
    'Apr_03_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15' 'Apr_08_15'...
    'Apr_08_15' 'Apr_08_15'};
cellnum_all_devhyper={'C' 'A' 'B' 'B' 'C' 'A'...
    'A' 'A' 'C' 'D' 'B' 'A'...
    'B' 'C' 'D' 'A' 'B' 'A'...
    'B' 'B' 'C' 'D' 'E' 'B'...
    'B' 'B' 'A' 'C' 'D' 'C'...
    'D' 'E'};
trials_all_devhyper=[2 2 2 2 2 2 ...
    2 4 2 2 2 4 ...
    8 2 4 2 2 6 ...
    4 2 2 2 2 4 ...
    7 6 6 6 4 4 ...
    7 5]';

for k=1:numel(dates_all_devhyper)
    eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_devhyper{k} '_' cellnum_all_devhyper{k} num2str(trials_all_devhyper(k)) '_fV.mat;'])
    gains_all(k,2)=pf_all{1}.beta(2);
    rsq_all(k,2)=pf_all{1}.rsquare;
    threshold_all(k,2)=threshold;
    avg_voltage_de_all(k,:)=avg_voltage{1};
    currents_de_all(k,:)=currents{1};
    rate_de_all(k,:)=rate_all{1};
    if sum(rate_de_all(k,:)>=1)
        de_2threshold(k)=find(rate_de_all(k,:)>=1,1);
        sub_currents_de_all(k,1:de_2threshold(k)-1)=currents_de_all(k,1:de_2threshold(k)-1);
        avg_sub_voltage_de(k,1:de_2threshold(k)-1)=avg_voltage_de_all(k,1:de_2threshold(k)-1);
        sup_currents_de_all(k,de_2threshold(k):end)=currents_de_all(k,de_2threshold(k):end);
        avg_sup_voltage_de(k,de_2threshold(k):end)=avg_voltage_de_all(k,de_2threshold(k):end);
    else
        de_2threshold(k)=NaN;
        sub_currents_de_all(k,:)=currents_de_all(k,:);
        avg_sub_voltage_de(k,:)=avg_voltage_de_all(k,:);
    end
    for h=1:numel(avg_sub_voltage_hyper(k,:))-3
        smooth_voltages_de(k,h)=mean(avg_sub_voltage_de(k,h:h+3));
        resistance_de_fit=polyfit(currents_de_all(k,h:h+3),avg_sub_voltage_de(k,h:h+3),1);
        smooth_sub_resistance_de(k,h)=resistance_de_fit(1);
    end
    for p=1:numel(bins)-1
        binned_resistances_de(k,p)=mean(smooth_sub_resistance_de(k,smooth_voltages_de(k,:)<bins(p+1) & bins(p)<smooth_voltages_de(k,:)));
    end
end

mean_binned_resistances_hyper=nanmean(binned_resistances_hyper);
std_binned_resistances_hyper=nanstd(binned_resistances_hyper);
ste_binned_resistances_hyper=std_binned_resistances_hyper./sqrt(sum(isfinite(binned_resistances_hyper)));
mean_binned_resistances_de=nanmean(binned_resistances_de);
std_binned_resistances_de=nanstd(binned_resistances_de);
ste_binned_resistances_de=std_binned_resistances_de./sqrt(sum(isfinite(binned_resistances_de)));

figure;shadedErrorBar(bins+bin_size/2,mean_binned_resistances_hyper*1e3,ste_binned_resistances_hyper*1e3)
hold on;shadedErrorBar(bins+bin_size/2,mean_binned_resistances_de*1e3,ste_binned_resistances_de*1e3,'r')

mean_gains=mean(gains_all);
std_gains=std(gains_all);
mean_threshold=mean(threshold_all);
std_threshold=std(threshold_all);

diff_voltage_all=avg_voltage_hyper_all-avg_voltage_de_all;

mean_avg_voltage_hyper=mean(avg_voltage_hyper_all);
std_avg_voltage_hyper=std(avg_voltage_hyper_all);
ste_avg_voltage_hyper=std_avg_voltage_hyper/sqrt(numel(dates_all_hypervde));
mean_avg_voltage_de=mean(avg_voltage_de_all);
std_avg_voltage_de=std(avg_voltage_de_all);
ste_avg_voltage_de=std_avg_voltage_de/sqrt(numel(dates_all_hypervde));
mean_diff_voltage=mean(diff_voltage_all);
std_diff_voltage=std(diff_voltage_all);
ste_diff_voltage=std_diff_voltage/sqrt(numel(dates_all_hypervde));

figure;errorbar(0:10:200,nanmean(avg_sub_voltage_hyper),nanstd(avg_sub_voltage_hyper)./sqrt(sum(~isnan(avg_sub_voltage_hyper))));
hold on;errorbar(0:10:200,nanmean(avg_sup_voltage_hyper),nanstd(avg_sup_voltage_hyper)./sqrt(sum(~isnan(avg_sup_voltage_hyper))),'r');
hold on;errorbar(0:10:200,nanmean(avg_sub_voltage_de),nanstd(avg_sub_voltage_de)./sqrt(sum(~isnan(avg_sub_voltage_de))),'g');
hold on;errorbar(0:10:200,nanmean(avg_sup_voltage_de),nanstd(avg_sup_voltage_de)./sqrt(sum(~isnan(avg_sup_voltage_de))),'m');
title({'Subthreshold Hyperpolarized (Blue)';'Suprathreshold Hyperpolarized (Red)';'Subthreshold Depolarized (Green)';'Suprathreshold Depolarized (Magenta)'})

sub_resistance_hyper=(diff(avg_sub_voltage_hyper')'/(currents_hyper_all(k,2)-currents_hyper_all(k,1)))/1e-9; % find the resistance in ohms
sub_resistance_de=(diff(avg_sub_voltage_de')'/(currents_de_all(k,2)-currents_de_all(k,1)))/1e-9;
diff_sub_resistance=sub_resistance_hyper-sub_resistance_de;

mean_sub_resistance_hyper=nanmean(sub_resistance_hyper);
std_sub_resistance_hyper=nanstd(sub_resistance_hyper);
nh=length(sub_resistance_hyper(:,1))-sum(isnan(sub_resistance_hyper));
ste_sub_resistance_hyper=std_sub_resistance_hyper./sqrt(nh);
mean_sub_resistance_de=nanmean(sub_resistance_de);
std_sub_resistance_de=nanstd(sub_resistance_de);
nd=length(sub_resistance_de(:,1))-sum(isnan(sub_resistance_de));
ste_sub_resistance_de=std_sub_resistance_de./sqrt(nd);
mean_sub_diff_resistance=nanmean(diff_sub_resistance);
std_sub_diff_resistance=nanstd(diff_sub_resistance);
ndiff=length(diff_sub_resistance(:,1))-sum(isnan(diff_sub_resistance));
ste_sub_diff_resistance=std_sub_diff_resistance./sqrt(ndiff);


figure;shadedErrorBar(0:10:200,mean_avg_voltage_hyper,ste_avg_voltage_hyper)
hold on;shadedErrorBar(0:10:200,mean_avg_voltage_de,ste_avg_voltage_de,'r')
title('I-V Curves for Hyperpolarized (Black) and Depolarized (Red)')

clear

% figure;shadedErrorBar(0:10:200,mean_diff_voltage,ste_diff_voltage)
% title('Difference Between I-V Curves (Hyperpolarized - Depolarized)')

% figure;shadedErrorBar(0:10:200,mean_sub_resistance_hyper,ste_sub_resistance_hyper)
% hold on;shadedErrorBar(0:10:200,mean_sub_resistance_de,ste_sub_resistance_de,'r')
% title('Resistance Curves for Hyperpolarized (Black) and Depolarized (Red)')

% %find averages of 5 different spots on the Resistance Curve
% diff_currents=0:10:200;
% currents1=mean(diff_currents(1:4));
% mean_sub_resistance_hyper1=mean(mean_sub_resistance_hyper(1:4));
% ste_sub_resistance_hyper1=mean(ste_sub_resistance_hyper(1:4));
% mean_sub_resistance_de1=mean(mean_sub_resistance_de(1:4));
% ste_sub_resistance_de1=mean(ste_sub_resistance_de(1:4));
% currents2=mean(diff_currents(5:8));
% mean_sub_resistance_hyper2=mean(mean_sub_resistance_hyper(5:8));
% ste_sub_resistance_hyper2=mean(ste_sub_resistance_hyper(5:8));
% mean_sub_resistance_de2=mean(mean_sub_resistance_de(5:8));
% ste_sub_resistance_de2=mean(ste_sub_resistance_de(5:8));
% currents3=mean(diff_currents(9:12));
% mean_sub_resistance_hyper3=mean(mean_sub_resistance_hyper(9:12));
% ste_sub_resistance_hyper3=mean(ste_sub_resistance_hyper(9:12));
% mean_sub_resistance_de3=mean(mean_sub_resistance_de(9:12));
% ste_sub_resistance_de3=mean(ste_sub_resistance_de(9:12));
% currents4=mean(diff_currents(13:16));
% mean_sub_resistance_hyper4=mean(mean_sub_resistance_hyper(13:16));
% ste_sub_resistance_hyper4=mean(ste_sub_resistance_hyper(13:16));
% mean_sub_resistance_de4=mean(mean_sub_resistance_de(13:16));
% ste_sub_resistance_de4=mean(ste_sub_resistance_de(13:16));
% currents5=mean(diff_currents(17:20));
% mean_sub_resistance_hyper5=mean(mean_sub_resistance_hyper(17:20));
% ste_sub_resistance_hyper5=mean(ste_sub_resistance_hyper(17:20));
% mean_sub_resistance_de5=mean(mean_sub_resistance_de(17:20));
% ste_sub_resistance_de5=mean(ste_sub_resistance_de(17:20));
% 
% currents_points=[currents1 currents2 currents3 currents4 currents5];
% mean_sub_resistance_points_hyper=[mean_sub_resistance_hyper1 mean_sub_resistance_hyper2 mean_sub_resistance_hyper3 mean_sub_resistance_hyper4 mean_sub_resistance_hyper5];
% ste_sub_resistance_points_hyper=[ste_sub_resistance_hyper1 ste_sub_resistance_hyper2 ste_sub_resistance_hyper3 ste_sub_resistance_hyper4 ste_sub_resistance_hyper5];
% mean_sub_resistance_points_de=[mean_sub_resistance_de1 mean_sub_resistance_de2 mean_sub_resistance_de3 mean_sub_resistance_de4 mean_sub_resistance_de5];
% ste_sub_resistance_points_de=[ste_sub_resistance_de1 ste_sub_resistance_de2 ste_sub_resistance_de3 ste_sub_resistance_de4 ste_sub_resistance_de5];
% 
% figure;errorbar(currents_points,mean_sub_resistance_points_hyper,ste_sub_resistance_points_hyper,'k')
% hold on;errorbar(currents_points,mean_sub_resistance_points_de,ste_sub_resistance_points_de,'r')
% 
% %find running average of Average Resistance Curves
% for k=2:numel(mean_sub_resistance_hyper)-1
%     smooth_mean_sub_resistance_hyper(k-1)=mean(mean_sub_resistance_hyper(k-1:k+1));
%     smooth_ste_sub_resistance_hyper(k-1)=mean(ste_sub_resistance_hyper(k-1:k+1)); %should I take the mean of the stes?
%     smooth_mean_sub_resistance_de(k-1)=mean(mean_sub_resistance_de(k-1:k+1));
%     smooth_ste_sub_resistance_de(k-1)=mean(ste_sub_resistance_de(k-1:k+1));
% end
% figure;shadedErrorBar(10:10:190,smooth_mean_sub_resistance_hyper,smooth_ste_sub_resistance_hyper)
% hold on;shadedErrorBar(10:10:190,smooth_mean_sub_resistance_de,smooth_ste_sub_resistance_de,'r')
% title('Smoothed Resistance Curves for Hyperpolarized (Black) and Depolarized (Red)')

% figure;shadedErrorBar(10:10:200,mean_sub_diff_resistance,ste_sub_diff_resistance)
% title('Difference Between Resistance Curves (Hyperpolarized - Depolarized)')

% [gainsttest(1),gainsttest(2)]=ttest(gains_all(:,1),gains_all(:,2));
% [thresholdttest(1),thresholdttest(2)]=ttest(threshold_all(:,1),threshold_all(:,2));
% 
% figure;errorbar(1:2,mean_gains,std_gains/sqrt(numel(dates_all_hypervde)),'or','LineWidth',2);
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/mV]')
% xlabel('Hyperpolarized vs. Depolarized')
% % axis([0.8 2.2 0 0.25])
% 
% figure;errorbar(1:2,mean_threshold,std_threshold/sqrt(numel(dates_all_hypervde)),'or','LineWidth',2);
% title('History-Dependent Change in Threshold')
% ylabel('Threshold [mV]')
% xlabel('Hyperpolarized vs. Depolarized')
% % axis([0.8 2.2 0 0.25])

% for k=1:numel(dates_all_devhyper)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_devhyper{k} '_' cellnum_all_devhyper{k} num2str(trials_all_devhyper(k)) '_fV.mat;'])
%     peakrate_all_devhyper(k,:)=peakrate;
%     nofailrate_all_devhyper(k,:)=nofailrate;
%     gains_all_devhyper(k,1)=pf_all{1}.beta(2);
%     rsq_all_devhyper(k,1)=pf_all{1}.rsquare;
%     rate_all_devhyper(k,:)=rate_all{1};
%     imp_all_devhyper(k,:)=imp;
%     holdingvoltage_all_devhyper(k,:)=mean_holdingvoltage;
% end
% 
% gains_all_devhyper(isnan(rsq_all_devhyper))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_devhyper=nanmean(peakrate_all_devhyper);
% std_peakrate_devhyper=nanstd(peakrate_all_devhyper);
% mean_nofailrate_devhyper=nanmean(nofailrate_all_devhyper);
% std_nofailrate_devhyper=nanstd(nofailrate_all_devhyper);
% mean_gains_devhyper=nanmean(gains_all_devhyper);
% std_gains_devhyper=nanstd(gains_all_devhyper);
% ste_gains_devhyper=std_gains_devhyper/sqrt(sum(~isnan(gains_all_devhyper)));
% mean_imp_devhyper=nanmean(imp_all_devhyper);
% std_imp_devhyper=nanstd(imp_all_devhyper);
% mean_holdingvoltage_all_devhyper=nanmean(holdingvoltage_all_devhyper);
% std_holdingvoltage_all_devhyper=nanstd(holdingvoltage_all_devhyper);
% 
% % difference between rates
% difference_rate_hypervde=rate_all_devhyper-rate_all_hypervde;
% mean_difference_rate_hypervde=nanmean(difference_rate_hypervde);
% std_difference_rate_hypervde=nanstd(difference_rate_hypervde);
% ste_difference_rate_hypervde=std_difference_rate_hypervde./sqrt(sum(~isnan(difference_rate_hypervde)));


%% Hyperpolarized (5 sec pulse, 1 sec pause; Currents go from 0:10:200)
% For Hyperpolarized with Noise

% % These are the 1 sec pulse, 1 sec pauses
% dates_all_hypervhypernoise={'Oct_03_14' 'Oct_06_14' 'Oct_06_14' 'Oct_14_14' 'Oct_14_14'};
% cellnum_all_hypervhypernoise={'B' 'A' 'C' 'A' 'B'};
% trials_all_hypervhypernoise=[1 1 1 1 1]';
dates_all_hypervhypernoise={'Feb_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15' 'Mar_16_15'... 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Mar_03_15' 'Mar_06_15' 'Mar_10_15'
    'Mar_17_15' 'Mar_18_15' 'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15'...
    'Mar_24_15' 'Apr_03_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15'};
cellnum_all_hypervhypernoise={'B' 'A' 'D' 'B' 'B' 'C'... 'A' 'B' 'C' 'A' 'A' 'C'
    'A' 'A' 'B' 'B' 'D' 'E'...
    'B' 'B' 'B' 'C' 'D'};
trials_all_hypervhypernoise=[1 3 1 3 7 1 ... 1 1 1 1 1 1
    1 5 3 1 1 1 ...
    3 6 5 5 3]';

sub_currents_hyper_all=NaN(numel(dates_all_hypervhypernoise),21);
sub_currents_de_all=NaN(numel(dates_all_hypervhypernoise),21);
sub_skew_noise_all_hyper_noisevhyper=NaN(numel(dates_all_hypervhypernoise),21);
avg_sub_voltage_hyper=NaN(numel(dates_all_hypervhypernoise),21);
avg_sub_voltage_de=NaN(numel(dates_all_hypervhypernoise),21);
sup_currents_hyper_all=NaN(numel(dates_all_hypervhypernoise),21);
sup_currents_de_all=NaN(numel(dates_all_hypervhypernoise),21);
sup_skew_noise_all_hyper_noisevhyper=NaN(numel(dates_all_hypervhypernoise),21);
avg_sup_voltage_hyper=NaN(numel(dates_all_hypervhypernoise),21);
avg_sup_voltage_de=NaN(numel(dates_all_hypervhypernoise),21);
smooth_sub_resistance_hyper=NaN(numel(dates_all_hypervhypernoise),21);
smooth_sub_resistance_de=NaN(numel(dates_all_hypervhypernoise),21);
smooth_voltages_hyper=NaN(numel(dates_all_hypervhypernoise),21);
smooth_voltages_de=NaN(numel(dates_all_hypervhypernoise),21);
bin_size=10; %in mV
bins=-110:bin_size:-30; %in mV
binned_resistances_hyper=NaN(numel(dates_all_hypervhypernoise),numel(bins));
binned_resistances_de=NaN(numel(dates_all_hypervhypernoise),numel(bins));

for k=1:numel(dates_all_hypervhypernoise)
    eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_hypervhypernoise{k} '_' cellnum_all_hypervhypernoise{k} num2str(trials_all_hypervhypernoise(k)) '_fV.mat;'])
    gains_all(k,1)=pf_all{1}.beta(2);
    rsq_all(k,1)=pf_all{1}.rsquare;
    threshold_all(k,1)=threshold;
    avg_voltage_hyper_all(k,:)=avg_voltage{1};
    currents_hyper_all(k,:)=currents{1};
    rate_hyper_all(k,:)=rate_all{1};
    if sum(rate_hyper_all(k,:)>=1)
        hyper_2threshold(k)=find(rate_hyper_all(k,:)>=1,1);
        sub_currents_hyper_all(k,1:hyper_2threshold(k)-1)=currents_hyper_all(k,1:hyper_2threshold(k)-1);
        avg_sub_voltage_hyper(k,1:hyper_2threshold(k)-1)=avg_voltage_hyper_all(k,1:hyper_2threshold(k)-1);
        sup_currents_hyper_all(k,hyper_2threshold(k):end)=currents_hyper_all(k,hyper_2threshold(k):end);
        avg_sup_voltage_hyper(k,hyper_2threshold(k):end)=avg_voltage_hyper_all(k,hyper_2threshold(k):end);
    else
        hyper_2threshold(k)=NaN;
        sub_currents_hyper_all(k,:)=currents_hyper_all(k,:);
        avg_sub_voltage_hyper(k,:)=avg_voltage_hyper_all(k,:);
    end
    for h=1:numel(avg_sub_voltage_hyper(k,:))-3
        smooth_voltages_hyper(k,h)=mean(avg_sub_voltage_hyper(k,h:h+3));
        resistance_hyper_fit=polyfit(currents_hyper_all(k,h:h+3),avg_sub_voltage_hyper(k,h:h+3),1);
        smooth_sub_resistance_hyper(k,h)=resistance_hyper_fit(1);
    end
    for p=1:numel(bins)-1
        binned_resistances_hyper(k,p)=mean(smooth_sub_resistance_hyper(k,smooth_voltages_hyper(k,:)<bins(p+1) & bins(p)<smooth_voltages_hyper(k,:)));
    end
end

% for k=1:numel(dates_all_hypervhypernoise)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_hypervhypernoise{k} '_' cellnum_all_hypervhypernoise{k} num2str(trials_all_hypervhypernoise(k)) '_fV.mat;'])
%     peakrate_all_hypervhypernoise(k,:)=peakrate;
%     nofailrate_all_hypervhypernoise(k,:)=nofailrate;
%     gains_all_hypervhypernoise(k,1)=pf_all{1}.beta(2);
%     rsq_all_hypervhypernoise(k,1)=pf_all{1}.rsquare;
%     rate_all_hypervhypernoise(k,:)=rate_all{1};
%     imp_all_hypervhypernoise(k,:)=imp;
%     holdingvoltage_all_hypervhypernoise(k,:)=mean_holdingvoltage;
%     std_noise_all_hypervhypernoise(k)=std_noise;
% end
% 
% gains_all_hypervhypernoise(isnan(rsq_all_hypervhypernoise))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_hypervhypernoise=nanmean(peakrate_all_hypervhypernoise);
% std_peakrate_hypervhypernoise=nanstd(peakrate_all_hypervhypernoise);
% mean_nofailrate_hypervhypernoise=nanmean(nofailrate_all_hypervhypernoise);
% std_nofailrate_hypervhypernoise=nanstd(nofailrate_all_hypervhypernoise);
% mean_gains_hypervhypernoise=nanmean(gains_all_hypervhypernoise);
% std_gains_hypervhypernoise=nanstd(gains_all_hypervhypernoise);
% ste_gains_hypervhypernoise=std_gains_hypervhypernoise/sqrt(sum(~isnan(gains_all_hypervhypernoise)));
% mean_imp_hypervhypernoise=nanmean(imp_all_hypervhypernoise);
% std_imp_hypervhypernoise=nanstd(imp_all_hypervhypernoise);
% mean_holdingvoltage_all_hypervhypernoise=nanmean(holdingvoltage_all_hypervhypernoise);
% std_holdingvoltage_all_hypervhypernoise=nanstd(holdingvoltage_all_hypervhypernoise);
% mean_std_noise_all_hypervhypernoise=nanmean(std_noise_all_hypervhypernoise);
% std_std_noise_all_hypervhypernoise=nanstd(std_noise_all_hypervhypernoise);


% Hyperpolarized with Noise (Currents go from 0:10:200)
% For Hyperpolarized

% % These are the 1 sec pulse, 1 sec pauses
% dates_all_hyper_noisevhyper={'Oct_03_14' 'Oct_06_14' 'Oct_06_14' 'Oct_14_14' 'Oct_14_14'};
% cellnum_all_hyper_noisevhyper={'B' 'A' 'C' 'A' 'B'};
% trials_all_hyper_noisevhyper=[4 3 3 2 1]';
dates_all_hyper_noisevhyper={'Feb_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15' 'Mar_16_15'... 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Mar_03_15' 'Mar_06_15' 'Mar_10_15'
    'Mar_17_15' 'Mar_18_15' 'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15'...
    'Mar_24_15' 'Apr_03_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15'};
cellnum_all_hyper_noisevhyper={'B' 'A' 'D' 'B' 'B' 'C'... 'A' 'B' 'C' 'A' 'A' 'C'
    'A' 'A' 'B' 'B' 'D' 'E'...
    'B' 'B' 'B' 'C' 'D'};
trials_all_hyper_noisevhyper=[1 3 1 3 5 1 ... 1 1 1 1 1 1
    1 3 1 1 1 1 ...
    3 1 1 1 1]';

for k=1:numel(dates_all_hyper_noisevhyper)
    eval(['load ' pwd '\fV_analysis\FI_OU_' dates_all_hyper_noisevhyper{k} '_' cellnum_all_hyper_noisevhyper{k} num2str(trials_all_hyper_noisevhyper(k)) '_fV.mat;'])
    gains_all(k,2)=pf_all{1}.beta(2);
    rsq_all(k,2)=pf_all{1}.rsquare;
    threshold_all(k,2)=threshold;
    avg_voltage_de_all(k,:)=avg_voltage{1}*1e3;
    currents_de_all(k,:)=currents{1};
    rate_de_all(k,:)=rate_all{1};
    skew_noise_all_hyper_noisevhyper(k,:)=skew_noise{1};
    if sum(rate_de_all(k,:)>=1)
        de_2threshold(k)=find(rate_de_all(k,:)>=1,1);
        sub_currents_de_all(k,1:de_2threshold(k)-1)=currents_de_all(k,1:de_2threshold(k)-1);
        avg_sub_voltage_de(k,1:de_2threshold(k)-1)=avg_voltage_de_all(k,1:de_2threshold(k)-1);
        sup_currents_de_all(k,de_2threshold(k):end)=currents_de_all(k,de_2threshold(k):end);
        avg_sup_voltage_de(k,de_2threshold(k):end)=avg_voltage_de_all(k,de_2threshold(k):end);
        sub_skew_noise_all_hyper_noisevhyper(k,1:de_2threshold(k)-1)=skew_noise_all_hyper_noisevhyper(k,1:de_2threshold(k)-1);
        sup_skew_noise_all_hyper_noisevhyper(k,de_2threshold(k):end)=skew_noise_all_hyper_noisevhyper(k,de_2threshold(k):end);
    else
        de_2threshold(k)=NaN;
        sub_currents_de_all(k,:)=currents_de_all(k,:);
        avg_sub_voltage_de(k,:)=avg_voltage_de_all(k,:);
        sub_skew_noise_all_hyper_noisevhyper(k,:)=skew_noise_all_hyper_noisevhyper(k,:);
    end
    for h=1:numel(avg_sub_voltage_hyper(k,:))-3
        smooth_voltages_de(k,h)=mean(avg_sub_voltage_de(k,h:h+3));
        resistance_de_fit=polyfit(currents_de_all(k,h:h+3),avg_sub_voltage_de(k,h:h+3),1);
        smooth_sub_resistance_de(k,h)=resistance_de_fit(1);
    end
    for p=1:numel(bins)-1
        binned_resistances_de(k,p)=mean(smooth_sub_resistance_de(k,smooth_voltages_de(k,:)<bins(p+1) & bins(p)<smooth_voltages_de(k,:)));
    end
end

mean_binned_resistances_hyper=nanmean(binned_resistances_hyper);
std_binned_resistances_hyper=nanstd(binned_resistances_hyper);
ste_binned_resistances_hyper=std_binned_resistances_hyper./sqrt(sum(isfinite(binned_resistances_hyper)));
mean_binned_resistances_de=nanmean(binned_resistances_de);
std_binned_resistances_de=nanstd(binned_resistances_de);
ste_binned_resistances_de=std_binned_resistances_de./sqrt(sum(isfinite(binned_resistances_de)));

figure;shadedErrorBar(bins+bin_size/2,mean_binned_resistances_hyper*1e3,ste_binned_resistances_hyper*1e3)
hold on;shadedErrorBar(bins+bin_size/2,mean_binned_resistances_de*1e3,ste_binned_resistances_de*1e3,'r')

mean_gains=mean(gains_all);
std_gains=std(gains_all);
mean_threshold=mean(threshold_all);
std_threshold=std(threshold_all);

diff_voltage_all=avg_voltage_hyper_all-avg_voltage_de_all;

mean_avg_voltage_hyper=mean(avg_voltage_hyper_all);
std_avg_voltage_hyper=std(avg_voltage_hyper_all);
ste_avg_voltage_hyper=std_avg_voltage_hyper/sqrt(numel(dates_all_hypervhypernoise));
mean_avg_voltage_de=mean(avg_voltage_de_all);
std_avg_voltage_de=std(avg_voltage_de_all);
ste_avg_voltage_de=std_avg_voltage_de/sqrt(numel(dates_all_hypervhypernoise));
mean_diff_voltage=mean(diff_voltage_all);
std_diff_voltage=std(diff_voltage_all);
ste_diff_voltage=std_diff_voltage/sqrt(numel(dates_all_hypervhypernoise));

figure;errorbar(0:10:200,nanmean(avg_sub_voltage_hyper),nanstd(avg_sub_voltage_hyper)./sqrt(sum(~isnan(avg_sub_voltage_hyper))));
hold on;errorbar(0:10:200,nanmean(avg_sup_voltage_hyper),nanstd(avg_sup_voltage_hyper)./sqrt(sum(~isnan(avg_sup_voltage_hyper))),'r');
hold on;errorbar(0:10:200,nanmean(avg_sub_voltage_de),nanstd(avg_sub_voltage_de)./sqrt(sum(~isnan(avg_sub_voltage_de))),'g');
hold on;errorbar(0:10:200,nanmean(avg_sup_voltage_de),nanstd(avg_sup_voltage_de)./sqrt(sum(~isnan(avg_sup_voltage_de))),'m');
title({'Subthreshold Hyperpolarized (Blue)';'Suprathreshold Hyperpolarized (Red)';'Subthreshold Hyperpolarized with Noise (Green)';'Suprathreshold Hyperpolarized with Noise (Magenta)'})

%Difference in subthreshold voltages
figure;errorbar(0:10:200,nanmean(avg_sub_voltage_hyper-avg_sub_voltage_de),...
    nanstd(avg_sub_voltage_hyper-avg_sub_voltage_de)./sqrt(sum(~isnan(avg_sub_voltage_hyper-avg_sub_voltage_de))));


sub_resistance_hyper=(diff(avg_sub_voltage_hyper')'/(currents_hyper_all(k,2)-currents_hyper_all(k,1)))/1e-9; % find the resistance in ohms
sub_resistance_de=(diff(avg_sub_voltage_de')'/(currents_de_all(k,2)-currents_de_all(k,1)))/1e-9;
diff_sub_resistance=sub_resistance_hyper-sub_resistance_de;

mean_sub_resistance_hyper=nanmean(sub_resistance_hyper);
std_sub_resistance_hyper=nanstd(sub_resistance_hyper);
nh=length(sub_resistance_hyper(:,1))-sum(isnan(sub_resistance_hyper));
ste_sub_resistance_hyper=std_sub_resistance_hyper./sqrt(nh);
mean_sub_resistance_de=nanmean(sub_resistance_de);
std_sub_resistance_de=nanstd(sub_resistance_de);
nd=length(sub_resistance_de(:,1))-sum(isnan(sub_resistance_de));
ste_sub_resistance_de=std_sub_resistance_de./sqrt(nd);
mean_sub_diff_resistance=nanmean(diff_sub_resistance);
std_sub_diff_resistance=nanstd(diff_sub_resistance);
ndiff=length(diff_sub_resistance(:,1))-sum(isnan(diff_sub_resistance));
ste_sub_diff_resistance=std_sub_diff_resistance./sqrt(ndiff);


figure;shadedErrorBar(0:10:200,mean_avg_voltage_hyper,ste_avg_voltage_hyper)
hold on;shadedErrorBar(0:10:200,mean_avg_voltage_de,ste_avg_voltage_de,'r')
title('I-V Curves for Hyperpolarized (Black) and Hyperpolarized with Noise (Red)')

clear

% for k=1:numel(dates_all_hyper_noisevhyper)
%     eval(['load FI_OU_' dates_all_hyper_noisevhyper{k} '_' cellnum_all_hyper_noisevhyper{k} num2str(trials_all_hyper_noisevhyper(k)) '_fV.mat;'])
%     peakrate_all_hyper_noisevhyper(k,:)=peakrate;
%     nofailrate_all_hyper_noisevhyper(k,:)=nofailrate;
%     gains_all_hyper_noisevhyper(k,1)=pf_all{1}.beta(2);
%     rsq_all_hyper_noisevhyper(k,1)=pf_all{1}.rsquare;
%     rate_all_hyper_noisevhyper(k,:)=rate_all{1};
%     resistance_all_hyper_noisevhyper(k)=mean_r_m;
%     capacitance_all_hyper_noisevhyper(k)=mean_c_m;
%     time_constant_all_hyper_noisevhyper(k)=mean_time_constant;
%     imp_all_hyper_noisevhyper(k,:)=imp;
%     holdingvoltage_all_hyper_noisevhyper(k,:)=mean_holdingvoltage;
%     std_noise_all_hyper_noisevhyper(k)=std_noise;
% end
% 
% gains_all_hyper_noisevhyper(isnan(rsq_all_hyper_noisevhyper))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_hyper_noisevhyper=nanmean(peakrate_all_hyper_noisevhyper);
% std_peakrate_hyper_noisevhyper=nanstd(peakrate_all_hyper_noisevhyper);
% mean_nofailrate_hyper_noisevhyper=nanmean(nofailrate_all_hyper_noisevhyper);
% std_nofailrate_hyper_noisevhyper=nanstd(nofailrate_all_hyper_noisevhyper);
% mean_gains_hyper_noisevhyper=nanmean(gains_all_hyper_noisevhyper);
% std_gains_hyper_noisevhyper=nanstd(gains_all_hyper_noisevhyper);
% ste_gains_hyper_noisevhyper=std_gains_hyper_noisevhyper/sqrt(sum(~isnan(gains_all_hyper_noisevhyper)));
% mean_resistance_hyper_noisevhyper=nanmean(resistance_all_hyper_noisevhyper);
% std_resistance_hyper_noisevhyper=nanstd(resistance_all_hyper_noisevhyper);
% mean_capacitance_hyper_noisevhyper=nanmean(capacitance_all_hyper_noisevhyper);
% std_capacitance_hyper_noisevhyper=nanstd(capacitance_all_hyper_noisevhyper);
% mean_tau_m_hyper_noisevhyper=nanmean(time_constant_all_hyper_noisevhyper);
% std_tau_m_hyper_noisevhyper=nanstd(time_constant_all_hyper_noisevhyper);
% mean_imp_hyper_noisevhyper=nanmean(imp_all_hyper_noisevhyper);
% std_imp_hyper_noisevhyper=nanstd(imp_all_hyper_noisevhyper);
% mean_holdingvoltage_all_hyper_noisevhyper=nanmean(holdingvoltage_all_hyper_noisevhyper);
% std_holdingvoltage_all_hyper_noisevhyper=nanstd(holdingvoltage_all_hyper_noisevhyper);
% mean_std_noise_all_hyper_noisevhyper=nanmean(std_noise_all_hyper_noisevhyper);
% std_std_noise_all_hyper_noisevhyper=nanstd(std_noise_all_hyper_noisevhyper);
% 
% % difference between rates (unpaired)
% difference_rate_hypervhypernoise=rate_all_hyper_noisevhyper-rate_all_hypervhypernoise;
% mean_difference_rate_hypervhypernoise=nanmean(difference_rate_hypervhypernoise);
% std_difference_rate_hypervhypernoise=nanstd(difference_rate_hypervhypernoise);
% ste_difference_rate_hypervhypernoise=std_difference_rate_hypervhypernoise./sqrt(sum(~isnan(difference_rate_hypervhypernoise)));
% 
% percent_difference_rate_hypervhypernoise=(difference_rate_hypervhypernoise./rate_all_hypervhypernoise)*100;
% percent_difference_rate_hypervhypernoise(~isfinite(percent_difference_rate_hypervhypernoise))=NaN;
% mean_percent_difference_rate_hypervhypernoise=nanmean(percent_difference_rate_hypervhypernoise);
% std_percent_difference_rate_hypervhypernoise=nanstd(percent_difference_rate_hypervhypernoise);
% ste_percent_difference_rate_hypervhypernoise=std_percent_difference_rate_hypervhypernoise./sqrt(sum(~isnan(percent_difference_rate_hypervhypernoise)));
% 
% new_percent_difference_rate_hypervhypernoise=difference_rate_hypervhypernoise./rate_all_hyper_noisevhyper;
% new_percent_difference_rate_hypervhypernoise(~isfinite(new_percent_difference_rate_hypervhypernoise))=NaN;
% mean_new_percent_difference_rate_hypervhypernoise=nanmean(new_percent_difference_rate_hypervhypernoise);
% std_new_percent_difference_rate_hypervhypernoise=nanstd(new_percent_difference_rate_hypervhypernoise);
% ste_new_percent_difference_rate_hypervhypernoise=std_new_percent_difference_rate_hypervhypernoise./sqrt(sum(~isnan(new_percent_difference_rate_hypervhypernoise)));
% 
% % difference between rates (paired)
% paired_difference_rate_hypervhypernoise=rate_all_hyper_noisevhyper(2:end,:)-rate_all_hypervhypernoise(2:end,:);
% paired_mean_difference_rate_hypervhypernoise=nanmean(paired_difference_rate_hypervhypernoise);
% paired_std_difference_rate_hypervhypernoise=nanstd(paired_difference_rate_hypervhypernoise);
% paired_ste_difference_rate_hypervhypernoise=paired_std_difference_rate_hypervhypernoise./sqrt(sum(~isnan(paired_difference_rate_hypervhypernoise)));
% 
% paired_percent_difference_rate_hypervhypernoise=(paired_difference_rate_hypervhypernoise./rate_all_hypervhypernoise(2:end,:))*100;
% paired_percent_difference_rate_hypervhypernoise(~isfinite(paired_percent_difference_rate_hypervhypernoise))=NaN;
% paired_mean_percent_difference_rate_hypervhypernoise=nanmean(paired_percent_difference_rate_hypervhypernoise);
% paired_std_percent_difference_rate_hypervhypernoise=nanstd(paired_percent_difference_rate_hypervhypernoise);
% paired_ste_percent_difference_rate_hypervhypernoise=paired_std_percent_difference_rate_hypervhypernoise./sqrt(sum(~isnan(paired_percent_difference_rate_hypervhypernoise)));
% 
% paired_new_percent_difference_rate_hypervhypernoise=paired_difference_rate_hypervhypernoise./rate_all_hyper_noisevhyper(2:end,:);
% paired_new_percent_difference_rate_hypervhypernoise(~isfinite(paired_new_percent_difference_rate_hypervhypernoise))=NaN;
% paired_mean_new_percent_difference_rate_hypervhypernoise=nanmean(paired_new_percent_difference_rate_hypervhypernoise);
% paired_std_new_percent_difference_rate_hypervhypernoise=nanstd(paired_new_percent_difference_rate_hypervhypernoise);
% paired_ste_new_percent_difference_rate_hypervhypernoise=paired_std_new_percent_difference_rate_hypervhypernoise./sqrt(sum(~isnan(paired_new_percent_difference_rate_hypervhypernoise)));


% %% Hyperpolarized (5 sec pulse, 1 sec pause; Currents go from 0:10:200)
% % For Hyperpolarized with Negative Leak
% 
% dates_all_hypervhypernegativeleak={'Jan_07_15' 'Jan_13_15' 'Jan_14_15'};
% cellnum_all_hypervhypernegativeleak={'B' 'A' 'A'};
% trials_all_hypervhypernegativeleak=[1 1 1]';
% 
% for k=1:numel(dates_all_hypervhypernegativeleak)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_hypervhypernegativeleak{k} '_' cellnum_all_hypervhypernegativeleak{k} num2str(trials_all_hypervhypernegativeleak(k)) '_fV.mat;'])
%     peakrate_all_hypervhypernegativeleak(k,:)=peakrate;
%     nofailrate_all_hypervhypernegativeleak(k,:)=nofailrate;
%     gains_all_hypervhypernegativeleak(k,1)=pf_all{1}.beta(2);
%     rsq_all_hypervhypernegativeleak(k,1)=pf_all{1}.rsquare;
%     rate_all_hypervhypernegativeleak(k,:)=rate_all{1};
%     imp_all_hypervhypernegativeleak(k,:)=imp;
%     holdingvoltage_all_hypervhypernegativeleak(k,:)=mean_holdingvoltage;
% end
% 
% gains_all_hypervhypernegativeleak(isnan(rsq_all_hypervhypernegativeleak))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_hypervhypernegativeleak=nanmean(peakrate_all_hypervhypernegativeleak);
% std_peakrate_hypervhypernegativeleak=nanstd(peakrate_all_hypervhypernegativeleak);
% mean_nofailrate_hypervhypernegativeleak=nanmean(nofailrate_all_hypervhypernegativeleak);
% std_nofailrate_hypervhypernegativeleak=nanstd(nofailrate_all_hypervhypernegativeleak);
% mean_gains_hypervhypernegativeleak=nanmean(gains_all_hypervhypernegativeleak);
% std_gains_hypervhypernegativeleak=nanstd(gains_all_hypervhypernegativeleak);
% ste_gains_hypervhypernegativeleak=std_gains_hypervhypernegativeleak/sqrt(sum(~isnan(gains_all_hypervhypernegativeleak)));
% mean_imp_hypervhypernegativeleak=nanmean(imp_all_hypervhypernegativeleak);
% std_imp_hypervhypernegativeleak=nanstd(imp_all_hypervhypernegativeleak);
% mean_holdingvoltage_all_hypervhypernegativeleak=nanmean(holdingvoltage_all_hypervhypernegativeleak);
% std_holdingvoltage_all_hypervhypernegativeleak=nanstd(holdingvoltage_all_hypervhypernegativeleak);
% 
% 
% %% Hyperpolarized with Negative Leak (Currents go from 5:5:100)
% % For Hyperpolarized
% 
% dates_all_hyper_negative_leakvhyper={'Jan_07_15' 'Jan_13_15' 'Jan_14_15'};
% cellnum_all_hyper_negative_leakvhyper={'B' 'A' 'A'};
% trials_all_hyper_negative_leakvhyper=[4 3 3]';
% 
% for k=1:numel(dates_all_hyper_negative_leakvhyper)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_hyper_negative_leakvhyper{k} '_' cellnum_all_hyper_negative_leakvhyper{k} num2str(trials_all_hyper_negative_leakvhyper(k)) '_fV.mat;'])
%     peakrate_all_hyper_negative_leakvhyper(k,:)=peakrate;
%     nofailrate_all_hyper_negative_leakvhyper(k,:)=nofailrate;
%     gains_all_hyper_negative_leakvhyper(k,1)=pf_all{1}.beta(2);
%     rsq_all_hyper_negative_leakvhyper(k,1)=pf_all{1}.rsquare;
%     rate_all_hyper_negative_leakvhyper(k,:)=rate_all{1};
%     imp_all_hyper_negative_leakvhyper(k,:)=imp;
%     holdingvoltage_all_hyper_negative_leakvhyper(k,:)=mean_holdingvoltage;
% end
% 
% gains_all_hyper_negative_leakvhyper(isnan(rsq_all_hyper_negative_leakvhyper))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_hyper_negative_leakvhyper=nanmean(peakrate_all_hyper_negative_leakvhyper);
% std_peakrate_hyper_negative_leakvhyper=nanstd(peakrate_all_hyper_negative_leakvhyper);
% mean_nofailrate_hyper_negative_leakvhyper=nanmean(nofailrate_all_hyper_negative_leakvhyper);
% std_nofailrate_hyper_negative_leakvhyper=nanstd(nofailrate_all_hyper_negative_leakvhyper);
% mean_gains_hyper_negative_leakvhyper=nanmean(gains_all_hyper_negative_leakvhyper);
% std_gains_hyper_negative_leakvhyper=nanstd(gains_all_hyper_negative_leakvhyper);
% ste_gains_hyper_negative_leakvhyper=std_gains_hyper_negative_leakvhyper/sqrt(sum(~isnan(gains_all_hyper_negative_leakvhyper)));
% mean_imp_hyper_negative_leakvhyper=nanmean(imp_all_hyper_negative_leakvhyper);
% std_imp_hyper_negative_leakvhyper=nanstd(imp_all_hyper_negative_leakvhyper);
% mean_holdingvoltage_all_hyper_negative_leakvhyper=nanmean(holdingvoltage_all_hyper_negative_leakvhyper);
% std_holdingvoltage_all_hyper_negative_leakvhyper=nanstd(holdingvoltage_all_hyper_negative_leakvhyper);
% 
% % difference between rates
% difference_rate_hypervhypernegativeleak=rate_all_hyper_negative_leakvhyper-rate_all_hypervhypernegativeleak;
% mean_difference_rate_hypervhypernegativeleak=nanmean(difference_rate_hypervhypernegativeleak);
% std_difference_rate_hypervhypernegativeleak=nanstd(difference_rate_hypervhypernegativeleak);
% ste_difference_rate_hypervhypernegativeleak=std_difference_rate_hypervhypernegativeleak./sqrt(sum(~isnan(difference_rate_hypervhypernegativeleak)));
% 
% 
% %% Hyperpolarized (5 sec pulse, 1 sec pause; Currents go from 0:10:200)
% % For Hyperpolarized with Current Subtracted
% 
% dates_all_hypervhypercurrentsubtracted={'Oct_30_14' 'Nov_26_14' 'Dec_08_14' 'Dec_19_14' 'Dec_22_14' 'Dec_22_14'...
%     'Dec_22_14' 'Dec_23_14' 'Dec_23_14' 'Dec_23_14'};
% cellnum_all_hypervhypercurrentsubtracted={'A' 'A' 'A' 'A' 'B' 'C'...
%     'D' 'A' 'B' 'C'};
% trials_all_hypervhypercurrentsubtracted=[1 1 1 1 1 1 ...
%     3 1 1 1]';
% 
% for k=1:numel(dates_all_hypervhypercurrentsubtracted)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_hypervhypercurrentsubtracted{k} '_' cellnum_all_hypervhypercurrentsubtracted{k} num2str(trials_all_hypervhypercurrentsubtracted(k)) '_fV.mat;'])
%     peakrate_all_hypervhypercurrentsubtracted(k,:)=peakrate;
%     nofailrate_all_hypervhypercurrentsubtracted(k,:)=nofailrate;
%     gains_all_hypervhypercurrentsubtracted(k,1)=pf_all{1}.beta(2);
%     rsq_all_hypervhypercurrentsubtracted(k,1)=pf_all{1}.rsquare;
%     rate_all_hypervhypercurrentsubtracted(k,:)=rate_all{1};
%     imp_all_hypervhypercurrentsubtracted(k,:)=imp;
%     holdingvoltage_all_hypervhypercurrentsubtracted(k,:)=mean_holdingvoltage;
% end
% 
% gains_all_hypervhypercurrentsubtracted(isnan(rsq_all_hypervhypercurrentsubtracted))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_hypervhypercurrentsubtracted=nanmean(peakrate_all_hypervhypercurrentsubtracted);
% std_peakrate_hypervhypercurrentsubtracted=nanstd(peakrate_all_hypervhypercurrentsubtracted);
% mean_nofailrate_hypervhypercurrentsubtracted=nanmean(nofailrate_all_hypervhypercurrentsubtracted);
% std_nofailrate_hypervhypercurrentsubtracted=nanstd(nofailrate_all_hypervhypercurrentsubtracted);
% mean_gains_hypervhypercurrentsubtracted=nanmean(gains_all_hypervhypercurrentsubtracted);
% std_gains_hypervhypercurrentsubtracted=nanstd(gains_all_hypervhypercurrentsubtracted);
% ste_gains_hypervhypercurrentsubtracted=std_gains_hypervhypercurrentsubtracted/sqrt(sum(~isnan(gains_all_hypervhypercurrentsubtracted)));
% mean_imp_hypervhypercurrentsubtracted=nanmean(imp_all_hypervhypercurrentsubtracted);
% std_imp_hypervhypercurrentsubtracted=nanstd(imp_all_hypervhypercurrentsubtracted);
% mean_holdingvoltage_all_hypervhypercurrentsubtracted=nanmean(holdingvoltage_all_hypervhypercurrentsubtracted);
% std_holdingvoltage_all_hypervhypercurrentsubtracted=nanstd(holdingvoltage_all_hypervhypercurrentsubtracted);
% 
% 
% %% Hyperpolarized with Current Subtracted (Currents go from 0:10:200)
% % For Hyperpolarized
% 
% dates_all_hyper_current_subtractedvhyper={'Oct_30_14' 'Nov_26_14' 'Dec_08_14' 'Dec_19_14' 'Dec_22_14' 'Dec_22_14'...
%     'Dec_22_14' 'Dec_23_14' 'Dec_23_14' 'Dec_23_14'};
% cellnum_all_hyper_current_subtractedvhyper={'A' 'A' 'A' 'A' 'B' 'C'...
%     'D' 'A' 'B' 'C'};
% trials_all_hyper_current_subtractedvhyper=[5 6 3 3 4 3 ...
%     6 4 3 3]';
% 
% for k=1:numel(dates_all_hyper_current_subtractedvhyper)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_hyper_current_subtractedvhyper{k} '_' cellnum_all_hyper_current_subtractedvhyper{k} num2str(trials_all_hyper_current_subtractedvhyper(k)) '_fV.mat;'])
%     peakrate_all_hyper_current_subtractedvhyper(k,:)=peakrate;
%     nofailrate_all_hyper_current_subtractedvhyper(k,:)=nofailrate;
%     gains_all_hyper_current_subtractedvhyper(k,1)=pf_all{1}.beta(2);
%     rsq_all_hyper_current_subtractedvhyper(k,1)=pf_all{1}.rsquare;
%     rate_all_hyper_current_subtractedvhyper(k,:)=rate_all{1};
%     imp_all_hyper_current_subtractedvhyper(k,:)=imp;
%     holdingvoltage_all_hyper_current_subtractedvhyper(k,:)=mean_holdingvoltage;
% end
% 
% gains_all_hyper_current_subtractedvhyper(isnan(rsq_all_hyper_current_subtractedvhyper))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_hyper_current_subtractedvhyper=nanmean(peakrate_all_hyper_current_subtractedvhyper);
% std_peakrate_hyper_current_subtractedvhyper=nanstd(peakrate_all_hyper_current_subtractedvhyper);
% mean_nofailrate_hyper_current_subtractedvhyper=nanmean(nofailrate_all_hyper_current_subtractedvhyper);
% std_nofailrate_hyper_current_subtractedvhyper=nanstd(nofailrate_all_hyper_current_subtractedvhyper);
% mean_gains_hyper_current_subtractedvhyper=nanmean(gains_all_hyper_current_subtractedvhyper);
% std_gains_hyper_current_subtractedvhyper=nanstd(gains_all_hyper_current_subtractedvhyper);
% ste_gains_hyper_current_subtractedvhyper=std_gains_hyper_current_subtractedvhyper/sqrt(sum(~isnan(gains_all_hyper_current_subtractedvhyper)));
% mean_imp_hyper_current_subtractedvhyper=nanmean(imp_all_hyper_current_subtractedvhyper);
% std_imp_hyper_current_subtractedvhyper=nanstd(imp_all_hyper_current_subtractedvhyper);
% mean_holdingvoltage_all_hyper_current_subtractedvhyper=nanmean(holdingvoltage_all_hyper_current_subtractedvhyper);
% std_holdingvoltage_all_hyper_current_subtractedvhyper=nanstd(holdingvoltage_all_hyper_current_subtractedvhyper);
% 
% % difference between rates
% difference_rate_hypervhypercurrentsubtracted=rate_all_hyper_current_subtractedvhyper-rate_all_hypervhypercurrentsubtracted;
% mean_difference_rate_hypervhypercurrentsubtracted=nanmean(difference_rate_hypervhypercurrentsubtracted);
% std_difference_rate_hypervhypercurrentsubtracted=nanstd(difference_rate_hypervhypercurrentsubtracted);
% ste_difference_rate_hypervhypercurrentsubtracted=std_difference_rate_hypervhypercurrentsubtracted./sqrt(sum(~isnan(difference_rate_hypervhypercurrentsubtracted)));
% 
% 
% %% Depolarized (5 sec pulse, 1 sec pause; 200 pA range of currents)
% % For Depolarized with Leak
% 
% dates_all_devdeleak={'Oct_28_14' 'Oct_30_14' 'Oct_30_14' 'Nov_26_14' 'Jan_07_15' 'Jan_07_15'};
% cellnum_all_devdeleak={'A' 'A' 'B' 'A' 'A' 'B'};
% trials_all_devdeleak=[2 2 2 2 2 2]';
% 
% for k=1:numel(dates_all_devdeleak)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_devdeleak{k} '_' cellnum_all_devdeleak{k} num2str(trials_all_devdeleak(k)) '_fV.mat;'])
%     peakrate_all_devdeleak(k,:)=peakrate;
%     nofailrate_all_devdeleak(k,:)=nofailrate;
%     gains_all_devdeleak(k,1)=pf_all{1}.beta(2);
%     rsq_all_devdeleak(k,1)=pf_all{1}.rsquare;
%     rate_all_devdeleak(k,:)=rate_all{1};
%     imp_all_devdeleak(k,:)=imp;
%     holdingvoltage_all_devdeleak(k,:)=mean_holdingvoltage;
% end
% 
% gains_all_devdeleak(isnan(rsq_all_devdeleak))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_devdeleak=nanmean(peakrate_all_devdeleak);
% std_peakrate_devdeleak=nanstd(peakrate_all_devdeleak);
% mean_nofailrate_devdeleak=nanmean(nofailrate_all_devdeleak);
% std_nofailrate_devdeleak=nanstd(nofailrate_all_devdeleak);
% mean_gains_devdeleak=nanmean(gains_all_devdeleak);
% std_gains_devdeleak=nanstd(gains_all_devdeleak);
% ste_gains_devdeleak=std_gains_devdeleak/sqrt(sum(~isnan(gains_all_devdeleak)));
% mean_imp_devdeleak=nanmean(imp_all_devdeleak);
% std_imp_devdeleak=nanstd(imp_all_devdeleak);
% mean_holdingvoltage_all_devdeleak=nanmean(holdingvoltage_all_devdeleak);
% std_holdingvoltage_all_devdeleak=nanstd(holdingvoltage_all_devdeleak);
% 
% 
% %% Depolarized with Leak (400 pA range of currents)
% % For Depolarized
% 
% dates_all_de_leakvde={'Oct_28_14' 'Oct_30_14' 'Oct_30_14' 'Nov_26_14' 'Jan_07_15' 'Jan_07_15'};
% cellnum_all_de_leakvde={'A' 'A' 'B' 'A' 'A' 'B'};
% trials_all_de_leakvde=[3 3 3 3 3 3]';
% 
% for k=1:numel(dates_all_de_leakvde)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_de_leakvde{k} '_' cellnum_all_de_leakvde{k} num2str(trials_all_de_leakvde(k)) '_fV.mat;'])
%     peakrate_all_de_leakvde(k,:)=peakrate;
%     nofailrate_all_de_leakvde(k,:)=nofailrate;
%     gains_all_de_leakvde(k,1)=pf_all{1}.beta(2);
%     rsq_all_de_leakvde(k,1)=pf_all{1}.rsquare;
%     rate_all_de_leakvde(k,:)=rate_all{1};
%     imp_all_de_leakvde(k,:)=imp;
%     holdingvoltage_all_de_leakvde(k,:)=mean_holdingvoltage;
% end
% 
% gains_all_de_leakvde(isnan(rsq_all_de_leakvde))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_de_leakvde=nanmean(peakrate_all_de_leakvde);
% std_peakrate_de_leakvde=nanstd(peakrate_all_de_leakvde);
% mean_nofailrate_de_leakvde=nanmean(nofailrate_all_de_leakvde);
% std_nofailrate_de_leakvde=nanstd(nofailrate_all_de_leakvde);
% mean_gains_de_leakvde=nanmean(gains_all_de_leakvde);
% std_gains_de_leakvde=nanstd(gains_all_de_leakvde);
% ste_gains_de_leakvde=std_gains_de_leakvde/sqrt(sum(~isnan(gains_all_de_leakvde)));
% mean_imp_de_leakvde=nanmean(imp_all_de_leakvde);
% std_imp_de_leakvde=nanstd(imp_all_de_leakvde);
% mean_holdingvoltage_all_de_leakvde=nanmean(holdingvoltage_all_de_leakvde);
% std_holdingvoltage_all_de_leakvde=nanstd(holdingvoltage_all_de_leakvde);
% 
% % difference between rates
% difference_rate_devdeleak=rate_all_de_leakvde-rate_all_devdeleak;
% mean_difference_rate_devdeleak=nanmean(difference_rate_devdeleak);
% std_difference_rate_devdeleak=nanstd(difference_rate_devdeleak);
% ste_difference_rate_devdeleak=std_difference_rate_devdeleak./sqrt(sum(~isnan(difference_rate_devdeleak)));


%% Depolarized (5 sec pulse, 1 sec pause; 200 pA range of currents)
% For Depolarized with Just Noise

% % These are the 1 sec pulse, 1 sec pauses
% dates_all_devdenoise={'Oct_14_14' 'Oct_14_14'};
% cellnum_all_devdenoise={'A' 'B'};
% trials_all_devdenoise=[2 2]';
dates_all_devdenoise={'Jan_27_15' 'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Mar_10_15'... 'Feb_03_15' 'Feb_10_15' 'Mar_03_15' 'Mar_06_15' 'Mar_10_15' 'Mar_10_15'
    'Mar_11_15' 'Mar_16_15' 'Mar_17_15' 'Mar_17_15' 'Mar_18_15' 'Mar_23_15'...
    'Mar_23_15' 'Mar_23_15' 'Mar_24_15' 'Apr_03_15' 'Apr_06_15' 'Apr_07_15'...
    'Apr_07_15' 'Apr_07_15'}; % 'Mar_10_15_B4' -> fine data, but not included in the hyper/de, so I didn't include it here
cellnum_all_devdenoise={'A' 'B' 'A' 'C' 'B' 'A'... 'B' 'C' 'A' 'A' 'C' 'D'
    'B' 'B' 'A' 'B' 'B' 'B'...
    'D' 'E' 'B' 'B' 'B' 'A'...
    'C' 'D'};
trials_all_devdenoise=[2 2 2 2 2 4 ... 2 2 2 2 2 2
    2 8 2 2 4 2 ...
    2 2 4 7 6 6 ...
    6 4]';

sub_currents_hyper_all=NaN(numel(dates_all_devdenoise),21);
sub_currents_de_all=NaN(numel(dates_all_devdenoise),21);
avg_sub_voltage_hyper=NaN(numel(dates_all_devdenoise),21);
avg_sub_voltage_de=NaN(numel(dates_all_devdenoise),21);
sup_currents_hyper_all=NaN(numel(dates_all_devdenoise),21);
sup_currents_de_all=NaN(numel(dates_all_devdenoise),21);
avg_sup_voltage_hyper=NaN(numel(dates_all_devdenoise),21);
avg_sup_voltage_de=NaN(numel(dates_all_devdenoise),21);
smooth_sub_resistance_hyper=NaN(numel(dates_all_devdenoise),21);
smooth_sub_resistance_de=NaN(numel(dates_all_devdenoise),21);
smooth_voltages_hyper=NaN(numel(dates_all_devdenoise),21);
smooth_voltages_de=NaN(numel(dates_all_devdenoise),21);
bin_size=10; %in mV
bins=-110:bin_size:-40; %in mV
binned_resistances_hyper=NaN(numel(dates_all_devdenoise),numel(bins));
binned_resistances_de=NaN(numel(dates_all_devdenoise),numel(bins));

for k=1:numel(dates_all_devdenoise)
    eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_devdenoise{k} '_' cellnum_all_devdenoise{k} num2str(trials_all_devdenoise(k)) '_fV.mat;'])
    gains_all(k,1)=pf_all{1}.beta(2);
    rsq_all(k,1)=pf_all{1}.rsquare;
    threshold_all(k,1)=threshold;
    avg_voltage_hyper_all(k,:)=avg_voltage{1};
    currents_hyper_all(k,:)=currents{1};
    rate_hyper_all(k,:)=rate_all{1};
    if sum(rate_hyper_all(k,:)>=1)
        hyper_2threshold(k)=find(rate_hyper_all(k,:)>=1,1);
        sub_currents_hyper_all(k,1:hyper_2threshold(k)-1)=currents_hyper_all(k,1:hyper_2threshold(k)-1);
        avg_sub_voltage_hyper(k,1:hyper_2threshold(k)-1)=avg_voltage_hyper_all(k,1:hyper_2threshold(k)-1);
        sup_currents_hyper_all(k,hyper_2threshold(k):end)=currents_hyper_all(k,hyper_2threshold(k):end);
        avg_sup_voltage_hyper(k,hyper_2threshold(k):end)=avg_voltage_hyper_all(k,hyper_2threshold(k):end);
    else
        hyper_2threshold(k)=NaN;
        sub_currents_hyper_all(k,:)=currents_hyper_all(k,:);
        avg_sub_voltage_hyper(k,:)=avg_voltage_hyper_all(k,:);
    end
    for h=1:numel(avg_sub_voltage_hyper(k,:))-3
        smooth_voltages_hyper(k,h)=mean(avg_sub_voltage_hyper(k,h:h+3));
        resistance_hyper_fit=polyfit(currents_hyper_all(k,h:h+3),avg_sub_voltage_hyper(k,h:h+3),1);
        smooth_sub_resistance_hyper(k,h)=resistance_hyper_fit(1);
    end
    for p=1:numel(bins)-1
        binned_resistances_hyper(k,p)=mean(smooth_sub_resistance_hyper(k,smooth_voltages_hyper(k,:)<bins(p+1) & bins(p)<smooth_voltages_hyper(k,:)));
    end
end

% for k=1:numel(dates_all_devdenoise)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_devdenoise{k} '_' cellnum_all_devdenoise{k} num2str(trials_all_devdenoise(k)) '_fV.mat;'])
%     peakrate_all_devdenoise(k,:)=peakrate;
%     nofailrate_all_devdenoise(k,:)=nofailrate;
%     gains_all_devdenoise(k,1)=pf_all{1}.beta(2);
%     rsq_all_devdenoise(k,1)=pf_all{1}.rsquare;
%     rate_all_devdenoise(k,:)=rate_all{1};
%     imp_all_devdenoise(k,:)=imp;
%     holdingvoltage_all_devdenoise(k,:)=mean_holdingvoltage;
%     std_noise_all_devdenoise(k)=std_noise;
% end
% 
% gains_all_devdenoise(isnan(rsq_all_devdenoise))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_devdenoise=nanmean(peakrate_all_devdenoise);
% std_peakrate_devdenoise=nanstd(peakrate_all_devdenoise);
% mean_nofailrate_devdenoise=nanmean(nofailrate_all_devdenoise);
% std_nofailrate_devdenoise=nanstd(nofailrate_all_devdenoise);
% mean_gains_devdenoise=nanmean(gains_all_devdenoise);
% std_gains_devdenoise=nanstd(gains_all_devdenoise);
% ste_gains_devdenoise=std_gains_devdenoise/sqrt(sum(~isnan(gains_all_devdenoise)));
% mean_imp_devdenoise=nanmean(imp_all_devdenoise);
% std_imp_devdenoise=nanstd(imp_all_devdenoise);
% mean_holdingvoltage_all_devdenoise=nanmean(holdingvoltage_all_devdenoise);
% std_holdingvoltage_all_devdenoise=nanstd(holdingvoltage_all_devdenoise);
% mean_std_noise_all_devdenoise=nanmean(std_noise_all_devdenoise);
% std_std_noise_all_devdenoise=nanstd(std_noise_all_devdenoise);


%% Depolarized with Just Noise (200 pA range of currents)
% For Depolarized

% % These are the 1 sec pulse, 1 sec pauses
% dates_all_de_noisevde={'Oct_14_14' 'Oct_14_14'};
% cellnum_all_de_noisevde={'A' 'B'};
% trials_all_de_noisevde=[3 2]';
dates_all_de_noisevde={'Jan_27_15' 'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Mar_10_15'... 'Feb_03_15' 'Feb_10_15' 'Mar_03_15' 'Mar_06_15' 'Mar_10_15' 'Mar_10_15'
    'Mar_11_15' 'Mar_16_15' 'Mar_17_15' 'Mar_17_15' 'Mar_18_15' 'Mar_23_15'...
    'Mar_23_15' 'Mar_23_15' 'Mar_24_15' 'Apr_03_15' 'Apr_06_15' 'Apr_07_15'...
    'Apr_07_15' 'Apr_07_15'}; % 'Mar_10_15_B2' -> fine data, but not included in the hyper/de, so I didn't include it here
cellnum_all_de_noisevde={'A' 'B' 'A' 'C' 'B' 'A'... 'B' 'C' 'A' 'A' 'C' 'D'
    'B' 'B' 'A' 'B' 'B' 'B'...
    'D' 'E' 'B' 'B' 'B' 'A'...
    'C' 'D'};
trials_all_de_noisevde=[4 4 2 2 2 4 ... 2 2 2 2 2 2
    2 6 2 2 2 2 ...
    2 2 4 2 2 2 ...
    2 2]';

for k=1:numel(dates_all_de_noisevde)
    eval(['load ' pwd '\fV_analysis\FI_OU_' dates_all_de_noisevde{k} '_' cellnum_all_de_noisevde{k} num2str(trials_all_de_noisevde(k)) '_fV.mat;'])
    gains_all(k,2)=pf_all{1}.beta(2);
    rsq_all(k,2)=pf_all{1}.rsquare;
    threshold_all(k,2)=threshold;
    avg_voltage_de_all(k,:)=avg_voltage{1}*1e3;
    currents_de_all(k,:)=currents{1};
    rate_de_all(k,:)=rate_all{1};
    if sum(rate_de_all(k,:)>=1)
        de_2threshold(k)=find(rate_de_all(k,:)>=1,1);
        sub_currents_de_all(k,1:de_2threshold(k)-1)=currents_de_all(k,1:de_2threshold(k)-1);
        avg_sub_voltage_de(k,1:de_2threshold(k)-1)=avg_voltage_de_all(k,1:de_2threshold(k)-1);
        sup_currents_de_all(k,de_2threshold(k):end)=currents_de_all(k,de_2threshold(k):end);
        avg_sup_voltage_de(k,de_2threshold(k):end)=avg_voltage_de_all(k,de_2threshold(k):end);
    else
        de_2threshold(k)=NaN;
        sub_currents_de_all(k,:)=currents_de_all(k,:);
        avg_sub_voltage_de(k,:)=avg_voltage_de_all(k,:);
    end
    for h=1:numel(avg_sub_voltage_hyper(k,:))-3
        smooth_voltages_de(k,h)=mean(avg_sub_voltage_de(k,h:h+3));
        resistance_de_fit=polyfit(currents_de_all(k,h:h+3),avg_sub_voltage_de(k,h:h+3),1);
        smooth_sub_resistance_de(k,h)=resistance_de_fit(1);
    end
    for p=1:numel(bins)-1
        binned_resistances_de(k,p)=mean(smooth_sub_resistance_de(k,smooth_voltages_de(k,:)<bins(p+1) & bins(p)<smooth_voltages_de(k,:)));
    end
end

mean_binned_resistances_hyper=nanmean(binned_resistances_hyper);
std_binned_resistances_hyper=nanstd(binned_resistances_hyper);
ste_binned_resistances_hyper=std_binned_resistances_hyper./sqrt(sum(isfinite(binned_resistances_hyper)));
mean_binned_resistances_de=nanmean(binned_resistances_de);
std_binned_resistances_de=nanstd(binned_resistances_de);
ste_binned_resistances_de=std_binned_resistances_de./sqrt(sum(isfinite(binned_resistances_de)));

figure;shadedErrorBar(bins+bin_size/2,mean_binned_resistances_hyper,ste_binned_resistances_hyper)
hold on;shadedErrorBar(bins+bin_size/2,mean_binned_resistances_de,ste_binned_resistances_de,'r')

mean_gains=mean(gains_all);
std_gains=std(gains_all);
mean_threshold=mean(threshold_all);
std_threshold=std(threshold_all);

diff_voltage_all=avg_voltage_hyper_all-avg_voltage_de_all;

mean_avg_voltage_hyper=mean(avg_voltage_hyper_all);
std_avg_voltage_hyper=std(avg_voltage_hyper_all);
ste_avg_voltage_hyper=std_avg_voltage_hyper/sqrt(numel(dates_all_devdenoise));
mean_avg_voltage_de=mean(avg_voltage_de_all);
std_avg_voltage_de=std(avg_voltage_de_all);
ste_avg_voltage_de=std_avg_voltage_de/sqrt(numel(dates_all_devdenoise));
mean_diff_voltage=mean(diff_voltage_all);
std_diff_voltage=std(diff_voltage_all);
ste_diff_voltage=std_diff_voltage/sqrt(numel(dates_all_devdenoise));

figure;errorbar(0:10:200,nanmean(avg_sub_voltage_hyper),nanstd(avg_sub_voltage_hyper)./sqrt(sum(~isnan(avg_sub_voltage_hyper))));
hold on;errorbar(0:10:200,nanmean(avg_sup_voltage_hyper),nanstd(avg_sup_voltage_hyper)./sqrt(sum(~isnan(avg_sup_voltage_hyper))),'r');
hold on;errorbar(0:10:200,nanmean(avg_sub_voltage_de),nanstd(avg_sub_voltage_de)./sqrt(sum(~isnan(avg_sub_voltage_de))),'g');
hold on;errorbar(0:10:200,nanmean(avg_sup_voltage_de),nanstd(avg_sup_voltage_de)./sqrt(sum(~isnan(avg_sup_voltage_de))),'m');
title({'Subthreshold Depolarized (Blue)';'Suprathreshold Depolarized (Red)';'Subthreshold Depolarized with Noise (Green)';'Suprathreshold Depolarized with Noise (Magenta)'})


sub_resistance_hyper=(diff(avg_sub_voltage_hyper')'/(currents_hyper_all(k,2)-currents_hyper_all(k,1)))/1e-9; % find the resistance in ohms
sub_resistance_de=(diff(avg_sub_voltage_de')'/(currents_de_all(k,2)-currents_de_all(k,1)))/1e-9;
diff_sub_resistance=sub_resistance_hyper-sub_resistance_de;

mean_sub_resistance_hyper=nanmean(sub_resistance_hyper);
std_sub_resistance_hyper=nanstd(sub_resistance_hyper);
nh=length(sub_resistance_hyper(:,1))-sum(isnan(sub_resistance_hyper));
ste_sub_resistance_hyper=std_sub_resistance_hyper./sqrt(nh);
mean_sub_resistance_de=nanmean(sub_resistance_de);
std_sub_resistance_de=nanstd(sub_resistance_de);
nd=length(sub_resistance_de(:,1))-sum(isnan(sub_resistance_de));
ste_sub_resistance_de=std_sub_resistance_de./sqrt(nd);
mean_sub_diff_resistance=nanmean(diff_sub_resistance);
std_sub_diff_resistance=nanstd(diff_sub_resistance);
ndiff=length(diff_sub_resistance(:,1))-sum(isnan(diff_sub_resistance));
ste_sub_diff_resistance=std_sub_diff_resistance./sqrt(ndiff);


figure;shadedErrorBar(0:10:200,mean_avg_voltage_hyper,ste_avg_voltage_hyper)
hold on;shadedErrorBar(0:10:200,mean_avg_voltage_de,ste_avg_voltage_de,'r')
title('I-V Curves for Depolarized (Black) and Depolarized with Noise (Red)')

% for k=1:numel(dates_all_de_noisevde)
%     eval(['load FI_OU_' dates_all_de_noisevde{k} '_' cellnum_all_de_noisevde{k} num2str(trials_all_de_noisevde(k)) '_fV.mat;'])
%     peakrate_all_de_noisevde(k,:)=peakrate;
%     nofailrate_all_de_noisevde(k,:)=nofailrate;
%     gains_all_de_noisevde(k,1)=pf_all{1}.beta(2);
%     rsq_all_de_noisevde(k,1)=pf_all{1}.rsquare;
%     rate_all_de_noisevde(k,:)=rate_all{1};
%     resistance_all_de_noisevde(k)=mean_r_m;
%     capacitance_all_de_noisevde(k)=mean_c_m;
%     time_constant_all_de_noisevde(k)=mean_time_constant;
%     imp_all_de_noisevde(k,:)=imp;
%     holdingvoltage_all_de_noisevde(k,:)=mean_holdingvoltage;
%     std_noise_all_de_noisevde(k)=std_noise;
% end
% 
% gains_all_de_noisevde(isnan(rsq_all_de_noisevde))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_de_noisevde=nanmean(peakrate_all_de_noisevde);
% std_peakrate_de_noisevde=nanstd(peakrate_all_de_noisevde);
% mean_nofailrate_de_noisevde=nanmean(nofailrate_all_de_noisevde);
% std_nofailrate_de_noisevde=nanstd(nofailrate_all_de_noisevde);
% mean_gains_de_noisevde=nanmean(gains_all_de_noisevde);
% std_gains_de_noisevde=nanstd(gains_all_de_noisevde);
% ste_gains_de_noisevde=std_gains_de_noisevde/sqrt(sum(~isnan(gains_all_de_noisevde)));
% mean_resistance_de_noisevde=nanmean(resistance_all_de_noisevde);
% std_resistance_de_noisevde=nanstd(resistance_all_de_noisevde);
% mean_capacitance_de_noisevde=nanmean(capacitance_all_de_noisevde);
% std_capacitance_de_noisevde=nanstd(capacitance_all_de_noisevde);
% mean_tau_m_de_noisevde=nanmean(time_constant_all_de_noisevde);
% std_tau_m_de_noisevde=nanstd(time_constant_all_de_noisevde);
% mean_imp_de_noisevde=nanmean(imp_all_de_noisevde);
% std_imp_de_noisevde=nanstd(imp_all_de_noisevde);
% mean_holdingvoltage_all_de_noisevde=nanmean(holdingvoltage_all_de_noisevde);
% std_holdingvoltage_all_de_noisevde=nanstd(holdingvoltage_all_de_noisevde);
% mean_std_noise_all_de_noisevde=nanmean(std_noise_all_de_noisevde);
% std_std_noise_all_de_noisevde=nanstd(std_noise_all_de_noisevde);
% 
% % difference between rates (unpaired)
% difference_rate_devdenoise=rate_all_de_noisevde-rate_all_devdenoise;
% mean_difference_rate_devdenoise=nanmean(difference_rate_devdenoise);
% std_difference_rate_devdenoise=nanstd(difference_rate_devdenoise);
% ste_difference_rate_devdenoise=std_difference_rate_devdenoise./sqrt(sum(~isnan(difference_rate_devdenoise)));
% 
% percent_difference_rate_devdenoise=(difference_rate_devdenoise./rate_all_devdenoise)*100;
% percent_difference_rate_devdenoise(~isfinite(percent_difference_rate_devdenoise))=NaN;
% mean_percent_difference_rate_devdenoise=nanmean(percent_difference_rate_devdenoise);
% std_percent_difference_rate_devdenoise=nanstd(percent_difference_rate_devdenoise);
% ste_percent_difference_rate_devdenoise=std_percent_difference_rate_devdenoise./sqrt(sum(~isnan(percent_difference_rate_devdenoise)));
% 
% new_percent_difference_rate_devdenoise=difference_rate_devdenoise./rate_all_de_noisevde;
% new_percent_difference_rate_devdenoise(~isfinite(new_percent_difference_rate_devdenoise))=NaN;
% mean_new_percent_difference_rate_devdenoise=nanmean(new_percent_difference_rate_devdenoise);
% std_new_percent_difference_rate_devdenoise=nanstd(new_percent_difference_rate_devdenoise);
% ste_new_percent_difference_rate_devdenoise=std_new_percent_difference_rate_devdenoise./sqrt(sum(~isnan(new_percent_difference_rate_devdenoise)));
% 
% % difference between rates (paired)
% paired_difference_rate_devdenoise=rate_all_de_noisevde-rate_all_devdenoise;
% paired_mean_difference_rate_devdenoise=nanmean(paired_difference_rate_devdenoise);
% paired_std_difference_rate_devdenoise=nanstd(paired_difference_rate_devdenoise);
% paired_ste_difference_rate_devdenoise=paired_std_difference_rate_devdenoise./sqrt(sum(~isnan(paired_difference_rate_devdenoise)));
% 
% paired_percent_difference_rate_devdenoise=(paired_difference_rate_devdenoise./rate_all_devdenoise)*100;
% paired_percent_difference_rate_devdenoise(~isfinite(paired_percent_difference_rate_devdenoise))=NaN;
% paired_mean_percent_difference_rate_devdenoise=nanmean(paired_percent_difference_rate_devdenoise);
% paired_std_percent_difference_rate_devdenoise=nanstd(paired_percent_difference_rate_devdenoise);
% paired_ste_percent_difference_rate_devdenoise=paired_std_percent_difference_rate_devdenoise./sqrt(sum(~isnan(paired_percent_difference_rate_devdenoise)));
% 
% paired_new_percent_difference_rate_devdenoise=paired_difference_rate_devdenoise./rate_all_de_noisevde;
% paired_new_percent_difference_rate_devdenoise(~isfinite(paired_new_percent_difference_rate_devdenoise))=NaN;
% paired_mean_new_percent_difference_rate_devdenoise=nanmean(paired_new_percent_difference_rate_devdenoise);
% paired_std_new_percent_difference_rate_devdenoise=nanstd(paired_new_percent_difference_rate_devdenoise);
% paired_ste_new_percent_difference_rate_devdenoise=paired_std_new_percent_difference_rate_devdenoise./sqrt(sum(~isnan(paired_new_percent_difference_rate_devdenoise)));


%% Depolarized (5 sec pulse, 1 sec pause; 200 pA range of currents)
% For Depolarized with Leak and Noise

dates_all_devdeleaknoise={'Oct_28_14' 'Oct_30_14' 'Nov_26_14' 'Jan_07_15' 'Jan_07_15' 'Mar_17_15'...
    'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15' 'Apr_06_15' 'Apr_07_15'...
    'Apr_07_15' 'Apr_07_15'};
cellnum_all_devdeleaknoise={'A' 'A' 'A' 'A' 'B' 'A'...
    'A' 'B' 'E' 'B' 'B' 'A'...
    'C' 'D'};
trials_all_devdeleaknoise=[2 2 2 2 2 2 ...
    6 2 2 4 6 6 ...
    6 4]';

sub_currents_hyper_all=NaN(numel(dates_all_devdeleaknoise),21);
sub_currents_de_all=NaN(numel(dates_all_devdeleaknoise),21);
avg_sub_voltage_hyper=NaN(numel(dates_all_devdeleaknoise),21);
avg_sub_voltage_de=NaN(numel(dates_all_devdeleaknoise),21);
sup_currents_hyper_all=NaN(numel(dates_all_devdeleaknoise),21);
sup_currents_de_all=NaN(numel(dates_all_devdeleaknoise),21);
avg_sup_voltage_hyper=NaN(numel(dates_all_devdeleaknoise),21);
avg_sup_voltage_de=NaN(numel(dates_all_devdeleaknoise),21);
smooth_sub_resistance_hyper=NaN(numel(dates_all_devdeleaknoise),21);
smooth_sub_resistance_de=NaN(numel(dates_all_devdeleaknoise),21);
smooth_voltages_hyper=NaN(numel(dates_all_devdeleaknoise),21);
smooth_voltages_de=NaN(numel(dates_all_devdeleaknoise),21);
bin_size=10; %in mV
bins=-110:bin_size:-40; %in mV
binned_resistances_hyper=NaN(numel(dates_all_devdeleaknoise),numel(bins));
binned_resistances_de=NaN(numel(dates_all_devdeleaknoise),numel(bins));

for k=1:numel(dates_all_devdeleaknoise)
    eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_devdeleaknoise{k} '_' cellnum_all_devdeleaknoise{k} num2str(trials_all_devdeleaknoise(k)) '_fV.mat;'])
    gains_all(k,1)=pf_all{1}.beta(2);
    rsq_all(k,1)=pf_all{1}.rsquare;
    threshold_all(k,1)=threshold;
    avg_voltage_hyper_all(k,:)=avg_voltage{1};
    currents_hyper_all(k,:)=currents{1};
    rate_hyper_all(k,:)=rate_all{1};
    if sum(rate_hyper_all(k,:)>=1)
        hyper_2threshold(k)=find(rate_hyper_all(k,:)>=1,1);
        sub_currents_hyper_all(k,1:hyper_2threshold(k)-1)=currents_hyper_all(k,1:hyper_2threshold(k)-1);
        avg_sub_voltage_hyper(k,1:hyper_2threshold(k)-1)=avg_voltage_hyper_all(k,1:hyper_2threshold(k)-1);
        sup_currents_hyper_all(k,hyper_2threshold(k):end)=currents_hyper_all(k,hyper_2threshold(k):end);
        avg_sup_voltage_hyper(k,hyper_2threshold(k):end)=avg_voltage_hyper_all(k,hyper_2threshold(k):end);
    else
        hyper_2threshold(k)=NaN;
        sub_currents_hyper_all(k,:)=currents_hyper_all(k,:);
        avg_sub_voltage_hyper(k,:)=avg_voltage_hyper_all(k,:);
    end
    for h=1:numel(avg_sub_voltage_hyper(k,:))-3
        smooth_voltages_hyper(k,h)=mean(avg_sub_voltage_hyper(k,h:h+3));
        resistance_hyper_fit=polyfit(currents_hyper_all(k,h:h+3),avg_sub_voltage_hyper(k,h:h+3),1);
        smooth_sub_resistance_hyper(k,h)=resistance_hyper_fit(1);
    end
    for p=1:numel(bins)-1
        binned_resistances_hyper(k,p)=mean(smooth_sub_resistance_hyper(k,smooth_voltages_hyper(k,:)<bins(p+1) & bins(p)<smooth_voltages_hyper(k,:)));
    end
end


%% Depolarized with Leak and Noise (400 pA range of currents)
% For Depolarized

dates_all_de_leak_noisevde={'Oct_28_14' 'Oct_30_14' 'Nov_26_14' 'Jan_07_15' 'Jan_07_15' 'Mar_17_15'...
    'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15' 'Apr_06_15' 'Apr_07_15'...
    'Apr_07_15' 'Apr_07_15'};
cellnum_all_de_leak_noisevde={'A' 'A' 'A' 'A' 'B' 'A'...
    'A' 'B' 'E' 'B' 'B' 'A'...
    'C' 'D'};
trials_all_de_leak_noisevde=[1 1 1 1 1 3 ...
    1 5 3 5 3 3 ...
    3 3]';

for k=1:numel(dates_all_de_leak_noisevde)
    eval(['load ' pwd '\fV_analysis\FI_OU_' dates_all_de_leak_noisevde{k} '_' cellnum_all_de_leak_noisevde{k} num2str(trials_all_de_leak_noisevde(k)) '_fV.mat;'])
    gains_all(k,2)=pf_all{1}.beta(2);
    rsq_all(k,2)=pf_all{1}.rsquare;
    threshold_all(k,2)=threshold;
    avg_voltage_de_all(k,:)=avg_voltage{1}*1e3;
    currents_de_all(k,:)=currents{1};
    rate_de_all(k,:)=rate_all{1};
    if sum(rate_de_all(k,:)>=1)
        de_2threshold(k)=find(rate_de_all(k,:)>=1,1);
        sub_currents_de_all(k,1:de_2threshold(k)-1)=currents_de_all(k,1:de_2threshold(k)-1);
        avg_sub_voltage_de(k,1:de_2threshold(k)-1)=avg_voltage_de_all(k,1:de_2threshold(k)-1);
        sup_currents_de_all(k,de_2threshold(k):end)=currents_de_all(k,de_2threshold(k):end);
        avg_sup_voltage_de(k,de_2threshold(k):end)=avg_voltage_de_all(k,de_2threshold(k):end);
    else
        de_2threshold(k)=NaN;
        sub_currents_de_all(k,:)=currents_de_all(k,:);
        avg_sub_voltage_de(k,:)=avg_voltage_de_all(k,:);
    end
    for h=1:numel(avg_sub_voltage_hyper(k,:))-3
        smooth_voltages_de(k,h)=mean(avg_sub_voltage_de(k,h:h+3));
        resistance_de_fit=polyfit(currents_de_all(k,h:h+3),avg_sub_voltage_de(k,h:h+3),1);
        smooth_sub_resistance_de(k,h)=resistance_de_fit(1);
    end
    for p=1:numel(bins)-1
        binned_resistances_de(k,p)=mean(smooth_sub_resistance_de(k,smooth_voltages_de(k,:)<bins(p+1) & bins(p)<smooth_voltages_de(k,:)));
    end
end

mean_binned_resistances_hyper=nanmean(binned_resistances_hyper);
std_binned_resistances_hyper=nanstd(binned_resistances_hyper);
ste_binned_resistances_hyper=std_binned_resistances_hyper./sqrt(sum(isfinite(binned_resistances_hyper)));
mean_binned_resistances_de=nanmean(binned_resistances_de);
std_binned_resistances_de=nanstd(binned_resistances_de);
ste_binned_resistances_de=std_binned_resistances_de./sqrt(sum(isfinite(binned_resistances_de)));

figure;shadedErrorBar(bins+bin_size/2,mean_binned_resistances_hyper,ste_binned_resistances_hyper)
hold on;shadedErrorBar(bins+bin_size/2,mean_binned_resistances_de,ste_binned_resistances_de,'r')

mean_gains=mean(gains_all);
std_gains=std(gains_all);
mean_threshold=mean(threshold_all);
std_threshold=std(threshold_all);

diff_voltage_all=avg_voltage_hyper_all-avg_voltage_de_all;

mean_avg_voltage_hyper=mean(avg_voltage_hyper_all);
std_avg_voltage_hyper=std(avg_voltage_hyper_all);
ste_avg_voltage_hyper=std_avg_voltage_hyper/sqrt(numel(dates_all_devdeleaknoise));
mean_avg_voltage_de=mean(avg_voltage_de_all);
std_avg_voltage_de=std(avg_voltage_de_all);
ste_avg_voltage_de=std_avg_voltage_de/sqrt(numel(dates_all_devdeleaknoise));
mean_diff_voltage=mean(diff_voltage_all);
std_diff_voltage=std(diff_voltage_all);
ste_diff_voltage=std_diff_voltage/sqrt(numel(dates_all_devdeleaknoise));

figure;errorbar(0:10:200,nanmean(avg_sub_voltage_hyper),nanstd(avg_sub_voltage_hyper)./sqrt(sum(~isnan(avg_sub_voltage_hyper))));
hold on;errorbar(0:10:200,nanmean(avg_sup_voltage_hyper),nanstd(avg_sup_voltage_hyper)./sqrt(sum(~isnan(avg_sup_voltage_hyper))),'r');
hold on;errorbar(0:10:200,nanmean(avg_sub_voltage_de),nanstd(avg_sub_voltage_de)./sqrt(sum(~isnan(avg_sub_voltage_de))),'g');
hold on;errorbar(0:10:200,nanmean(avg_sup_voltage_de),nanstd(avg_sup_voltage_de)./sqrt(sum(~isnan(avg_sup_voltage_de))),'m');
title({'Subthreshold Depolarized (Blue)';'Suprathreshold Depolarized (Red)';'Subthreshold Depolarized with Leak and Noise (Green)';'Suprathreshold Depolarized with Leak and Noise (Magenta)'})


sub_resistance_hyper=(diff(avg_sub_voltage_hyper')'/(currents_hyper_all(k,2)-currents_hyper_all(k,1)))/1e-9; % find the resistance in ohms
sub_resistance_de=(diff(avg_sub_voltage_de')'/(currents_de_all(k,2)-currents_de_all(k,1)))/1e-9;
diff_sub_resistance=sub_resistance_hyper-sub_resistance_de;

mean_sub_resistance_hyper=nanmean(sub_resistance_hyper);
std_sub_resistance_hyper=nanstd(sub_resistance_hyper);
nh=length(sub_resistance_hyper(:,1))-sum(isnan(sub_resistance_hyper));
ste_sub_resistance_hyper=std_sub_resistance_hyper./sqrt(nh);
mean_sub_resistance_de=nanmean(sub_resistance_de);
std_sub_resistance_de=nanstd(sub_resistance_de);
nd=length(sub_resistance_de(:,1))-sum(isnan(sub_resistance_de));
ste_sub_resistance_de=std_sub_resistance_de./sqrt(nd);
mean_sub_diff_resistance=nanmean(diff_sub_resistance);
std_sub_diff_resistance=nanstd(diff_sub_resistance);
ndiff=length(diff_sub_resistance(:,1))-sum(isnan(diff_sub_resistance));
ste_sub_diff_resistance=std_sub_diff_resistance./sqrt(ndiff);


figure;shadedErrorBar(0:10:200,mean_avg_voltage_hyper,ste_avg_voltage_hyper)
hold on;shadedErrorBar(0:10:200,mean_avg_voltage_de,ste_avg_voltage_de,'r')
title('I-V Curves for Depolarized (Black) and Depolarized with Leak and Noise (Red)')


%% Statistics

[gainsttest_hyper_de(1),gainsttest_hyper_de(2)]=ttest(gains_all_hypervde,gains_all_devhyper);
[gainsttest_hyper_hyper_noise(1),gainsttest_hyper_hyper_noise(2)]=ttest(gains_all_hypervhypernoise,gains_all_hyper_noisevhyper);
[gainsttest_hyper_hyper_negative_leak(1),gainsttest_hyper_hyper_negative_leak(2)]=ttest(gains_all_hypervhypernegativeleak,gains_all_hyper_negative_leakvhyper);
[gainsttest_hyper_hyper_current_subtracted(1),gainsttest_hyper_hyper_current_subtracted(2)]=ttest(gains_all_hypervhypercurrentsubtracted,gains_all_hyper_current_subtractedvhyper);
[gainsttest_de_de_leak(1),gainsttest_de_de_leak(2)]=ttest(gains_all_devdeleak,gains_all_de_leakvde);
[gainsttest_de_de_noise(1),gainsttest_de_de_noise(2)]=ttest(gains_all_devdenoise,gains_all_de_noisevde);
[gainsttest_de_de_leak_noise(1),gainsttest_de_de_leak_noise(2)]=ttest(gains_all_devdeleaknoise,gains_all_de_leak_noisevde);


%% Plotting

% figure;errorbar(1:2,[mean_gains_hypervde mean_gains_devhyper],[ste_gains_hypervde ste_gains_devhyper],'.m','LineWidth',2);
% hold on;bar(1:2,[mean_gains_hypervde mean_gains_devhyper],.5,'m')
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/pA]')
% xlabel('Hyperpolarized    Depolarized')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(1:2,[mean_gains_hypervhypernoise mean_gains_hyper_noisevhyper],[ste_gains_hypervhypernoise ste_gains_hyper_noisevhyper],'.m','LineWidth',2);
% hold on;bar(1:2,[mean_gains_hypervhypernoise mean_gains_hyper_noisevhyper],.5,'m')
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/pA]')
% xlabel('Hyperpolarized    Hyperpolarized with Noise')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(1:2,[mean_gains_hypervhypernegativeleak mean_gains_hyper_negative_leakvhyper],[ste_gains_hypervhypernegativeleak ste_gains_hyper_negative_leakvhyper],'.m','LineWidth',2);
% hold on;bar(1:2,[mean_gains_hypervhypernegativeleak mean_gains_hyper_negative_leakvhyper],.5,'m')
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/pA]')
% xlabel('Hyperpolarized    Hyperpolarized with Negative Leak')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(1:2,[mean_gains_hypervhypercurrentsubtracted mean_gains_hyper_current_subtractedvhyper],[ste_gains_hypervhypercurrentsubtracted ste_gains_hyper_current_subtractedvhyper],'.m','LineWidth',2);
% hold on;bar(1:2,[mean_gains_hypervhypercurrentsubtracted mean_gains_hyper_current_subtractedvhyper],.5,'m')
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/pA]')
% xlabel('Hyperpolarized    Hyperpolarized with Current Subtracted')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(1:2,[mean_gains_devdeleak mean_gains_de_leakvde],[ste_gains_devdeleak ste_gains_de_leakvde],'.m','LineWidth',2);
% hold on;bar(1:2,[mean_gains_devdeleak mean_gains_de_leakvde],.5,'m')
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/pA]')
% xlabel('Depolarized    Depolarized with Leak')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(1:2,[mean_gains_devdenoise mean_gains_de_noisevde],[ste_gains_devdenoise ste_gains_de_noisevde],'.m','LineWidth',2);
% hold on;bar(1:2,[mean_gains_devdenoise mean_gains_de_noisevde],.5,'m')
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/pA]')
% xlabel('Depolarized    Depolarized with Noise')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(1:2,[mean_gains_devdeleaknoise mean_gains_de_leak_noisevde],[ste_gains_devdeleaknoise ste_gains_de_leak_noisevde],'.m','LineWidth',2);
% hold on;bar(1:2,[mean_gains_devdeleaknoise mean_gains_de_leak_noisevde],.5,'m')
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/pA]')
% xlabel('Depolarized    Depolarized with Leak and Noise')
% % axis([0.4 2.6 0 0.2])

figure;errorbar(0:10:200,mean_difference_rate_hypervde,ste_difference_rate_hypervde)
title('Difference in Frequencies for Hyperpolarized and Depolarized')
ylabel('Frequency Difference [Hz]')
xlabel('Current [pA]')
% axis([0.4 2.6 0 0.2])

figure;errorbar(0:10:200,mean_difference_rate_hypervhypernoise,ste_difference_rate_hypervhypernoise)
title('Difference in Frequencies for Hyperpolarized and Hyperpolarized with Noise')
ylabel('Frequency Difference [Hz]')
xlabel('Current [pA]')
% axis([0.4 2.6 0 0.2])

figure;errorbar(1:21,mean_difference_rate_hypervhypernegativeleak,ste_difference_rate_hypervhypernegativeleak)
title('Difference in Frequencies for Hyperpolarized and Hyperpolarized with Negative Leak')
ylabel('Frequency Difference [Hz]')
xlabel('Current Step')
% axis([0.4 2.6 0 0.2])

figure;errorbar(0:10:200,mean_difference_rate_hypervhypercurrentsubtracted,ste_difference_rate_hypervhypercurrentsubtracted)
title('Difference in Frequencies for Hyperpolarized and Hyperpolarized with Current Subtracted')
ylabel('Frequency Difference [Hz]')
xlabel('Current [pA]')
% axis([0.4 2.6 0 0.2])

figure;errorbar(1:21,mean_difference_rate_devdeleak,ste_difference_rate_devdeleak)
title('Difference in Frequencies for Depolarized and Depolarized with Leak')
ylabel('Frequency Difference [Hz]')
xlabel('Current Step')
% axis([0.4 2.6 0 0.2])

figure;errorbar(0:10:200,mean_difference_rate_devdenoise,ste_difference_rate_devdenoise)
title('Difference in Frequencies for Depolarized and Depolarized with Just Noise')
ylabel('Frequency Difference [Hz]')
xlabel('Current [pA]')
% axis([0.4 2.6 0 0.2])

figure;errorbar(1:21,mean_difference_rate_devdeleaknoise,ste_difference_rate_devdeleaknoise)
title('Difference in Frequencies for Depolarized and Depolarized with Leak and Noise')
ylabel('Frequency Difference [Hz]')
xlabel('Current Step')
% axis([0.4 2.6 0 0.2])

figure;errorbar(0:10:200,mean_difference_rate_hypervhypernoise,ste_difference_rate_hypervhypernoise)
hold on;errorbar(0:10:200,mean_difference_rate_devdenoise,ste_difference_rate_devdenoise,'r')
title('Difference in Frequencies with and without Noise for Hyperpolarized (Blue) and Depolarized (Red)')
ylabel('Frequency Difference [Hz]')
xlabel('Current [pA]')
% axis([0.4 2.6 0 0.2])

figure;errorbar(0:10:200,mean_percent_difference_rate_hypervhypernoise,ste_percent_difference_rate_hypervhypernoise)
hold on;errorbar(0:10:200,mean_percent_difference_rate_devdenoise,ste_percent_difference_rate_devdenoise,'r')
title('Percentage Difference in Frequencies with and without Noise for Hyperpolarized (Blue) and Depolarized (Red)')
ylabel('Frequency Difference [%]')
xlabel('Current [pA]')
% axis([0.4 2.6 0 0.2])

figure;errorbar(0:10:200,mean_new_percent_difference_rate_hypervhypernoise,ste_new_percent_difference_rate_hypervhypernoise)
hold on;errorbar(0:10:200,mean_new_percent_difference_rate_devdenoise,ste_new_percent_difference_rate_devdenoise,'r')
title('Difference in Frequencies with and without Noise for Hyperpolarized (Blue) and Depolarized (Red)')
ylabel('Frequency Difference [(fnoise - fnoiseless)/fnoise]')
xlabel('Current [pA]')
% axis([0.4 2.6 0 0.2])

figure;errorbar(0:10:200,paired_mean_new_percent_difference_rate_hypervhypernoise,paired_ste_new_percent_difference_rate_hypervhypernoise)
hold on;errorbar(0:10:200,paired_mean_new_percent_difference_rate_devdenoise,paired_ste_new_percent_difference_rate_devdenoise,'r')
title('Paired Differences in Frequencies with and without Noise for Hyperpolarized (Blue) and Depolarized (Red)')
ylabel('Frequency Difference [(fnoise - fnoiseless)/fnoise]')
xlabel('Current [pA]')
% axis([0.4 2.6 0 0.2])