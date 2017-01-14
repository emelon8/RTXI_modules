clear;clc;%close all

dates_all={'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13' 'May_31_13' 'May_31_13'...
    'Jun_24_13' 'Jul_03_13' 'Jul_03_13' 'Jul_29_13' 'Aug_05_13' 'Aug_16_13'...
    'Sep_05_13' 'Sep_16_13' 'Oct_08_13'}; % Used synaptic blockers: 'Sep_10_13'
cellnum_all={'B' 'A' 'A' 'B'...
    'C' 'D' 'B' 'A' 'B'...
    'B' 'A' 'A' 'A' 'A'...
    'A'}; % Used synaptic blockers: 'A'

for k=1:numel(dates_all)
    eval(['load ' pwd '\fi_analysis\fi_curves_' dates_all{k} '_' cellnum_all{k} '_fi.mat;'])
    peakrate_all(k,:)=peakrate;
    nofailrate_all(k,:)=nofailrate;
    gains_all(k,1)=pf_all{1}.beta(2);
    gains_all(k,2)=pf_all{2}.beta(2);
    rsq_all(k,1)=pf_all{1}.rsquare;
    rsq_all(k,2)=pf_all{2}.rsquare;
    resistance_all(k)=mean_r_m;
    capacitance_all(k)=mean_c_m;
    time_constant_all(k)=mean_time_constant;
    imp_all(k,:)=imp;
    holdingvoltage_all(k,:)=mean_holdingvoltage;
    rate_hyperpolarized_all(k,:)=rate_all{1};
    rate_depolarized_all(k,:)=rate_all{2};
    rate_differences_all(k,:)=rate_all{2}-rate_all{1};
%     hold on;plot([1 2],gains_all(k,:),'or')
end

currents=-50:5:200;

mean_rate_differences=nanmean(rate_differences_all);
std_rate_differences=nanstd(rate_differences_all);
ste_rate_differences=std_rate_differences./sqrt(sum(isfinite(rate_differences_all)));

figure;errorbar(currents,mean_rate_differences,ste_rate_differences)

mean_rate_hyperpolarized=nanmean(rate_hyperpolarized_all);
std_rate_hyperpolarized=nanstd(rate_hyperpolarized_all);
ste_rate_hyperpolarized=std_rate_hyperpolarized./sqrt(sum(~isnan(rate_hyperpolarized_all)));

mean_rate_depolarized=nanmean(rate_depolarized_all);
std_rate_depolarized=nanstd(rate_depolarized_all);
ste_rate_depolarized=std_rate_depolarized./sqrt(sum(~isnan(rate_depolarized_all)));

nlf_fi_hyper=nlinfit(currents,mean_rate_hyperpolarized,'sigFun',[320,50,10]);
nlf_fi_de=nlinfit(currents,mean_rate_depolarized,'sigFun',[320,50,10]);

hyper_max=nlf_fi_hyper(1);
hyper_midpoint=nlf_fi_hyper(2);
hyper_slope=nlf_fi_hyper(1)/(4*nlf_fi_hyper(3));
de_max=nlf_fi_de(1);
de_midpoint=nlf_fi_de(2);
de_slope=nlf_fi_de(1)/(4*nlf_fi_de(3));

figure;errorbar([currents;currents]',[mean_rate_hyperpolarized;mean_rate_depolarized]',[ste_rate_hyperpolarized;ste_rate_depolarized]')
legend('Hyperpolarized','Depolarized')
hold on;plot(currents,sigFun(nlf_fi_hyper,currents),'m');plot(currents,sigFun(nlf_fi_de,currents),'r')
title('Average f-I Curves for Hyperpolarized and Depolarized (1 sec pulse, 1 sec pause)')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

mean_peakrate=nanmean(peakrate_all);
std_peakrate=nanstd(peakrate_all);
mean_nofailrate=nanmean(nofailrate_all);
std_nofailrate=nanstd(nofailrate_all);
mean_gains=mean(gains_all);
std_gains=std(gains_all);
mean_resistance=mean(resistance_all);
std_resistance=std(resistance_all);
mean_capacitance=mean(capacitance_all);
std_capacitance=std(capacitance_all);
mean_tau_m=mean(time_constant_all);
std_tau_m=std(time_constant_all);
mean_imp=mean(imp_all);
std_imp=std(imp_all);
mean_holdingvoltage_all=mean(holdingvoltage_all);
std_holdingvoltage_all=std(holdingvoltage_all);

[gainsttest(1),gainsttest(2)]=ttest(gains_all(:,1),gains_all(:,2));

figure;hold on;errorbar(1:2,mean_gains,std_gains/sqrt(numel(dates_all)),'.m','LineWidth',6);
hold on;bar(1:2,mean_gains,.5,'m')
title('History-Dependent Change in Gains')
ylabel('Gains [Hz/pA]')
xlabel('Hyperpolarized vs. Depolarized')
axis([0.4 2.6 0 0.12])

figure;errorbar(1,mean_resistance,std_resistance/sqrt(numel(dates_all)),'or','LineWidth',2);
title('Cellular Resistance, Capacitance, Membrane Time Constants, Hyperpolarized Holding Voltage, and Depolarized Holding Voltage')
ylabel('Gigaohms, nanofarads, or seconds')

hold on;errorbar(2,mean_capacitance,std_capacitance/sqrt(numel(dates_all)),'or','LineWidth',2);
hold on;errorbar(3,mean_tau_m,std_tau_m/sqrt(numel(dates_all)),'or','LineWidth',2);
hold on;errorbar(4,mean_holdingvoltage_all(1),std_holdingvoltage_all(1)/sqrt(numel(dates_all)),'or','LineWidth',2)
hold on;errorbar(5,mean_holdingvoltage_all(2),std_holdingvoltage_all(2)/sqrt(numel(dates_all)),'or','LineWidth',2)
hold on;errorbar(4,mean_imp(1),std_imp(1)/sqrt(numel(dates_all)),'og','LineWidth',2)
hold on;errorbar(5,mean_imp(2),std_imp(2)/sqrt(numel(dates_all)),'og','LineWidth',2)