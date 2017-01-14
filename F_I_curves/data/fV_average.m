clear;clc;%close all

dates_all={'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'... %used different depolarized current range: 'Mar_19_13' 'Mar_21_13' 
    'May_31_13' 'May_31_13' 'Jun_24_13' 'Jun_24_13' 'Jul_03_13' 'Jul_03_13'...
    'Jul_29_13' 'Jul_29_13' 'Aug_05_13' 'Aug_16_13' 'Sep_05_13' 'Sep_16_13'...
    'Oct_08_13' 'Oct_08_13' 'Mar_18_14'};
cellnum_all={'B' 'A' 'A' 'B'... %used different depolarized current range: 'B' 'A'
    'C' 'D' 'A' 'B' 'A' 'B'...
    'A' 'B' 'A' 'A' 'A' 'A'...
    'A' 'B' 'A'};

sub_currents_hyper_all=NaN(numel(dates_all),51);
sub_currents_de_all=NaN(numel(dates_all),51);
avg_sub_voltage_hyper=NaN(numel(dates_all),51);
avg_sub_voltage_de=NaN(numel(dates_all),51);
sup_currents_hyper_all=NaN(numel(dates_all),51);
sup_currents_de_all=NaN(numel(dates_all),51);
avg_sup_voltage_hyper=NaN(numel(dates_all),51);
avg_sup_voltage_de=NaN(numel(dates_all),51);
smooth_sub_resistance_hyper=NaN(numel(dates_all),51);
smooth_sub_resistance_de=NaN(numel(dates_all),51);
smooth_voltages_hyper=NaN(numel(dates_all),51);
smooth_voltages_de=NaN(numel(dates_all),51);
bin_size=10; %in mV
bins=-110:bin_size:-40; %in mV
binned_resistances_hyper=NaN(numel(dates_all),numel(bins));
binned_resistances_de=NaN(numel(dates_all),numel(bins));

for k=1:numel(dates_all)
    eval(['load ' pwd '\fV_analysis\fi_curves_' dates_all{k} '_' cellnum_all{k} '_fV.mat;'])
    gains_all(k,1)=pf_all{1}.beta(2);
    gains_all(k,2)=pf_all{2}.beta(2);
    rsq_all(k,1)=pf_all{1}.rsquare;
    rsq_all(k,2)=pf_all{2}.rsquare;
    threshold_all(k,:)=threshold;
    avg_voltage_hyper_all(k,:)=avg_voltage{1};
    avg_voltage_de_all(k,:)=avg_voltage{2};
    currents_hyper_all(k,:)=currents{1};
    currents_de_all(k,:)=currents{2};
    rate_hyper_all(k,:)=rate_all{1};
    rate_de_all(k,:)=rate_all{2};
    if sum(rate_hyper_all(k,:)>=2)
        hyper_2threshold(k)=find(rate_hyper_all(k,:)>=2,1);
        sub_currents_hyper_all(k,1:hyper_2threshold(k)-1)=currents_hyper_all(k,1:hyper_2threshold(k)-1);
        avg_sub_voltage_hyper(k,1:hyper_2threshold(k)-1)=avg_voltage_hyper_all(k,1:hyper_2threshold(k)-1);
        sup_currents_hyper_all(k,hyper_2threshold(k):end)=currents_hyper_all(k,hyper_2threshold(k):end);
        avg_sup_voltage_hyper(k,hyper_2threshold(k):end)=avg_voltage_hyper_all(k,hyper_2threshold(k):end);
    else
        hyper_2threshold(k)=NaN;
        sub_currents_hyper_all(k,:)=currents_hyper_all(k,:);
        avg_sub_voltage_hyper(k,:)=avg_voltage_hyper_all(k,:);
    end
    if sum(rate_de_all(k,:)>=2)
        de_2threshold(k)=find(rate_de_all(k,:)>=2,1);
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
        smooth_voltages_hyper(k,h)=mean(avg_sub_voltage_hyper(k,h:h+3));
        resistance_hyper_fit=polyfit(currents_hyper_all(k,h:h+3),avg_sub_voltage_hyper(k,h:h+3),1);
        smooth_sub_resistance_hyper(k,h)=resistance_hyper_fit(1);
        smooth_voltages_de(k,h)=mean(avg_sub_voltage_de(k,h:h+3));
        resistance_de_fit=polyfit(currents_de_all(k,h:h+3),avg_sub_voltage_de(k,h:h+3),1);
        smooth_sub_resistance_de(k,h)=resistance_de_fit(1);
    end
    for p=1:numel(bins)-1
        binned_resistances_hyper(k,p)=mean(smooth_sub_resistance_hyper(k,smooth_voltages_hyper(k,:)<bins(p+1) & bins(p)<smooth_voltages_hyper(k,:)));
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
ste_avg_voltage_hyper=std_avg_voltage_hyper/sqrt(numel(dates_all));
mean_avg_voltage_de=mean(avg_voltage_de_all);
std_avg_voltage_de=std(avg_voltage_de_all);
ste_avg_voltage_de=std_avg_voltage_de/sqrt(numel(dates_all));
mean_diff_voltage=mean(diff_voltage_all);
std_diff_voltage=std(diff_voltage_all);
ste_diff_voltage=std_diff_voltage/sqrt(numel(dates_all));

