clear;clc;close all

%% Hyperpolarized (5 sec pulse, 1 sec pause)

dates_all_hyper={'Oct_28_14' 'Oct_28_14' 'Oct_28_14' 'Oct_30_14' 'Oct_30_14' 'Nov_26_14'...
    'Dec_03_14' 'Dec_03_14' 'Dec_08_14' 'Dec_12_14' 'Dec_17_14' 'Dec_19_14'...
    'Dec_22_14' 'Dec_22_14' 'Dec_22_14' 'Dec_22_14' 'Dec_22_14' 'Dec_23_14'...
    'Dec_23_14' 'Dec_23_14' 'Jan_07_15' 'Jan_07_15' 'Jan_13_15' 'Jan_13_15'...
    'Jan_13_15' 'Jan_14_15' 'Jan_27_15' 'Jan_27_15' 'Feb_03_15' 'Feb_03_15'...
    'Feb_03_15' 'Feb_10_15' 'Feb_10_15' 'Feb_10_15'};
cellnum_all_hyper={'A' 'B' 'C' 'A' 'B' 'A'...
    'A' 'B' 'A' 'A' 'A' 'A'...
    'A' 'B' 'C' 'D' 'E' 'A'...
    'B' 'C' 'A' 'B' 'A' 'B'...
    'C' 'A' 'A' 'B' 'A' 'B'...
    'C' 'A' 'B' 'C'};
trials_all_hyper=[1 1 1 1 1 1 ...
    1 1 1 1 1 1 ...
    1 1 1 3 1 1 ...
    1 1 1 1 1 1 ...
    1 1 1 1 1 1 ...
    1 1 1 1]';

for k=1:numel(dates_all_hyper)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_curves_' dates_all_hyper{k} '_' cellnum_all_hyper{k} num2str(trials_all_hyper(k)) '_fi.mat;'])
    peakrate_all_hyper(k,:)=peakrate;
    nofailrate_all_hyper(k,:)=nofailrate;
    gains_all_hyper(k,1)=pf_all{1}.beta(2);
%     gains_all_hyper(k,2)=pf_all{2}.beta(2);
    rsq_all_hyper(k,1)=pf_all{1}.rsquare;
%     rsq_all_hyper(k,2)=pf_all{2}.rsquare;
    imp_all_hyper(k,:)=imp;
    holdingvoltage_all_hyper(k,:)=mean_holdingvoltage;
%     hold on;plot([1 2],gains_all_hyper(k,:),'or')
end

gains_all_hyper(isnan(rsq_all_hyper))=NaN; % filter out the gains that are NaNs

mean_peakrate_hyper=nanmean(peakrate_all_hyper);
std_peakrate_hyper=nanstd(peakrate_all_hyper);
mean_nofailrate_hyper=nanmean(nofailrate_all_hyper);
std_nofailrate_hyper=nanstd(nofailrate_all_hyper);
mean_gains_hyper=nanmean(gains_all_hyper);
std_gains_hyper=nanstd(gains_all_hyper);
ste_gains_hyper=std_gains_hyper/sqrt(sum(~isnan(gains_all_hyper)));
mean_imp_hyper=nanmean(imp_all_hyper);
std_imp_hyper=nanstd(imp_all_hyper);
mean_holdingvoltage_all_hyper=nanmean(holdingvoltage_all_hyper);
std_holdingvoltage_all_hyper=nanstd(holdingvoltage_all_hyper);


%% Depolarized (5 sec pulse, 1 sec pause)

dates_all_de={'Oct_28_14' 'Oct_30_14' 'Oct_30_14' 'Nov_26_14' 'Dec_03_14' 'Dec_03_14'...
    'Dec_08_14' 'Dec_19_14' 'Dec_22_14' 'Dec_22_14' 'Dec_22_14' 'Dec_22_14'...
    'Dec_23_14' 'Dec_23_14' 'Dec_23_14' 'Jan_07_15' 'Jan_07_15' 'Jan_13_15'...
    'Jan_13_15' 'Jan_13_15' 'Jan_14_15' 'Jan_27_15' 'Jan_27_15' 'Feb_03_15'...
    'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Feb_10_15' 'Feb_10_15'};
cellnum_all_de={'A' 'A' 'B' 'A' 'A' 'B'...
    'A' 'A' 'A' 'B' 'C' 'D'...
    'A' 'B' 'C' 'A' 'B' 'A'...
    'B' 'C' 'A' 'A' 'B' 'A'...
    'B' 'C' 'A' 'B' 'C'};
