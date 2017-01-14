clear;clc;%close all

dates_all={'Sep_05_13' 'Sep_10_13' 'Oct_08_13'}; %'Jul_03_13' Used different number of increments so much be analyzed separately, but data still good
cellnum_all={'A' 'A' 'B'}; %'B'

avg_sub_voltage_hyper=NaN(numel(dates_all),51);
avg_sub_voltage_de=NaN(numel(dates_all),51);

for k=1:numel(dates_all)
    eval(['load ' pwd '\fV_4AP_analysis\fi_curves_' dates_all{k} '_' cellnum_all{k} '_fV_4AP.mat;'])
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
        avg_sub_voltage_hyper(k,1:hyper_2threshold(k)-1)=avg_voltage_hyper_all(k,1:hyper_2threshold(k)-1);
    else
        hyper_2threshold(k)=NaN;
        avg_sub_voltage_hyper(k,:)=avg_voltage_hyper_all(k,:);
    end
    if sum(rate_de_all(k,:)>=2)
        de_2threshold(k)=find(rate_de_all(k,:)>=2,1);
        avg_sub_voltage_de(k,1:de_2threshold(k)-1)=avg_voltage_de_all(k,1:de_2threshold(k)-1);
    else
        de_2threshold(k)=NaN;
        avg_sub_voltage_de(k,:)=avg_voltage_de_all(k,:);
    end
end

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


sub_resistance_hyper=diff(avg_sub_voltage_hyper')'/1e-9; % find the resistance in ohms
sub_resistance_de=diff(avg_sub_voltage_de')'/1e-9;
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
title('I-V Curves for Hyperpolarized (Black) and Depolarized (Red) with 4-AP')

figure;shadedErrorBar(-50:5:200,mean_diff_voltage,ste_diff_voltage)
title('Difference Between I-V Curves (Hyperpolarized - Depolarized) with 4-AP')

figure;shadedErrorBar(-45:5:200,mean_sub_resistance_hyper,ste_sub_resistance_hyper)
hold on;shadedErrorBar(-45:5:200,mean_sub_resistance_de,ste_sub_resistance_de,'r')
title('Resistance Curves for Hyperpolarized (Black) and Depolarized (Red) with 4-AP')

figure;shadedErrorBar(-45:5:200,mean_sub_diff_resistance,ste_sub_diff_resistance)
title('Difference Between Resistance Curves (Hyperpolarized - Depolarized) with 4-AP')


[gainsttest(1),gainsttest(2)]=ttest(gains_all(:,1),gains_all(:,2));
[thresholdttest(1),thresholdttest(2)]=ttest(threshold_all(:,1),threshold_all(:,2));

figure;errorbar(1:2,mean_gains,std_gains/sqrt(numel(dates_all)),'or','LineWidth',2);
title('History-Dependent Change in Gains')
ylabel('Gains [mV/pA]')
xlabel('Hyperpolarized vs. Depolarized')
% axis([0.8 2.2 0 0.25])

figure;errorbar(1:2,mean_threshold,std_threshold/sqrt(numel(dates_all)),'or','LineWidth',2);
title('History-Dependent Change in Threshold')
ylabel('Threshold [mV]')
xlabel('Hyperpolarized vs. Depolarized')
% axis([0.8 2.2 0 0.25])