figure;errorbar(-50:5:200,nanmean(avg_sub_voltage_hyper),nanstd(avg_sub_voltage_hyper)./sqrt(sum(~isnan(avg_sub_voltage_hyper))));
hold on;errorbar(-50:5:200,nanmean(avg_sup_voltage_hyper),nanstd(avg_sup_voltage_hyper)./sqrt(sum(~isnan(avg_sup_voltage_hyper))),'r');
hold on;errorbar(-50:5:200,nanmean(avg_sub_voltage_de),nanstd(avg_sub_voltage_de)./sqrt(sum(~isnan(avg_sub_voltage_de))),'g');
hold on;errorbar(-50:5:200,nanmean(avg_sup_voltage_de),nanstd(avg_sup_voltage_de)./sqrt(sum(~isnan(avg_sup_voltage_de))),'m');

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


figure;shadedErrorBar(-50:5:200,mean_avg_voltage_hyper,ste_avg_voltage_hyper)
hold on;shadedErrorBar(-50:5:200,mean_avg_voltage_de,ste_avg_voltage_de,'r')
title('I-V Curves for Hyperpolarized (Black) and Depolarized (Red)')

figure;shadedErrorBar(-50:5:200,mean_diff_voltage,ste_diff_voltage)
title('Difference Between I-V Curves (Hyperpolarized - Depolarized)')

figure;shadedErrorBar(-45:5:200,mean_sub_resistance_hyper,ste_sub_resistance_hyper)
hold on;shadedErrorBar(-45:5:200,mean_sub_resistance_de,ste_sub_resistance_de,'r')
title('Resistance Curves for Hyperpolarized (Black) and Depolarized (Red)')

%find averages of 5 different spots on the Resistance Curve
diff_currents=-45:5:200;
currents1=mean(diff_currents(1:4));
mean_sub_resistance_hyper1=mean(mean_sub_resistance_hyper(1:4));
ste_sub_resistance_hyper1=mean(ste_sub_resistance_hyper(1:4));
mean_sub_resistance_de1=mean(mean_sub_resistance_de(1:4));
ste_sub_resistance_de1=mean(ste_sub_resistance_de(1:4));
currents2=mean(diff_currents(11:14));
mean_sub_resistance_hyper2=mean(mean_sub_resistance_hyper(11:14));
ste_sub_resistance_hyper2=mean(ste_sub_resistance_hyper(11:14));
mean_sub_resistance_de2=mean(mean_sub_resistance_de(11:14));
ste_sub_resistance_de2=mean(ste_sub_resistance_de(11:14));
currents3=mean(diff_currents(20:23));
mean_sub_resistance_hyper3=mean(mean_sub_resistance_hyper(20:23));
ste_sub_resistance_hyper3=mean(ste_sub_resistance_hyper(20:23));
mean_sub_resistance_de3=mean(mean_sub_resistance_de(20:23));
ste_sub_resistance_de3=mean(ste_sub_resistance_de(20:23));
currents4=mean(diff_currents(33:36));
mean_sub_resistance_hyper4=mean(mean_sub_resistance_hyper(33:36));
ste_sub_resistance_hyper4=mean(ste_sub_resistance_hyper(33:36));
mean_sub_resistance_de4=mean(mean_sub_resistance_de(33:36));
ste_sub_resistance_de4=mean(ste_sub_resistance_de(33:36));
currents5=mean(diff_currents(47:50));
mean_sub_resistance_hyper5=mean(mean_sub_resistance_hyper(47:50));
ste_sub_resistance_hyper5=mean(ste_sub_resistance_hyper(47:50));
mean_sub_resistance_de5=mean(mean_sub_resistance_de(42:45));
ste_sub_resistance_de5=mean(ste_sub_resistance_de(42:45));