trials_all_de=[2 2 2 2 2 2 ...
    2 2 2 2 2 4 ...
    2 2 2 2 2 2 ...
    2 2 2 2 2 2 ...
    2 2 2 2 2]';

for k=1:numel(dates_all_de)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_curves_' dates_all_de{k} '_' cellnum_all_de{k} num2str(trials_all_de(k)) '_fi.mat;'])
    peakrate_all_de(k,:)=peakrate;
    nofailrate_all_de(k,:)=nofailrate;
    gains_all_de(k,1)=pf_all{1}.beta(2);
    rsq_all_de(k,1)=pf_all{1}.rsquare;
    imp_all_de(k,:)=imp;
    holdingvoltage_all_de(k,:)=mean_holdingvoltage;
end

gains_all_de(isnan(rsq_all_de))=NaN; % filter out the gains that are NaNs

mean_peakrate_de=nanmean(peakrate_all_de);
std_peakrate_de=nanstd(peakrate_all_de);
mean_nofailrate_de=nanmean(nofailrate_all_de);
std_nofailrate_de=nanstd(nofailrate_all_de);
mean_gains_de=nanmean(gains_all_de);
std_gains_de=nanstd(gains_all_de);
ste_gains_de=std_gains_de/sqrt(sum(~isnan(gains_all_de)));
mean_imp_de=nanmean(imp_all_de);
std_imp_de=nanstd(imp_all_de);
mean_holdingvoltage_all_de=nanmean(holdingvoltage_all_de);
std_holdingvoltage_all_de=nanstd(holdingvoltage_all_de);


%% Hyperpolarized with Negative Leak

dates_all_hyper_negative_leak={'Oct_24_14' 'Oct_24_14' 'Oct_24_14' 'Oct_24_14' 'Jan_07_15' 'Jan_13_15'...
    'Jan_14_15'};
cellnum_all_hyper_negative_leak={'A' 'A' 'B' 'B' 'B' 'A'...
    'A'};
trials_all_hyper_negative_leak=[5 6 4 5 4 3 ...
    3]';

for k=1:numel(dates_all_hyper_negative_leak)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_curves_' dates_all_hyper_negative_leak{k} '_' cellnum_all_hyper_negative_leak{k} num2str(trials_all_hyper_negative_leak(k)) '_fi.mat;'])
    peakrate_all_hyper_negative_leak(k,:)=peakrate;
    nofailrate_all_hyper_negative_leak(k,:)=nofailrate;
    gains_all_hyper_negative_leak(k,1)=pf_all{1}.beta(2);
    rsq_all_hyper_negative_leak(k,1)=pf_all{1}.rsquare;
    imp_all_hyper_negative_leak(k,:)=imp;
    holdingvoltage_all_hyper_negative_leak(k,:)=mean_holdingvoltage;
end

gains_all_hyper_negative_leak(isnan(rsq_all_hyper_negative_leak))=NaN; % filter out the gains that are NaNs

mean_peakrate_hyper_negative_leak=nanmean(peakrate_all_hyper_negative_leak);
std_peakrate_hyper_negative_leak=nanstd(peakrate_all_hyper_negative_leak);
mean_nofailrate_hyper_negative_leak=nanmean(nofailrate_all_hyper_negative_leak);
std_nofailrate_hyper_negative_leak=nanstd(nofailrate_all_hyper_negative_leak);
mean_gains_hyper_negative_leak=nanmean(gains_all_hyper_negative_leak);
std_gains_hyper_negative_leak=nanstd(gains_all_hyper_negative_leak);
ste_gains_hyper_negative_leak=std_gains_hyper_negative_leak/sqrt(sum(~isnan(gains_all_hyper_negative_leak)));
mean_imp_hyper_negative_leak=nanmean(imp_all_hyper_negative_leak);
std_imp_hyper_negative_leak=nanstd(imp_all_hyper_negative_leak);
mean_holdingvoltage_all_hyper_negative_leak=nanmean(holdingvoltage_all_hyper_negative_leak);
std_holdingvoltage_all_hyper_negative_leak=nanstd(holdingvoltage_all_hyper_negative_leak);


%% Depolarized with Leak

