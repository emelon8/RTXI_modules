clear;clc;%close all

% dates_all={'Oct_03_14' 'Oct_03_14' 'Oct_06_14' 'Oct_06_14' 'Oct_06_14' 'Oct_06_14'...
%     'Oct_14_14' 'Oct_14_14' 'Oct_14_14' 'Oct_14_14' 'Oct_15_14' 'Oct_23_14'...
%     'Oct_23_14' 'Oct_23_14' 'Oct_24_14' 'Oct_24_14' 'Nov_26_14' 'Jan_27_15'...
%     'Jan_27_15' 'Jan_27_15' 'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_03_15'...
%     'Feb_10_15' 'Feb_10_15'};%... % End of hyperpolarized with noise
% dates_all={'Oct_14_14' 'Oct_14_14' 'Oct_14_14' 'Oct_15_14' 'Oct_23_14' 'Oct_24_14'...
%     'Jan_27_15' 'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15'...
%     'Feb_10_15'};... % End of depolarized with just noise
dates_all={'Oct_24_14' 'Oct_24_14' 'Oct_28_14' 'Oct_30_14' 'Nov_26_14' 'Jan_07_15'...
    'Jan_07_15'}; % End of depolarized with leak and noise

% cellnum_all={'B' 'B' 'A' 'A' 'C' 'C'...
%     'A' 'A' 'B' 'C' 'A' 'A'...
%     'A' 'A' 'A' 'B' 'A' 'A'...
%     'A' 'B' 'B' 'A' 'B' 'C'...
%     'B' 'C'};%... % End of hyperpolarized with noise
% cellnum_all={'A' 'B' 'C' 'A' 'A' 'B'...
%     'A' 'B' 'A' 'B' 'C' 'B'...
%     'C'};... % End of depolarized with just noise
cellnum_all={'A' 'B' 'A' 'A' 'A' 'A'...
    'B'}; % End of depolarized with leak and noise

% noise_trials_all=[4 5 3 4 3 4 ...
%     2 4 1 1 1 1 ...
%     2 3 2 2 2 1 ...
%     2 2 1 1 1 1 ...
%     1 1]';... % End of hyperpolarized with noise
% noise_trials_all=[3 2 2 2 3 3 ...
%     4 4 2 2 2 2 ...
%     2 ]';... % End of depolarized with just noise
noise_trials_all=[1 1 1 1 1 1 ...
    1]'; % End of depolarized with leak and noise

for k=1:numel(dates_all)
    eval(['load ' pwd '\fi_analysis\FI_OU_' dates_all{k} '_' cellnum_all{k} num2str(noise_trials_all(k)) '_fi.mat;'])
    peakrate_all(k,:)=peakrate;
    nofailrate_all(k,:)=nofailrate;
    gains_all(k,1)=pf_all{1}.beta(2);
%     gains_all(k,2)=pf_all{2}.beta(2);
    rsq_all(k,1)=pf_all{1}.rsquare;
%     rsq_all(k,2)=pf_all{2}.rsquare;
    resistance_all(k)=mean_r_m;
    capacitance_all(k)=mean_c_m;
    time_constant_all(k)=mean_time_constant;
    imp_all(k,:)=imp;
    holdingvoltage_all(k,:)=mean_holdingvoltage;
%     hold on;plot([1 2],gains_all(k,:),'or')
end

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

% [gainsttest(1),gainsttest(2)]=ttest(gains_all(:,1),gains_all(:,2));

figure;hold on;errorbar(1,mean_gains,std_gains/sqrt(numel(dates_all)),'.m','LineWidth',2);
hold on;bar(1,mean_gains,.5,'m')
title('History-Dependent Change in Gains')
ylabel('Gains [Hz/pA]')
xlabel('Hyperpolarized vs. Depolarized')
axis([0.4 2.6 0 0.4])

figure;errorbar(1,mean_resistance,std_resistance/sqrt(numel(dates_all)),'or','LineWidth',2);
title('Cellular Resistance, Capacitance, Membrane Time Constants, Hyperpolarized Holding Voltage, and Depolarized Holding Voltage')
ylabel('Gigaohms, nanofarads, or seconds')

hold on;errorbar(2,mean_capacitance,std_capacitance/sqrt(numel(dates_all)),'or','LineWidth',2);
hold on;errorbar(3,mean_tau_m,std_tau_m/sqrt(numel(dates_all)),'or','LineWidth',2);
hold on;errorbar(4,mean_holdingvoltage_all(1),std_holdingvoltage_all(1)/sqrt(numel(dates_all)),'or','LineWidth',2)
% hold on;errorbar(5,mean_holdingvoltage_all(2),std_holdingvoltage_all(2)/sqrt(numel(dates_all)),'or','LineWidth',2)
hold on;errorbar(4,mean_imp(1),std_imp(1)/sqrt(numel(dates_all)),'og','LineWidth',2)
% hold on;errorbar(5,mean_imp(2),std_imp(2)/sqrt(numel(dates_all)),'og','LineWidth',2)