currents_points=[currents1 currents2 currents3 currents4 currents5];
mean_sub_resistance_points_hyper=[mean_sub_resistance_hyper1 mean_sub_resistance_hyper2 mean_sub_resistance_hyper3 mean_sub_resistance_hyper4 mean_sub_resistance_hyper5];
ste_sub_resistance_points_hyper=[ste_sub_resistance_hyper1 ste_sub_resistance_hyper2 ste_sub_resistance_hyper3 ste_sub_resistance_hyper4 ste_sub_resistance_hyper5];
mean_sub_resistance_points_de=[mean_sub_resistance_de1 mean_sub_resistance_de2 mean_sub_resistance_de3 mean_sub_resistance_de4 mean_sub_resistance_de5];
ste_sub_resistance_points_de=[ste_sub_resistance_de1 ste_sub_resistance_de2 ste_sub_resistance_de3 ste_sub_resistance_de4 ste_sub_resistance_de5];

figure;errorbar(currents_points,mean_sub_resistance_points_hyper,ste_sub_resistance_points_hyper,'k')
hold on;errorbar(currents_points,mean_sub_resistance_points_de,ste_sub_resistance_points_de,'r')

%find running average of Average Resistance Curves
for k=2:numel(mean_sub_resistance_hyper)-1
    smooth_mean_sub_resistance_hyper(k-1)=mean(mean_sub_resistance_hyper(k-1:k+1));
    smooth_ste_sub_resistance_hyper(k-1)=mean(ste_sub_resistance_hyper(k-1:k+1)); %should I take the mean of the stes?
    smooth_mean_sub_resistance_de(k-1)=mean(mean_sub_resistance_de(k-1:k+1));
    smooth_ste_sub_resistance_de(k-1)=mean(ste_sub_resistance_de(k-1:k+1));
end
figure;shadedErrorBar(-40:5:195,smooth_mean_sub_resistance_hyper,smooth_ste_sub_resistance_hyper)
hold on;shadedErrorBar(-40:5:195,smooth_mean_sub_resistance_de,smooth_ste_sub_resistance_de,'r')
title('Smoothed Resistance Curves for Hyperpolarized (Black) and Depolarized (Red)')

% figure;shadedErrorBar(-45:5:200,mean_sub_diff_resistance,ste_sub_diff_resistance)
% title('Difference Between Resistance Curves (Hyperpolarized - Depolarized)')

[gainsttest(1),gainsttest(2)]=ttest(gains_all(:,1),gains_all(:,2));
[thresholdttest(1),thresholdttest(2)]=ttest(threshold_all(:,1),threshold_all(:,2));

figure;errorbar(1:2,mean_gains,std_gains/sqrt(numel(dates_all)),'or','LineWidth',2);
title('History-Dependent Change in Gains')
ylabel('Gains [Hz/mV]')
xlabel('Hyperpolarized vs. Depolarized')
% axis([0.8 2.2 0 0.25])

figure;errorbar(1:2,mean_threshold,std_threshold/sqrt(numel(dates_all)),'or','LineWidth',2);
title('History-Dependent Change in Threshold')
ylabel('Threshold [mV]')
xlabel('Hyperpolarized vs. Depolarized')
% axis([0.8 2.2 0 0.25])