dates_all_de_leak={'Oct_23_14' 'Oct_24_14' 'Oct_24_14' 'Oct_24_14' 'Oct_28_14' 'Oct_30_14'...
    'Oct_30_14' 'Oct_30_14' 'Nov_26_14' 'Jan_07_15' 'Jan_07_15'};
cellnum_all_de_leak={'A' 'A' 'A' 'B' 'A' 'A'...
    'A' 'B' 'A' 'A' 'B'};
trials_all_de_leak=[3 3 4 3 3 3 ...
    4 3 3 3 3]';

for k=1:numel(dates_all_de_leak)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_curves_' dates_all_de_leak{k} '_' cellnum_all_de_leak{k} num2str(trials_all_de_leak(k)) '_fi.mat;'])
    peakrate_all_de_leak(k,:)=peakrate;
    nofailrate_all_de_leak(k,:)=nofailrate;
    gains_all_de_leak(k,1)=pf_all{1}.beta(2);
    rsq_all_de_leak(k,1)=pf_all{1}.rsquare;
    imp_all_de_leak(k,:)=imp;
    holdingvoltage_all_de_leak(k,:)=mean_holdingvoltage;
end

gains_all_de_leak(isnan(rsq_all_de_leak))=NaN; % filter out the gains that are NaNs

mean_peakrate_de_leak=nanmean(peakrate_all_de_leak);
std_peakrate_de_leak=nanstd(peakrate_all_de_leak);
mean_nofailrate_de_leak=nanmean(nofailrate_all_de_leak);
std_nofailrate_de_leak=nanstd(nofailrate_all_de_leak);
mean_gains_de_leak=nanmean(gains_all_de_leak);
std_gains_de_leak=nanstd(gains_all_de_leak);
ste_gains_de_leak=std_gains_de_leak/sqrt(sum(~isnan(gains_all_de_leak)));
mean_imp_de_leak=nanmean(imp_all_de_leak);
std_imp_de_leak=nanstd(imp_all_de_leak);
mean_holdingvoltage_all_de_leak=nanmean(holdingvoltage_all_de_leak);
std_holdingvoltage_all_de_leak=nanstd(holdingvoltage_all_de_leak);


%% Hyperpolarized with Current Subtracted

dates_all_hyper_current_subtracted={'Sep_16_14' 'Sep_16_14' 'Sep_19_14' 'Sep_19_14' 'Sep_23_14' 'Sep_23_14'... % don't use 'Sep_19_14_C' in the average
    'Oct_24_14' 'Oct_24_14' 'Oct_30_14' 'Nov_26_14' 'Nov_26_14' 'Nov_26_14'...
    'Dec_08_14' 'Dec_19_14' 'Dec_19_14' 'Dec_19_14' 'Dec_22_14' 'Dec_22_14'...
    'Dec_22_14' 'Dec_22_14' 'Dec_22_14' 'Dec_22_14' 'Dec_22_14' 'Dec_22_14'...
    'Dec_22_14' 'Dec_22_14' 'Dec_22_14' 'Dec_23_14' 'Dec_23_14' 'Dec_23_14'...
    'Dec_23_14' 'Dec_23_14' 'Dec_23_14'};
cellnum_all_hyper_current_subtracted={'A' 'B' 'A' 'C' 'A' 'B'...
    'B' 'B' 'A' 'A' 'A' 'A'...
    'A' 'A' 'A' 'A' 'B' 'B'...
    'B' 'C' 'C' 'C' 'C' 'C'...
    'D' 'D' 'D' 'A' 'A' 'B'...
    'B' 'C' 'C'};
trials_all_hyper_current_subtracted=[3 3 4 4 5 4 ...
    6 7 5 4 5 6 ...
    3 3 4 5 3 4 ...
    5 3 4 5 6 7 ...
    5 6 7 3 4 3 ...
    4 3 4]';

for k=1:numel(dates_all_hyper_current_subtracted)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_curves_' dates_all_hyper_current_subtracted{k} '_' cellnum_all_hyper_current_subtracted{k} num2str(trials_all_hyper_current_subtracted(k)) '_fi.mat;'])
    peakrate_all_hyper_current_subtracted(k,:)=peakrate;
    nofailrate_all_hyper_current_subtracted(k,:)=nofailrate;
    gains_all_hyper_current_subtracted(k,1)=pf_all{1}.beta(2);
    rsq_all_hyper_current_subtracted(k,1)=pf_all{1}.rsquare;
    imp_all_hyper_current_subtracted(k,:)=imp;
    holdingvoltage_all_hyper_current_subtracted(k,:)=mean_holdingvoltage;
end

gains_all_hyper_current_subtracted(isnan(rsq_all_hyper_current_subtracted))=NaN; % filter out the gains that are NaNs

mean_peakrate_hyper_current_subtracted=nanmean(peakrate_all_hyper_current_subtracted);
std_peakrate_hyper_current_subtracted=nanstd(peakrate_all_hyper_current_subtracted);
mean_nofailrate_hyper_current_subtracted=nanmean(nofailrate_all_hyper_current_subtracted);
std_nofailrate_hyper_current_subtracted=nanstd(nofailrate_all_hyper_current_subtracted);
mean_gains_hyper_current_subtracted=nanmean(gains_all_hyper_current_subtracted);
std_gains_hyper_current_subtracted=nanstd(gains_all_hyper_current_subtracted);
ste_gains_hyper_current_subtracted=std_gains_hyper_current_subtracted/sqrt(sum(~isnan(gains_all_hyper_current_subtracted)));
mean_imp_hyper_current_subtracted=nanmean(imp_all_hyper_current_subtracted);
std_imp_hyper_current_subtracted=nanstd(imp_all_hyper_current_subtracted);
mean_holdingvoltage_all_hyper_current_subtracted=nanmean(holdingvoltage_all_hyper_current_subtracted);
std_holdingvoltage_all_hyper_current_subtracted=nanstd(holdingvoltage_all_hyper_current_subtracted);


%% Hyperpolarized with Noise

dates_all_hyper_noise={'Oct_03_14' 'Oct_03_14' 'Oct_06_14' 'Oct_06_14' 'Oct_06_14' 'Oct_06_14'...
    'Oct_14_14' 'Oct_14_14' 'Oct_14_14' 'Oct_14_14' 'Oct_15_14' 'Oct_23_14'...
    'Oct_23_14' 'Oct_23_14' 'Oct_24_14' 'Oct_24_14' 'Nov_26_14' 'Jan_27_15'...
    'Jan_27_15' 'Jan_27_15' 'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_03_15'...
    'Feb_10_15' 'Feb_10_15'};
cellnum_all_hyper_noise={'B' 'B' 'A' 'A' 'C' 'C'...
    'A' 'A' 'B' 'C' 'A' 'A'...
    'A' 'A' 'A' 'B' 'A' 'A'...
    'A' 'B' 'B' 'A' 'B' 'C'...
    'B' 'C'};
trials_all_hyper_noise=[4 5 3 4 3 4 ...
    2 4 1 1 1 1 ...
    2 3 2 2 2 1 ...
    2 2 1 1 1 1 ...
    1 1]';

for k=1:numel(dates_all_hyper_noise)
    eval(['load FI_OU_' dates_all_hyper_noise{k} '_' cellnum_all_hyper_noise{k} num2str(trials_all_hyper_noise(k)) '_fi.mat;'])
    peakrate_all_hyper_noise(k,:)=peakrate;
    nofailrate_all_hyper_noise(k,:)=nofailrate;
    gains_all_hyper_noise(k,1)=pf_all{1}.beta(2);
    rsq_all_hyper_noise(k,1)=pf_all{1}.rsquare;
%     resistance_all_hyper_noise(k)=mean_r_m;
%     capacitance_all_hyper_noise(k)=mean_c_m;
%     time_constant_all_hyper_noise(k)=mean_time_constant;
    imp_all_hyper_noise(k,:)=imp;
    holdingvoltage_all_hyper_noise(k,:)=mean_holdingvoltage;
end

gains_all_hyper_noise(isnan(rsq_all_hyper_noise))=NaN; % filter out the gains that are NaNs

mean_peakrate_hyper_noise=nanmean(peakrate_all_hyper_noise);
std_peakrate_hyper_noise=nanstd(peakrate_all_hyper_noise);
mean_nofailrate_hyper_noise=nanmean(nofailrate_all_hyper_noise);
std_nofailrate_hyper_noise=nanstd(nofailrate_all_hyper_noise);
mean_gains_hyper_noise=nanmean(gains_all_hyper_noise);
std_gains_hyper_noise=nanstd(gains_all_hyper_noise);
ste_gains_hyper_noise=std_gains_hyper_noise/sqrt(sum(~isnan(gains_all_hyper_noise)));
mean_resistance_hyper_noise=nanmean(resistance_all_hyper_noise);
std_resistance_hyper_noise=nanstd(resistance_all_hyper_noise);
mean_capacitance_hyper_noise=nanmean(capacitance_all_hyper_noise);
std_capacitance_hyper_noise=nanstd(capacitance_all_hyper_noise);
mean_tau_m_hyper_noise=nanmean(time_constant_all_hyper_noise);
std_tau_m_hyper_noise=nanstd(time_constant_all_hyper_noise);
mean_imp_hyper_noise=nanmean(imp_all_hyper_noise);
std_imp_hyper_noise=nanstd(imp_all_hyper_noise);
mean_holdingvoltage_all_hyper_noise=nanmean(holdingvoltage_all_hyper_noise);
std_holdingvoltage_all_hyper_noise=nanstd(holdingvoltage_all_hyper_noise);


%% Depolarized with Just Noise


dates_all_de_noise={'Oct_14_14' 'Oct_14_14' 'Oct_14_14' 'Oct_15_14' 'Oct_23_14' 'Oct_24_14'...
    'Jan_27_15' 'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15'...
    'Feb_10_15'};
cellnum_all_de_noise={'A' 'B' 'C' 'A' 'A' 'B'...
    'A' 'B' 'A' 'B' 'C' 'B'...
    'C'};
trials_all_de_noise=[3 2 2 2 3 3 ...
    4 4 2 2 2 2 ...
    2 ]';

for k=1:numel(dates_all_de_noise)
    eval(['load FI_OU_' dates_all_de_noise{k} '_' cellnum_all_de_noise{k} num2str(trials_all_de_noise(k)) '_fi.mat;'])
    peakrate_all_de_noise(k,:)=peakrate;
    nofailrate_all_de_noise(k,:)=nofailrate;
    gains_all_de_noise(k,1)=pf_all{1}.beta(2);
    rsq_all_de_noise(k,1)=pf_all{1}.rsquare;
    imp_all_de_noise(k,:)=imp;
    holdingvoltage_all_de_noise(k,:)=mean_holdingvoltage;
end

gains_all_de_noise(isnan(rsq_all_de_noise))=NaN; % filter out the gains that are NaNs

mean_peakrate_de_noise=nanmean(peakrate_all_de_noise);
std_peakrate_de_noise=nanstd(peakrate_all_de_noise);
mean_nofailrate_de_noise=nanmean(nofailrate_all_de_noise);
std_nofailrate_de_noise=nanstd(nofailrate_all_de_noise);
mean_gains_de_noise=nanmean(gains_all_de_noise);
std_gains_de_noise=nanstd(gains_all_de_noise);
ste_gains_de_noise=std_gains_de_noise/sqrt(sum(~isnan(gains_all_de_noise)));
mean_resistance_de_noise=nanmean(resistance_all_de_noise);
std_resistance_de_noise=nanstd(resistance_all_de_noise);
mean_capacitance_de_noise=nanmean(capacitance_all_de_noise);
std_capacitance_de_noise=nanstd(capacitance_all_de_noise);
mean_tau_m_de_noise=nanmean(time_constant_all_de_noise);
std_tau_m_de_noise=nanstd(time_constant_all_de_noise);
mean_imp_de_noise=nanmean(imp_all_de_noise);
std_imp_de_noise=nanstd(imp_all_de_noise);
mean_holdingvoltage_all_de_noise=nanmean(holdingvoltage_all_de_noise);
std_holdingvoltage_all_de_noise=nanstd(holdingvoltage_all_de_noise);


%% Depolarized with Leak and Noise

dates_all_de_leak_noise={'Oct_24_14' 'Oct_24_14' 'Oct_28_14' 'Oct_30_14' 'Nov_26_14' 'Jan_07_15'...
    'Jan_07_15'};
cellnum_all_de_leak_noise={'A' 'B' 'A' 'A' 'A' 'A'...
    'B'};
trials_all_de_leak_noise=[1 1 1 1 1 1 ...
    1]';

for k=1:numel(dates_all_de_leak_noise)
    eval(['load FI_OU_' dates_all_de_leak_noise{k} '_' cellnum_all_de_leak_noise{k} num2str(trials_all_de_leak_noise(k)) '_fi.mat;'])
    peakrate_all_de_leak_noise(k,:)=peakrate;
    nofailrate_all_de_leak_noise(k,:)=nofailrate;
    gains_all_de_leak_noise(k,1)=pf_all{1}.beta(2);
    rsq_all_de_leak_noise(k,1)=pf_all{1}.rsquare;
    imp_all_de_leak_noise(k,:)=imp;
    holdingvoltage_all_de_leak_noise(k,:)=mean_holdingvoltage;
end

gains_all_de_leak_noise(isnan(rsq_all_de_leak_noise))=NaN; % filter out the gains that are NaNs

mean_peakrate_de_leak_noise=nanmean(peakrate_all_de_leak_noise);
std_peakrate_de_leak_noise=nanstd(peakrate_all_de_leak_noise);
mean_nofailrate_de_leak_noise=nanmean(nofailrate_all_de_leak_noise);
std_nofailrate_de_leak_noise=nanstd(nofailrate_all_de_leak_noise);
mean_gains_de_leak_noise=nanmean(gains_all_de_leak_noise);
std_gains_de_leak_noise=nanstd(gains_all_de_leak_noise);
ste_gains_de_leak_noise=std_gains_de_leak_noise/sqrt(sum(~isnan(gains_all_de_leak_noise)));
mean_resistance_de_leak_noise=nanmean(resistance_all_de_leak_noise);
std_resistance_de_leak_noise=nanstd(resistance_all_de_leak_noise);
mean_capacitance_de_leak_noise=nanmean(capacitance_all_de_leak_noise);
std_capacitance_de_leak_noise=nanstd(capacitance_all_de_leak_noise);
mean_tau_m_de_leak_noise=nanmean(time_constant_all_de_leak_noise);
std_tau_m_de_leak_noise=nanstd(time_constant_all_de_leak_noise);
mean_imp_de_leak_noise=nanmean(imp_all_de_leak_noise);
std_imp_de_leak_noise=nanstd(imp_all_de_leak_noise);
mean_holdingvoltage_all_de_leak_noise=nanmean(holdingvoltage_all_de_leak_noise);
std_holdingvoltage_all_de_leak_noise=nanstd(holdingvoltage_all_de_leak_noise);

%% Statistics

[gainsttest_hyper_de(1),gainsttest_hyper_de(2)]=ttest2(gains_all_hyper,gains_all_de);
[gainsttest_hyper_hyper_noise(1),gainsttest_hyper_hyper_noise(2)]=ttest2(gains_all_hyper,gains_all_hyper_noise);
[gainsttest_hyper_hyper_negative_leak(1),gainsttest_hyper_hyper_negative_leak(2)]=ttest2(gains_all_hyper,gains_all_hyper_negative_leak);
[gainsttest_hyper_hyper_current_subtracted(1),gainsttest_hyper_hyper_current_subtracted(2)]=ttest2(gains_all_hyper,gains_all_hyper_current_subtracted);
[gainsttest_de_de_leak(1),gainsttest_de_de_leak(2)]=ttest2(gains_all_de,gains_all_de_leak);
[gainsttest_de_de_noise(1),gainsttest_de_de_noise(2)]=ttest2(gains_all_de,gains_all_de_noise);
[gainsttest_de_de_leak_noise(1),gainsttest_de_de_leak_noise(2)]=ttest2(gains_all_de,gains_all_de_leak_noise);


%% Plotting

all_mean_gains=[mean_gains_hyper mean_gains_hyper_noise mean_gains_hyper_negative_leak mean_gains_hyper_current_subtracted mean_gains_de mean_gains_de_leak mean_gains_de_noise mean_gains_de_leak_noise];
all_ste_gains=[ste_gains_hyper ste_gains_hyper_noise ste_gains_hyper_negative_leak ste_gains_hyper_current_subtracted ste_gains_de ste_gains_de_leak ste_gains_de_noise ste_gains_de_leak_noise];

figure;errorbar(1:8,all_mean_gains,all_ste_gains,'.m','LineWidth',2);
hold on;bar(1:8,all_mean_gains,.5,'m')
title('History-Dependent Change in Gains')
ylabel('Gains [Hz/pA]')
xlabel('Hyperpolarized    Hyperpolarized with Noise    Hyperpolarized with Negative Leak    Hyperpolarized with Current Subtracted    Depolarized    Depolarized with Leak    Depolarized with Noise    Depolarized with Leak and Noise')
% axis([0.4 2.6 0 0.2])