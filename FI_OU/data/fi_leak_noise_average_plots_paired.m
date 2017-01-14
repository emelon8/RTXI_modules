clear;clc;close all

%% Hyperpolarized (5 sec pulse, 1 sec pause)
% For Depolarized

% % These are the 1 sec pulse, 1 sec pauses
% dates_all_hypervde={'Oct_03_14' 'Oct_03_14' 'Oct_06_14' 'Oct_06_14' 'Oct_06_14' 'Oct_14_14'...
%     'Oct_14_14'};
% cellnum_all_hypervde={'A' 'B' 'A' 'B' 'C' 'A'...
%     'B'};
% trials_all_hypervde=[1 1 1 1 1 1 ...
%     1]';

% % Before I threw out all the bad-quality data
% dates_all_hypervde={'Oct_28_14' 'Oct_30_14' 'Oct_30_14' 'Nov_26_14' 'Dec_03_14' 'Dec_03_14'...
%     'Dec_08_14' 'Dec_19_14' 'Dec_22_14' 'Dec_22_14' 'Dec_22_14' 'Dec_22_14'...
%     'Dec_23_14' 'Dec_23_14' 'Dec_23_14' 'Jan_07_15' 'Jan_07_15' 'Jan_13_15'...
%     'Jan_13_15' 'Jan_13_15' 'Jan_14_15' 'Jan_27_15' 'Jan_27_15' 'Feb_03_15'...
%     'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Feb_10_15' 'Feb_10_15' 'Mar_03_15'...
%     'Mar_06_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15'};
% cellnum_all_hypervde={'A' 'A' 'B' 'A' 'A' 'B'...
%     'A' 'A' 'A' 'B' 'C' 'D'...
%     'A' 'B' 'C' 'A' 'B' 'A'...
%     'B' 'C' 'A' 'A' 'B' 'A'...
%     'B' 'C' 'A' 'B' 'C' 'A'...
%     'A' 'A' 'B' 'C' 'D' 'B'};
% trials_all_hypervde=[1 1 1 1 1 1 ...
%     1 1 1 1 1 3 ...
%     1 1 1 1 1 1 ...
%     1 1 1 1 1 1 ...
%     1 1 1 1 1 1 ...
%     1 3 1 1 1 1]';

% Good quality data only
dates_all_hypervde={'Dec_22_14' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Feb_10_15' 'Mar_03_15'...
    'Mar_06_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15'...
    'Mar_16_15' 'Mar_16_15' 'Mar_16_15' 'Mar_17_15' 'Mar_17_15' 'Mar_18_15'...
    'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15'...
    'Apr_03_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15' 'Apr_08_15'...
    'Apr_08_15' 'Apr_08_15' 'Apr_29_15' 'May_01_15' 'May_05_15'};
cellnum_all_hypervde={'C' 'A' 'B' 'B' 'C' 'A'...
    'A' 'A' 'C' 'D' 'B' 'A'...
    'B' 'C' 'D' 'A' 'B' 'A'...
    'B' 'B' 'C' 'D' 'E' 'B'...
    'B' 'B' 'A' 'C' 'D' 'C'...
    'D' 'E' 'E' 'C' 'D'};
trials_all_hypervde=[1 1 1 1 1 1 ...
    1 3 1 1 3 3 ...
    7 1 3 1 1 5 ...
    3 1 1 1 1 3 ...
    6 5 5 5 3 3 ...
    6 4 1 1 1]';

for k=1:numel(dates_all_hypervde)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_hypervde{k} '_' cellnum_all_hypervde{k} num2str(trials_all_hypervde(k)) '_fi.mat;'])
    peakrate_all_hypervde(k,:)=peakrate;
    nofailrate_all_hypervde(k,:)=nofailrate;
    gains_all_hypervde(k,1)=pf_all{1}.beta(2);
%     gains_all_hypervde(k,2)=pf_all{2}.beta(2);
    rsq_all_hypervde(k,1)=pf_all{1}.rsquare;
%     rsq_all_hypervde(k,2)=pf_all{2}.rsquare;
    rate_all_hypervde(k,:)=rate_all{1};
    imp_all_hypervde(k,:)=imp;
    holdingvoltage_all_hypervde(k,:)=mean_holdingvoltage;
%     hold on;plot([1 2],gains_all_hypervde(k,:),'or')
    mean_spikeform_all_hypervde(k,:)=mean_spikeform;
    mean_freq0_outputforms_increment_all_hypervde(k,:)=mean_freq0_outputforms_increment;
    mean_freq0_spikeforms_increment_all_hypervde(k,:)=mean_freq0_spikeforms_increment;
    mean_freq1_outputforms_increment_all_hypervde(k,:)=mean_freq1_outputforms_increment;
    mean_freq1_spikeforms_increment_all_hypervde(k,:)=mean_freq1_spikeforms_increment;
    mean_freq2_outputforms_increment_all_hypervde(k,:)=mean_freq2_outputforms_increment;
    mean_freq2_spikeforms_increment_all_hypervde(k,:)=mean_freq2_spikeforms_increment;
    mean_freq3_outputforms_increment_all_hypervde(k,:)=mean_freq3_outputforms_increment;
    mean_freq3_spikeforms_increment_all_hypervde(k,:)=mean_freq3_spikeforms_increment;
    mean_freq4_outputforms_increment_all_hypervde(k,:)=mean_freq4_outputforms_increment;
    mean_freq4_spikeforms_increment_all_hypervde(k,:)=mean_freq4_spikeforms_increment;
    mean_freq5_outputforms_increment_all_hypervde(k,:)=mean_freq5_outputforms_increment;
    mean_freq5_spikeforms_increment_all_hypervde(k,:)=mean_freq5_spikeforms_increment;
    mean_freq6_outputforms_increment_all_hypervde(k,:)=mean_freq6_outputforms_increment;
    mean_freq6_spikeforms_increment_all_hypervde(k,:)=mean_freq6_spikeforms_increment;
    mean_freq7_outputforms_increment_all_hypervde(k,:)=mean_freq7_outputforms_increment;
    mean_freq7_spikeforms_increment_all_hypervde(k,:)=mean_freq7_spikeforms_increment;
    mean_freq8_outputforms_increment_all_hypervde(k,:)=mean_freq8_outputforms_increment;
    mean_freq8_spikeforms_increment_all_hypervde(k,:)=mean_freq8_spikeforms_increment;
    mean_freq9_outputforms_increment_all_hypervde(k,:)=mean_freq9_outputforms_increment;
    mean_freq9_spikeforms_increment_all_hypervde(k,:)=mean_freq9_spikeforms_increment;
    mean_freq10_outputforms_increment_all_hypervde(k,:)=mean_freq10_outputforms_increment;
    mean_freq10_spikeforms_increment_all_hypervde(k,:)=mean_freq10_spikeforms_increment;
    mean_lastspikeforms_increment_all_hypervde(k,:)=mean_lastspikeforms_increment;
    mean_lastoutputforms_increment_all_hypervde(k,:)=mean_lastoutputforms_increment;
    ISIratio_hypervde(k,:)=ISIratio{1};
    ISIs_all_hypervde=ISIs_all{1};
    firstISI_all_hypervde(k,:)=firstISI{1};
    lastISI_all_hypervde(k,:)=lastISI{1};
end

mean_freq0_outputforms_hypervde=nanmean(mean_freq0_outputforms_increment_all_hypervde);
mean_freq0_spikeforms_hypervde=nanmean(mean_freq0_spikeforms_increment_all_hypervde);
std_freq0_outputforms_hypervde=nanstd(mean_freq0_outputforms_increment_all_hypervde);
std_freq0_spikeforms_hypervde=nanstd(mean_freq0_spikeforms_increment_all_hypervde);
ste_freq0_outputforms_hypervde=std_freq0_outputforms_hypervde/sqrt(sum(~isnan(mean_freq0_outputforms_increment_all_hypervde)));
ste_freq0_spikeforms_hypervde=std_freq0_spikeforms_hypervde/sqrt(sum(~isnan(mean_freq0_spikeforms_increment_all_hypervde)));
mean_freq1_outputforms_hypervde=nanmean(mean_freq1_outputforms_increment_all_hypervde);
mean_freq1_spikeforms_hypervde=nanmean(mean_freq1_spikeforms_increment_all_hypervde);
std_freq1_outputforms_hypervde=nanstd(mean_freq1_outputforms_increment_all_hypervde);
std_freq1_spikeforms_hypervde=nanstd(mean_freq1_spikeforms_increment_all_hypervde);
ste_freq1_outputforms_hypervde=std_freq1_outputforms_hypervde/sqrt(sum(~isnan(mean_freq1_outputforms_increment_all_hypervde)));
ste_freq1_spikeforms_hypervde=std_freq1_spikeforms_hypervde/sqrt(sum(~isnan(mean_freq1_spikeforms_increment_all_hypervde)));
mean_freq2_outputforms_hypervde=nanmean(mean_freq2_outputforms_increment_all_hypervde);
mean_freq2_spikeforms_hypervde=nanmean(mean_freq2_spikeforms_increment_all_hypervde);
std_freq2_outputforms_hypervde=nanstd(mean_freq2_outputforms_increment_all_hypervde);
std_freq2_spikeforms_hypervde=nanstd(mean_freq2_spikeforms_increment_all_hypervde);
ste_freq2_outputforms_hypervde=std_freq2_outputforms_hypervde/sqrt(sum(~isnan(mean_freq2_outputforms_increment_all_hypervde)));
ste_freq2_spikeforms_hypervde=std_freq2_spikeforms_hypervde/sqrt(sum(~isnan(mean_freq2_spikeforms_increment_all_hypervde)));
mean_freq3_outputforms_hypervde=nanmean(mean_freq3_outputforms_increment_all_hypervde);
mean_freq3_spikeforms_hypervde=nanmean(mean_freq3_spikeforms_increment_all_hypervde);
std_freq3_outputforms_hypervde=nanstd(mean_freq3_outputforms_increment_all_hypervde);
std_freq3_spikeforms_hypervde=nanstd(mean_freq3_spikeforms_increment_all_hypervde);
ste_freq3_outputforms_hypervde=std_freq3_outputforms_hypervde/sqrt(sum(~isnan(mean_freq3_outputforms_increment_all_hypervde)));
ste_freq3_spikeforms_hypervde=std_freq3_spikeforms_hypervde/sqrt(sum(~isnan(mean_freq3_spikeforms_increment_all_hypervde)));
mean_freq4_outputforms_hypervde=nanmean(mean_freq4_outputforms_increment_all_hypervde);
mean_freq4_spikeforms_hypervde=nanmean(mean_freq4_spikeforms_increment_all_hypervde);
std_freq4_outputforms_hypervde=nanstd(mean_freq4_outputforms_increment_all_hypervde);
std_freq4_spikeforms_hypervde=nanstd(mean_freq4_spikeforms_increment_all_hypervde);
ste_freq4_outputforms_hypervde=std_freq4_outputforms_hypervde/sqrt(sum(~isnan(mean_freq4_outputforms_increment_all_hypervde)));
ste_freq4_spikeforms_hypervde=std_freq4_spikeforms_hypervde/sqrt(sum(~isnan(mean_freq4_spikeforms_increment_all_hypervde)));
mean_freq5_outputforms_hypervde=nanmean(mean_freq5_outputforms_increment_all_hypervde);
mean_freq5_spikeforms_hypervde=nanmean(mean_freq5_spikeforms_increment_all_hypervde);
std_freq5_outputforms_hypervde=nanstd(mean_freq5_outputforms_increment_all_hypervde);
std_freq5_spikeforms_hypervde=nanstd(mean_freq5_spikeforms_increment_all_hypervde);
ste_freq5_outputforms_hypervde=std_freq5_outputforms_hypervde/sqrt(sum(~isnan(mean_freq5_outputforms_increment_all_hypervde)));
ste_freq5_spikeforms_hypervde=std_freq5_spikeforms_hypervde/sqrt(sum(~isnan(mean_freq5_spikeforms_increment_all_hypervde)));
mean_freq6_outputforms_hypervde=nanmean(mean_freq6_outputforms_increment_all_hypervde);
mean_freq6_spikeforms_hypervde=nanmean(mean_freq6_spikeforms_increment_all_hypervde);
std_freq6_outputforms_hypervde=nanstd(mean_freq6_outputforms_increment_all_hypervde);
std_freq6_spikeforms_hypervde=nanstd(mean_freq6_spikeforms_increment_all_hypervde);
ste_freq6_outputforms_hypervde=std_freq6_outputforms_hypervde/sqrt(sum(~isnan(mean_freq6_outputforms_increment_all_hypervde)));
ste_freq6_spikeforms_hypervde=std_freq6_spikeforms_hypervde/sqrt(sum(~isnan(mean_freq6_spikeforms_increment_all_hypervde)));
mean_freq7_outputforms_hypervde=nanmean(mean_freq7_outputforms_increment_all_hypervde);
mean_freq7_spikeforms_hypervde=nanmean(mean_freq7_spikeforms_increment_all_hypervde);
std_freq7_outputforms_hypervde=nanstd(mean_freq7_outputforms_increment_all_hypervde);
std_freq7_spikeforms_hypervde=nanstd(mean_freq7_spikeforms_increment_all_hypervde);
ste_freq7_outputforms_hypervde=std_freq7_outputforms_hypervde/sqrt(sum(~isnan(mean_freq7_outputforms_increment_all_hypervde)));
ste_freq7_spikeforms_hypervde=std_freq7_spikeforms_hypervde/sqrt(sum(~isnan(mean_freq7_spikeforms_increment_all_hypervde)));
mean_freq8_outputforms_hypervde=nanmean(mean_freq8_outputforms_increment_all_hypervde);
mean_freq8_spikeforms_hypervde=nanmean(mean_freq8_spikeforms_increment_all_hypervde);
std_freq8_outputforms_hypervde=nanstd(mean_freq8_outputforms_increment_all_hypervde);
std_freq8_spikeforms_hypervde=nanstd(mean_freq8_spikeforms_increment_all_hypervde);
ste_freq8_outputforms_hypervde=std_freq8_outputforms_hypervde/sqrt(sum(~isnan(mean_freq8_outputforms_increment_all_hypervde)));
ste_freq8_spikeforms_hypervde=std_freq8_spikeforms_hypervde/sqrt(sum(~isnan(mean_freq8_spikeforms_increment_all_hypervde)));
mean_freq9_outputforms_hypervde=nanmean(mean_freq9_outputforms_increment_all_hypervde);
mean_freq9_spikeforms_hypervde=nanmean(mean_freq9_spikeforms_increment_all_hypervde);
std_freq9_outputforms_hypervde=nanstd(mean_freq9_outputforms_increment_all_hypervde);
std_freq9_spikeforms_hypervde=nanstd(mean_freq9_spikeforms_increment_all_hypervde);
ste_freq9_outputforms_hypervde=std_freq9_outputforms_hypervde/sqrt(sum(~isnan(mean_freq9_outputforms_increment_all_hypervde)));
ste_freq9_spikeforms_hypervde=std_freq9_spikeforms_hypervde/sqrt(sum(~isnan(mean_freq9_spikeforms_increment_all_hypervde)));
mean_freq10_outputforms_hypervde=nanmean(mean_freq10_outputforms_increment_all_hypervde);
mean_freq10_spikeforms_hypervde=nanmean(mean_freq10_spikeforms_increment_all_hypervde);
std_freq10_outputforms_hypervde=nanstd(mean_freq10_outputforms_increment_all_hypervde);
std_freq10_spikeforms_hypervde=nanstd(mean_freq10_spikeforms_increment_all_hypervde);
ste_freq10_outputforms_hypervde=std_freq10_outputforms_hypervde/sqrt(sum(~isnan(mean_freq10_outputforms_increment_all_hypervde)));
ste_freq10_spikeforms_hypervde=std_freq10_spikeforms_hypervde/sqrt(sum(~isnan(mean_freq10_spikeforms_increment_all_hypervde)));

mean_lastspikeforms_hypervde=nanmean(mean_lastspikeforms_increment_all_hypervde);
std_lastspikeforms_hypervde=nanstd(mean_lastspikeforms_increment_all_hypervde);
ste_lastspikeforms_hypervde=std_lastspikeforms_hypervde/sqrt(sum(~isnan(mean_lastspikeforms_increment_all_hypervde)));
mean_lastoutputforms_hypervde=nanmean(mean_lastoutputforms_increment_all_hypervde);
std_lastoutputforms_hypervde=nanstd(mean_lastoutputforms_increment_all_hypervde);
ste_lastoutputforms_hypervde=std_lastoutputforms_hypervde/sqrt(sum(~isnan(mean_lastoutputforms_increment_all_hypervde)));

gains_all_hypervde(isnan(rsq_all_hypervde))=NaN; % filter out the gains that are NaNs

mean_peakrate_hypervde=nanmean(peakrate_all_hypervde);
std_peakrate_hypervde=nanstd(peakrate_all_hypervde);
mean_nofailrate_hypervde=nanmean(nofailrate_all_hypervde);
std_nofailrate_hypervde=nanstd(nofailrate_all_hypervde);
mean_gains_hypervde=nanmean(gains_all_hypervde);
std_gains_hypervde=nanstd(gains_all_hypervde);
ste_gains_hypervde=std_gains_hypervde/sqrt(sum(~isnan(gains_all_hypervde)));
mean_imp_hypervde=nanmean(imp_all_hypervde);
std_imp_hypervde=nanstd(imp_all_hypervde);
mean_holdingvoltage_all_hypervde=nanmean(holdingvoltage_all_hypervde);
std_holdingvoltage_all_hypervde=nanstd(holdingvoltage_all_hypervde);
mean_rate_hypervde=nanmean(rate_all_hypervde);
std_rate_hypervde=nanstd(rate_all_hypervde);
ste_rate_hypervde=std_rate_hypervde./sqrt(sum(~isnan(rate_all_hypervde)));

mean_spikeform_hypervde=nanmean(mean_spikeform_all_hypervde);
std_spikeform_hypervde=nanstd(mean_spikeform_all_hypervde);
ste_spikeform_hypervde=std_spikeform_hypervde./sqrt(sum(~isnan(mean_spikeform_all_hypervde)));


% Depolarized (5 sec pulse, 1 sec pause)
% For Hyperpolarized

% % These are the 1 sec pulse, 1 sec pauses
% dates_all_devhyper={'Oct_03_14' 'Oct_03_14' 'Oct_06_14' 'Oct_06_14' 'Oct_06_14' 'Oct_14_14'...
%     'Oct_14_14'};
% cellnum_all_devhyper={'A' 'B' 'A' 'B' 'C' 'A'...
%     'B'};
% trials_all_devhyper=[2 2 2 2 2 2 ...
%     2]';

% % Before I threw out all the bad-quality data
% dates_all_devhyper={'Oct_28_14' 'Oct_30_14' 'Oct_30_14' 'Nov_26_14' 'Dec_03_14' 'Dec_03_14'...
%     'Dec_08_14' 'Dec_19_14' 'Dec_22_14' 'Dec_22_14' 'Dec_22_14' 'Dec_22_14'...
%     'Dec_23_14' 'Dec_23_14' 'Dec_23_14' 'Jan_07_15' 'Jan_07_15' 'Jan_13_15'...
%     'Jan_13_15' 'Jan_13_15' 'Jan_14_15' 'Jan_27_15' 'Jan_27_15' 'Feb_03_15'...
%     'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Feb_10_15' 'Feb_10_15' 'Mar_03_15'...
%     'Mar_06_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15'};
% cellnum_all_devhyper={'A' 'A' 'B' 'A' 'A' 'B'...
%     'A' 'A' 'A' 'B' 'C' 'D'...
%     'A' 'B' 'C' 'A' 'B' 'A'...
%     'B' 'C' 'A' 'A' 'B' 'A'...
%     'B' 'C' 'A' 'B' 'C' 'A'...
%     'A' 'A' 'B' 'C' 'D' 'B'};
% trials_all_devhyper=[2 2 2 2 2 2 ...
%     2 2 2 2 2 4 ...
%     2 2 2 2 2 2 ...
%     2 2 2 2 2 2 ...
%     2 2 2 2 2 2 ...
%     2 4 2 2 2 2]';

% Good quality data only
dates_all_devhyper={'Dec_22_14' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Feb_10_15' 'Mar_03_15'...
    'Mar_06_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15'...
    'Mar_16_15' 'Mar_16_15' 'Mar_16_15' 'Mar_17_15' 'Mar_17_15' 'Mar_18_15'...
    'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15'...
    'Apr_03_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15' 'Apr_08_15'...
    'Apr_08_15' 'Apr_08_15' 'Apr_29_15' 'May_01_15' 'May_05_15'};
cellnum_all_devhyper={'C' 'A' 'B' 'B' 'C' 'A'...
    'A' 'A' 'C' 'D' 'B' 'A'...
    'B' 'C' 'D' 'A' 'B' 'A'...
    'B' 'B' 'C' 'D' 'E' 'B'...
    'B' 'B' 'A' 'C' 'D' 'C'...
    'D' 'E' 'E' 'C' 'D'};
trials_all_devhyper=[2 2 2 2 2 2 ...
    2 4 2 2 2 4 ...
    8 2 4 2 2 6 ...
    4 2 2 2 2 4 ...
    7 6 6 6 4 4 ...
    7 5 2 3 2]';

for k=1:numel(dates_all_devhyper)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_devhyper{k} '_' cellnum_all_devhyper{k} num2str(trials_all_devhyper(k)) '_fi.mat;'])
    peakrate_all_devhyper(k,:)=peakrate;
    nofailrate_all_devhyper(k,:)=nofailrate;
    gains_all_devhyper(k,1)=pf_all{1}.beta(2);
    rsq_all_devhyper(k,1)=pf_all{1}.rsquare;
    rate_all_devhyper(k,:)=rate_all{1};
    imp_all_devhyper(k,:)=imp;
    holdingvoltage_all_devhyper(k,:)=mean_holdingvoltage;
    mean_spikeform_all_devhyper(k,:)=mean_spikeform;
    mean_freq0_outputforms_increment_all_devhyper(k,:)=mean_freq0_outputforms_increment;
    mean_freq0_spikeforms_increment_all_devhyper(k,:)=mean_freq0_spikeforms_increment;
    mean_freq1_outputforms_increment_all_devhyper(k,:)=mean_freq1_outputforms_increment;
    mean_freq1_spikeforms_increment_all_devhyper(k,:)=mean_freq1_spikeforms_increment;
    mean_freq2_outputforms_increment_all_devhyper(k,:)=mean_freq2_outputforms_increment;
    mean_freq2_spikeforms_increment_all_devhyper(k,:)=mean_freq2_spikeforms_increment;
    mean_freq3_outputforms_increment_all_devhyper(k,:)=mean_freq3_outputforms_increment;
    mean_freq3_spikeforms_increment_all_devhyper(k,:)=mean_freq3_spikeforms_increment;
    mean_freq4_outputforms_increment_all_devhyper(k,:)=mean_freq4_outputforms_increment;
    mean_freq4_spikeforms_increment_all_devhyper(k,:)=mean_freq4_spikeforms_increment;
    mean_freq5_outputforms_increment_all_devhyper(k,:)=mean_freq5_outputforms_increment;
    mean_freq5_spikeforms_increment_all_devhyper(k,:)=mean_freq5_spikeforms_increment;
    mean_freq6_outputforms_increment_all_devhyper(k,:)=mean_freq6_outputforms_increment;
    mean_freq6_spikeforms_increment_all_devhyper(k,:)=mean_freq6_spikeforms_increment;
    mean_freq7_outputforms_increment_all_devhyper(k,:)=mean_freq7_outputforms_increment;
    mean_freq7_spikeforms_increment_all_devhyper(k,:)=mean_freq7_spikeforms_increment;
    mean_freq8_outputforms_increment_all_devhyper(k,:)=mean_freq8_outputforms_increment;
    mean_freq8_spikeforms_increment_all_devhyper(k,:)=mean_freq8_spikeforms_increment;
    mean_freq9_outputforms_increment_all_devhyper(k,:)=mean_freq9_outputforms_increment;
    mean_freq9_spikeforms_increment_all_devhyper(k,:)=mean_freq9_spikeforms_increment;
    mean_freq10_outputforms_increment_all_devhyper(k,:)=mean_freq10_outputforms_increment;
    mean_freq10_spikeforms_increment_all_devhyper(k,:)=mean_freq10_spikeforms_increment;
    mean_lastspikeforms_increment_all_devhyper(k,:)=mean_lastspikeforms_increment;
    mean_lastoutputforms_increment_all_devhyper(k,:)=mean_lastoutputforms_increment;
    ISIratio_devhyper(k,:)=ISIratio{1};
    ISIs_all_devhyper=ISIs_all{1};
    firstISI_all_devhyper(k,:)=firstISI{1};
    lastISI_all_devhyper(k,:)=lastISI{1};
end

samecell=1;

for k=1:numel(dates_all_hypervde)
    for h=1:numel(dates_all_devhyper)
        if isequal(dates_all_hypervde{k},dates_all_devhyper{h}) && ...
                isequal(cellnum_all_hypervde{k},cellnum_all_devhyper{h})
            samecell_hypervde(samecell)=k;
            samecell_devhyper(samecell)=h;
            samecell=samecell+1;
        end
    end
end

matchfreq_ISIratio_hypervde=NaN(samecell-1,1);
matchfreq_ISIratio_devhyper=NaN(samecell-1,1);

% look at ISI ratio for hyperpolarized and depolarized
for k=1:samecell-1
    samefreq{k}=find(abs((1./firstISI_all_hypervde(samecell_hypervde(k),:))-(1./firstISI_all_devhyper(samecell_devhyper(k),:)))<2,1,'last');
    if numel(samefreq{k})>0
        matchfreq_ISIratio_hypervde(k)=ISIratio_hypervde(samecell_hypervde(k),samefreq{k});
        matchfreq_ISIratio_devhyper(k)=ISIratio_devhyper(samecell_devhyper(k),samefreq{k});
    end
end

mean_ISIratio_hypervde=nanmean(matchfreq_ISIratio_hypervde);
std_ISIratio_hypervde=nanstd(matchfreq_ISIratio_hypervde);
ste_ISIratio_hypervde=std_ISIratio_hypervde/sqrt(sum(~isnan(matchfreq_ISIratio_hypervde)));
mean_ISIratio_devhyper=nanmean(matchfreq_ISIratio_devhyper);
std_ISIratio_devhyper=nanstd(matchfreq_ISIratio_devhyper);
ste_ISIratio_devhyper=std_ISIratio_devhyper/sqrt(sum(~isnan(matchfreq_ISIratio_devhyper)));

figure;errorbar(1:2,[mean_ISIratio_hypervde mean_ISIratio_devhyper],[ste_ISIratio_hypervde ste_ISIratio_devhyper])
[ISIratio_hypervde(1),ISIratio_hypervde(2)]=ttest(matchfreq_ISIratio_hypervde,matchfreq_ISIratio_devhyper);

mean_freq0_outputforms_devhyper=nanmean(mean_freq0_outputforms_increment_all_devhyper);
mean_freq0_spikeforms_devhyper=nanmean(mean_freq0_spikeforms_increment_all_devhyper);
std_freq0_outputforms_devhyper=nanstd(mean_freq0_outputforms_increment_all_devhyper);
std_freq0_spikeforms_devhyper=nanstd(mean_freq0_spikeforms_increment_all_devhyper);
ste_freq0_outputforms_devhyper=std_freq0_outputforms_devhyper/sqrt(sum(~isnan(mean_freq0_outputforms_increment_all_devhyper)));
ste_freq0_spikeforms_devhyper=std_freq0_spikeforms_devhyper/sqrt(sum(~isnan(mean_freq0_spikeforms_increment_all_devhyper)));
mean_freq1_outputforms_devhyper=nanmean(mean_freq1_outputforms_increment_all_devhyper);
mean_freq1_spikeforms_devhyper=nanmean(mean_freq1_spikeforms_increment_all_devhyper);
std_freq1_outputforms_devhyper=nanstd(mean_freq1_outputforms_increment_all_devhyper);
std_freq1_spikeforms_devhyper=nanstd(mean_freq1_spikeforms_increment_all_devhyper);
ste_freq1_outputforms_devhyper=std_freq1_outputforms_devhyper/sqrt(sum(~isnan(mean_freq1_outputforms_increment_all_devhyper)));
ste_freq1_spikeforms_devhyper=std_freq1_spikeforms_devhyper/sqrt(sum(~isnan(mean_freq1_spikeforms_increment_all_devhyper)));
mean_freq2_outputforms_devhyper=nanmean(mean_freq2_outputforms_increment_all_devhyper);
mean_freq2_spikeforms_devhyper=nanmean(mean_freq2_spikeforms_increment_all_devhyper);
std_freq2_outputforms_devhyper=nanstd(mean_freq2_outputforms_increment_all_devhyper);
std_freq2_spikeforms_devhyper=nanstd(mean_freq2_spikeforms_increment_all_devhyper);
ste_freq2_outputforms_devhyper=std_freq2_outputforms_devhyper/sqrt(sum(~isnan(mean_freq2_outputforms_increment_all_devhyper)));
ste_freq2_spikeforms_devhyper=std_freq2_spikeforms_devhyper/sqrt(sum(~isnan(mean_freq2_spikeforms_increment_all_devhyper)));
mean_freq3_outputforms_devhyper=nanmean(mean_freq3_outputforms_increment_all_devhyper);
mean_freq3_spikeforms_devhyper=nanmean(mean_freq3_spikeforms_increment_all_devhyper);
std_freq3_outputforms_devhyper=nanstd(mean_freq3_outputforms_increment_all_devhyper);
std_freq3_spikeforms_devhyper=nanstd(mean_freq3_spikeforms_increment_all_devhyper);
ste_freq3_outputforms_devhyper=std_freq3_outputforms_devhyper/sqrt(sum(~isnan(mean_freq3_outputforms_increment_all_devhyper)));
ste_freq3_spikeforms_devhyper=std_freq3_spikeforms_devhyper/sqrt(sum(~isnan(mean_freq3_spikeforms_increment_all_devhyper)));
mean_freq4_outputforms_devhyper=nanmean(mean_freq4_outputforms_increment_all_devhyper);
mean_freq4_spikeforms_devhyper=nanmean(mean_freq4_spikeforms_increment_all_devhyper);
std_freq4_outputforms_devhyper=nanstd(mean_freq4_outputforms_increment_all_devhyper);
std_freq4_spikeforms_devhyper=nanstd(mean_freq4_spikeforms_increment_all_devhyper);
ste_freq4_outputforms_devhyper=std_freq4_outputforms_devhyper/sqrt(sum(~isnan(mean_freq4_outputforms_increment_all_devhyper)));
ste_freq4_spikeforms_devhyper=std_freq4_spikeforms_devhyper/sqrt(sum(~isnan(mean_freq4_spikeforms_increment_all_devhyper)));
mean_freq5_outputforms_devhyper=nanmean(mean_freq5_outputforms_increment_all_devhyper);
mean_freq5_spikeforms_devhyper=nanmean(mean_freq5_spikeforms_increment_all_devhyper);
std_freq5_outputforms_devhyper=nanstd(mean_freq5_outputforms_increment_all_devhyper);
std_freq5_spikeforms_devhyper=nanstd(mean_freq5_spikeforms_increment_all_devhyper);
ste_freq5_outputforms_devhyper=std_freq5_outputforms_devhyper/sqrt(sum(~isnan(mean_freq5_outputforms_increment_all_devhyper)));
ste_freq5_spikeforms_devhyper=std_freq5_spikeforms_devhyper/sqrt(sum(~isnan(mean_freq5_spikeforms_increment_all_devhyper)));
mean_freq6_outputforms_devhyper=nanmean(mean_freq6_outputforms_increment_all_devhyper);
mean_freq6_spikeforms_devhyper=nanmean(mean_freq6_spikeforms_increment_all_devhyper);
std_freq6_outputforms_devhyper=nanstd(mean_freq6_outputforms_increment_all_devhyper);
std_freq6_spikeforms_devhyper=nanstd(mean_freq6_spikeforms_increment_all_devhyper);
ste_freq6_outputforms_devhyper=std_freq6_outputforms_devhyper/sqrt(sum(~isnan(mean_freq6_outputforms_increment_all_devhyper)));
ste_freq6_spikeforms_devhyper=std_freq6_spikeforms_devhyper/sqrt(sum(~isnan(mean_freq6_spikeforms_increment_all_devhyper)));
mean_freq7_outputforms_devhyper=nanmean(mean_freq7_outputforms_increment_all_devhyper);
mean_freq7_spikeforms_devhyper=nanmean(mean_freq7_spikeforms_increment_all_devhyper);
std_freq7_outputforms_devhyper=nanstd(mean_freq7_outputforms_increment_all_devhyper);
std_freq7_spikeforms_devhyper=nanstd(mean_freq7_spikeforms_increment_all_devhyper);
ste_freq7_outputforms_devhyper=std_freq7_outputforms_devhyper/sqrt(sum(~isnan(mean_freq7_outputforms_increment_all_devhyper)));
ste_freq7_spikeforms_devhyper=std_freq7_spikeforms_devhyper/sqrt(sum(~isnan(mean_freq7_spikeforms_increment_all_devhyper)));
mean_freq8_outputforms_devhyper=nanmean(mean_freq8_outputforms_increment_all_devhyper);
mean_freq8_spikeforms_devhyper=nanmean(mean_freq8_spikeforms_increment_all_devhyper);
std_freq8_outputforms_devhyper=nanstd(mean_freq8_outputforms_increment_all_devhyper);
std_freq8_spikeforms_devhyper=nanstd(mean_freq8_spikeforms_increment_all_devhyper);
ste_freq8_outputforms_devhyper=std_freq8_outputforms_devhyper/sqrt(sum(~isnan(mean_freq8_outputforms_increment_all_devhyper)));
ste_freq8_spikeforms_devhyper=std_freq8_spikeforms_devhyper/sqrt(sum(~isnan(mean_freq8_spikeforms_increment_all_devhyper)));
mean_freq9_outputforms_devhyper=nanmean(mean_freq9_outputforms_increment_all_devhyper);
mean_freq9_spikeforms_devhyper=nanmean(mean_freq9_spikeforms_increment_all_devhyper);
std_freq9_outputforms_devhyper=nanstd(mean_freq9_outputforms_increment_all_devhyper);
std_freq9_spikeforms_devhyper=nanstd(mean_freq9_spikeforms_increment_all_devhyper);
ste_freq9_outputforms_devhyper=std_freq9_outputforms_devhyper/sqrt(sum(~isnan(mean_freq9_outputforms_increment_all_devhyper)));
ste_freq9_spikeforms_devhyper=std_freq9_spikeforms_devhyper/sqrt(sum(~isnan(mean_freq9_spikeforms_increment_all_devhyper)));
mean_freq10_outputforms_devhyper=nanmean(mean_freq10_outputforms_increment_all_devhyper);
mean_freq10_spikeforms_devhyper=nanmean(mean_freq10_spikeforms_increment_all_devhyper);
std_freq10_outputforms_devhyper=nanstd(mean_freq10_outputforms_increment_all_devhyper);
std_freq10_spikeforms_devhyper=nanstd(mean_freq10_spikeforms_increment_all_devhyper);
ste_freq10_outputforms_devhyper=std_freq10_outputforms_devhyper/sqrt(sum(~isnan(mean_freq10_outputforms_increment_all_devhyper)));
ste_freq10_spikeforms_devhyper=std_freq10_spikeforms_devhyper/sqrt(sum(~isnan(mean_freq10_spikeforms_increment_all_devhyper)));

mean_lastspikeforms_devhyper=nanmean(mean_lastspikeforms_increment_all_devhyper);
std_lastspikeforms_devhyper=nanstd(mean_lastspikeforms_increment_all_devhyper);
ste_lastspikeforms_devhyper=std_lastspikeforms_devhyper/sqrt(sum(~isnan(mean_lastspikeforms_increment_all_devhyper)));
mean_lastoutputforms_devhyper=nanmean(mean_lastoutputforms_increment_all_devhyper);
std_lastoutputforms_devhyper=nanstd(mean_lastoutputforms_increment_all_devhyper);
ste_lastoutputforms_devhyper=std_lastoutputforms_devhyper/sqrt(sum(~isnan(mean_lastoutputforms_increment_all_devhyper)));

gains_all_devhyper(isnan(rsq_all_devhyper))=NaN; % filter out the gains that are NaNs

mean_peakrate_devhyper=nanmean(peakrate_all_devhyper);
std_peakrate_devhyper=nanstd(peakrate_all_devhyper);
mean_nofailrate_devhyper=nanmean(nofailrate_all_devhyper);
std_nofailrate_devhyper=nanstd(nofailrate_all_devhyper);

mean_gains_devhyper=nanmean(gains_all_devhyper);
std_gains_devhyper=nanstd(gains_all_devhyper);
ste_gains_devhyper=std_gains_devhyper/sqrt(sum(~isnan(gains_all_devhyper)));

mean_spikeform_devhyper=nanmean(mean_spikeform_all_devhyper);
std_spikeform_devhyper=nanstd(mean_spikeform_all_devhyper);
ste_spikeform_devhyper=std_spikeform_devhyper./sqrt(sum(~isnan(mean_spikeform_all_devhyper)));

normalized_gains_all_devhyper=gains_all_devhyper./gains_all_hypervde;
normalized_mean_gains_devhyper=nanmean(normalized_gains_all_devhyper([1:10 12:end-2]));
normalized_std_gains_devhyper=nanstd(normalized_gains_all_devhyper([1:10 12:end-2]));
normalized_ste_gains_devhyper=normalized_std_gains_devhyper/sqrt(sum(~isnan(normalized_gains_all_devhyper([1:10 12:end-2]))));
figure;plot(ones(size(normalized_gains_all_devhyper([1:10 12:end-2]))),normalized_gains_all_devhyper([1:10 12:end-2]),'.','LineWidth',3)
hold on;errorbar(1,normalized_mean_gains_devhyper,normalized_ste_gains_devhyper,'or','LineWidth',2)
title('Normalized Depolarized Gains')
ylabel('Normalized Gain')
axis([0.9 1.1 -20 120])
axis 'auto y'
set(gca, 'XTick', []);
[gainsttest_normalized_hyper_de(1),gainsttest_normalized_hyper_de(2)]=ttest(ones(size(normalized_gains_all_devhyper([1:10 12:end-1]))),normalized_gains_all_devhyper([1:10 12:end-1]));

mean_imp_devhyper=nanmean(imp_all_devhyper);
std_imp_devhyper=nanstd(imp_all_devhyper);
mean_holdingvoltage_all_devhyper=nanmean(holdingvoltage_all_devhyper);
std_holdingvoltage_all_devhyper=nanstd(holdingvoltage_all_devhyper);
mean_rate_devhyper=nanmean(rate_all_devhyper);
std_rate_devhyper=nanstd(rate_all_devhyper);
ste_rate_devhyper=std_rate_devhyper./sqrt(sum(~isnan(rate_all_devhyper)));

currents=0:10:200;
nlf_fi_hypervde=nlinfit(currents,mean_rate_hypervde,'sigFun',[320,50,10]);
nlf_fi_devhyper=nlinfit(currents,mean_rate_devhyper,'sigFun',[320,50,10]);

hypervde_max=nlf_fi_hypervde(1);
hypervde_midpoint=nlf_fi_hypervde(2);
hypervde_slope=nlf_fi_hypervde(1)/(4*nlf_fi_hypervde(3));
devhyper_max=nlf_fi_devhyper(1);
devhyper_midpoint=nlf_fi_devhyper(2);
devhyper_slope=nlf_fi_devhyper(1)/(4*nlf_fi_devhyper(3));

figure;errorbar([currents;currents]',[mean_rate_hypervde;mean_rate_devhyper]',[ste_rate_hypervde;ste_rate_devhyper]')
legend('Hyperpolarized','Depolarized')
hold on;plot(currents,sigFun(nlf_fi_hypervde,currents),'m');plot(currents,sigFun(nlf_fi_devhyper,currents),'r')
title('Average f-I Curves for Hyperpolarized and Depolarized')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% difference between rates
difference_rate_hypervde=rate_all_devhyper-rate_all_hypervde;
mean_difference_rate_hypervde=nanmean(difference_rate_hypervde);
std_difference_rate_hypervde=nanstd(difference_rate_hypervde);
ste_difference_rate_hypervde=std_difference_rate_hypervde./sqrt(sum(~isnan(difference_rate_hypervde)));


%% Hyperpolarized with 4-AP (5 sec pulse, 1 sec pause)
% For Depolarized with 4-AP

dates_all_hypervde4AP={'Apr_29_15' 'May_01_15' 'May_04_15' 'May_05_15' 'May_05_15'};
cellnum_all_hypervde4AP={'E' 'C' 'C' 'E' 'F'};
trials_all_hypervde4AP=[1 9 8 3 3]';

for k=1:numel(dates_all_hypervde4AP)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_hypervde4AP{k} '_' cellnum_all_hypervde4AP{k} num2str(trials_all_hypervde4AP(k)) '_fi.mat;'])
    peakrate_all_hypervde4AP(k,:)=peakrate;
    nofailrate_all_hypervde4AP(k,:)=nofailrate;
    gains_all_hypervde4AP(k,1)=pf_all{1}.beta(2);
%     gains_all_hypervde4AP(k,2)=pf_all{2}.beta(2);
    rsq_all_hypervde4AP(k,1)=pf_all{1}.rsquare;
%     rsq_all_hypervde4AP(k,2)=pf_all{2}.rsquare;
    rate_all_hypervde4AP(k,:)=rate_all{1};
    imp_all_hypervde4AP(k,:)=imp;
    holdingvoltage_all_hypervde4AP(k,:)=mean_holdingvoltage;
%     hold on;plot([1 2],gains_all_hypervde4AP(k,:),'or')
    mean_spikeform_all_hypervde4AP(k,:)=mean_spikeform;
    mean_freq0_outputforms_increment_all_hypervde4AP(k,:)=mean_freq0_outputforms_increment;
    mean_freq0_spikeforms_increment_all_hypervde4AP(k,:)=mean_freq0_spikeforms_increment;
    mean_freq1_outputforms_increment_all_hypervde4AP(k,:)=mean_freq1_outputforms_increment;
    mean_freq1_spikeforms_increment_all_hypervde4AP(k,:)=mean_freq1_spikeforms_increment;
    mean_freq2_outputforms_increment_all_hypervde4AP(k,:)=mean_freq2_outputforms_increment;
    mean_freq2_spikeforms_increment_all_hypervde4AP(k,:)=mean_freq2_spikeforms_increment;
    mean_freq3_outputforms_increment_all_hypervde4AP(k,:)=mean_freq3_outputforms_increment;
    mean_freq3_spikeforms_increment_all_hypervde4AP(k,:)=mean_freq3_spikeforms_increment;
    mean_freq4_outputforms_increment_all_hypervde4AP(k,:)=mean_freq4_outputforms_increment;
    mean_freq4_spikeforms_increment_all_hypervde4AP(k,:)=mean_freq4_spikeforms_increment;
    mean_freq5_outputforms_increment_all_hypervde4AP(k,:)=mean_freq5_outputforms_increment;
    mean_freq5_spikeforms_increment_all_hypervde4AP(k,:)=mean_freq5_spikeforms_increment;
    mean_freq6_outputforms_increment_all_hypervde4AP(k,:)=mean_freq6_outputforms_increment;
    mean_freq6_spikeforms_increment_all_hypervde4AP(k,:)=mean_freq6_spikeforms_increment;
    mean_freq7_outputforms_increment_all_hypervde4AP(k,:)=mean_freq7_outputforms_increment;
    mean_freq7_spikeforms_increment_all_hypervde4AP(k,:)=mean_freq7_spikeforms_increment;
    mean_freq8_outputforms_increment_all_hypervde4AP(k,:)=mean_freq8_outputforms_increment;
    mean_freq8_spikeforms_increment_all_hypervde4AP(k,:)=mean_freq8_spikeforms_increment;
    mean_freq9_outputforms_increment_all_hypervde4AP(k,:)=mean_freq9_outputforms_increment;
    mean_freq9_spikeforms_increment_all_hypervde4AP(k,:)=mean_freq9_spikeforms_increment;
    mean_freq10_outputforms_increment_all_hypervde4AP(k,:)=mean_freq10_outputforms_increment;
    mean_freq10_spikeforms_increment_all_hypervde4AP(k,:)=mean_freq10_spikeforms_increment;
    mean_lastspikeforms_increment_all_hypervde4AP(k,:)=mean_lastspikeforms_increment;
    mean_lastoutputforms_increment_all_hypervde4AP(k,:)=mean_lastoutputforms_increment;
    ISIratio_hypervde4AP(k,:)=ISIratio{1};
    ISIs_all_hypervde4AP=ISIs_all{1};
    firstISI_all_hypervde4AP(k,:)=firstISI{1};
    lastISI_all_hypervde4AP(k,:)=lastISI{1};
end

mean_freq0_outputforms_hypervde4AP=nanmean(mean_freq0_outputforms_increment_all_hypervde4AP);
mean_freq0_spikeforms_hypervde4AP=nanmean(mean_freq0_spikeforms_increment_all_hypervde4AP);
std_freq0_outputforms_hypervde4AP=nanstd(mean_freq0_outputforms_increment_all_hypervde4AP);
std_freq0_spikeforms_hypervde4AP=nanstd(mean_freq0_spikeforms_increment_all_hypervde4AP);
ste_freq0_outputforms_hypervde4AP=std_freq0_outputforms_hypervde4AP/sqrt(sum(~isnan(mean_freq0_outputforms_increment_all_hypervde4AP)));
ste_freq0_spikeforms_hypervde4AP=std_freq0_spikeforms_hypervde4AP/sqrt(sum(~isnan(mean_freq0_spikeforms_increment_all_hypervde4AP)));
mean_freq1_outputforms_hypervde4AP=nanmean(mean_freq1_outputforms_increment_all_hypervde4AP);
mean_freq1_spikeforms_hypervde4AP=nanmean(mean_freq1_spikeforms_increment_all_hypervde4AP);
std_freq1_outputforms_hypervde4AP=nanstd(mean_freq1_outputforms_increment_all_hypervde4AP);
std_freq1_spikeforms_hypervde4AP=nanstd(mean_freq1_spikeforms_increment_all_hypervde4AP);
ste_freq1_outputforms_hypervde4AP=std_freq1_outputforms_hypervde4AP/sqrt(sum(~isnan(mean_freq1_outputforms_increment_all_hypervde4AP)));
ste_freq1_spikeforms_hypervde4AP=std_freq1_spikeforms_hypervde4AP/sqrt(sum(~isnan(mean_freq1_spikeforms_increment_all_hypervde4AP)));
mean_freq2_outputforms_hypervde4AP=nanmean(mean_freq2_outputforms_increment_all_hypervde4AP);
mean_freq2_spikeforms_hypervde4AP=nanmean(mean_freq2_spikeforms_increment_all_hypervde4AP);
std_freq2_outputforms_hypervde4AP=nanstd(mean_freq2_outputforms_increment_all_hypervde4AP);
std_freq2_spikeforms_hypervde4AP=nanstd(mean_freq2_spikeforms_increment_all_hypervde4AP);
ste_freq2_outputforms_hypervde4AP=std_freq2_outputforms_hypervde4AP/sqrt(sum(~isnan(mean_freq2_outputforms_increment_all_hypervde4AP)));
ste_freq2_spikeforms_hypervde4AP=std_freq2_spikeforms_hypervde4AP/sqrt(sum(~isnan(mean_freq2_spikeforms_increment_all_hypervde4AP)));
mean_freq3_outputforms_hypervde4AP=nanmean(mean_freq3_outputforms_increment_all_hypervde4AP);
mean_freq3_spikeforms_hypervde4AP=nanmean(mean_freq3_spikeforms_increment_all_hypervde4AP);
std_freq3_outputforms_hypervde4AP=nanstd(mean_freq3_outputforms_increment_all_hypervde4AP);
std_freq3_spikeforms_hypervde4AP=nanstd(mean_freq3_spikeforms_increment_all_hypervde4AP);
ste_freq3_outputforms_hypervde4AP=std_freq3_outputforms_hypervde4AP/sqrt(sum(~isnan(mean_freq3_outputforms_increment_all_hypervde4AP)));
ste_freq3_spikeforms_hypervde4AP=std_freq3_spikeforms_hypervde4AP/sqrt(sum(~isnan(mean_freq3_spikeforms_increment_all_hypervde4AP)));
mean_freq4_outputforms_hypervde4AP=nanmean(mean_freq4_outputforms_increment_all_hypervde4AP);
mean_freq4_spikeforms_hypervde4AP=nanmean(mean_freq4_spikeforms_increment_all_hypervde4AP);
std_freq4_outputforms_hypervde4AP=nanstd(mean_freq4_outputforms_increment_all_hypervde4AP);
std_freq4_spikeforms_hypervde4AP=nanstd(mean_freq4_spikeforms_increment_all_hypervde4AP);
ste_freq4_outputforms_hypervde4AP=std_freq4_outputforms_hypervde4AP/sqrt(sum(~isnan(mean_freq4_outputforms_increment_all_hypervde4AP)));
ste_freq4_spikeforms_hypervde4AP=std_freq4_spikeforms_hypervde4AP/sqrt(sum(~isnan(mean_freq4_spikeforms_increment_all_hypervde4AP)));
mean_freq5_outputforms_hypervde4AP=nanmean(mean_freq5_outputforms_increment_all_hypervde4AP);
mean_freq5_spikeforms_hypervde4AP=nanmean(mean_freq5_spikeforms_increment_all_hypervde4AP);
std_freq5_outputforms_hypervde4AP=nanstd(mean_freq5_outputforms_increment_all_hypervde4AP);
std_freq5_spikeforms_hypervde4AP=nanstd(mean_freq5_spikeforms_increment_all_hypervde4AP);
ste_freq5_outputforms_hypervde4AP=std_freq5_outputforms_hypervde4AP/sqrt(sum(~isnan(mean_freq5_outputforms_increment_all_hypervde4AP)));
ste_freq5_spikeforms_hypervde4AP=std_freq5_spikeforms_hypervde4AP/sqrt(sum(~isnan(mean_freq5_spikeforms_increment_all_hypervde4AP)));
mean_freq6_outputforms_hypervde4AP=nanmean(mean_freq6_outputforms_increment_all_hypervde4AP);
mean_freq6_spikeforms_hypervde4AP=nanmean(mean_freq6_spikeforms_increment_all_hypervde4AP);
std_freq6_outputforms_hypervde4AP=nanstd(mean_freq6_outputforms_increment_all_hypervde4AP);
std_freq6_spikeforms_hypervde4AP=nanstd(mean_freq6_spikeforms_increment_all_hypervde4AP);
ste_freq6_outputforms_hypervde4AP=std_freq6_outputforms_hypervde4AP/sqrt(sum(~isnan(mean_freq6_outputforms_increment_all_hypervde4AP)));
ste_freq6_spikeforms_hypervde4AP=std_freq6_spikeforms_hypervde4AP/sqrt(sum(~isnan(mean_freq6_spikeforms_increment_all_hypervde4AP)));
mean_freq7_outputforms_hypervde4AP=nanmean(mean_freq7_outputforms_increment_all_hypervde4AP);
mean_freq7_spikeforms_hypervde4AP=nanmean(mean_freq7_spikeforms_increment_all_hypervde4AP);
std_freq7_outputforms_hypervde4AP=nanstd(mean_freq7_outputforms_increment_all_hypervde4AP);
std_freq7_spikeforms_hypervde4AP=nanstd(mean_freq7_spikeforms_increment_all_hypervde4AP);
ste_freq7_outputforms_hypervde4AP=std_freq7_outputforms_hypervde4AP/sqrt(sum(~isnan(mean_freq7_outputforms_increment_all_hypervde4AP)));
ste_freq7_spikeforms_hypervde4AP=std_freq7_spikeforms_hypervde4AP/sqrt(sum(~isnan(mean_freq7_spikeforms_increment_all_hypervde4AP)));
mean_freq8_outputforms_hypervde4AP=nanmean(mean_freq8_outputforms_increment_all_hypervde4AP);
mean_freq8_spikeforms_hypervde4AP=nanmean(mean_freq8_spikeforms_increment_all_hypervde4AP);
std_freq8_outputforms_hypervde4AP=nanstd(mean_freq8_outputforms_increment_all_hypervde4AP);
std_freq8_spikeforms_hypervde4AP=nanstd(mean_freq8_spikeforms_increment_all_hypervde4AP);
ste_freq8_outputforms_hypervde4AP=std_freq8_outputforms_hypervde4AP/sqrt(sum(~isnan(mean_freq8_outputforms_increment_all_hypervde4AP)));
ste_freq8_spikeforms_hypervde4AP=std_freq8_spikeforms_hypervde4AP/sqrt(sum(~isnan(mean_freq8_spikeforms_increment_all_hypervde4AP)));
mean_freq9_outputforms_hypervde4AP=nanmean(mean_freq9_outputforms_increment_all_hypervde4AP);
mean_freq9_spikeforms_hypervde4AP=nanmean(mean_freq9_spikeforms_increment_all_hypervde4AP);
std_freq9_outputforms_hypervde4AP=nanstd(mean_freq9_outputforms_increment_all_hypervde4AP);
std_freq9_spikeforms_hypervde4AP=nanstd(mean_freq9_spikeforms_increment_all_hypervde4AP);
ste_freq9_outputforms_hypervde4AP=std_freq9_outputforms_hypervde4AP/sqrt(sum(~isnan(mean_freq9_outputforms_increment_all_hypervde4AP)));
ste_freq9_spikeforms_hypervde4AP=std_freq9_spikeforms_hypervde4AP/sqrt(sum(~isnan(mean_freq9_spikeforms_increment_all_hypervde4AP)));
mean_freq10_outputforms_hypervde4AP=nanmean(mean_freq10_outputforms_increment_all_hypervde4AP);
mean_freq10_spikeforms_hypervde4AP=nanmean(mean_freq10_spikeforms_increment_all_hypervde4AP);
std_freq10_outputforms_hypervde4AP=nanstd(mean_freq10_outputforms_increment_all_hypervde4AP);
std_freq10_spikeforms_hypervde4AP=nanstd(mean_freq10_spikeforms_increment_all_hypervde4AP);
ste_freq10_outputforms_hypervde4AP=std_freq10_outputforms_hypervde4AP/sqrt(sum(~isnan(mean_freq10_outputforms_increment_all_hypervde4AP)));
ste_freq10_spikeforms_hypervde4AP=std_freq10_spikeforms_hypervde4AP/sqrt(sum(~isnan(mean_freq10_spikeforms_increment_all_hypervde4AP)));

mean_lastspikeforms_hypervde4AP=nanmean(mean_lastspikeforms_increment_all_hypervde4AP);
std_lastspikeforms_hypervde4AP=nanstd(mean_lastspikeforms_increment_all_hypervde4AP);
ste_lastspikeforms_hypervde4AP=std_lastspikeforms_hypervde4AP/sqrt(sum(~isnan(mean_lastspikeforms_increment_all_hypervde4AP)));
mean_lastoutputforms_hypervde4AP=nanmean(mean_lastoutputforms_increment_all_hypervde4AP);
std_lastoutputforms_hypervde4AP=nanstd(mean_lastoutputforms_increment_all_hypervde4AP);
ste_lastoutputforms_hypervde4AP=std_lastoutputforms_hypervde4AP/sqrt(sum(~isnan(mean_lastoutputforms_increment_all_hypervde4AP)));

gains_all_hypervde4AP(isnan(rsq_all_hypervde4AP))=NaN; % filter out the gains that are NaNs

mean_peakrate_hypervde4AP=nanmean(peakrate_all_hypervde4AP);
std_peakrate_hypervde4AP=nanstd(peakrate_all_hypervde4AP);
mean_nofailrate_hypervde4AP=nanmean(nofailrate_all_hypervde4AP);
std_nofailrate_hypervde4AP=nanstd(nofailrate_all_hypervde4AP);
mean_gains_hypervde4AP=nanmean(gains_all_hypervde4AP);
std_gains_hypervde4AP=nanstd(gains_all_hypervde4AP);
ste_gains_hypervde4AP=std_gains_hypervde4AP/sqrt(sum(~isnan(gains_all_hypervde4AP)));
mean_imp_hypervde4AP=nanmean(imp_all_hypervde4AP);
std_imp_hypervde4AP=nanstd(imp_all_hypervde4AP);
mean_holdingvoltage_all_hypervde4AP=nanmean(holdingvoltage_all_hypervde4AP);
std_holdingvoltage_all_hypervde4AP=nanstd(holdingvoltage_all_hypervde4AP);
mean_rate_hypervde4AP=nanmean(rate_all_hypervde4AP);
std_rate_hypervde4AP=nanstd(rate_all_hypervde4AP);
ste_rate_hypervde4AP=std_rate_hypervde4AP./sqrt(sum(~isnan(rate_all_hypervde4AP)));

mean_spikeform_hypervde4AP=nanmean(mean_spikeform_all_hypervde4AP);
std_spikeform_hypervde4AP=nanstd(mean_spikeform_all_hypervde4AP);
ste_spikeform_hypervde4AP=std_spikeform_hypervde4AP./sqrt(sum(~isnan(mean_spikeform_all_hypervde4AP)));


% Depolarized with 4-AP (5 sec pulse, 1 sec pause)
% For Hyperpolarized with 4-AP

dates_all_devhyper4AP={'Apr_29_15' 'May_01_15' 'May_04_15' 'May_05_15' 'May_05_15'};
cellnum_all_devhyper4AP={'E' 'C' 'C' 'E' 'F'};
trials_all_devhyper4AP=[2 10 9 4 4]';

for k=1:numel(dates_all_devhyper4AP)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_devhyper4AP{k} '_' cellnum_all_devhyper4AP{k} num2str(trials_all_devhyper4AP(k)) '_fi.mat;'])
    peakrate_all_devhyper4AP(k,:)=peakrate;
    nofailrate_all_devhyper4AP(k,:)=nofailrate;
    gains_all_devhyper4AP(k,1)=pf_all{1}.beta(2);
    rsq_all_devhyper4AP(k,1)=pf_all{1}.rsquare;
    rate_all_devhyper4AP(k,:)=rate_all{1};
    imp_all_devhyper4AP(k,:)=imp;
    holdingvoltage_all_devhyper4AP(k,:)=mean_holdingvoltage;
    mean_spikeform_all_devhyper4AP(k,:)=mean_spikeform;
    mean_freq0_outputforms_increment_all_devhyper4AP(k,:)=mean_freq0_outputforms_increment;
    mean_freq0_spikeforms_increment_all_devhyper4AP(k,:)=mean_freq0_spikeforms_increment;
    mean_freq1_outputforms_increment_all_devhyper4AP(k,:)=mean_freq1_outputforms_increment;
    mean_freq1_spikeforms_increment_all_devhyper4AP(k,:)=mean_freq1_spikeforms_increment;
    mean_freq2_outputforms_increment_all_devhyper4AP(k,:)=mean_freq2_outputforms_increment;
    mean_freq2_spikeforms_increment_all_devhyper4AP(k,:)=mean_freq2_spikeforms_increment;
    mean_freq3_outputforms_increment_all_devhyper4AP(k,:)=mean_freq3_outputforms_increment;
    mean_freq3_spikeforms_increment_all_devhyper4AP(k,:)=mean_freq3_spikeforms_increment;
    mean_freq4_outputforms_increment_all_devhyper4AP(k,:)=mean_freq4_outputforms_increment;
    mean_freq4_spikeforms_increment_all_devhyper4AP(k,:)=mean_freq4_spikeforms_increment;
    mean_freq5_outputforms_increment_all_devhyper4AP(k,:)=mean_freq5_outputforms_increment;
    mean_freq5_spikeforms_increment_all_devhyper4AP(k,:)=mean_freq5_spikeforms_increment;
    mean_freq6_outputforms_increment_all_devhyper4AP(k,:)=mean_freq6_outputforms_increment;
    mean_freq6_spikeforms_increment_all_devhyper4AP(k,:)=mean_freq6_spikeforms_increment;
    mean_freq7_outputforms_increment_all_devhyper4AP(k,:)=mean_freq7_outputforms_increment;
    mean_freq7_spikeforms_increment_all_devhyper4AP(k,:)=mean_freq7_spikeforms_increment;
    mean_freq8_outputforms_increment_all_devhyper4AP(k,:)=mean_freq8_outputforms_increment;
    mean_freq8_spikeforms_increment_all_devhyper4AP(k,:)=mean_freq8_spikeforms_increment;
    mean_freq9_outputforms_increment_all_devhyper4AP(k,:)=mean_freq9_outputforms_increment;
    mean_freq9_spikeforms_increment_all_devhyper4AP(k,:)=mean_freq9_spikeforms_increment;
    mean_freq10_outputforms_increment_all_devhyper4AP(k,:)=mean_freq10_outputforms_increment;
    mean_freq10_spikeforms_increment_all_devhyper4AP(k,:)=mean_freq10_spikeforms_increment;
    mean_lastspikeforms_increment_all_devhyper4AP(k,:)=mean_lastspikeforms_increment;
    mean_lastoutputforms_increment_all_devhyper4AP(k,:)=mean_lastoutputforms_increment;
    ISIratio_devhyper4AP(k,:)=ISIratio{1};
    ISIs_all_devhyper4AP=ISIs_all{1};
    firstISI_all_devhyper4AP(k,:)=firstISI{1};
    lastISI_all_devhyper4AP(k,:)=lastISI{1};
end

samecell=1;

for k=1:numel(dates_all_hypervde4AP)
    for h=1:numel(dates_all_devhyper4AP)
        if isequal(dates_all_hypervde4AP{k},dates_all_devhyper4AP{h}) && ...
                isequal(cellnum_all_hypervde4AP{k},cellnum_all_devhyper4AP{h})
            samecell_hypervde4AP(samecell)=k;
            samecell_devhyper4AP(samecell)=h;
            samecell=samecell+1;
        end
    end
end

matchfreq_ISIratio_hypervde4AP=NaN(samecell-1,1);
matchfreq_ISIratio_devhyper4AP=NaN(samecell-1,1);

% look at ISI ratio for hyperpolarized and depolarized
for k=1:samecell-1
    samefreq{k}=find(abs((1./firstISI_all_hypervde4AP(samecell_hypervde4AP(k),:))-(1./firstISI_all_devhyper4AP(samecell_devhyper4AP(k),:)))<2,1,'last');
    if numel(samefreq{k})>0
        matchfreq_ISIratio_hypervde4AP(k)=ISIratio_hypervde4AP(samecell_hypervde4AP(k),samefreq{k});
        matchfreq_ISIratio_devhyper4AP(k)=ISIratio_devhyper4AP(samecell_devhyper4AP(k),samefreq{k});
    end
end

mean_ISIratio_hypervde4AP=nanmean(matchfreq_ISIratio_hypervde4AP);
std_ISIratio_hypervde4AP=nanstd(matchfreq_ISIratio_hypervde4AP);
ste_ISIratio_hypervde4AP=std_ISIratio_hypervde4AP/sqrt(sum(~isnan(matchfreq_ISIratio_hypervde4AP)));
mean_ISIratio_devhyper4AP=nanmean(matchfreq_ISIratio_devhyper4AP);
std_ISIratio_devhyper4AP=nanstd(matchfreq_ISIratio_devhyper4AP);
ste_ISIratio_devhyper4AP=std_ISIratio_devhyper4AP/sqrt(sum(~isnan(matchfreq_ISIratio_devhyper4AP)));

figure;errorbar(1:2,[mean_ISIratio_hypervde4AP mean_ISIratio_devhyper4AP],[ste_ISIratio_hypervde4AP ste_ISIratio_devhyper4AP])
[ISIratio_hypervde4AP(1),ISIratio_hypervde4AP(2)]=ttest(matchfreq_ISIratio_hypervde4AP,matchfreq_ISIratio_devhyper4AP);

mean_freq0_outputforms_devhyper4AP=nanmean(mean_freq0_outputforms_increment_all_devhyper4AP);
mean_freq0_spikeforms_devhyper4AP=nanmean(mean_freq0_spikeforms_increment_all_devhyper4AP);
std_freq0_outputforms_devhyper4AP=nanstd(mean_freq0_outputforms_increment_all_devhyper4AP);
std_freq0_spikeforms_devhyper4AP=nanstd(mean_freq0_spikeforms_increment_all_devhyper4AP);
ste_freq0_outputforms_devhyper4AP=std_freq0_outputforms_devhyper4AP/sqrt(sum(~isnan(mean_freq0_outputforms_increment_all_devhyper4AP)));
ste_freq0_spikeforms_devhyper4AP=std_freq0_spikeforms_devhyper4AP/sqrt(sum(~isnan(mean_freq0_spikeforms_increment_all_devhyper4AP)));
mean_freq1_outputforms_devhyper4AP=nanmean(mean_freq1_outputforms_increment_all_devhyper4AP);
mean_freq1_spikeforms_devhyper4AP=nanmean(mean_freq1_spikeforms_increment_all_devhyper4AP);
std_freq1_outputforms_devhyper4AP=nanstd(mean_freq1_outputforms_increment_all_devhyper4AP);
std_freq1_spikeforms_devhyper4AP=nanstd(mean_freq1_spikeforms_increment_all_devhyper4AP);
ste_freq1_outputforms_devhyper4AP=std_freq1_outputforms_devhyper4AP/sqrt(sum(~isnan(mean_freq1_outputforms_increment_all_devhyper4AP)));
ste_freq1_spikeforms_devhyper4AP=std_freq1_spikeforms_devhyper4AP/sqrt(sum(~isnan(mean_freq1_spikeforms_increment_all_devhyper4AP)));
mean_freq2_outputforms_devhyper4AP=nanmean(mean_freq2_outputforms_increment_all_devhyper4AP);
mean_freq2_spikeforms_devhyper4AP=nanmean(mean_freq2_spikeforms_increment_all_devhyper4AP);
std_freq2_outputforms_devhyper4AP=nanstd(mean_freq2_outputforms_increment_all_devhyper4AP);
std_freq2_spikeforms_devhyper4AP=nanstd(mean_freq2_spikeforms_increment_all_devhyper4AP);
ste_freq2_outputforms_devhyper4AP=std_freq2_outputforms_devhyper4AP/sqrt(sum(~isnan(mean_freq2_outputforms_increment_all_devhyper4AP)));
ste_freq2_spikeforms_devhyper4AP=std_freq2_spikeforms_devhyper4AP/sqrt(sum(~isnan(mean_freq2_spikeforms_increment_all_devhyper4AP)));
mean_freq3_outputforms_devhyper4AP=nanmean(mean_freq3_outputforms_increment_all_devhyper4AP);
mean_freq3_spikeforms_devhyper4AP=nanmean(mean_freq3_spikeforms_increment_all_devhyper4AP);
std_freq3_outputforms_devhyper4AP=nanstd(mean_freq3_outputforms_increment_all_devhyper4AP);
std_freq3_spikeforms_devhyper4AP=nanstd(mean_freq3_spikeforms_increment_all_devhyper4AP);
ste_freq3_outputforms_devhyper4AP=std_freq3_outputforms_devhyper4AP/sqrt(sum(~isnan(mean_freq3_outputforms_increment_all_devhyper4AP)));
ste_freq3_spikeforms_devhyper4AP=std_freq3_spikeforms_devhyper4AP/sqrt(sum(~isnan(mean_freq3_spikeforms_increment_all_devhyper4AP)));
mean_freq4_outputforms_devhyper4AP=nanmean(mean_freq4_outputforms_increment_all_devhyper4AP);
mean_freq4_spikeforms_devhyper4AP=nanmean(mean_freq4_spikeforms_increment_all_devhyper4AP);
std_freq4_outputforms_devhyper4AP=nanstd(mean_freq4_outputforms_increment_all_devhyper4AP);
std_freq4_spikeforms_devhyper4AP=nanstd(mean_freq4_spikeforms_increment_all_devhyper4AP);
ste_freq4_outputforms_devhyper4AP=std_freq4_outputforms_devhyper4AP/sqrt(sum(~isnan(mean_freq4_outputforms_increment_all_devhyper4AP)));
ste_freq4_spikeforms_devhyper4AP=std_freq4_spikeforms_devhyper4AP/sqrt(sum(~isnan(mean_freq4_spikeforms_increment_all_devhyper4AP)));
mean_freq5_outputforms_devhyper4AP=nanmean(mean_freq5_outputforms_increment_all_devhyper4AP);
mean_freq5_spikeforms_devhyper4AP=nanmean(mean_freq5_spikeforms_increment_all_devhyper4AP);
std_freq5_outputforms_devhyper4AP=nanstd(mean_freq5_outputforms_increment_all_devhyper4AP);
std_freq5_spikeforms_devhyper4AP=nanstd(mean_freq5_spikeforms_increment_all_devhyper4AP);
ste_freq5_outputforms_devhyper4AP=std_freq5_outputforms_devhyper4AP/sqrt(sum(~isnan(mean_freq5_outputforms_increment_all_devhyper4AP)));
ste_freq5_spikeforms_devhyper4AP=std_freq5_spikeforms_devhyper4AP/sqrt(sum(~isnan(mean_freq5_spikeforms_increment_all_devhyper4AP)));
mean_freq6_outputforms_devhyper4AP=nanmean(mean_freq6_outputforms_increment_all_devhyper4AP);
mean_freq6_spikeforms_devhyper4AP=nanmean(mean_freq6_spikeforms_increment_all_devhyper4AP);
std_freq6_outputforms_devhyper4AP=nanstd(mean_freq6_outputforms_increment_all_devhyper4AP);
std_freq6_spikeforms_devhyper4AP=nanstd(mean_freq6_spikeforms_increment_all_devhyper4AP);
ste_freq6_outputforms_devhyper4AP=std_freq6_outputforms_devhyper4AP/sqrt(sum(~isnan(mean_freq6_outputforms_increment_all_devhyper4AP)));
ste_freq6_spikeforms_devhyper4AP=std_freq6_spikeforms_devhyper4AP/sqrt(sum(~isnan(mean_freq6_spikeforms_increment_all_devhyper4AP)));
mean_freq7_outputforms_devhyper4AP=nanmean(mean_freq7_outputforms_increment_all_devhyper4AP);
mean_freq7_spikeforms_devhyper4AP=nanmean(mean_freq7_spikeforms_increment_all_devhyper4AP);
std_freq7_outputforms_devhyper4AP=nanstd(mean_freq7_outputforms_increment_all_devhyper4AP);
std_freq7_spikeforms_devhyper4AP=nanstd(mean_freq7_spikeforms_increment_all_devhyper4AP);
ste_freq7_outputforms_devhyper4AP=std_freq7_outputforms_devhyper4AP/sqrt(sum(~isnan(mean_freq7_outputforms_increment_all_devhyper4AP)));
ste_freq7_spikeforms_devhyper4AP=std_freq7_spikeforms_devhyper4AP/sqrt(sum(~isnan(mean_freq7_spikeforms_increment_all_devhyper4AP)));
mean_freq8_outputforms_devhyper4AP=nanmean(mean_freq8_outputforms_increment_all_devhyper4AP);
mean_freq8_spikeforms_devhyper4AP=nanmean(mean_freq8_spikeforms_increment_all_devhyper4AP);
std_freq8_outputforms_devhyper4AP=nanstd(mean_freq8_outputforms_increment_all_devhyper4AP);
std_freq8_spikeforms_devhyper4AP=nanstd(mean_freq8_spikeforms_increment_all_devhyper4AP);
ste_freq8_outputforms_devhyper4AP=std_freq8_outputforms_devhyper4AP/sqrt(sum(~isnan(mean_freq8_outputforms_increment_all_devhyper4AP)));
ste_freq8_spikeforms_devhyper4AP=std_freq8_spikeforms_devhyper4AP/sqrt(sum(~isnan(mean_freq8_spikeforms_increment_all_devhyper4AP)));
mean_freq9_outputforms_devhyper4AP=nanmean(mean_freq9_outputforms_increment_all_devhyper4AP);
mean_freq9_spikeforms_devhyper4AP=nanmean(mean_freq9_spikeforms_increment_all_devhyper4AP);
std_freq9_outputforms_devhyper4AP=nanstd(mean_freq9_outputforms_increment_all_devhyper4AP);
std_freq9_spikeforms_devhyper4AP=nanstd(mean_freq9_spikeforms_increment_all_devhyper4AP);
ste_freq9_outputforms_devhyper4AP=std_freq9_outputforms_devhyper4AP/sqrt(sum(~isnan(mean_freq9_outputforms_increment_all_devhyper4AP)));
ste_freq9_spikeforms_devhyper4AP=std_freq9_spikeforms_devhyper4AP/sqrt(sum(~isnan(mean_freq9_spikeforms_increment_all_devhyper4AP)));
mean_freq10_outputforms_devhyper4AP=nanmean(mean_freq10_outputforms_increment_all_devhyper4AP);
mean_freq10_spikeforms_devhyper4AP=nanmean(mean_freq10_spikeforms_increment_all_devhyper4AP);
std_freq10_outputforms_devhyper4AP=nanstd(mean_freq10_outputforms_increment_all_devhyper4AP);
std_freq10_spikeforms_devhyper4AP=nanstd(mean_freq10_spikeforms_increment_all_devhyper4AP);
ste_freq10_outputforms_devhyper4AP=std_freq10_outputforms_devhyper4AP/sqrt(sum(~isnan(mean_freq10_outputforms_increment_all_devhyper4AP)));
ste_freq10_spikeforms_devhyper4AP=std_freq10_spikeforms_devhyper4AP/sqrt(sum(~isnan(mean_freq10_spikeforms_increment_all_devhyper4AP)));

mean_lastspikeforms_devhyper4AP=nanmean(mean_lastspikeforms_increment_all_devhyper4AP);
std_lastspikeforms_devhyper4AP=nanstd(mean_lastspikeforms_increment_all_devhyper4AP);
ste_lastspikeforms_devhyper4AP=std_lastspikeforms_devhyper4AP/sqrt(sum(~isnan(mean_lastspikeforms_increment_all_devhyper4AP)));
mean_lastoutputforms_devhyper4AP=nanmean(mean_lastoutputforms_increment_all_devhyper4AP);
std_lastoutputforms_devhyper4AP=nanstd(mean_lastoutputforms_increment_all_devhyper4AP);
ste_lastoutputforms_devhyper4AP=std_lastoutputforms_devhyper4AP/sqrt(sum(~isnan(mean_lastoutputforms_increment_all_devhyper4AP)));

gains_all_devhyper4AP(isnan(rsq_all_devhyper4AP))=NaN; % filter out the gains that are NaNs

mean_peakrate_devhyper4AP=nanmean(peakrate_all_devhyper4AP);
std_peakrate_devhyper4AP=nanstd(peakrate_all_devhyper4AP);
mean_nofailrate_devhyper4AP=nanmean(nofailrate_all_devhyper4AP);
std_nofailrate_devhyper4AP=nanstd(nofailrate_all_devhyper4AP);

mean_gains_devhyper4AP=nanmean(gains_all_devhyper4AP);
std_gains_devhyper4AP=nanstd(gains_all_devhyper4AP);
ste_gains_devhyper4AP=std_gains_devhyper4AP/sqrt(sum(~isnan(gains_all_devhyper4AP)));

mean_spikeform_devhyper4AP=nanmean(mean_spikeform_all_devhyper4AP);
std_spikeform_devhyper4AP=nanstd(mean_spikeform_all_devhyper4AP);
ste_spikeform_devhyper4AP=std_spikeform_devhyper4AP./sqrt(sum(~isnan(mean_spikeform_all_devhyper4AP)));

normalized_gains_all_devhyper4AP=gains_all_devhyper4AP./gains_all_hypervde4AP;
normalized_mean_gains_devhyper4AP=nanmean(normalized_gains_all_devhyper4AP);
normalized_std_gains_devhyper4AP=nanstd(normalized_gains_all_devhyper4AP);
normalized_ste_gains_devhyper4AP=normalized_std_gains_devhyper4AP/sqrt(sum(~isnan(normalized_gains_all_devhyper4AP)));
figure;plot(ones(size(normalized_gains_all_devhyper4AP)),normalized_gains_all_devhyper4AP,'.','LineWidth',3)
hold on;errorbar(1,normalized_mean_gains_devhyper4AP,normalized_ste_gains_devhyper4AP,'or','LineWidth',2)
title('Normalized Depolarized Gains')
ylabel('Normalized Gain')
axis([0.9 1.1 -20 120])
axis 'auto y'
set(gca, 'XTick', []);
[gainsttest_normalized_hyper_de_4AP(1),gainsttest_normalized_hyper_de_4AP(2)]=ttest(ones(size(normalized_gains_all_devhyper4AP)),normalized_gains_all_devhyper4AP);

mean_imp_devhyper4AP=nanmean(imp_all_devhyper4AP);
std_imp_devhyper4AP=nanstd(imp_all_devhyper4AP);
mean_holdingvoltage_all_devhyper4AP=nanmean(holdingvoltage_all_devhyper4AP);
std_holdingvoltage_all_devhyper4AP=nanstd(holdingvoltage_all_devhyper4AP);
mean_rate_devhyper4AP=nanmean(rate_all_devhyper4AP);
std_rate_devhyper4AP=nanstd(rate_all_devhyper4AP);
ste_rate_devhyper4AP=std_rate_devhyper4AP./sqrt(sum(~isnan(rate_all_devhyper4AP)));

currents=0:10:200;
nlf_fi_hypervde4AP=nlinfit(currents,mean_rate_hypervde4AP,'sigFun',[320,50,10]);
nlf_fi_devhyper4AP=nlinfit(currents,mean_rate_devhyper4AP,'sigFun',[320,50,10]);

hypervde4AP_max=nlf_fi_hypervde4AP(1);
hypervde4AP_midpoint=nlf_fi_hypervde4AP(2);
hypervde4AP_slope=nlf_fi_hypervde4AP(1)/(4*nlf_fi_hypervde4AP(3));
devhyper4AP_max=nlf_fi_devhyper4AP(1);
devhyper4AP_midpoint=nlf_fi_devhyper4AP(2);
devhyper4AP_slope=nlf_fi_devhyper4AP(1)/(4*nlf_fi_devhyper4AP(3));

figure;errorbar([currents;currents]',[mean_rate_hypervde4AP;mean_rate_devhyper4AP]',[ste_rate_hypervde4AP;ste_rate_devhyper4AP]')
legend('Hyperpolarized','Depolarized')
hold on;plot(currents,sigFun(nlf_fi_hypervde4AP,currents),'m');plot(currents,sigFun(nlf_fi_devhyper4AP,currents),'r')
title('Average f-I Curves for Hyperpolarized and Depolarized')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% difference between rates
difference_rate_hypervde4AP=rate_all_devhyper4AP-rate_all_hypervde4AP;
mean_difference_rate_hypervde4AP=nanmean(difference_rate_hypervde4AP);
std_difference_rate_hypervde4AP=nanstd(difference_rate_hypervde4AP);
ste_difference_rate_hypervde4AP=std_difference_rate_hypervde4AP./sqrt(sum(~isnan(difference_rate_hypervde4AP)));


%% Hyperpolarized (5 sec pulse, 1 sec pause; Currents go from 0:10:200)
% For Hyperpolarized with Noise

% % These are the 1 sec pulse, 1 sec pauses (haven't looked at the quality of this data yet
% dates_all_hypervhypernoise={'Oct_03_14' 'Oct_06_14' 'Oct_06_14' 'Oct_14_14' 'Oct_14_14'};
% cellnum_all_hypervhypernoise={'B' 'A' 'C' 'A' 'B'};
% trials_all_hypervhypernoise=[1 1 1 1 1]';

% % Unpaired with depolarized data (haven't looked at the quality of this data yet)
% dates_all_hypervhypernoise={'Nov_26_14' 'Jan_27_15' 'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_03_15'...
%     'Feb_10_15' 'Feb_10_15' 'Mar_03_15' 'Mar_06_15' 'Mar_10_15' 'Mar_10_15'...
%     'Mar_10_15' 'Mar_10_15' 'Mar_11_15'};
% cellnum_all_hypervhypernoise={'A' 'A' 'B' 'A' 'B' 'C'...
%     'B' 'C' 'A' 'A' 'A' 'B'...
%     'C' 'D' 'B'};
% trials_all_hypervhypernoise=[1 1 1 1 1 1 ...
%     1 1 1 1 3 1 ...
%     1 1 1]';

% Paired with depolarized data only
dates_all_hypervhypernoise={'Feb_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15' 'Mar_16_15'... 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Mar_03_15' 'Mar_06_15' 'Mar_10_15'
    'Mar_17_15' 'Mar_18_15' 'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15'...
    'Mar_24_15' 'Apr_03_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15'};
cellnum_all_hypervhypernoise={'B' 'A' 'D' 'B' 'B' 'C'... 'A' 'B' 'C' 'A' 'A' 'C'
    'A' 'A' 'B' 'B' 'D' 'E'...
    'B' 'B' 'B' 'C' 'D'};
trials_all_hypervhypernoise=[1 3 1 3 7 1 ... 1 1 1 1 1 1
    1 5 3 1 1 1 ...
    3 6 5 5 3]';

for k=1:numel(dates_all_hypervhypernoise)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_hypervhypernoise{k} '_' cellnum_all_hypervhypernoise{k} num2str(trials_all_hypervhypernoise(k)) '_fi.mat;'])
    peakrate_all_hypervhypernoise(k,:)=peakrate;
    nofailrate_all_hypervhypernoise(k,:)=nofailrate;
    gains_all_hypervhypernoise(k,1)=pf_all{1}.beta(2);
    rsq_all_hypervhypernoise(k,1)=pf_all{1}.rsquare;
    rate_all_hypervhypernoise(k,:)=rate_all{1};
    imp_all_hypervhypernoise(k,:)=imp;
    holdingvoltage_all_hypervhypernoise(k,:)=mean_holdingvoltage;
    std_noise_all_hypervhypernoise(k)=std_noise;
    mean_spikeform_all_hypervhypernoise(k,:)=mean_spikeform;
    mean_freq0_outputforms_increment_all_hypervhypernoise(k,:)=mean_freq0_outputforms_increment;
    mean_freq0_spikeforms_increment_all_hypervhypernoise(k,:)=mean_freq0_spikeforms_increment;
    mean_freq1_outputforms_increment_all_hypervhypernoise(k,:)=mean_freq1_outputforms_increment;
    mean_freq1_spikeforms_increment_all_hypervhypernoise(k,:)=mean_freq1_spikeforms_increment;
    mean_freq2_outputforms_increment_all_hypervhypernoise(k,:)=mean_freq2_outputforms_increment;
    mean_freq2_spikeforms_increment_all_hypervhypernoise(k,:)=mean_freq2_spikeforms_increment;
    mean_freq3_outputforms_increment_all_hypervhypernoise(k,:)=mean_freq3_outputforms_increment;
    mean_freq3_spikeforms_increment_all_hypervhypernoise(k,:)=mean_freq3_spikeforms_increment;
    mean_freq4_outputforms_increment_all_hypervhypernoise(k,:)=mean_freq4_outputforms_increment;
    mean_freq4_spikeforms_increment_all_hypervhypernoise(k,:)=mean_freq4_spikeforms_increment;
    mean_freq5_outputforms_increment_all_hypervhypernoise(k,:)=mean_freq5_outputforms_increment;
    mean_freq5_spikeforms_increment_all_hypervhypernoise(k,:)=mean_freq5_spikeforms_increment;
    mean_freq6_outputforms_increment_all_hypervhypernoise(k,:)=mean_freq6_outputforms_increment;
    mean_freq6_spikeforms_increment_all_hypervhypernoise(k,:)=mean_freq6_spikeforms_increment;
    mean_freq7_outputforms_increment_all_hypervhypernoise(k,:)=mean_freq7_outputforms_increment;
    mean_freq7_spikeforms_increment_all_hypervhypernoise(k,:)=mean_freq7_spikeforms_increment;
    mean_freq8_outputforms_increment_all_hypervhypernoise(k,:)=mean_freq8_outputforms_increment;
    mean_freq8_spikeforms_increment_all_hypervhypernoise(k,:)=mean_freq8_spikeforms_increment;
    mean_freq9_outputforms_increment_all_hypervhypernoise(k,:)=mean_freq9_outputforms_increment;
    mean_freq9_spikeforms_increment_all_hypervhypernoise(k,:)=mean_freq9_spikeforms_increment;
    mean_freq10_outputforms_increment_all_hypervhypernoise(k,:)=mean_freq10_outputforms_increment;
    mean_freq10_spikeforms_increment_all_hypervhypernoise(k,:)=mean_freq10_spikeforms_increment;
    mean_lastspikeforms_increment_all_hypervhypernoise(k,:)=mean_lastspikeforms_increment;
    mean_lastoutputforms_increment_all_hypervhypernoise(k,:)=mean_lastoutputforms_increment;
end

mean_freq0_outputforms_hypervhypernoise=nanmean(mean_freq0_outputforms_increment_all_hypervhypernoise);
mean_freq0_spikeforms_hypervhypernoise=nanmean(mean_freq0_spikeforms_increment_all_hypervhypernoise);
std_freq0_outputforms_hypervhypernoise=nanstd(mean_freq0_outputforms_increment_all_hypervhypernoise);
std_freq0_spikeforms_hypervhypernoise=nanstd(mean_freq0_spikeforms_increment_all_hypervhypernoise);
ste_freq0_outputforms_hypervhypernoise=std_freq0_outputforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq0_outputforms_increment_all_hypervhypernoise)));
ste_freq0_spikeforms_hypervhypernoise=std_freq0_spikeforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq0_spikeforms_increment_all_hypervhypernoise)));
mean_freq1_outputforms_hypervhypernoise=nanmean(mean_freq1_outputforms_increment_all_hypervhypernoise);
mean_freq1_spikeforms_hypervhypernoise=nanmean(mean_freq1_spikeforms_increment_all_hypervhypernoise);
std_freq1_outputforms_hypervhypernoise=nanstd(mean_freq1_outputforms_increment_all_hypervhypernoise);
std_freq1_spikeforms_hypervhypernoise=nanstd(mean_freq1_spikeforms_increment_all_hypervhypernoise);
ste_freq1_outputforms_hypervhypernoise=std_freq1_outputforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq1_outputforms_increment_all_hypervhypernoise)));
ste_freq1_spikeforms_hypervhypernoise=std_freq1_spikeforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq1_spikeforms_increment_all_hypervhypernoise)));
mean_freq2_outputforms_hypervhypernoise=nanmean(mean_freq2_outputforms_increment_all_hypervhypernoise);
mean_freq2_spikeforms_hypervhypernoise=nanmean(mean_freq2_spikeforms_increment_all_hypervhypernoise);
std_freq2_outputforms_hypervhypernoise=nanstd(mean_freq2_outputforms_increment_all_hypervhypernoise);
std_freq2_spikeforms_hypervhypernoise=nanstd(mean_freq2_spikeforms_increment_all_hypervhypernoise);
ste_freq2_outputforms_hypervhypernoise=std_freq2_outputforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq2_outputforms_increment_all_hypervhypernoise)));
ste_freq2_spikeforms_hypervhypernoise=std_freq2_spikeforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq2_spikeforms_increment_all_hypervhypernoise)));
mean_freq3_outputforms_hypervhypernoise=nanmean(mean_freq3_outputforms_increment_all_hypervhypernoise);
mean_freq3_spikeforms_hypervhypernoise=nanmean(mean_freq3_spikeforms_increment_all_hypervhypernoise);
std_freq3_outputforms_hypervhypernoise=nanstd(mean_freq3_outputforms_increment_all_hypervhypernoise);
std_freq3_spikeforms_hypervhypernoise=nanstd(mean_freq3_spikeforms_increment_all_hypervhypernoise);
ste_freq3_outputforms_hypervhypernoise=std_freq3_outputforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq3_outputforms_increment_all_hypervhypernoise)));
ste_freq3_spikeforms_hypervhypernoise=std_freq3_spikeforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq3_spikeforms_increment_all_hypervhypernoise)));
mean_freq4_outputforms_hypervhypernoise=nanmean(mean_freq4_outputforms_increment_all_hypervhypernoise);
mean_freq4_spikeforms_hypervhypernoise=nanmean(mean_freq4_spikeforms_increment_all_hypervhypernoise);
std_freq4_outputforms_hypervhypernoise=nanstd(mean_freq4_outputforms_increment_all_hypervhypernoise);
std_freq4_spikeforms_hypervhypernoise=nanstd(mean_freq4_spikeforms_increment_all_hypervhypernoise);
ste_freq4_outputforms_hypervhypernoise=std_freq4_outputforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq4_outputforms_increment_all_hypervhypernoise)));
ste_freq4_spikeforms_hypervhypernoise=std_freq4_spikeforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq4_spikeforms_increment_all_hypervhypernoise)));
mean_freq5_outputforms_hypervhypernoise=nanmean(mean_freq5_outputforms_increment_all_hypervhypernoise);
mean_freq5_spikeforms_hypervhypernoise=nanmean(mean_freq5_spikeforms_increment_all_hypervhypernoise);
std_freq5_outputforms_hypervhypernoise=nanstd(mean_freq5_outputforms_increment_all_hypervhypernoise);
std_freq5_spikeforms_hypervhypernoise=nanstd(mean_freq5_spikeforms_increment_all_hypervhypernoise);
ste_freq5_outputforms_hypervhypernoise=std_freq5_outputforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq5_outputforms_increment_all_hypervhypernoise)));
ste_freq5_spikeforms_hypervhypernoise=std_freq5_spikeforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq5_spikeforms_increment_all_hypervhypernoise)));
mean_freq6_outputforms_hypervhypernoise=nanmean(mean_freq6_outputforms_increment_all_hypervhypernoise);
mean_freq6_spikeforms_hypervhypernoise=nanmean(mean_freq6_spikeforms_increment_all_hypervhypernoise);
std_freq6_outputforms_hypervhypernoise=nanstd(mean_freq6_outputforms_increment_all_hypervhypernoise);
std_freq6_spikeforms_hypervhypernoise=nanstd(mean_freq6_spikeforms_increment_all_hypervhypernoise);
ste_freq6_outputforms_hypervhypernoise=std_freq6_outputforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq6_outputforms_increment_all_hypervhypernoise)));
ste_freq6_spikeforms_hypervhypernoise=std_freq6_spikeforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq6_spikeforms_increment_all_hypervhypernoise)));
mean_freq7_outputforms_hypervhypernoise=nanmean(mean_freq7_outputforms_increment_all_hypervhypernoise);
mean_freq7_spikeforms_hypervhypernoise=nanmean(mean_freq7_spikeforms_increment_all_hypervhypernoise);
std_freq7_outputforms_hypervhypernoise=nanstd(mean_freq7_outputforms_increment_all_hypervhypernoise);
std_freq7_spikeforms_hypervhypernoise=nanstd(mean_freq7_spikeforms_increment_all_hypervhypernoise);
ste_freq7_outputforms_hypervhypernoise=std_freq7_outputforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq7_outputforms_increment_all_hypervhypernoise)));
ste_freq7_spikeforms_hypervhypernoise=std_freq7_spikeforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq7_spikeforms_increment_all_hypervhypernoise)));
mean_freq8_outputforms_hypervhypernoise=nanmean(mean_freq8_outputforms_increment_all_hypervhypernoise);
mean_freq8_spikeforms_hypervhypernoise=nanmean(mean_freq8_spikeforms_increment_all_hypervhypernoise);
std_freq8_outputforms_hypervhypernoise=nanstd(mean_freq8_outputforms_increment_all_hypervhypernoise);
std_freq8_spikeforms_hypervhypernoise=nanstd(mean_freq8_spikeforms_increment_all_hypervhypernoise);
ste_freq8_outputforms_hypervhypernoise=std_freq8_outputforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq8_outputforms_increment_all_hypervhypernoise)));
ste_freq8_spikeforms_hypervhypernoise=std_freq8_spikeforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq8_spikeforms_increment_all_hypervhypernoise)));
mean_freq9_outputforms_hypervhypernoise=nanmean(mean_freq9_outputforms_increment_all_hypervhypernoise);
mean_freq9_spikeforms_hypervhypernoise=nanmean(mean_freq9_spikeforms_increment_all_hypervhypernoise);
std_freq9_outputforms_hypervhypernoise=nanstd(mean_freq9_outputforms_increment_all_hypervhypernoise);
std_freq9_spikeforms_hypervhypernoise=nanstd(mean_freq9_spikeforms_increment_all_hypervhypernoise);
ste_freq9_outputforms_hypervhypernoise=std_freq9_outputforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq9_outputforms_increment_all_hypervhypernoise)));
ste_freq9_spikeforms_hypervhypernoise=std_freq9_spikeforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq9_spikeforms_increment_all_hypervhypernoise)));
mean_freq10_outputforms_hypervhypernoise=nanmean(mean_freq10_outputforms_increment_all_hypervhypernoise);
mean_freq10_spikeforms_hypervhypernoise=nanmean(mean_freq10_spikeforms_increment_all_hypervhypernoise);
std_freq10_outputforms_hypervhypernoise=nanstd(mean_freq10_outputforms_increment_all_hypervhypernoise);
std_freq10_spikeforms_hypervhypernoise=nanstd(mean_freq10_spikeforms_increment_all_hypervhypernoise);
ste_freq10_outputforms_hypervhypernoise=std_freq10_outputforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq10_outputforms_increment_all_hypervhypernoise)));
ste_freq10_spikeforms_hypervhypernoise=std_freq10_spikeforms_hypervhypernoise/sqrt(sum(~isnan(mean_freq10_spikeforms_increment_all_hypervhypernoise)));

mean_lastspikeforms_hypervhypernoise=nanmean(mean_lastspikeforms_increment_all_hypervhypernoise);
std_lastspikeforms_hypervhypernoise=nanstd(mean_lastspikeforms_increment_all_hypervhypernoise);
ste_lastspikeforms_hypervhypernoise=std_lastspikeforms_hypervhypernoise/sqrt(sum(~isnan(mean_lastspikeforms_increment_all_hypervhypernoise)));
mean_lastoutputforms_hypervhypernoise=nanmean(mean_lastoutputforms_increment_all_hypervhypernoise);
std_lastoutputforms_hypervhypernoise=nanstd(mean_lastoutputforms_increment_all_hypervhypernoise);
ste_lastoutputforms_hypervhypernoise=std_lastoutputforms_hypervhypernoise/sqrt(sum(~isnan(mean_lastoutputforms_increment_all_hypervhypernoise)));

gains_all_hypervhypernoise(isnan(rsq_all_hypervhypernoise))=NaN; % filter out the gains that are NaNs

mean_peakrate_hypervhypernoise=nanmean(peakrate_all_hypervhypernoise);
std_peakrate_hypervhypernoise=nanstd(peakrate_all_hypervhypernoise);
mean_nofailrate_hypervhypernoise=nanmean(nofailrate_all_hypervhypernoise);
std_nofailrate_hypervhypernoise=nanstd(nofailrate_all_hypervhypernoise);
mean_gains_hypervhypernoise=nanmean(gains_all_hypervhypernoise);
std_gains_hypervhypernoise=nanstd(gains_all_hypervhypernoise);
ste_gains_hypervhypernoise=std_gains_hypervhypernoise/sqrt(sum(~isnan(gains_all_hypervhypernoise)));
mean_imp_hypervhypernoise=nanmean(imp_all_hypervhypernoise);
std_imp_hypervhypernoise=nanstd(imp_all_hypervhypernoise);
mean_holdingvoltage_all_hypervhypernoise=nanmean(holdingvoltage_all_hypervhypernoise);
std_holdingvoltage_all_hypervhypernoise=nanstd(holdingvoltage_all_hypervhypernoise);
mean_std_noise_all_hypervhypernoise=nanmean(std_noise_all_hypervhypernoise);
std_std_noise_all_hypervhypernoise=nanstd(std_noise_all_hypervhypernoise);
mean_rate_hypervhypernoise=nanmean(rate_all_hypervhypernoise);
std_rate_hypervhypernoise=nanstd(rate_all_hypervhypernoise);
ste_rate_hypervhypernoise=std_rate_hypervhypernoise./sqrt(sum(~isnan(rate_all_hypervhypernoise)));

mean_spikeform_hypervhypernoise=nanmean(mean_spikeform_all_hypervhypernoise);
std_spikeform_hypervhypernoise=nanstd(mean_spikeform_all_hypervhypernoise);
ste_spikeform_hypervhypernoise=std_spikeform_hypervhypernoise./sqrt(sum(~isnan(mean_spikeform_all_hypervhypernoise)));


% Hyperpolarized with Noise (Currents go from 0:10:200)
% For Hyperpolarized

% % These are the 1 sec pulse, 1 sec pauses
% dates_all_hyper_noisevhyper={'Oct_03_14' 'Oct_06_14' 'Oct_06_14' 'Oct_14_14' 'Oct_14_14'};
% cellnum_all_hyper_noisevhyper={'B' 'A' 'C' 'A' 'B'};
% trials_all_hyper_noisevhyper=[4 3 3 2 1]';

% % Unpaired with depolarized data (haven't looked at the quality of this data yet)
% dates_all_hyper_noisevhyper={'Nov_26_14' 'Jan_27_15' 'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_03_15'...
%     'Feb_10_15' 'Feb_10_15' 'Mar_03_15' 'Mar_06_15' 'Mar_10_15' 'Mar_10_15'...
%     'Mar_10_15' 'Mar_10_15' 'Mar_11_15'};
% cellnum_all_hyper_noisevhyper={'A' 'A' 'B' 'A' 'B' 'C'...
%     'B' 'C' 'A' 'A' 'A' 'B'...
%     'C' 'D' 'B'};
% trials_all_hyper_noisevhyper=[2 1 2 1 1 1 ...
%     1 1 1 1 3 1 ...
%     1 1 1]';

% Paired with depolarized data only
dates_all_hyper_noisevhyper={'Feb_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15' 'Mar_16_15'... 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Mar_03_15' 'Mar_06_15' 'Mar_10_15'
    'Mar_17_15' 'Mar_18_15' 'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15'...
    'Mar_24_15' 'Apr_03_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15'};
cellnum_all_hyper_noisevhyper={'B' 'A' 'D' 'B' 'B' 'C'... 'A' 'B' 'C' 'A' 'A' 'C'
    'A' 'A' 'B' 'B' 'D' 'E'...
    'B' 'B' 'B' 'C' 'D'};
trials_all_hyper_noisevhyper=[1 3 1 3 5 1 ... 1 1 1 1 1 1
    1 3 1 1 1 1 ...
    3 1 1 1 1]';

sub_currents_hyper_noisevhyper_all=NaN(numel(dates_all_hyper_noisevhyper),21);
sub_noise_hyper_noisevhyper=NaN(numel(dates_all_hyper_noisevhyper),21);
sup_currents_hyper_noisevhyper_all=NaN(numel(dates_all_hyper_noisevhyper),21);
sup_noise_hyper_noisevhyper=NaN(numel(dates_all_hyper_noisevhyper),21);

for k=1:numel(dates_all_hyper_noisevhyper)
    eval(['load ' pwd '\fi_analysis\FI_OU_' dates_all_hyper_noisevhyper{k} '_' cellnum_all_hyper_noisevhyper{k} num2str(trials_all_hyper_noisevhyper(k)) '_fi.mat;'])
    peakrate_all_hyper_noisevhyper(k,:)=peakrate;
    nofailrate_all_hyper_noisevhyper(k,:)=nofailrate;
    gains_all_hyper_noisevhyper(k,1)=pf_all{1}.beta(2);
    rsq_all_hyper_noisevhyper(k,1)=pf_all{1}.rsquare;
    rate_all_hyper_noisevhyper(k,:)=rate_all{1};
%     resistance_all_hyper_noisevhyper(k)=mean_r_m;
%     capacitance_all_hyper_noisevhyper(k)=mean_c_m;
%     time_constant_all_hyper_noisevhyper(k)=mean_time_constant;
    imp_all_hyper_noisevhyper(k,:)=imp;
    holdingvoltage_all_hyper_noisevhyper(k,:)=mean_holdingvoltage;
    std_noise_all_hyper_noisevhyper(k)=std_noise;
    mean_spikeform_all_hyper_noisevhyper(k,:)=mean_spikeform;
    mean_freq0_Isynforms_increment_all_hyper_noisevhyper(k,:)=mean_freq0_Isynforms_increment;
    mean_freq0_spikeforms_increment_all_hyper_noisevhyper(k,:)=mean_freq0_spikeforms_increment;
    mean_freq1_Isynforms_increment_all_hyper_noisevhyper(k,:)=mean_freq1_Isynforms_increment;
    mean_freq1_spikeforms_increment_all_hyper_noisevhyper(k,:)=mean_freq1_spikeforms_increment;
    mean_freq2_Isynforms_increment_all_hyper_noisevhyper(k,:)=mean_freq2_Isynforms_increment;
    mean_freq2_spikeforms_increment_all_hyper_noisevhyper(k,:)=mean_freq2_spikeforms_increment;
    mean_freq3_Isynforms_increment_all_hyper_noisevhyper(k,:)=mean_freq3_Isynforms_increment;
    mean_freq3_spikeforms_increment_all_hyper_noisevhyper(k,:)=mean_freq3_spikeforms_increment;
    mean_freq4_Isynforms_increment_all_hyper_noisevhyper(k,:)=mean_freq4_Isynforms_increment;
    mean_freq4_spikeforms_increment_all_hyper_noisevhyper(k,:)=mean_freq4_spikeforms_increment;
    mean_freq5_Isynforms_increment_all_hyper_noisevhyper(k,:)=mean_freq5_Isynforms_increment;
    mean_freq5_spikeforms_increment_all_hyper_noisevhyper(k,:)=mean_freq5_spikeforms_increment;
    mean_freq6_Isynforms_increment_all_hyper_noisevhyper(k,:)=mean_freq6_Isynforms_increment;
    mean_freq6_spikeforms_increment_all_hyper_noisevhyper(k,:)=mean_freq6_spikeforms_increment;
    mean_freq7_Isynforms_increment_all_hyper_noisevhyper(k,:)=mean_freq7_Isynforms_increment;
    mean_freq7_spikeforms_increment_all_hyper_noisevhyper(k,:)=mean_freq7_spikeforms_increment;
    mean_freq8_Isynforms_increment_all_hyper_noisevhyper(k,:)=mean_freq8_Isynforms_increment;
    mean_freq8_spikeforms_increment_all_hyper_noisevhyper(k,:)=mean_freq8_spikeforms_increment;
    mean_freq9_Isynforms_increment_all_hyper_noisevhyper(k,:)=mean_freq9_Isynforms_increment;
    mean_freq9_spikeforms_increment_all_hyper_noisevhyper(k,:)=mean_freq9_spikeforms_increment;
    mean_freq10_Isynforms_increment_all_hyper_noisevhyper(k,:)=mean_freq10_Isynforms_increment;
    mean_freq10_spikeforms_increment_all_hyper_noisevhyper(k,:)=mean_freq10_spikeforms_increment;
    mean_lastspikeforms_increment_all_hyper_noisevhyper(k,:)=mean_lastspikeforms_increment;
    mean_lastistepforms_increment_all_hyper_noisevhyper(k,:)=mean_lastistepforms_increment;
    mean_lastIsynforms_increment_all_hyper_noisevhyper(k,:)=mean_lastIsynforms_increment;
    mean_lastoutputforms_increment_all_hyper_noisevhyper(k,:)=mean_lastoutputforms_increment;
    ISIratio_hyper_noisevhyper(k,:)=ISIratio{1};
    ISIs_all_hyper_noisevhyper=ISIs_all{1};
    firstISI_all_hyper_noisevhyper(k,:)=firstISI{1};
    lastISI_all_hyper_noisevhyper(k,:)=lastISI{1};
    std_noise_hyper_noisevhyper(k,:)=std_noise_all{1}; %not just the first second of the first pulse, but all pulses
    currents_hyper_noisevhyper_all(k,:)=0:10:200;
    if sum(rate_all_hyper_noisevhyper(k,:)>=1)
        hyper_noisevhyper_2threshold(k)=find(rate_all_hyper_noisevhyper(k,:)>=1,1);
        sub_currents_hyper_noisevhyper_all(k,1:hyper_noisevhyper_2threshold(k)-1)=currents_hyper_noisevhyper_all(k,1:hyper_noisevhyper_2threshold(k)-1);
        sub_noise_hyper_noisevhyper(k,1:hyper_noisevhyper_2threshold(k)-1)=std_noise_hyper_noisevhyper(k,1:hyper_noisevhyper_2threshold(k)-1);
        sup_currents_hyper_noisevhyper_all(k,hyper_noisevhyper_2threshold(k):end)=currents_hyper_noisevhyper_all(k,hyper_noisevhyper_2threshold(k):end);
        sup_noise_hyper_noisevhyper(k,hyper_noisevhyper_2threshold(k):end)=std_noise_hyper_noisevhyper(k,hyper_noisevhyper_2threshold(k):end);
    else
        hyper_noisevhyper_2threshold(k)=NaN;
        sub_currents_hyper_noisevhyper_all(k,:)=currents_hyper_noisevhyper_all(k,:);
        sub_noise_hyper_noisevhyper(k,:)=std_noise_hyper_noisevhyper(k,:);
    end
end

mean_std_noise_hyper_noisevhyper=nanmean(std_noise_hyper_noisevhyper);
std_std_noise_hyper_noisevhyper=nanstd(std_noise_hyper_noisevhyper);
ste_std_noise_hyper_noisevhyper=std_std_noise_hyper_noisevhyper./sqrt(sum(~isnan(std_noise_hyper_noisevhyper)));

mean_sub_noise_hyper_noisevhyper=nanmean(sub_noise_hyper_noisevhyper);
std_sub_noise_hyper_noisevhyper=nanstd(sub_noise_hyper_noisevhyper);
ste_sub_noise_hyper_noisevhyper=std_sub_noise_hyper_noisevhyper./sqrt(sum(~isnan(sub_noise_hyper_noisevhyper)));
mean_sup_noise_hyper_noisevhyper=nanmean(sup_noise_hyper_noisevhyper);
std_sup_noise_hyper_noisevhyper=nanstd(sup_noise_hyper_noisevhyper);
ste_sup_noise_hyper_noisevhyper=std_sup_noise_hyper_noisevhyper./sqrt(sum(~isnan(sup_noise_hyper_noisevhyper)));

mean_freq0_Isynforms_hyper_noisevhyper=nanmean(mean_freq0_Isynforms_increment_all_hyper_noisevhyper);
mean_freq0_spikeforms_hyper_noisevhyper=nanmean(mean_freq0_spikeforms_increment_all_hyper_noisevhyper);
std_freq0_Isynforms_hyper_noisevhyper=nanstd(mean_freq0_Isynforms_increment_all_hyper_noisevhyper);
std_freq0_spikeforms_hyper_noisevhyper=nanstd(mean_freq0_spikeforms_increment_all_hyper_noisevhyper);
ste_freq0_Isynforms_hyper_noisevhyper=std_freq0_Isynforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq0_Isynforms_increment_all_hyper_noisevhyper)));
ste_freq0_spikeforms_hyper_noisevhyper=std_freq0_spikeforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq0_spikeforms_increment_all_hyper_noisevhyper)));
mean_freq1_Isynforms_hyper_noisevhyper=nanmean(mean_freq1_Isynforms_increment_all_hyper_noisevhyper);
mean_freq1_spikeforms_hyper_noisevhyper=nanmean(mean_freq1_spikeforms_increment_all_hyper_noisevhyper);
std_freq1_Isynforms_hyper_noisevhyper=nanstd(mean_freq1_Isynforms_increment_all_hyper_noisevhyper);
std_freq1_spikeforms_hyper_noisevhyper=nanstd(mean_freq1_spikeforms_increment_all_hyper_noisevhyper);
ste_freq1_Isynforms_hyper_noisevhyper=std_freq1_Isynforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq1_Isynforms_increment_all_hyper_noisevhyper)));
ste_freq1_spikeforms_hyper_noisevhyper=std_freq1_spikeforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq1_spikeforms_increment_all_hyper_noisevhyper)));
mean_freq2_Isynforms_hyper_noisevhyper=nanmean(mean_freq2_Isynforms_increment_all_hyper_noisevhyper);
mean_freq2_spikeforms_hyper_noisevhyper=nanmean(mean_freq2_spikeforms_increment_all_hyper_noisevhyper);
std_freq2_Isynforms_hyper_noisevhyper=nanstd(mean_freq2_Isynforms_increment_all_hyper_noisevhyper);
std_freq2_spikeforms_hyper_noisevhyper=nanstd(mean_freq2_spikeforms_increment_all_hyper_noisevhyper);
ste_freq2_Isynforms_hyper_noisevhyper=std_freq2_Isynforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq2_Isynforms_increment_all_hyper_noisevhyper)));
ste_freq2_spikeforms_hyper_noisevhyper=std_freq2_spikeforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq2_spikeforms_increment_all_hyper_noisevhyper)));
mean_freq3_Isynforms_hyper_noisevhyper=nanmean(mean_freq3_Isynforms_increment_all_hyper_noisevhyper);
mean_freq3_spikeforms_hyper_noisevhyper=nanmean(mean_freq3_spikeforms_increment_all_hyper_noisevhyper);
std_freq3_Isynforms_hyper_noisevhyper=nanstd(mean_freq3_Isynforms_increment_all_hyper_noisevhyper);
std_freq3_spikeforms_hyper_noisevhyper=nanstd(mean_freq3_spikeforms_increment_all_hyper_noisevhyper);
ste_freq3_Isynforms_hyper_noisevhyper=std_freq3_Isynforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq3_Isynforms_increment_all_hyper_noisevhyper)));
ste_freq3_spikeforms_hyper_noisevhyper=std_freq3_spikeforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq3_spikeforms_increment_all_hyper_noisevhyper)));
mean_freq4_Isynforms_hyper_noisevhyper=nanmean(mean_freq4_Isynforms_increment_all_hyper_noisevhyper);
mean_freq4_spikeforms_hyper_noisevhyper=nanmean(mean_freq4_spikeforms_increment_all_hyper_noisevhyper);
std_freq4_Isynforms_hyper_noisevhyper=nanstd(mean_freq4_Isynforms_increment_all_hyper_noisevhyper);
std_freq4_spikeforms_hyper_noisevhyper=nanstd(mean_freq4_spikeforms_increment_all_hyper_noisevhyper);
ste_freq4_Isynforms_hyper_noisevhyper=std_freq4_Isynforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq4_Isynforms_increment_all_hyper_noisevhyper)));
ste_freq4_spikeforms_hyper_noisevhyper=std_freq4_spikeforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq4_spikeforms_increment_all_hyper_noisevhyper)));
mean_freq5_Isynforms_hyper_noisevhyper=nanmean(mean_freq5_Isynforms_increment_all_hyper_noisevhyper);
mean_freq5_spikeforms_hyper_noisevhyper=nanmean(mean_freq5_spikeforms_increment_all_hyper_noisevhyper);
std_freq5_Isynforms_hyper_noisevhyper=nanstd(mean_freq5_Isynforms_increment_all_hyper_noisevhyper);
std_freq5_spikeforms_hyper_noisevhyper=nanstd(mean_freq5_spikeforms_increment_all_hyper_noisevhyper);
ste_freq5_Isynforms_hyper_noisevhyper=std_freq5_Isynforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq5_Isynforms_increment_all_hyper_noisevhyper)));
ste_freq5_spikeforms_hyper_noisevhyper=std_freq5_spikeforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq5_spikeforms_increment_all_hyper_noisevhyper)));
mean_freq6_Isynforms_hyper_noisevhyper=nanmean(mean_freq6_Isynforms_increment_all_hyper_noisevhyper);
mean_freq6_spikeforms_hyper_noisevhyper=nanmean(mean_freq6_spikeforms_increment_all_hyper_noisevhyper);
std_freq6_Isynforms_hyper_noisevhyper=nanstd(mean_freq6_Isynforms_increment_all_hyper_noisevhyper);
std_freq6_spikeforms_hyper_noisevhyper=nanstd(mean_freq6_spikeforms_increment_all_hyper_noisevhyper);
ste_freq6_Isynforms_hyper_noisevhyper=std_freq6_Isynforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq6_Isynforms_increment_all_hyper_noisevhyper)));
ste_freq6_spikeforms_hyper_noisevhyper=std_freq6_spikeforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq6_spikeforms_increment_all_hyper_noisevhyper)));
mean_freq7_Isynforms_hyper_noisevhyper=nanmean(mean_freq7_Isynforms_increment_all_hyper_noisevhyper);
mean_freq7_spikeforms_hyper_noisevhyper=nanmean(mean_freq7_spikeforms_increment_all_hyper_noisevhyper);
std_freq7_Isynforms_hyper_noisevhyper=nanstd(mean_freq7_Isynforms_increment_all_hyper_noisevhyper);
std_freq7_spikeforms_hyper_noisevhyper=nanstd(mean_freq7_spikeforms_increment_all_hyper_noisevhyper);
ste_freq7_Isynforms_hyper_noisevhyper=std_freq7_Isynforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq7_Isynforms_increment_all_hyper_noisevhyper)));
ste_freq7_spikeforms_hyper_noisevhyper=std_freq7_spikeforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq7_spikeforms_increment_all_hyper_noisevhyper)));
mean_freq8_Isynforms_hyper_noisevhyper=nanmean(mean_freq8_Isynforms_increment_all_hyper_noisevhyper);
mean_freq8_spikeforms_hyper_noisevhyper=nanmean(mean_freq8_spikeforms_increment_all_hyper_noisevhyper);
std_freq8_Isynforms_hyper_noisevhyper=nanstd(mean_freq8_Isynforms_increment_all_hyper_noisevhyper);
std_freq8_spikeforms_hyper_noisevhyper=nanstd(mean_freq8_spikeforms_increment_all_hyper_noisevhyper);
ste_freq8_Isynforms_hyper_noisevhyper=std_freq8_Isynforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq8_Isynforms_increment_all_hyper_noisevhyper)));
ste_freq8_spikeforms_hyper_noisevhyper=std_freq8_spikeforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq8_spikeforms_increment_all_hyper_noisevhyper)));
mean_freq9_Isynforms_hyper_noisevhyper=nanmean(mean_freq9_Isynforms_increment_all_hyper_noisevhyper);
mean_freq9_spikeforms_hyper_noisevhyper=nanmean(mean_freq9_spikeforms_increment_all_hyper_noisevhyper);
std_freq9_Isynforms_hyper_noisevhyper=nanstd(mean_freq9_Isynforms_increment_all_hyper_noisevhyper);
std_freq9_spikeforms_hyper_noisevhyper=nanstd(mean_freq9_spikeforms_increment_all_hyper_noisevhyper);
ste_freq9_Isynforms_hyper_noisevhyper=std_freq9_Isynforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq9_Isynforms_increment_all_hyper_noisevhyper)));
ste_freq9_spikeforms_hyper_noisevhyper=std_freq9_spikeforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq9_spikeforms_increment_all_hyper_noisevhyper)));
mean_freq10_Isynforms_hyper_noisevhyper=nanmean(mean_freq10_Isynforms_increment_all_hyper_noisevhyper);
mean_freq10_spikeforms_hyper_noisevhyper=nanmean(mean_freq10_spikeforms_increment_all_hyper_noisevhyper);
std_freq10_Isynforms_hyper_noisevhyper=nanstd(mean_freq10_Isynforms_increment_all_hyper_noisevhyper);
std_freq10_spikeforms_hyper_noisevhyper=nanstd(mean_freq10_spikeforms_increment_all_hyper_noisevhyper);
ste_freq10_Isynforms_hyper_noisevhyper=std_freq10_Isynforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq10_Isynforms_increment_all_hyper_noisevhyper)));
ste_freq10_spikeforms_hyper_noisevhyper=std_freq10_spikeforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_freq10_spikeforms_increment_all_hyper_noisevhyper)));

mean_lastspikeforms_hyper_noisevhyper=nanmean(mean_lastspikeforms_increment_all_hyper_noisevhyper);
std_lastspikeforms_hyper_noisevhyper=nanstd(mean_lastspikeforms_increment_all_hyper_noisevhyper);
ste_lastspikeforms_hyper_noisevhyper=std_lastspikeforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_lastspikeforms_increment_all_hyper_noisevhyper)));
mean_lastistepforms_hyper_noisevhyper=nanmean(mean_lastistepforms_increment_all_hyper_noisevhyper);
std_lastistepforms_hyper_noisevhyper=nanstd(mean_lastistepforms_increment_all_hyper_noisevhyper);
ste_lastistepforms_hyper_noisevhyper=std_lastistepforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_lastistepforms_increment_all_hyper_noisevhyper)));
mean_lastIsynforms_hyper_noisevhyper=nanmean(mean_lastIsynforms_increment_all_hyper_noisevhyper);
std_lastIsynforms_hyper_noisevhyper=nanstd(mean_lastIsynforms_increment_all_hyper_noisevhyper);
ste_lastIsynforms_hyper_noisevhyper=std_lastIsynforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_lastIsynforms_increment_all_hyper_noisevhyper)));
mean_lastoutputforms_hyper_noisevhyper=nanmean(mean_lastoutputforms_increment_all_hyper_noisevhyper);
std_lastoutputforms_hyper_noisevhyper=nanstd(mean_lastoutputforms_increment_all_hyper_noisevhyper);
ste_lastoutputforms_hyper_noisevhyper=std_lastoutputforms_hyper_noisevhyper/sqrt(sum(~isnan(mean_lastoutputforms_increment_all_hyper_noisevhyper)));

gains_all_hyper_noisevhyper(isnan(rsq_all_hyper_noisevhyper))=NaN; % filter out the gains that are NaNs

mean_peakrate_hyper_noisevhyper=nanmean(peakrate_all_hyper_noisevhyper);
std_peakrate_hyper_noisevhyper=nanstd(peakrate_all_hyper_noisevhyper);
mean_nofailrate_hyper_noisevhyper=nanmean(nofailrate_all_hyper_noisevhyper);
std_nofailrate_hyper_noisevhyper=nanstd(nofailrate_all_hyper_noisevhyper);
mean_gains_hyper_noisevhyper=nanmean(gains_all_hyper_noisevhyper);
std_gains_hyper_noisevhyper=nanstd(gains_all_hyper_noisevhyper);
ste_gains_hyper_noisevhyper=std_gains_hyper_noisevhyper/sqrt(sum(~isnan(gains_all_hyper_noisevhyper)));

mean_spikeform_hyper_noisevhyper=nanmean(mean_spikeform_all_hyper_noisevhyper);
std_spikeform_hyper_noisevhyper=nanstd(mean_spikeform_all_hyper_noisevhyper);
ste_spikeform_hyper_noisevhyper=std_spikeform_hyper_noisevhyper./sqrt(sum(~isnan(mean_spikeform_all_hyper_noisevhyper)));

normalized_gains_all_hyper_noisevhyper=gains_all_hyper_noisevhyper./gains_all_hypervhypernoise;
normalized_mean_gains_hyper_noisevhyper=nanmean(normalized_gains_all_hyper_noisevhyper([1:3 5:end]));
normalized_std_gains_hyper_noisevhyper=nanstd(normalized_gains_all_hyper_noisevhyper([1:3 5:end]));
normalized_ste_gains_hyper_noisevhyper=normalized_std_gains_hyper_noisevhyper/sqrt(sum(~isnan(normalized_gains_all_hyper_noisevhyper([1:3 5:end]))));
figure;plot(ones(size(normalized_gains_all_hyper_noisevhyper([1:3 5:end]))),normalized_gains_all_hyper_noisevhyper([1:3 5:end]),'.','LineWidth',3)
hold on;errorbar(1,normalized_mean_gains_hyper_noisevhyper,normalized_ste_gains_hyper_noisevhyper,'or','LineWidth',2)
title('Normalized Hyperpolarized with Noise Gains')
ylabel('Normalized Gain')
axis([0.9 1.1 0 140])
axis 'auto y'
set(gca, 'XTick', []);
[gainsttest_normalized_hyper_hyper_noise(1),gainsttest_normalized_hyper_hyper_noise(2)]=ttest(ones(size(normalized_gains_all_hyper_noisevhyper([1:3 5:end]))),normalized_gains_all_hyper_noisevhyper([1:3 5:end]));

% mean_resistance_hyper_noisevhyper=nanmean(resistance_all_hyper_noisevhyper);
% std_resistance_hyper_noisevhyper=nanstd(resistance_all_hyper_noisevhyper);
% mean_capacitance_hyper_noisevhyper=nanmean(capacitance_all_hyper_noisevhyper);
% std_capacitance_hyper_noisevhyper=nanstd(capacitance_all_hyper_noisevhyper);
% mean_tau_m_hyper_noisevhyper=nanmean(time_constant_all_hyper_noisevhyper);
% std_tau_m_hyper_noisevhyper=nanstd(time_constant_all_hyper_noisevhyper);
mean_imp_hyper_noisevhyper=nanmean(imp_all_hyper_noisevhyper);
std_imp_hyper_noisevhyper=nanstd(imp_all_hyper_noisevhyper);
mean_holdingvoltage_all_hyper_noisevhyper=nanmean(holdingvoltage_all_hyper_noisevhyper);
std_holdingvoltage_all_hyper_noisevhyper=nanstd(holdingvoltage_all_hyper_noisevhyper);
mean_std_noise_all_hyper_noisevhyper=nanmean(std_noise_all_hyper_noisevhyper);
std_std_noise_all_hyper_noisevhyper=nanstd(std_noise_all_hyper_noisevhyper);
mean_rate_hyper_noisevhyper=nanmean(rate_all_hyper_noisevhyper);
std_rate_hyper_noisevhyper=nanstd(rate_all_hyper_noisevhyper);
ste_rate_hyper_noisevhyper=std_rate_hyper_noisevhyper./sqrt(sum(~isnan(rate_all_hyper_noisevhyper)));

currents=0:10:200;
nlf_fi_hypervhypernoise=nlinfit(currents,mean_rate_hypervhypernoise,'sigFun',[320,50,10]);
nlf_fi_hyper_noisevhyper=nlinfit(currents,mean_rate_hyper_noisevhyper,'sigFun',[320,50,10]);

hypervhypernoise_max=nlf_fi_hypervhypernoise(1);
hypervhypernoise_midpoint=nlf_fi_hypervhypernoise(2);
hypervhypernoise_slope=nlf_fi_hypervhypernoise(1)/(4*nlf_fi_hypervhypernoise(3));
hyper_noisevhyper_max=nlf_fi_hyper_noisevhyper(1);
hyper_noisevhyper_midpoint=nlf_fi_hyper_noisevhyper(2);
hyper_noisevhyper_slope=nlf_fi_hyper_noisevhyper(1)/(4*nlf_fi_hyper_noisevhyper(3));

figure;errorbar([currents;currents]',[mean_rate_hypervhypernoise;mean_rate_hyper_noisevhyper]',[ste_rate_hypervhypernoise;ste_rate_hyper_noisevhyper]')
legend('Hyperpolarized','Hyperpolarized with Noise')
hold on;plot(currents,sigFun(nlf_fi_hypervhypernoise,currents),'m');plot(currents,sigFun(nlf_fi_hyper_noisevhyper,currents),'r')
title('Average f-I Curves for Hyperpolarized and Hyperpolarized with Noise')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% difference between rates (unpaired)
difference_rate_hypervhypernoise=rate_all_hyper_noisevhyper-rate_all_hypervhypernoise;
mean_difference_rate_hypervhypernoise=nanmean(difference_rate_hypervhypernoise);
std_difference_rate_hypervhypernoise=nanstd(difference_rate_hypervhypernoise);
ste_difference_rate_hypervhypernoise=std_difference_rate_hypervhypernoise./sqrt(sum(~isnan(difference_rate_hypervhypernoise)));

percent_difference_rate_hypervhypernoise=(difference_rate_hypervhypernoise./rate_all_hypervhypernoise)*100;
percent_difference_rate_hypervhypernoise(~isfinite(percent_difference_rate_hypervhypernoise))=NaN;
mean_percent_difference_rate_hypervhypernoise=nanmean(percent_difference_rate_hypervhypernoise);
std_percent_difference_rate_hypervhypernoise=nanstd(percent_difference_rate_hypervhypernoise);
ste_percent_difference_rate_hypervhypernoise=std_percent_difference_rate_hypervhypernoise./sqrt(sum(~isnan(percent_difference_rate_hypervhypernoise)));

new_percent_difference_rate_hypervhypernoise=difference_rate_hypervhypernoise./rate_all_hyper_noisevhyper;
new_percent_difference_rate_hypervhypernoise(~isfinite(new_percent_difference_rate_hypervhypernoise))=NaN;
mean_new_percent_difference_rate_hypervhypernoise=nanmean(new_percent_difference_rate_hypervhypernoise);
std_new_percent_difference_rate_hypervhypernoise=nanstd(new_percent_difference_rate_hypervhypernoise);
ste_new_percent_difference_rate_hypervhypernoise=std_new_percent_difference_rate_hypervhypernoise./sqrt(sum(~isnan(new_percent_difference_rate_hypervhypernoise)));

% difference between rates (paired) #####recount which trials are paired
% and which aren't
paired_difference_rate_hypervhypernoise=rate_all_hyper_noisevhyper([1 2 4 5 7 9:end],:)-rate_all_hypervhypernoise([1 2 4 5 7 9:end],:);
paired_mean_difference_rate_hypervhypernoise=nanmean(paired_difference_rate_hypervhypernoise);
paired_std_difference_rate_hypervhypernoise=nanstd(paired_difference_rate_hypervhypernoise);
paired_ste_difference_rate_hypervhypernoise=paired_std_difference_rate_hypervhypernoise./sqrt(sum(~isnan(paired_difference_rate_hypervhypernoise)));

paired_percent_difference_rate_hypervhypernoise=(paired_difference_rate_hypervhypernoise./rate_all_hypervhypernoise([1 2 4 5 7 9:end],:))*100;
paired_percent_difference_rate_hypervhypernoise(~isfinite(paired_percent_difference_rate_hypervhypernoise))=NaN;
paired_mean_percent_difference_rate_hypervhypernoise=nanmean(paired_percent_difference_rate_hypervhypernoise);
paired_std_percent_difference_rate_hypervhypernoise=nanstd(paired_percent_difference_rate_hypervhypernoise);
paired_ste_percent_difference_rate_hypervhypernoise=paired_std_percent_difference_rate_hypervhypernoise./sqrt(sum(~isnan(paired_percent_difference_rate_hypervhypernoise)));

paired_new_percent_difference_rate_hypervhypernoise=paired_difference_rate_hypervhypernoise./rate_all_hyper_noisevhyper([1 2 4 5 7 9:end],:);
paired_new_percent_difference_rate_hypervhypernoise(~isfinite(paired_new_percent_difference_rate_hypervhypernoise))=NaN;
paired_mean_new_percent_difference_rate_hypervhypernoise=nanmean(paired_new_percent_difference_rate_hypervhypernoise);
paired_std_new_percent_difference_rate_hypervhypernoise=nanstd(paired_new_percent_difference_rate_hypervhypernoise);
paired_ste_new_percent_difference_rate_hypervhypernoise=paired_std_new_percent_difference_rate_hypervhypernoise./sqrt(sum(~isnan(paired_new_percent_difference_rate_hypervhypernoise)));


%% Hyperpolarized (5 sec pulse, 1 sec pause; Currents go from 0:10:200)
% For Hyperpolarized with Negative Leak

dates_all_hypervhypernegativeleak={'Jan_07_15' 'Jan_13_15' 'Jan_14_15' 'Mar_17_15' 'Mar_18_15' 'Mar_23_15'...
    'Mar_23_15' 'Mar_24_15' 'Apr_07_15'};
cellnum_all_hypervhypernegativeleak={'B' 'A' 'A' 'A' 'A' 'B'...
    'C' 'B' 'D'};
trials_all_hypervhypernegativeleak=[1 1 1 1 5 1 ...
    1 3 3]';

for k=1:numel(dates_all_hypervhypernegativeleak)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_hypervhypernegativeleak{k} '_' cellnum_all_hypervhypernegativeleak{k} num2str(trials_all_hypervhypernegativeleak(k)) '_fi.mat;'])
    peakrate_all_hypervhypernegativeleak(k,:)=peakrate;
    nofailrate_all_hypervhypernegativeleak(k,:)=nofailrate;
    gains_all_hypervhypernegativeleak(k,1)=pf_all{1}.beta(2);
    rsq_all_hypervhypernegativeleak(k,1)=pf_all{1}.rsquare;
    rate_all_hypervhypernegativeleak(k,:)=rate_all{1};
    imp_all_hypervhypernegativeleak(k,:)=imp;
    holdingvoltage_all_hypervhypernegativeleak(k,:)=mean_holdingvoltage;
end

gains_all_hypervhypernegativeleak(isnan(rsq_all_hypervhypernegativeleak))=NaN; % filter out the gains that are NaNs

mean_peakrate_hypervhypernegativeleak=nanmean(peakrate_all_hypervhypernegativeleak);
std_peakrate_hypervhypernegativeleak=nanstd(peakrate_all_hypervhypernegativeleak);
mean_nofailrate_hypervhypernegativeleak=nanmean(nofailrate_all_hypervhypernegativeleak);
std_nofailrate_hypervhypernegativeleak=nanstd(nofailrate_all_hypervhypernegativeleak);
mean_gains_hypervhypernegativeleak=nanmean(gains_all_hypervhypernegativeleak);
std_gains_hypervhypernegativeleak=nanstd(gains_all_hypervhypernegativeleak);
ste_gains_hypervhypernegativeleak=std_gains_hypervhypernegativeleak/sqrt(sum(~isnan(gains_all_hypervhypernegativeleak)));
mean_imp_hypervhypernegativeleak=nanmean(imp_all_hypervhypernegativeleak);
std_imp_hypervhypernegativeleak=nanstd(imp_all_hypervhypernegativeleak);
mean_holdingvoltage_all_hypervhypernegativeleak=nanmean(holdingvoltage_all_hypervhypernegativeleak);
std_holdingvoltage_all_hypervhypernegativeleak=nanstd(holdingvoltage_all_hypervhypernegativeleak);
mean_rate_hypervhypernegativeleak=nanmean(rate_all_hypervhypernegativeleak);
std_rate_hypervhypernegativeleak=nanstd(rate_all_hypervhypernegativeleak);
ste_rate_hypervhypernegativeleak=std_rate_hypervhypernegativeleak./sqrt(sum(~isnan(rate_all_hypervhypernegativeleak)));


% Hyperpolarized with Negative Leak (Currents go from 5:5:100)
% For Hyperpolarized

dates_all_hyper_negative_leakvhyper={'Jan_07_15' 'Jan_13_15' 'Jan_14_15' 'Mar_17_15' 'Mar_18_15' 'Mar_23_15'...
    'Mar_23_15' 'Mar_24_15' 'Apr_07_15'};
cellnum_all_hyper_negative_leakvhyper={'B' 'A' 'A' 'A' 'A' 'B'...
    'C' 'B' 'D'};
trials_all_hyper_negative_leakvhyper=[4 3 3 7 9 7 ...
    5 6 6]';

for k=1:numel(dates_all_hyper_negative_leakvhyper)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_hyper_negative_leakvhyper{k} '_' cellnum_all_hyper_negative_leakvhyper{k} num2str(trials_all_hyper_negative_leakvhyper(k)) '_fi.mat;'])
    peakrate_all_hyper_negative_leakvhyper(k,:)=peakrate;
    nofailrate_all_hyper_negative_leakvhyper(k,:)=nofailrate;
    gains_all_hyper_negative_leakvhyper(k,1)=pf_all{1}.beta(2);
    rsq_all_hyper_negative_leakvhyper(k,1)=pf_all{1}.rsquare;
    rate_all_hyper_negative_leakvhyper(k,:)=rate_all{1};
    imp_all_hyper_negative_leakvhyper(k,:)=imp;
    holdingvoltage_all_hyper_negative_leakvhyper(k,:)=mean_holdingvoltage;
end

gains_all_hyper_negative_leakvhyper(isnan(rsq_all_hyper_negative_leakvhyper))=NaN; % filter out the gains that are NaNs

mean_peakrate_hyper_negative_leakvhyper=nanmean(peakrate_all_hyper_negative_leakvhyper);
std_peakrate_hyper_negative_leakvhyper=nanstd(peakrate_all_hyper_negative_leakvhyper);
mean_nofailrate_hyper_negative_leakvhyper=nanmean(nofailrate_all_hyper_negative_leakvhyper);
std_nofailrate_hyper_negative_leakvhyper=nanstd(nofailrate_all_hyper_negative_leakvhyper);
mean_gains_hyper_negative_leakvhyper=nanmean(gains_all_hyper_negative_leakvhyper);
std_gains_hyper_negative_leakvhyper=nanstd(gains_all_hyper_negative_leakvhyper);
ste_gains_hyper_negative_leakvhyper=std_gains_hyper_negative_leakvhyper/sqrt(sum(~isnan(gains_all_hyper_negative_leakvhyper)));
mean_imp_hyper_negative_leakvhyper=nanmean(imp_all_hyper_negative_leakvhyper);
std_imp_hyper_negative_leakvhyper=nanstd(imp_all_hyper_negative_leakvhyper);
mean_holdingvoltage_all_hyper_negative_leakvhyper=nanmean(holdingvoltage_all_hyper_negative_leakvhyper);
std_holdingvoltage_all_hyper_negative_leakvhyper=nanstd(holdingvoltage_all_hyper_negative_leakvhyper);
mean_rate_hyper_negative_leakvhyper=nanmean(rate_all_hyper_negative_leakvhyper);
std_rate_hyper_negative_leakvhyper=nanstd(rate_all_hyper_negative_leakvhyper);
ste_rate_hyper_negative_leakvhyper=std_rate_hyper_negative_leakvhyper./sqrt(sum(~isnan(rate_all_hyper_negative_leakvhyper)));

currents=0:10:200;
currents_negative_leak=0:5:100;
nlf_fi_hypervhypernegativeleak=nlinfit(currents,mean_rate_hypervhypernegativeleak,'sigFun',[320,50,10]);
nlf_fi_hyper_negative_leakvhyper=nlinfit(currents_negative_leak,mean_rate_hyper_negative_leakvhyper,'sigFun',[320,50,10]);

hypervhypernegativeleak_max=nlf_fi_hypervhypernegativeleak(1);
hypervhypernegativeleak_midpoint=nlf_fi_hypervhypernegativeleak(2);
hypervhypernegativeleak_slope=nlf_fi_hypervhypernegativeleak(1)/(4*nlf_fi_hypervhypernegativeleak(3));
hyper_negative_leakvhyper_max=nlf_fi_hyper_negative_leakvhyper(1);
hyper_negative_leakvhyper_midpoint=nlf_fi_hyper_negative_leakvhyper(2);
hyper_negative_leakvhyper_slope=nlf_fi_hyper_negative_leakvhyper(1)/(4*nlf_fi_hyper_negative_leakvhyper(3));

figure;errorbar([currents;currents_negative_leak]',[mean_rate_hypervhypernegativeleak;mean_rate_hyper_negative_leakvhyper]',[ste_rate_hypervhypernegativeleak;ste_rate_hyper_negative_leakvhyper]')
legend('Hyperpolarized','Hyperpolarized with Negative Leak (-3 nS)')
hold on;plot(currents,sigFun(nlf_fi_hypervhypernegativeleak,currents),'m');plot(currents_negative_leak,sigFun(nlf_fi_hyper_negative_leakvhyper,currents_negative_leak),'r')
title('Average f-I Curves for Hyperpolarized and Hyperpolarized with Negative Leak (-3 nS)')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% difference between rates
difference_rate_hypervhypernegativeleak=rate_all_hyper_negative_leakvhyper-rate_all_hypervhypernegativeleak;
mean_difference_rate_hypervhypernegativeleak=nanmean(difference_rate_hypervhypernegativeleak);
std_difference_rate_hypervhypernegativeleak=nanstd(difference_rate_hypervhypernegativeleak);
ste_difference_rate_hypervhypernegativeleak=std_difference_rate_hypervhypernegativeleak./sqrt(sum(~isnan(difference_rate_hypervhypernegativeleak)));


%% Hyperpolarized (5 sec pulse, 1 sec pause; Currents go from 0:10:200)
% For Hyperpolarized with Current Subtracted

dates_all_hypervhypercurrentsubtracted={'Oct_30_14' 'Nov_26_14' 'Dec_08_14' 'Dec_19_14' 'Dec_22_14' 'Dec_22_14'...
    'Dec_22_14' 'Dec_23_14' 'Dec_23_14' 'Dec_23_14'};
cellnum_all_hypervhypercurrentsubtracted={'A' 'A' 'A' 'A' 'B' 'C'...
    'D' 'A' 'B' 'C'};
trials_all_hypervhypercurrentsubtracted=[1 1 1 1 1 1 ...
    3 1 1 1]';

for k=1:numel(dates_all_hypervhypercurrentsubtracted)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_hypervhypercurrentsubtracted{k} '_' cellnum_all_hypervhypercurrentsubtracted{k} num2str(trials_all_hypervhypercurrentsubtracted(k)) '_fi.mat;'])
    peakrate_all_hypervhypercurrentsubtracted(k,:)=peakrate;
    nofailrate_all_hypervhypercurrentsubtracted(k,:)=nofailrate;
    gains_all_hypervhypercurrentsubtracted(k,1)=pf_all{1}.beta(2);
    rsq_all_hypervhypercurrentsubtracted(k,1)=pf_all{1}.rsquare;
    rate_all_hypervhypercurrentsubtracted(k,:)=rate_all{1};
    imp_all_hypervhypercurrentsubtracted(k,:)=imp;
    holdingvoltage_all_hypervhypercurrentsubtracted(k,:)=mean_holdingvoltage;
end

gains_all_hypervhypercurrentsubtracted(isnan(rsq_all_hypervhypercurrentsubtracted))=NaN; % filter out the gains that are NaNs

mean_peakrate_hypervhypercurrentsubtracted=nanmean(peakrate_all_hypervhypercurrentsubtracted);
std_peakrate_hypervhypercurrentsubtracted=nanstd(peakrate_all_hypervhypercurrentsubtracted);
mean_nofailrate_hypervhypercurrentsubtracted=nanmean(nofailrate_all_hypervhypercurrentsubtracted);
std_nofailrate_hypervhypercurrentsubtracted=nanstd(nofailrate_all_hypervhypercurrentsubtracted);
mean_gains_hypervhypercurrentsubtracted=nanmean(gains_all_hypervhypercurrentsubtracted);
std_gains_hypervhypercurrentsubtracted=nanstd(gains_all_hypervhypercurrentsubtracted);
ste_gains_hypervhypercurrentsubtracted=std_gains_hypervhypercurrentsubtracted/sqrt(sum(~isnan(gains_all_hypervhypercurrentsubtracted)));
mean_imp_hypervhypercurrentsubtracted=nanmean(imp_all_hypervhypercurrentsubtracted);
std_imp_hypervhypercurrentsubtracted=nanstd(imp_all_hypervhypercurrentsubtracted);
mean_holdingvoltage_all_hypervhypercurrentsubtracted=nanmean(holdingvoltage_all_hypervhypercurrentsubtracted);
std_holdingvoltage_all_hypervhypercurrentsubtracted=nanstd(holdingvoltage_all_hypervhypercurrentsubtracted);
mean_rate_hypervhypercurrentsubtracted=nanmean(rate_all_hypervhypercurrentsubtracted);
std_rate_hypervhypercurrentsubtracted=nanstd(rate_all_hypervhypercurrentsubtracted);
ste_rate_hypervhypercurrentsubtracted=std_rate_hypervhypercurrentsubtracted./sqrt(sum(~isnan(rate_all_hypervhypercurrentsubtracted)));


% Hyperpolarized with Current Subtracted (Currents go from 0:10:200)
% For Hyperpolarized

dates_all_hyper_current_subtractedvhyper={'Oct_30_14' 'Nov_26_14' 'Dec_08_14' 'Dec_19_14' 'Dec_22_14' 'Dec_22_14'...
    'Dec_22_14' 'Dec_23_14' 'Dec_23_14' 'Dec_23_14'};
cellnum_all_hyper_current_subtractedvhyper={'A' 'A' 'A' 'A' 'B' 'C'...
    'D' 'A' 'B' 'C'};
trials_all_hyper_current_subtractedvhyper=[5 6 3 3 4 3 ...
    6 4 3 3]';

for k=1:numel(dates_all_hyper_current_subtractedvhyper)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_hyper_current_subtractedvhyper{k} '_' cellnum_all_hyper_current_subtractedvhyper{k} num2str(trials_all_hyper_current_subtractedvhyper(k)) '_fi.mat;'])
    peakrate_all_hyper_current_subtractedvhyper(k,:)=peakrate;
    nofailrate_all_hyper_current_subtractedvhyper(k,:)=nofailrate;
    gains_all_hyper_current_subtractedvhyper(k,1)=pf_all{1}.beta(2);
    rsq_all_hyper_current_subtractedvhyper(k,1)=pf_all{1}.rsquare;
    rate_all_hyper_current_subtractedvhyper(k,:)=rate_all{1};
    imp_all_hyper_current_subtractedvhyper(k,:)=imp;
    holdingvoltage_all_hyper_current_subtractedvhyper(k,:)=mean_holdingvoltage;
end

gains_all_hyper_current_subtractedvhyper(isnan(rsq_all_hyper_current_subtractedvhyper))=NaN; % filter out the gains that are NaNs

mean_peakrate_hyper_current_subtractedvhyper=nanmean(peakrate_all_hyper_current_subtractedvhyper);
std_peakrate_hyper_current_subtractedvhyper=nanstd(peakrate_all_hyper_current_subtractedvhyper);
mean_nofailrate_hyper_current_subtractedvhyper=nanmean(nofailrate_all_hyper_current_subtractedvhyper);
std_nofailrate_hyper_current_subtractedvhyper=nanstd(nofailrate_all_hyper_current_subtractedvhyper);
mean_gains_hyper_current_subtractedvhyper=nanmean(gains_all_hyper_current_subtractedvhyper);
std_gains_hyper_current_subtractedvhyper=nanstd(gains_all_hyper_current_subtractedvhyper);
ste_gains_hyper_current_subtractedvhyper=std_gains_hyper_current_subtractedvhyper/sqrt(sum(~isnan(gains_all_hyper_current_subtractedvhyper)));
mean_imp_hyper_current_subtractedvhyper=nanmean(imp_all_hyper_current_subtractedvhyper);
std_imp_hyper_current_subtractedvhyper=nanstd(imp_all_hyper_current_subtractedvhyper);
mean_holdingvoltage_all_hyper_current_subtractedvhyper=nanmean(holdingvoltage_all_hyper_current_subtractedvhyper);
std_holdingvoltage_all_hyper_current_subtractedvhyper=nanstd(holdingvoltage_all_hyper_current_subtractedvhyper);
mean_rate_hyper_current_subtractedvhyper=nanmean(rate_all_hyper_current_subtractedvhyper);
std_rate_hyper_current_subtractedvhyper=nanstd(rate_all_hyper_current_subtractedvhyper);
ste_rate_hyper_current_subtractedvhyper=std_rate_hyper_current_subtractedvhyper./sqrt(sum(~isnan(rate_all_hyper_current_subtractedvhyper)));

currents=0:10:200;
nlf_fi_hypervhypercurrentsubtracted=nlinfit(currents,mean_rate_hypervhypercurrentsubtracted,'sigFun',[320,50,10]);
nlf_fi_hyper_current_subtractedvhyper=nlinfit(currents,mean_rate_hyper_current_subtractedvhyper,'sigFun',[320,50,10]);

hypervhypercurrentsubtracted_max=nlf_fi_hypervhypercurrentsubtracted(1);
hypervhypercurrentsubtracted_midpoint=nlf_fi_hypervhypercurrentsubtracted(2);
hypervhypercurrentsubtracted_slope=nlf_fi_hypervhypercurrentsubtracted(1)/(4*nlf_fi_hypervhypercurrentsubtracted(3));
hyper_current_subtractedvhyper_max=nlf_fi_hyper_current_subtractedvhyper(1);
hyper_current_subtractedvhyper_midpoint=nlf_fi_hyper_current_subtractedvhyper(2);
hyper_current_subtractedvhyper_slope=nlf_fi_hyper_current_subtractedvhyper(1)/(4*nlf_fi_hyper_current_subtractedvhyper(3));

figure;errorbar([currents;currents]',[mean_rate_hypervhypercurrentsubtracted;mean_rate_hyper_current_subtractedvhyper]',[ste_rate_hypervhypercurrentsubtracted;ste_rate_hyper_current_subtractedvhyper]')
legend('Hyperpolarized','Hyperpolarized with Current Subtracted')
hold on;plot(currents,sigFun(nlf_fi_hypervhypercurrentsubtracted,currents),'m');plot(currents,sigFun(nlf_fi_hyper_current_subtractedvhyper,currents),'r')
title('Average f-I Curves for Hyperpolarized and Hyperpolarized with Current Subtracted')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% difference between rates
difference_rate_hypervhypercurrentsubtracted=rate_all_hyper_current_subtractedvhyper-rate_all_hypervhypercurrentsubtracted;
mean_difference_rate_hypervhypercurrentsubtracted=nanmean(difference_rate_hypervhypercurrentsubtracted);
std_difference_rate_hypervhypercurrentsubtracted=nanstd(difference_rate_hypervhypercurrentsubtracted);
ste_difference_rate_hypervhypercurrentsubtracted=std_difference_rate_hypervhypercurrentsubtracted./sqrt(sum(~isnan(difference_rate_hypervhypercurrentsubtracted)));


%% Depolarized (5 sec pulse, 1 sec pause; 200 pA range of currents)
% For Depolarized with Leak

dates_all_devdeleak={'Oct_28_14' 'Oct_30_14' 'Oct_30_14' 'Nov_26_14' 'Jan_07_15' 'Jan_07_15'...
    'Mar_17_15' 'Mar_18_15' 'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15'...
    'Apr_06_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15'};
cellnum_all_devdeleak={'A' 'A' 'B' 'A' 'A' 'B'...
    'A' 'A' 'B' 'B' 'E' 'B'...
    'B' 'A' 'C' 'D'};
trials_all_devdeleak=[2 2 2 2 2 2 ...
    1 5 3 2 2 4 ...
    6 6 6 4]';

for k=1:numel(dates_all_devdeleak)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_devdeleak{k} '_' cellnum_all_devdeleak{k} num2str(trials_all_devdeleak(k)) '_fi.mat;'])
    peakrate_all_devdeleak(k,:)=peakrate;
    nofailrate_all_devdeleak(k,:)=nofailrate;
    gains_all_devdeleak(k,1)=pf_all{1}.beta(2);
    rsq_all_devdeleak(k,1)=pf_all{1}.rsquare;
    rate_all_devdeleak(k,:)=rate_all{1};
    imp_all_devdeleak(k,:)=imp;
    holdingvoltage_all_devdeleak(k,:)=mean_holdingvoltage;
end

gains_all_devdeleak(isnan(rsq_all_devdeleak))=NaN; % filter out the gains that are NaNs

mean_peakrate_devdeleak=nanmean(peakrate_all_devdeleak);
std_peakrate_devdeleak=nanstd(peakrate_all_devdeleak);
mean_nofailrate_devdeleak=nanmean(nofailrate_all_devdeleak);
std_nofailrate_devdeleak=nanstd(nofailrate_all_devdeleak);
mean_gains_devdeleak=nanmean(gains_all_devdeleak);
std_gains_devdeleak=nanstd(gains_all_devdeleak);
ste_gains_devdeleak=std_gains_devdeleak/sqrt(sum(~isnan(gains_all_devdeleak)));
mean_imp_devdeleak=nanmean(imp_all_devdeleak);
std_imp_devdeleak=nanstd(imp_all_devdeleak);
mean_holdingvoltage_all_devdeleak=nanmean(holdingvoltage_all_devdeleak);
std_holdingvoltage_all_devdeleak=nanstd(holdingvoltage_all_devdeleak);
mean_rate_devdeleak=nanmean(rate_all_devdeleak);
std_rate_devdeleak=nanstd(rate_all_devdeleak);
ste_rate_devdeleak=std_rate_devdeleak./sqrt(sum(~isnan(rate_all_devdeleak)));


% Depolarized with Leak (400 pA range of currents)
% For Depolarized
% Justification for 3 nS Leak: 1/200e6; ans+3e-9; 1/ans; ans/1e6

dates_all_de_leakvde={'Oct_28_14' 'Oct_30_14' 'Oct_30_14' 'Nov_26_14' 'Jan_07_15' 'Jan_07_15'...
    'Mar_17_15' 'Mar_18_15' 'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15'...
    'Apr_06_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15'};
cellnum_all_de_leakvde={'A' 'A' 'B' 'A' 'A' 'B'...
    'A' 'A' 'B' 'B' 'E' 'B'...
    'B' 'A' 'C' 'D'};
trials_all_de_leakvde=[3 3 3 3 3 3 ...
    5 7 5 6 3 5 ...
    7 7 7 5]';

for k=1:numel(dates_all_de_leakvde)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_de_leakvde{k} '_' cellnum_all_de_leakvde{k} num2str(trials_all_de_leakvde(k)) '_fi.mat;'])
    peakrate_all_de_leakvde(k,:)=peakrate;
    nofailrate_all_de_leakvde(k,:)=nofailrate;
    gains_all_de_leakvde(k,1)=pf_all{1}.beta(2);
    rsq_all_de_leakvde(k,1)=pf_all{1}.rsquare;
    rate_all_de_leakvde(k,:)=rate_all{1};
    imp_all_de_leakvde(k,:)=imp;
    holdingvoltage_all_de_leakvde(k,:)=mean_holdingvoltage;
end

gains_all_de_leakvde(isnan(rsq_all_de_leakvde))=NaN; % filter out the gains that are NaNs

mean_peakrate_de_leakvde=nanmean(peakrate_all_de_leakvde);
std_peakrate_de_leakvde=nanstd(peakrate_all_de_leakvde);
mean_nofailrate_de_leakvde=nanmean(nofailrate_all_de_leakvde);
std_nofailrate_de_leakvde=nanstd(nofailrate_all_de_leakvde);
mean_gains_de_leakvde=nanmean(gains_all_de_leakvde);
std_gains_de_leakvde=nanstd(gains_all_de_leakvde);
ste_gains_de_leakvde=std_gains_de_leakvde/sqrt(sum(~isnan(gains_all_de_leakvde)));
mean_imp_de_leakvde=nanmean(imp_all_de_leakvde);
std_imp_de_leakvde=nanstd(imp_all_de_leakvde);
mean_holdingvoltage_all_de_leakvde=nanmean(holdingvoltage_all_de_leakvde);
std_holdingvoltage_all_de_leakvde=nanstd(holdingvoltage_all_de_leakvde);
mean_rate_de_leakvde=nanmean(rate_all_de_leakvde);
std_rate_de_leakvde=nanstd(rate_all_de_leakvde);
ste_rate_de_leakvde=std_rate_de_leakvde./sqrt(sum(~isnan(rate_all_de_leakvde)));

currents=0:10:200;
currents_leak=0:20:400;
nlf_fi_devdeleak=nlinfit(currents,mean_rate_devdeleak,'sigFun',[320,50,10]);
nlf_fi_de_leakvde=nlinfit(currents_leak,mean_rate_de_leakvde,'sigFun',[320,50,10]);

devdeleak_max=nlf_fi_devdeleak(1);
devdeleak_midpoint=nlf_fi_devdeleak(2);
devdeleak_slope=nlf_fi_devdeleak(1)/(4*nlf_fi_devdeleak(3));
de_leakvde_max=nlf_fi_de_leakvde(1);
de_leakvde_midpoint=nlf_fi_de_leakvde(2);
de_leakvde_slope=nlf_fi_de_leakvde(1)/(4*nlf_fi_de_leakvde(3));

figure;errorbar([currents;currents_leak]',[mean_rate_devdeleak;mean_rate_de_leakvde]',[ste_rate_devdeleak;ste_rate_de_leakvde]')
legend('Depolarized','Depolarized with Leak (3 nS)')
hold on;plot(currents,sigFun(nlf_fi_devdeleak,currents),'m');plot(currents_leak,sigFun(nlf_fi_de_leakvde,currents_leak),'r')
title('Average f-I Curves for Depolarized and Depolarized with Leak (3 nS)')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% difference between rates
difference_rate_devdeleak=rate_all_de_leakvde-rate_all_devdeleak;
mean_difference_rate_devdeleak=nanmean(difference_rate_devdeleak);
std_difference_rate_devdeleak=nanstd(difference_rate_devdeleak);
ste_difference_rate_devdeleak=std_difference_rate_devdeleak./sqrt(sum(~isnan(difference_rate_devdeleak)));


%% Depolarized (5 sec pulse, 1 sec pause; 200 pA range of currents)
% For Depolarized with Just Noise

% % These are the 1 sec pulse, 1 sec pauses
% dates_all_devdenoise={'Oct_14_14' 'Oct_14_14'};
% cellnum_all_devdenoise={'A' 'B'};
% trials_all_devdenoise=[2 2]';

% % Unpaired with hyperpolarized data (haven't looked at the quality of this data yet)
% dates_all_devdenoise={'Jan_27_15' 'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15'...
%     'Feb_10_15' 'Mar_03_15' 'Mar_06_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15'...
%     'Mar_10_15' 'Mar_11_15'};
% cellnum_all_devdenoise={'A' 'B' 'A' 'B' 'C' 'B'...
%     'C' 'A' 'A' 'A' 'B' 'C'...
%     'D' 'B'};
% trials_all_devdenoise=[2 2 2 2 2 2 ...
%     2 2 2 4 2 2 ...
%     2 2]';

% Paired with hyperpolarized data only
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

for k=1:numel(dates_all_devdenoise)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_devdenoise{k} '_' cellnum_all_devdenoise{k} num2str(trials_all_devdenoise(k)) '_fi.mat;'])
    peakrate_all_devdenoise(k,:)=peakrate;
    nofailrate_all_devdenoise(k,:)=nofailrate;
    gains_all_devdenoise(k,1)=pf_all{1}.beta(2);
    rsq_all_devdenoise(k,1)=pf_all{1}.rsquare;
    rate_all_devdenoise(k,:)=rate_all{1};
    imp_all_devdenoise(k,:)=imp;
    holdingvoltage_all_devdenoise(k,:)=mean_holdingvoltage;
    std_noise_all_devdenoise(k)=std_noise;
    mean_spikeform_all_devdenoise(k,:)=mean_spikeform;
    mean_freq0_outputforms_increment_all_devdenoise(k,:)=mean_freq0_outputforms_increment;
    mean_freq0_spikeforms_increment_all_devdenoise(k,:)=mean_freq0_spikeforms_increment;
    mean_freq1_outputforms_increment_all_devdenoise(k,:)=mean_freq1_outputforms_increment;
    mean_freq1_spikeforms_increment_all_devdenoise(k,:)=mean_freq1_spikeforms_increment;
    mean_freq2_outputforms_increment_all_devdenoise(k,:)=mean_freq2_outputforms_increment;
    mean_freq2_spikeforms_increment_all_devdenoise(k,:)=mean_freq2_spikeforms_increment;
    mean_freq3_outputforms_increment_all_devdenoise(k,:)=mean_freq3_outputforms_increment;
    mean_freq3_spikeforms_increment_all_devdenoise(k,:)=mean_freq3_spikeforms_increment;
    mean_freq4_outputforms_increment_all_devdenoise(k,:)=mean_freq4_outputforms_increment;
    mean_freq4_spikeforms_increment_all_devdenoise(k,:)=mean_freq4_spikeforms_increment;
    mean_freq5_outputforms_increment_all_devdenoise(k,:)=mean_freq5_outputforms_increment;
    mean_freq5_spikeforms_increment_all_devdenoise(k,:)=mean_freq5_spikeforms_increment;
    mean_freq6_outputforms_increment_all_devdenoise(k,:)=mean_freq6_outputforms_increment;
    mean_freq6_spikeforms_increment_all_devdenoise(k,:)=mean_freq6_spikeforms_increment;
    mean_freq7_outputforms_increment_all_devdenoise(k,:)=mean_freq7_outputforms_increment;
    mean_freq7_spikeforms_increment_all_devdenoise(k,:)=mean_freq7_spikeforms_increment;
    mean_freq8_outputforms_increment_all_devdenoise(k,:)=mean_freq8_outputforms_increment;
    mean_freq8_spikeforms_increment_all_devdenoise(k,:)=mean_freq8_spikeforms_increment;
    mean_freq9_outputforms_increment_all_devdenoise(k,:)=mean_freq9_outputforms_increment;
    mean_freq9_spikeforms_increment_all_devdenoise(k,:)=mean_freq9_spikeforms_increment;
    mean_freq10_outputforms_increment_all_devdenoise(k,:)=mean_freq10_outputforms_increment;
    mean_freq10_spikeforms_increment_all_devdenoise(k,:)=mean_freq10_spikeforms_increment;
    mean_lastspikeforms_increment_all_devdenoise(k,:)=mean_lastspikeforms_increment;
    mean_lastoutputforms_increment_all_devdenoise(k,:)=mean_lastoutputforms_increment;
end

mean_freq0_outputforms_devdenoise=nanmean(mean_freq0_outputforms_increment_all_devdenoise);
mean_freq0_spikeforms_devdenoise=nanmean(mean_freq0_spikeforms_increment_all_devdenoise);
std_freq0_outputforms_devdenoise=nanstd(mean_freq0_outputforms_increment_all_devdenoise);
std_freq0_spikeforms_devdenoise=nanstd(mean_freq0_spikeforms_increment_all_devdenoise);
ste_freq0_outputforms_devdenoise=std_freq0_outputforms_devdenoise/sqrt(sum(~isnan(mean_freq0_outputforms_increment_all_devdenoise)));
ste_freq0_spikeforms_devdenoise=std_freq0_spikeforms_devdenoise/sqrt(sum(~isnan(mean_freq0_spikeforms_increment_all_devdenoise)));
mean_freq1_outputforms_devdenoise=nanmean(mean_freq1_outputforms_increment_all_devdenoise);
mean_freq1_spikeforms_devdenoise=nanmean(mean_freq1_spikeforms_increment_all_devdenoise);
std_freq1_outputforms_devdenoise=nanstd(mean_freq1_outputforms_increment_all_devdenoise);
std_freq1_spikeforms_devdenoise=nanstd(mean_freq1_spikeforms_increment_all_devdenoise);
ste_freq1_outputforms_devdenoise=std_freq1_outputforms_devdenoise/sqrt(sum(~isnan(mean_freq1_outputforms_increment_all_devdenoise)));
ste_freq1_spikeforms_devdenoise=std_freq1_spikeforms_devdenoise/sqrt(sum(~isnan(mean_freq1_spikeforms_increment_all_devdenoise)));
mean_freq2_outputforms_devdenoise=nanmean(mean_freq2_outputforms_increment_all_devdenoise);
mean_freq2_spikeforms_devdenoise=nanmean(mean_freq2_spikeforms_increment_all_devdenoise);
std_freq2_outputforms_devdenoise=nanstd(mean_freq2_outputforms_increment_all_devdenoise);
std_freq2_spikeforms_devdenoise=nanstd(mean_freq2_spikeforms_increment_all_devdenoise);
ste_freq2_outputforms_devdenoise=std_freq2_outputforms_devdenoise/sqrt(sum(~isnan(mean_freq2_outputforms_increment_all_devdenoise)));
ste_freq2_spikeforms_devdenoise=std_freq2_spikeforms_devdenoise/sqrt(sum(~isnan(mean_freq2_spikeforms_increment_all_devdenoise)));
mean_freq3_outputforms_devdenoise=nanmean(mean_freq3_outputforms_increment_all_devdenoise);
mean_freq3_spikeforms_devdenoise=nanmean(mean_freq3_spikeforms_increment_all_devdenoise);
std_freq3_outputforms_devdenoise=nanstd(mean_freq3_outputforms_increment_all_devdenoise);
std_freq3_spikeforms_devdenoise=nanstd(mean_freq3_spikeforms_increment_all_devdenoise);
ste_freq3_outputforms_devdenoise=std_freq3_outputforms_devdenoise/sqrt(sum(~isnan(mean_freq3_outputforms_increment_all_devdenoise)));
ste_freq3_spikeforms_devdenoise=std_freq3_spikeforms_devdenoise/sqrt(sum(~isnan(mean_freq3_spikeforms_increment_all_devdenoise)));
mean_freq4_outputforms_devdenoise=nanmean(mean_freq4_outputforms_increment_all_devdenoise);
mean_freq4_spikeforms_devdenoise=nanmean(mean_freq4_spikeforms_increment_all_devdenoise);
std_freq4_outputforms_devdenoise=nanstd(mean_freq4_outputforms_increment_all_devdenoise);
std_freq4_spikeforms_devdenoise=nanstd(mean_freq4_spikeforms_increment_all_devdenoise);
ste_freq4_outputforms_devdenoise=std_freq4_outputforms_devdenoise/sqrt(sum(~isnan(mean_freq4_outputforms_increment_all_devdenoise)));
ste_freq4_spikeforms_devdenoise=std_freq4_spikeforms_devdenoise/sqrt(sum(~isnan(mean_freq4_spikeforms_increment_all_devdenoise)));
mean_freq5_outputforms_devdenoise=nanmean(mean_freq5_outputforms_increment_all_devdenoise);
mean_freq5_spikeforms_devdenoise=nanmean(mean_freq5_spikeforms_increment_all_devdenoise);
std_freq5_outputforms_devdenoise=nanstd(mean_freq5_outputforms_increment_all_devdenoise);
std_freq5_spikeforms_devdenoise=nanstd(mean_freq5_spikeforms_increment_all_devdenoise);
ste_freq5_outputforms_devdenoise=std_freq5_outputforms_devdenoise/sqrt(sum(~isnan(mean_freq5_outputforms_increment_all_devdenoise)));
ste_freq5_spikeforms_devdenoise=std_freq5_spikeforms_devdenoise/sqrt(sum(~isnan(mean_freq5_spikeforms_increment_all_devdenoise)));
mean_freq6_outputforms_devdenoise=nanmean(mean_freq6_outputforms_increment_all_devdenoise);
mean_freq6_spikeforms_devdenoise=nanmean(mean_freq6_spikeforms_increment_all_devdenoise);
std_freq6_outputforms_devdenoise=nanstd(mean_freq6_outputforms_increment_all_devdenoise);
std_freq6_spikeforms_devdenoise=nanstd(mean_freq6_spikeforms_increment_all_devdenoise);
ste_freq6_outputforms_devdenoise=std_freq6_outputforms_devdenoise/sqrt(sum(~isnan(mean_freq6_outputforms_increment_all_devdenoise)));
ste_freq6_spikeforms_devdenoise=std_freq6_spikeforms_devdenoise/sqrt(sum(~isnan(mean_freq6_spikeforms_increment_all_devdenoise)));
mean_freq7_outputforms_devdenoise=nanmean(mean_freq7_outputforms_increment_all_devdenoise);
mean_freq7_spikeforms_devdenoise=nanmean(mean_freq7_spikeforms_increment_all_devdenoise);
std_freq7_outputforms_devdenoise=nanstd(mean_freq7_outputforms_increment_all_devdenoise);
std_freq7_spikeforms_devdenoise=nanstd(mean_freq7_spikeforms_increment_all_devdenoise);
ste_freq7_outputforms_devdenoise=std_freq7_outputforms_devdenoise/sqrt(sum(~isnan(mean_freq7_outputforms_increment_all_devdenoise)));
ste_freq7_spikeforms_devdenoise=std_freq7_spikeforms_devdenoise/sqrt(sum(~isnan(mean_freq7_spikeforms_increment_all_devdenoise)));
mean_freq8_outputforms_devdenoise=nanmean(mean_freq8_outputforms_increment_all_devdenoise);
mean_freq8_spikeforms_devdenoise=nanmean(mean_freq8_spikeforms_increment_all_devdenoise);
std_freq8_outputforms_devdenoise=nanstd(mean_freq8_outputforms_increment_all_devdenoise);
std_freq8_spikeforms_devdenoise=nanstd(mean_freq8_spikeforms_increment_all_devdenoise);
ste_freq8_outputforms_devdenoise=std_freq8_outputforms_devdenoise/sqrt(sum(~isnan(mean_freq8_outputforms_increment_all_devdenoise)));
ste_freq8_spikeforms_devdenoise=std_freq8_spikeforms_devdenoise/sqrt(sum(~isnan(mean_freq8_spikeforms_increment_all_devdenoise)));
mean_freq9_outputforms_devdenoise=nanmean(mean_freq9_outputforms_increment_all_devdenoise);
mean_freq9_spikeforms_devdenoise=nanmean(mean_freq9_spikeforms_increment_all_devdenoise);
std_freq9_outputforms_devdenoise=nanstd(mean_freq9_outputforms_increment_all_devdenoise);
std_freq9_spikeforms_devdenoise=nanstd(mean_freq9_spikeforms_increment_all_devdenoise);
ste_freq9_outputforms_devdenoise=std_freq9_outputforms_devdenoise/sqrt(sum(~isnan(mean_freq9_outputforms_increment_all_devdenoise)));
ste_freq9_spikeforms_devdenoise=std_freq9_spikeforms_devdenoise/sqrt(sum(~isnan(mean_freq9_spikeforms_increment_all_devdenoise)));
mean_freq10_outputforms_devdenoise=nanmean(mean_freq10_outputforms_increment_all_devdenoise);
mean_freq10_spikeforms_devdenoise=nanmean(mean_freq10_spikeforms_increment_all_devdenoise);
std_freq10_outputforms_devdenoise=nanstd(mean_freq10_outputforms_increment_all_devdenoise);
std_freq10_spikeforms_devdenoise=nanstd(mean_freq10_spikeforms_increment_all_devdenoise);
ste_freq10_outputforms_devdenoise=std_freq10_outputforms_devdenoise/sqrt(sum(~isnan(mean_freq10_outputforms_increment_all_devdenoise)));
ste_freq10_spikeforms_devdenoise=std_freq10_spikeforms_devdenoise/sqrt(sum(~isnan(mean_freq10_spikeforms_increment_all_devdenoise)));

mean_lastspikeforms_devdenoise=nanmean(mean_lastspikeforms_increment_all_devdenoise);
std_lastspikeforms_devdenoise=nanstd(mean_lastspikeforms_increment_all_devdenoise);
ste_lastspikeforms_devdenoise=std_lastspikeforms_devdenoise/sqrt(sum(~isnan(mean_lastspikeforms_increment_all_devdenoise)));
mean_lastoutputforms_devdenoise=nanmean(mean_lastoutputforms_increment_all_devdenoise);
std_lastoutputforms_devdenoise=nanstd(mean_lastoutputforms_increment_all_devdenoise);
ste_lastoutputforms_devdenoise=std_lastoutputforms_devdenoise/sqrt(sum(~isnan(mean_lastoutputforms_increment_all_devdenoise)));

gains_all_devdenoise(isnan(rsq_all_devdenoise))=NaN; % filter out the gains that are NaNs

mean_peakrate_devdenoise=nanmean(peakrate_all_devdenoise);
std_peakrate_devdenoise=nanstd(peakrate_all_devdenoise);
mean_nofailrate_devdenoise=nanmean(nofailrate_all_devdenoise);
std_nofailrate_devdenoise=nanstd(nofailrate_all_devdenoise);
mean_gains_devdenoise=nanmean(gains_all_devdenoise);
std_gains_devdenoise=nanstd(gains_all_devdenoise);
ste_gains_devdenoise=std_gains_devdenoise/sqrt(sum(~isnan(gains_all_devdenoise)));
mean_imp_devdenoise=nanmean(imp_all_devdenoise);
std_imp_devdenoise=nanstd(imp_all_devdenoise);
mean_holdingvoltage_all_devdenoise=nanmean(holdingvoltage_all_devdenoise);
std_holdingvoltage_all_devdenoise=nanstd(holdingvoltage_all_devdenoise);
mean_std_noise_all_devdenoise=nanmean(std_noise_all_devdenoise);
std_std_noise_all_devdenoise=nanstd(std_noise_all_devdenoise);
mean_rate_devdenoise=nanmean(rate_all_devdenoise);
std_rate_devdenoise=nanstd(rate_all_devdenoise);
ste_rate_devdenoise=std_rate_devdenoise./sqrt(sum(~isnan(rate_all_devdenoise)));


% Depolarized with Just Noise (200 pA range of currents)
% For Depolarized

% % These are the 1 sec pulse, 1 sec pauses
% dates_all_de_noisevde={'Oct_14_14' 'Oct_14_14'};
% cellnum_all_de_noisevde={'A' 'B'};
% trials_all_de_noisevde=[3 2]';

% % Unpaired with hyperpolarized data (haven't looked at the quality of this data yet)
% dates_all_de_noisevde={'Jan_27_15' 'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15'...
%     'Feb_10_15' 'Mar_03_15' 'Mar_06_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15'...
%     'Mar_10_15' 'Mar_11_15'};
% cellnum_all_de_noisevde={'A' 'B' 'A' 'B' 'C' 'B'...
%     'C' 'A' 'A' 'A' 'B' 'C'...
%     'D' 'B'};
% trials_all_de_noisevde=[4 4 2 2 2 2 ...
%     2 2 2 4 2 2 ...
%     2 2]';

% Paired with hyperpolarized data only
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

sub_currents_de_noisevde_all=NaN(numel(dates_all_de_noisevde),21);
sub_noise_de_noisevde=NaN(numel(dates_all_de_noisevde),21);
sup_currents_de_noisevde_all=NaN(numel(dates_all_de_noisevde),21);
sup_noise_de_noisevde=NaN(numel(dates_all_de_noisevde),21);

for k=1:numel(dates_all_de_noisevde)
    eval(['load ' pwd '\fi_analysis\FI_OU_' dates_all_de_noisevde{k} '_' cellnum_all_de_noisevde{k} num2str(trials_all_de_noisevde(k)) '_fi.mat;'])
    peakrate_all_de_noisevde(k,:)=peakrate;
    nofailrate_all_de_noisevde(k,:)=nofailrate;
    gains_all_de_noisevde(k,1)=pf_all{1}.beta(2);
    rsq_all_de_noisevde(k,1)=pf_all{1}.rsquare;
    rate_all_de_noisevde(k,:)=rate_all{1};
    imp_all_de_noisevde(k,:)=imp;
    holdingvoltage_all_de_noisevde(k,:)=mean_holdingvoltage;
    std_noise_all_de_noisevde(k)=std_noise;
    mean_spikeform_all_de_noisevde(k,:)=mean_spikeform;
    mean_freq0_Isynforms_increment_all_de_noisevde(k,:)=mean_freq0_Isynforms_increment;
    mean_freq0_spikeforms_increment_all_de_noisevde(k,:)=mean_freq0_spikeforms_increment;
    mean_freq1_Isynforms_increment_all_de_noisevde(k,:)=mean_freq1_Isynforms_increment;
    mean_freq1_spikeforms_increment_all_de_noisevde(k,:)=mean_freq1_spikeforms_increment;
    mean_freq2_Isynforms_increment_all_de_noisevde(k,:)=mean_freq2_Isynforms_increment;
    mean_freq2_spikeforms_increment_all_de_noisevde(k,:)=mean_freq2_spikeforms_increment;
    mean_freq3_Isynforms_increment_all_de_noisevde(k,:)=mean_freq3_Isynforms_increment;
    mean_freq3_spikeforms_increment_all_de_noisevde(k,:)=mean_freq3_spikeforms_increment;
    mean_freq4_Isynforms_increment_all_de_noisevde(k,:)=mean_freq4_Isynforms_increment;
    mean_freq4_spikeforms_increment_all_de_noisevde(k,:)=mean_freq4_spikeforms_increment;
    mean_freq5_Isynforms_increment_all_de_noisevde(k,:)=mean_freq5_Isynforms_increment;
    mean_freq5_spikeforms_increment_all_de_noisevde(k,:)=mean_freq5_spikeforms_increment;
    mean_freq6_Isynforms_increment_all_de_noisevde(k,:)=mean_freq6_Isynforms_increment;
    mean_freq6_spikeforms_increment_all_de_noisevde(k,:)=mean_freq6_spikeforms_increment;
    mean_freq7_Isynforms_increment_all_de_noisevde(k,:)=mean_freq7_Isynforms_increment;
    mean_freq7_spikeforms_increment_all_de_noisevde(k,:)=mean_freq7_spikeforms_increment;
    mean_freq8_Isynforms_increment_all_de_noisevde(k,:)=mean_freq8_Isynforms_increment;
    mean_freq8_spikeforms_increment_all_de_noisevde(k,:)=mean_freq8_spikeforms_increment;
    mean_freq9_Isynforms_increment_all_de_noisevde(k,:)=mean_freq9_Isynforms_increment;
    mean_freq9_spikeforms_increment_all_de_noisevde(k,:)=mean_freq9_spikeforms_increment;
    mean_freq10_Isynforms_increment_all_de_noisevde(k,:)=mean_freq10_Isynforms_increment;
    mean_freq10_spikeforms_increment_all_de_noisevde(k,:)=mean_freq10_spikeforms_increment;
    mean_lastspikeforms_increment_all_de_noisevde(k,:)=mean_lastspikeforms_increment;
    mean_lastistepforms_increment_all_de_noisevde(k,:)=mean_lastistepforms_increment;
    mean_lastIsynforms_increment_all_de_noisevde(k,:)=mean_lastIsynforms_increment;
    mean_lastoutputforms_increment_all_de_noisevde(k,:)=mean_lastoutputforms_increment;
    ISIratio_de_noisevde(k,:)=ISIratio{1};
    firstISI_all_de_noisevde(k,:)=firstISI{1};
    lastISI_all_de_noisevde(k,:)=lastISI{1};
    std_noise_de_noisevde(k,:)=std_noise_all{1};
    currents_de_noisevde_all(k,:)=0:10:200;
    if sum(rate_all_de_noisevde(k,:)>=1)
        de_noisevde_2threshold(k)=find(rate_all_de_noisevde(k,:)>=1,1);
        sub_currents_de_noisevde_all(k,1:de_noisevde_2threshold(k)-1)=currents_de_noisevde_all(k,1:de_noisevde_2threshold(k)-1);
        sub_noise_de_noisevde(k,1:de_noisevde_2threshold(k)-1)=std_noise_de_noisevde(k,1:de_noisevde_2threshold(k)-1);
        sup_currents_de_noisevde_all(k,de_noisevde_2threshold(k):end)=currents_de_noisevde_all(k,de_noisevde_2threshold(k):end);
        sup_noise_de_noisevde(k,de_noisevde_2threshold(k):end)=std_noise_de_noisevde(k,de_noisevde_2threshold(k):end);
    else
        de_noisevde_2threshold(k)=NaN;
        sub_currents_de_noisevde_all(k,:)=currents_de_noisevde_all(k,:);
        sub_noise_de_noisevde(k,:)=std_noise_de_noisevde(k,:);
    end
end

mean_sub_noise_de_noisevde=nanmean(sub_noise_de_noisevde);
std_sub_noise_de_noisevde=nanstd(sub_noise_de_noisevde);
ste_sub_noise_de_noisevde=std_sub_noise_de_noisevde./sqrt(sum(~isnan(sub_noise_de_noisevde)));
mean_sup_noise_de_noisevde=nanmean(sup_noise_de_noisevde);
std_sup_noise_de_noisevde=nanstd(sup_noise_de_noisevde);
ste_sup_noise_de_noisevde=std_sup_noise_de_noisevde./sqrt(sum(~isnan(sup_noise_de_noisevde)));

samecell=1;

for k=1:numel(dates_all_hyper_noisevhyper)
    for h=1:numel(dates_all_de_noisevde)
        if isequal(dates_all_hyper_noisevhyper{k},dates_all_de_noisevde{h}) && ...
                isequal(cellnum_all_hyper_noisevhyper{k},cellnum_all_de_noisevde{h})
            samecell_hyper_noisevhyper(samecell)=k;
            samecell_de_noisevde(samecell)=h;
            samecell=samecell+1;
        end
    end
end

matchfreq_ISIratio_hyper_noisevhyper=NaN(samecell-1,1);
matchfreq_ISIratio_de_noisevde=NaN(samecell-1,1);

% look at ISI ratio for hyperpolarized and depolarized
for k=1:samecell-1
    samefreq{k}=find(abs((1./firstISI_all_hyper_noisevhyper(samecell_hyper_noisevhyper(k),:))-(1./firstISI_all_de_noisevde(samecell_de_noisevde(k),:)))<2,1,'last');
    if numel(samefreq{k})>0
        matchfreq_ISIratio_hyper_noisevhyper(k)=ISIratio_hyper_noisevhyper(samecell_hyper_noisevhyper(k),samefreq{k});
        matchfreq_ISIratio_de_noisevde(k)=ISIratio_de_noisevde(samecell_de_noisevde(k),samefreq{k});
    end
end

mean_ISIratio_hyper_noisevhyper=nanmean(matchfreq_ISIratio_hyper_noisevhyper);
std_ISIratio_hyper_noisevhyper=nanstd(matchfreq_ISIratio_hyper_noisevhyper);
ste_ISIratio_hyper_noisevhyper=std_ISIratio_hyper_noisevhyper/sqrt(sum(~isnan(matchfreq_ISIratio_hyper_noisevhyper)));
mean_ISIratio_de_noisevde=nanmean(matchfreq_ISIratio_de_noisevde);
std_ISIratio_de_noisevde=nanstd(matchfreq_ISIratio_de_noisevde);
ste_ISIratio_de_noisevde=std_ISIratio_de_noisevde/sqrt(sum(~isnan(matchfreq_ISIratio_de_noisevde)));

figure;errorbar(1:2,[mean_ISIratio_hypervde mean_ISIratio_devhyper],[ste_ISIratio_hypervde ste_ISIratio_devhyper])
[ISIratio_hypervdenoise(1),ISIratio_hypervdenoise(2)]=ttest(matchfreq_ISIratio_hyper_noisevhyper,matchfreq_ISIratio_de_noisevde);
hold on;errorbar(1:2,[mean_ISIratio_hyper_noisevhyper mean_ISIratio_de_noisevde],[ste_ISIratio_hyper_noisevhyper ste_ISIratio_de_noisevde],'r')

mean_std_noise_de_noisevde=nanmean(std_noise_de_noisevde);
std_std_noise_de_noisevde=nanstd(std_noise_de_noisevde);
ste_std_noise_de_noisevde=std_std_noise_de_noisevde./sqrt(sum(~isnan(std_noise_de_noisevde)));

figure;errorbar([0:10:200;0:10:200]',[mean_std_noise_hyper_noisevhyper;mean_std_noise_de_noisevde]',[ste_std_noise_hyper_noisevhyper;ste_std_noise_de_noisevde]')

for k=1:samecell-1
    diff_std_noise(k,:)=std_noise_de_noisevde(samecell_de_noisevde(k),:)-std_noise_hyper_noisevhyper(samecell_hyper_noisevhyper(k),:);
    diff_sub_noise(k,:)=sub_noise_de_noisevde(samecell_de_noisevde(k),:)-sub_noise_hyper_noisevhyper(samecell_hyper_noisevhyper(k),:);
    diff_sup_noise(k,:)=sup_noise_de_noisevde(samecell_de_noisevde(k),:)-sup_noise_hyper_noisevhyper(samecell_hyper_noisevhyper(k),:);
end

mean_diff_std_noise=nanmean(diff_std_noise);
std_diff_std_noise=nanstd(diff_std_noise);
ste_diff_std_noise=std_diff_std_noise./sqrt(sum(~isnan(diff_std_noise)));
mean_diff_sub_noise=nanmean(diff_sub_noise);
std_diff_sub_noise=nanstd(diff_sub_noise);
ste_diff_sub_noise=std_diff_sub_noise./sqrt(sum(~isnan(diff_sub_noise)));
mean_diff_sup_noise=nanmean(diff_sup_noise);
std_diff_sup_noise=nanstd(diff_sup_noise);
ste_diff_sup_noise=std_diff_sup_noise./sqrt(sum(~isnan(diff_sup_noise)));

figure;errorbar(0:10:200,mean_diff_std_noise,ste_diff_std_noise)
figure;errorbar([0:10:200;0:10:200]',[mean_diff_sub_noise;mean_diff_sup_noise]',[ste_diff_sub_noise;ste_diff_sup_noise]')

mean_freq0_Isynforms_de_noisevde=nanmean(mean_freq0_Isynforms_increment_all_de_noisevde);
mean_freq0_spikeforms_de_noisevde=nanmean(mean_freq0_spikeforms_increment_all_de_noisevde);
std_freq0_Isynforms_de_noisevde=nanstd(mean_freq0_Isynforms_increment_all_de_noisevde);
std_freq0_spikeforms_de_noisevde=nanstd(mean_freq0_spikeforms_increment_all_de_noisevde);
ste_freq0_Isynforms_de_noisevde=std_freq0_Isynforms_de_noisevde/sqrt(sum(~isnan(mean_freq0_Isynforms_increment_all_de_noisevde)));
ste_freq0_spikeforms_de_noisevde=std_freq0_spikeforms_de_noisevde/sqrt(sum(~isnan(mean_freq0_spikeforms_increment_all_de_noisevde)));
mean_freq1_Isynforms_de_noisevde=nanmean(mean_freq1_Isynforms_increment_all_de_noisevde);
mean_freq1_spikeforms_de_noisevde=nanmean(mean_freq1_spikeforms_increment_all_de_noisevde);
std_freq1_Isynforms_de_noisevde=nanstd(mean_freq1_Isynforms_increment_all_de_noisevde);
std_freq1_spikeforms_de_noisevde=nanstd(mean_freq1_spikeforms_increment_all_de_noisevde);
ste_freq1_Isynforms_de_noisevde=std_freq1_Isynforms_de_noisevde/sqrt(sum(~isnan(mean_freq1_Isynforms_increment_all_de_noisevde)));
ste_freq1_spikeforms_de_noisevde=std_freq1_spikeforms_de_noisevde/sqrt(sum(~isnan(mean_freq1_spikeforms_increment_all_de_noisevde)));
mean_freq2_Isynforms_de_noisevde=nanmean(mean_freq2_Isynforms_increment_all_de_noisevde);
mean_freq2_spikeforms_de_noisevde=nanmean(mean_freq2_spikeforms_increment_all_de_noisevde);
std_freq2_Isynforms_de_noisevde=nanstd(mean_freq2_Isynforms_increment_all_de_noisevde);
std_freq2_spikeforms_de_noisevde=nanstd(mean_freq2_spikeforms_increment_all_de_noisevde);
ste_freq2_Isynforms_de_noisevde=std_freq2_Isynforms_de_noisevde/sqrt(sum(~isnan(mean_freq2_Isynforms_increment_all_de_noisevde)));
ste_freq2_spikeforms_de_noisevde=std_freq2_spikeforms_de_noisevde/sqrt(sum(~isnan(mean_freq2_spikeforms_increment_all_de_noisevde)));
mean_freq3_Isynforms_de_noisevde=nanmean(mean_freq3_Isynforms_increment_all_de_noisevde);
mean_freq3_spikeforms_de_noisevde=nanmean(mean_freq3_spikeforms_increment_all_de_noisevde);
std_freq3_Isynforms_de_noisevde=nanstd(mean_freq3_Isynforms_increment_all_de_noisevde);
std_freq3_spikeforms_de_noisevde=nanstd(mean_freq3_spikeforms_increment_all_de_noisevde);
ste_freq3_Isynforms_de_noisevde=std_freq3_Isynforms_de_noisevde/sqrt(sum(~isnan(mean_freq3_Isynforms_increment_all_de_noisevde)));
ste_freq3_spikeforms_de_noisevde=std_freq3_spikeforms_de_noisevde/sqrt(sum(~isnan(mean_freq3_spikeforms_increment_all_de_noisevde)));
mean_freq4_Isynforms_de_noisevde=nanmean(mean_freq4_Isynforms_increment_all_de_noisevde);
mean_freq4_spikeforms_de_noisevde=nanmean(mean_freq4_spikeforms_increment_all_de_noisevde);
std_freq4_Isynforms_de_noisevde=nanstd(mean_freq4_Isynforms_increment_all_de_noisevde);
std_freq4_spikeforms_de_noisevde=nanstd(mean_freq4_spikeforms_increment_all_de_noisevde);
ste_freq4_Isynforms_de_noisevde=std_freq4_Isynforms_de_noisevde/sqrt(sum(~isnan(mean_freq4_Isynforms_increment_all_de_noisevde)));
ste_freq4_spikeforms_de_noisevde=std_freq4_spikeforms_de_noisevde/sqrt(sum(~isnan(mean_freq4_spikeforms_increment_all_de_noisevde)));
mean_freq5_Isynforms_de_noisevde=nanmean(mean_freq5_Isynforms_increment_all_de_noisevde);
mean_freq5_spikeforms_de_noisevde=nanmean(mean_freq5_spikeforms_increment_all_de_noisevde);
std_freq5_Isynforms_de_noisevde=nanstd(mean_freq5_Isynforms_increment_all_de_noisevde);
std_freq5_spikeforms_de_noisevde=nanstd(mean_freq5_spikeforms_increment_all_de_noisevde);
ste_freq5_Isynforms_de_noisevde=std_freq5_Isynforms_de_noisevde/sqrt(sum(~isnan(mean_freq5_Isynforms_increment_all_de_noisevde)));
ste_freq5_spikeforms_de_noisevde=std_freq5_spikeforms_de_noisevde/sqrt(sum(~isnan(mean_freq5_spikeforms_increment_all_de_noisevde)));
mean_freq6_Isynforms_de_noisevde=nanmean(mean_freq6_Isynforms_increment_all_de_noisevde);
mean_freq6_spikeforms_de_noisevde=nanmean(mean_freq6_spikeforms_increment_all_de_noisevde);
std_freq6_Isynforms_de_noisevde=nanstd(mean_freq6_Isynforms_increment_all_de_noisevde);
std_freq6_spikeforms_de_noisevde=nanstd(mean_freq6_spikeforms_increment_all_de_noisevde);
ste_freq6_Isynforms_de_noisevde=std_freq6_Isynforms_de_noisevde/sqrt(sum(~isnan(mean_freq6_Isynforms_increment_all_de_noisevde)));
ste_freq6_spikeforms_de_noisevde=std_freq6_spikeforms_de_noisevde/sqrt(sum(~isnan(mean_freq6_spikeforms_increment_all_de_noisevde)));
mean_freq7_Isynforms_de_noisevde=nanmean(mean_freq7_Isynforms_increment_all_de_noisevde);
mean_freq7_spikeforms_de_noisevde=nanmean(mean_freq7_spikeforms_increment_all_de_noisevde);
std_freq7_Isynforms_de_noisevde=nanstd(mean_freq7_Isynforms_increment_all_de_noisevde);
std_freq7_spikeforms_de_noisevde=nanstd(mean_freq7_spikeforms_increment_all_de_noisevde);
ste_freq7_Isynforms_de_noisevde=std_freq7_Isynforms_de_noisevde/sqrt(sum(~isnan(mean_freq7_Isynforms_increment_all_de_noisevde)));
ste_freq7_spikeforms_de_noisevde=std_freq7_spikeforms_de_noisevde/sqrt(sum(~isnan(mean_freq7_spikeforms_increment_all_de_noisevde)));
mean_freq8_Isynforms_de_noisevde=nanmean(mean_freq8_Isynforms_increment_all_de_noisevde);
mean_freq8_spikeforms_de_noisevde=nanmean(mean_freq8_spikeforms_increment_all_de_noisevde);
std_freq8_Isynforms_de_noisevde=nanstd(mean_freq8_Isynforms_increment_all_de_noisevde);
std_freq8_spikeforms_de_noisevde=nanstd(mean_freq8_spikeforms_increment_all_de_noisevde);
ste_freq8_Isynforms_de_noisevde=std_freq8_Isynforms_de_noisevde/sqrt(sum(~isnan(mean_freq8_Isynforms_increment_all_de_noisevde)));
ste_freq8_spikeforms_de_noisevde=std_freq8_spikeforms_de_noisevde/sqrt(sum(~isnan(mean_freq8_spikeforms_increment_all_de_noisevde)));
mean_freq9_Isynforms_de_noisevde=nanmean(mean_freq9_Isynforms_increment_all_de_noisevde);
mean_freq9_spikeforms_de_noisevde=nanmean(mean_freq9_spikeforms_increment_all_de_noisevde);
std_freq9_Isynforms_de_noisevde=nanstd(mean_freq9_Isynforms_increment_all_de_noisevde);
std_freq9_spikeforms_de_noisevde=nanstd(mean_freq9_spikeforms_increment_all_de_noisevde);
ste_freq9_Isynforms_de_noisevde=std_freq9_Isynforms_de_noisevde/sqrt(sum(~isnan(mean_freq9_Isynforms_increment_all_de_noisevde)));
ste_freq9_spikeforms_de_noisevde=std_freq9_spikeforms_de_noisevde/sqrt(sum(~isnan(mean_freq9_spikeforms_increment_all_de_noisevde)));
mean_freq10_Isynforms_de_noisevde=nanmean(mean_freq10_Isynforms_increment_all_de_noisevde);
mean_freq10_spikeforms_de_noisevde=nanmean(mean_freq10_spikeforms_increment_all_de_noisevde);
std_freq10_Isynforms_de_noisevde=nanstd(mean_freq10_Isynforms_increment_all_de_noisevde);
std_freq10_spikeforms_de_noisevde=nanstd(mean_freq10_spikeforms_increment_all_de_noisevde);
ste_freq10_Isynforms_de_noisevde=std_freq10_Isynforms_de_noisevde/sqrt(sum(~isnan(mean_freq10_Isynforms_increment_all_de_noisevde)));
ste_freq10_spikeforms_de_noisevde=std_freq10_spikeforms_de_noisevde/sqrt(sum(~isnan(mean_freq10_spikeforms_increment_all_de_noisevde)));

mean_lastspikeforms_de_noisevde=nanmean(mean_lastspikeforms_increment_all_de_noisevde);
std_lastspikeforms_de_noisevde=nanstd(mean_lastspikeforms_increment_all_de_noisevde);
ste_lastspikeforms_de_noisevde=std_lastspikeforms_de_noisevde/sqrt(sum(~isnan(mean_lastspikeforms_increment_all_de_noisevde)));
mean_lastistepforms_de_noisevde=nanmean(mean_lastistepforms_increment_all_de_noisevde);
std_lastistepforms_de_noisevde=nanstd(mean_lastistepforms_increment_all_de_noisevde);
ste_lastistepforms_de_noisevde=std_lastistepforms_de_noisevde/sqrt(sum(~isnan(mean_lastistepforms_increment_all_de_noisevde)));
mean_lastIsynforms_de_noisevde=nanmean(mean_lastIsynforms_increment_all_de_noisevde);
std_lastIsynforms_de_noisevde=nanstd(mean_lastIsynforms_increment_all_de_noisevde);
ste_lastIsynforms_de_noisevde=std_lastIsynforms_de_noisevde/sqrt(sum(~isnan(mean_lastIsynforms_increment_all_de_noisevde)));
mean_lastoutputforms_de_noisevde=nanmean(mean_lastoutputforms_increment_all_de_noisevde);
std_lastoutputforms_de_noisevde=nanstd(mean_lastoutputforms_increment_all_de_noisevde);
ste_lastoutputforms_de_noisevde=std_lastoutputforms_de_noisevde/sqrt(sum(~isnan(mean_lastoutputforms_increment_all_de_noisevde)));

gains_all_de_noisevde(isnan(rsq_all_de_noisevde))=NaN; % filter out the gains that are NaNs

mean_peakrate_de_noisevde=nanmean(peakrate_all_de_noisevde);
std_peakrate_de_noisevde=nanstd(peakrate_all_de_noisevde);
mean_nofailrate_de_noisevde=nanmean(nofailrate_all_de_noisevde);
std_nofailrate_de_noisevde=nanstd(nofailrate_all_de_noisevde);
mean_gains_de_noisevde=nanmean(gains_all_de_noisevde);
std_gains_de_noisevde=nanstd(gains_all_de_noisevde);
ste_gains_de_noisevde=std_gains_de_noisevde/sqrt(sum(~isnan(gains_all_de_noisevde)));

normalized_gains_all_de_noisevde=gains_all_de_noisevde./gains_all_devdenoise;
normalized_mean_gains_de_noisevde=nanmean(normalized_gains_all_de_noisevde);
normalized_std_gains_de_noisevde=nanstd(normalized_gains_all_de_noisevde);
normalized_ste_gains_de_noisevde=normalized_std_gains_de_noisevde/sqrt(sum(~isnan(normalized_gains_all_de_noisevde)));
figure;plot(ones(size(normalized_gains_all_de_noisevde)),normalized_gains_all_de_noisevde,'.','LineWidth',3)
hold on;errorbar(1,normalized_mean_gains_de_noisevde,normalized_ste_gains_de_noisevde,'or','LineWidth',2)
title('Normalized Depolarized with Noise Gains')
ylabel('Normalized Gain')
axis([0.9 1.1 0 50])
axis 'auto y'
set(gca, 'XTick', []);
[gainsttest_normalized_de_de_noise(1),gainsttest_normalized_de_de_noise(2)]=ttest(ones(size(normalized_gains_all_de_noisevde)),normalized_gains_all_de_noisevde);

mean_imp_de_noisevde=nanmean(imp_all_de_noisevde);
std_imp_de_noisevde=nanstd(imp_all_de_noisevde);
mean_holdingvoltage_all_de_noisevde=nanmean(holdingvoltage_all_de_noisevde);
std_holdingvoltage_all_de_noisevde=nanstd(holdingvoltage_all_de_noisevde);
mean_std_noise_all_de_noisevde=nanmean(std_noise_all_de_noisevde);
std_std_noise_all_de_noisevde=nanstd(std_noise_all_de_noisevde);
mean_rate_de_noisevde=nanmean(rate_all_de_noisevde);
std_rate_de_noisevde=nanstd(rate_all_de_noisevde);
ste_rate_de_noisevde=std_rate_de_noisevde./sqrt(sum(~isnan(rate_all_de_noisevde)));

currents=0:10:200;
nlf_fi_devdenoise=nlinfit(currents,mean_rate_devdenoise,'sigFun',[320,50,10]);
nlf_fi_de_noisevde=nlinfit(currents,mean_rate_de_noisevde,'sigFun',[320,50,10]);

devdenoise_max=nlf_fi_devdenoise(1);
devdenoise_midpoint=nlf_fi_devdenoise(2);
devdenoise_slope=nlf_fi_devdenoise(1)/(4*nlf_fi_devdenoise(3));
de_noisevde_max=nlf_fi_de_noisevde(1);
de_noisevde_midpoint=nlf_fi_de_noisevde(2);
de_noisevde_slope=nlf_fi_de_noisevde(1)/(4*nlf_fi_de_noisevde(3));

figure;errorbar([currents;currents]',[mean_rate_devdenoise;mean_rate_de_noisevde]',[ste_rate_devdenoise;ste_rate_de_noisevde]')
legend('Depolarized','Depolarized with Just Noise')
hold on;plot(currents,sigFun(nlf_fi_devdenoise,currents),'m');plot(currents,sigFun(nlf_fi_de_noisevde,currents),'r')
title('Average f-I Curves for Depolarized and Depolarized with Just Noise')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% difference between rates (unpaired)
difference_rate_devdenoise=rate_all_de_noisevde-rate_all_devdenoise;
mean_difference_rate_devdenoise=nanmean(difference_rate_devdenoise);
std_difference_rate_devdenoise=nanstd(difference_rate_devdenoise);
ste_difference_rate_devdenoise=std_difference_rate_devdenoise./sqrt(sum(~isnan(difference_rate_devdenoise)));

percent_difference_rate_devdenoise=(difference_rate_devdenoise./rate_all_devdenoise)*100;
percent_difference_rate_devdenoise(~isfinite(percent_difference_rate_devdenoise))=NaN;
mean_percent_difference_rate_devdenoise=nanmean(percent_difference_rate_devdenoise);
std_percent_difference_rate_devdenoise=nanstd(percent_difference_rate_devdenoise);
ste_percent_difference_rate_devdenoise=std_percent_difference_rate_devdenoise./sqrt(sum(~isnan(percent_difference_rate_devdenoise)));

new_percent_difference_rate_devdenoise=difference_rate_devdenoise./rate_all_de_noisevde;
new_percent_difference_rate_devdenoise(~isfinite(new_percent_difference_rate_devdenoise))=NaN;
mean_new_percent_difference_rate_devdenoise=nanmean(new_percent_difference_rate_devdenoise);
std_new_percent_difference_rate_devdenoise=nanstd(new_percent_difference_rate_devdenoise);
ste_new_percent_difference_rate_devdenoise=std_new_percent_difference_rate_devdenoise./sqrt(sum(~isnan(new_percent_difference_rate_devdenoise)));

% difference between rates (paired)
paired_difference_rate_devdenoise=rate_all_de_noisevde([5:9 11:end],:)-rate_all_devdenoise([5:9 11:end],:);
paired_mean_difference_rate_devdenoise=nanmean(paired_difference_rate_devdenoise);
paired_std_difference_rate_devdenoise=nanstd(paired_difference_rate_devdenoise);
paired_ste_difference_rate_devdenoise=paired_std_difference_rate_devdenoise./sqrt(sum(~isnan(paired_difference_rate_devdenoise)));

paired_percent_difference_rate_devdenoise=(paired_difference_rate_devdenoise./rate_all_devdenoise([5:9 11:end],:))*100;
paired_percent_difference_rate_devdenoise(~isfinite(paired_percent_difference_rate_devdenoise))=NaN;
paired_mean_percent_difference_rate_devdenoise=nanmean(paired_percent_difference_rate_devdenoise);
paired_std_percent_difference_rate_devdenoise=nanstd(paired_percent_difference_rate_devdenoise);
paired_ste_percent_difference_rate_devdenoise=paired_std_percent_difference_rate_devdenoise./sqrt(sum(~isnan(paired_percent_difference_rate_devdenoise)));

paired_new_percent_difference_rate_devdenoise=paired_difference_rate_devdenoise./rate_all_de_noisevde([5:9 11:end],:);
paired_new_percent_difference_rate_devdenoise(~isfinite(paired_new_percent_difference_rate_devdenoise))=NaN;
paired_mean_new_percent_difference_rate_devdenoise=nanmean(paired_new_percent_difference_rate_devdenoise);
paired_std_new_percent_difference_rate_devdenoise=nanstd(paired_new_percent_difference_rate_devdenoise);
paired_ste_new_percent_difference_rate_devdenoise=paired_std_new_percent_difference_rate_devdenoise./sqrt(sum(~isnan(paired_new_percent_difference_rate_devdenoise)));


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

for k=1:numel(dates_all_devdeleaknoise)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_devdeleaknoise{k} '_' cellnum_all_devdeleaknoise{k} num2str(trials_all_devdeleaknoise(k)) '_fi.mat;'])
    peakrate_all_devdeleaknoise(k,:)=peakrate;
    nofailrate_all_devdeleaknoise(k,:)=nofailrate;
    gains_all_devdeleaknoise(k,1)=pf_all{1}.beta(2);
    rsq_all_devdeleaknoise(k,1)=pf_all{1}.rsquare;
    rate_all_devdeleaknoise(k,:)=rate_all{1};
    imp_all_devdeleaknoise(k,:)=imp;
    holdingvoltage_all_devdeleaknoise(k,:)=mean_holdingvoltage;
    std_noise_all_devdeleaknoise(k)=std_noise;
end

gains_all_devdeleaknoise(isnan(rsq_all_devdeleaknoise))=NaN; % filter out the gains that are NaNs

mean_peakrate_devdeleaknoise=nanmean(peakrate_all_devdeleaknoise);
std_peakrate_devdeleaknoise=nanstd(peakrate_all_devdeleaknoise);
mean_nofailrate_devdeleaknoise=nanmean(nofailrate_all_devdeleaknoise);
std_nofailrate_devdeleaknoise=nanstd(nofailrate_all_devdeleaknoise);
mean_gains_devdeleaknoise=nanmean(gains_all_devdeleaknoise);
std_gains_devdeleaknoise=nanstd(gains_all_devdeleaknoise);
ste_gains_devdeleaknoise=std_gains_devdeleaknoise/sqrt(sum(~isnan(gains_all_devdeleaknoise)));
mean_imp_devdeleaknoise=nanmean(imp_all_devdeleaknoise);
std_imp_devdeleaknoise=nanstd(imp_all_devdeleaknoise);
mean_holdingvoltage_all_devdeleaknoise=nanmean(holdingvoltage_all_devdeleaknoise);
std_holdingvoltage_all_devdeleaknoise=nanstd(holdingvoltage_all_devdeleaknoise);
mean_std_noise_all_devdeleaknoise=nanmean(std_noise_all_devdeleaknoise);
std_std_noise_all_devdeleaknoise=nanstd(std_noise_all_devdeleaknoise);
mean_rate_devdeleaknoise=nanmean(rate_all_devdeleaknoise);
std_rate_devdeleaknoise=nanstd(rate_all_devdeleaknoise);
ste_rate_devdeleaknoise=std_rate_devdeleaknoise./sqrt(sum(~isnan(rate_all_devdeleaknoise)));


% Depolarized with Leak and Noise (400 pA range of currents)
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
    eval(['load ' pwd '\fi_analysis\FI_OU_' dates_all_de_leak_noisevde{k} '_' cellnum_all_de_leak_noisevde{k} num2str(trials_all_de_leak_noisevde(k)) '_fi.mat;'])
    peakrate_all_de_leak_noisevde(k,:)=peakrate;
    nofailrate_all_de_leak_noisevde(k,:)=nofailrate;
    gains_all_de_leak_noisevde(k,1)=pf_all{1}.beta(2);
    rsq_all_de_leak_noisevde(k,1)=pf_all{1}.rsquare;
    rate_all_de_leak_noisevde(k,:)=rate_all{1};
    imp_all_de_leak_noisevde(k,:)=imp;
    holdingvoltage_all_de_leak_noisevde(k,:)=mean_holdingvoltage;
    std_noise_all_de_leak_noisevde(k)=std_noise;
end

gains_all_de_leak_noisevde(isnan(rsq_all_de_leak_noisevde))=NaN; % filter out the gains that are NaNs

mean_peakrate_de_leak_noisevde=nanmean(peakrate_all_de_leak_noisevde);
std_peakrate_de_leak_noisevde=nanstd(peakrate_all_de_leak_noisevde);
mean_nofailrate_de_leak_noisevde=nanmean(nofailrate_all_de_leak_noisevde);
std_nofailrate_de_leak_noisevde=nanstd(nofailrate_all_de_leak_noisevde);
mean_gains_de_leak_noisevde=nanmean(gains_all_de_leak_noisevde);
std_gains_de_leak_noisevde=nanstd(gains_all_de_leak_noisevde);
ste_gains_de_leak_noisevde=std_gains_de_leak_noisevde/sqrt(sum(~isnan(gains_all_de_leak_noisevde)));
mean_imp_de_leak_noisevde=nanmean(imp_all_de_leak_noisevde);
std_imp_de_leak_noisevde=nanstd(imp_all_de_leak_noisevde);
mean_holdingvoltage_all_de_leak_noisevde=nanmean(holdingvoltage_all_de_leak_noisevde);
std_holdingvoltage_all_de_leak_noisevde=nanstd(holdingvoltage_all_de_leak_noisevde);
mean_std_noise_all_de_leak_noisevde=nanmean(std_noise_all_de_leak_noisevde);
std_std_noise_all_de_leak_noisevde=nanstd(std_noise_all_de_leak_noisevde);
mean_rate_de_leak_noisevde=nanmean(rate_all_de_leak_noisevde);
std_rate_de_leak_noisevde=nanstd(rate_all_de_leak_noisevde);
ste_rate_de_leak_noisevde=std_rate_de_leak_noisevde./sqrt(sum(~isnan(rate_all_de_leak_noisevde)));

currents=0:10:200;
currents_leak=0:20:400;
nlf_fi_devdeleaknoise=nlinfit(currents,mean_rate_devdeleaknoise,'sigFun',[320,50,10]);
nlf_fi_de_leak_noisevde=nlinfit(currents_leak,mean_rate_de_leak_noisevde,'sigFun',[320,50,10]);

devdeleaknoise_max=nlf_fi_devdeleaknoise(1);
devdeleaknoise_midpoint=nlf_fi_devdeleaknoise(2);
devdeleaknoise_slope=nlf_fi_devdeleaknoise(1)/(4*nlf_fi_devdeleaknoise(3));
de_leak_noisevde_max=nlf_fi_de_leak_noisevde(1);
de_leak_noisevde_midpoint=nlf_fi_de_leak_noisevde(2);
de_leak_noisevde_slope=nlf_fi_de_leak_noisevde(1)/(4*nlf_fi_de_leak_noisevde(3));

figure;errorbar([currents;currents_leak]',[mean_rate_devdeleaknoise;mean_rate_de_leak_noisevde]',[ste_rate_devdeleaknoise;ste_rate_de_leak_noisevde]')
legend('Depolarized','Depolarized with Leak (3 nS) and Noise')
hold on;plot(currents,sigFun(nlf_fi_devdeleaknoise,currents),'m');plot(currents_leak,sigFun(nlf_fi_de_leak_noisevde,currents_leak),'r')
title('Average f-I Curves for Depolarized and Depolarized with Leak (3 nS) and Noise')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% difference between rates
difference_rate_devdeleaknoise=rate_all_de_leak_noisevde-rate_all_devdeleaknoise;
mean_difference_rate_devdeleaknoise=nanmean(difference_rate_devdeleaknoise);
std_difference_rate_devdeleaknoise=nanstd(difference_rate_devdeleaknoise);
ste_difference_rate_devdeleaknoise=std_difference_rate_devdeleaknoise./sqrt(sum(~isnan(difference_rate_devdeleaknoise)));


%% Hyperpolarized Non-Cholinergic (5 sec pulse, 1 sec pause)
% For Depolarized Non-Cholinergic

dates_all_hypervde_noncholinergic={'Mar_24_15' 'Mar_27_15' 'Mar_28_15' 'Mar_28_15' 'Mar_30_15' 'Mar_30_15'...
    'Apr_10_15' 'Apr_10_15' 'May_05_15' 'May_05_15' 'May_05_15'};
cellnum_all_hypervde_noncholinergic={'C' 'B' 'B' 'C' 'A' 'B'...
    'A' 'C' 'A' 'B' 'C'};
trials_all_hypervde_noncholinergic=[3 4 2 3 1 2 ...
    5 4 1 1 3]';

for k=1:numel(dates_all_hypervde_noncholinergic)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_hypervde_noncholinergic{k} '_' cellnum_all_hypervde_noncholinergic{k} num2str(trials_all_hypervde_noncholinergic(k)) '_fi.mat;'])
    peakrate_all_hypervde_noncholinergic(k,:)=peakrate;
    nofailrate_all_hypervde_noncholinergic(k,:)=nofailrate;
    gains_all_hypervde_noncholinergic(k,1)=pf_all{1}.beta(2);
    rsq_all_hypervde_noncholinergic(k,1)=pf_all{1}.rsquare;
    rate_all_hypervde_noncholinergic(k,:)=rate_all{1};
    imp_all_hypervde_noncholinergic(k,:)=imp;
    holdingvoltage_all_hypervde_noncholinergic(k,:)=mean_holdingvoltage;
end

gains_all_hypervde_noncholinergic(isnan(rsq_all_hypervde_noncholinergic))=NaN; % filter out the gains that are NaNs

mean_peakrate_hypervde_noncholinergic=nanmean(peakrate_all_hypervde_noncholinergic);
std_peakrate_hypervde_noncholinergic=nanstd(peakrate_all_hypervde_noncholinergic);
mean_nofailrate_hypervde_noncholinergic=nanmean(nofailrate_all_hypervde_noncholinergic);
std_nofailrate_hypervde_noncholinergic=nanstd(nofailrate_all_hypervde_noncholinergic);
mean_gains_hypervde_noncholinergic=nanmean(gains_all_hypervde_noncholinergic);
std_gains_hypervde_noncholinergic=nanstd(gains_all_hypervde_noncholinergic);
ste_gains_hypervde_noncholinergic=std_gains_hypervde_noncholinergic/sqrt(sum(~isnan(gains_all_hypervde_noncholinergic)));
mean_imp_hypervde_noncholinergic=nanmean(imp_all_hypervde_noncholinergic);
std_imp_hypervde_noncholinergic=nanstd(imp_all_hypervde_noncholinergic);
mean_holdingvoltage_all_hypervde_noncholinergic=nanmean(holdingvoltage_all_hypervde_noncholinergic);
std_holdingvoltage_all_hypervde_noncholinergic=nanstd(holdingvoltage_all_hypervde_noncholinergic);
mean_rate_hypervde_noncholinergic=nanmean(rate_all_hypervde_noncholinergic);
std_rate_hypervde_noncholinergic=nanstd(rate_all_hypervde_noncholinergic);
ste_rate_hypervde_noncholinergic=std_rate_hypervde_noncholinergic./sqrt(sum(~isnan(rate_all_hypervde_noncholinergic)));


% Depolarized Non-Cholinergic (5 sec pulse, 1 sec pause)
% For Hyperpolarized Non-Cholinergic

dates_all_devhyper_noncholinergic={'Mar_24_15' 'Mar_27_15' 'Mar_28_15' 'Mar_28_15' 'Mar_30_15' 'Mar_30_15'...
    'Apr_10_15' 'Apr_10_15' 'May_05_15' 'May_05_15' 'May_05_15'};
cellnum_all_devhyper_noncholinergic={'C' 'B' 'B' 'C' 'A' 'B'...
    'A' 'C' 'A' 'B' 'C'};
trials_all_devhyper_noncholinergic=[4 5 3 4 2 3 ...
    6 5 2 2 4]';

for k=1:numel(dates_all_devhyper_noncholinergic)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_devhyper_noncholinergic{k} '_' cellnum_all_devhyper_noncholinergic{k} num2str(trials_all_devhyper_noncholinergic(k)) '_fi.mat;'])
    peakrate_all_devhyper_noncholinergic(k,:)=peakrate;
    nofailrate_all_devhyper_noncholinergic(k,:)=nofailrate;
    gains_all_devhyper_noncholinergic(k,1)=pf_all{1}.beta(2);
    rsq_all_devhyper_noncholinergic(k,1)=pf_all{1}.rsquare;
    rate_all_devhyper_noncholinergic(k,:)=rate_all{1};
    imp_all_devhyper_noncholinergic(k,:)=imp;
    holdingvoltage_all_devhyper_noncholinergic(k,:)=mean_holdingvoltage;
end

gains_all_devhyper_noncholinergic(isnan(rsq_all_devhyper_noncholinergic))=NaN; % filter out the gains that are NaNs

mean_peakrate_devhyper_noncholinergic=nanmean(peakrate_all_devhyper_noncholinergic);
std_peakrate_devhyper_noncholinergic=nanstd(peakrate_all_devhyper_noncholinergic);
mean_nofailrate_devhyper_noncholinergic=nanmean(nofailrate_all_devhyper_noncholinergic);
std_nofailrate_devhyper_noncholinergic=nanstd(nofailrate_all_devhyper_noncholinergic);
mean_gains_devhyper_noncholinergic=nanmean(gains_all_devhyper_noncholinergic);
std_gains_devhyper_noncholinergic=nanstd(gains_all_devhyper_noncholinergic);
ste_gains_devhyper_noncholinergic=std_gains_devhyper_noncholinergic/sqrt(sum(~isnan(gains_all_devhyper_noncholinergic)));

normalized_gains_all_devhyper_noncholinergic=gains_all_devhyper_noncholinergic./gains_all_hypervde_noncholinergic;
normalized_mean_gains_devhyper_noncholinergic=nanmean(normalized_gains_all_devhyper_noncholinergic);
normalized_std_gains_devhyper_noncholinergic=nanstd(normalized_gains_all_devhyper_noncholinergic);
normalized_ste_gains_devhyper_noncholinergic=normalized_std_gains_devhyper_noncholinergic/sqrt(sum(~isnan(normalized_gains_all_devhyper_noncholinergic)));
figure;plot(ones(size(normalized_gains_all_devhyper_noncholinergic)),normalized_gains_all_devhyper_noncholinergic,'.','LineWidth',3)
hold on;errorbar(1,normalized_mean_gains_devhyper_noncholinergic,normalized_ste_gains_devhyper_noncholinergic,'or','LineWidth',2)
title('Normalized Non-Cholinergic Depolarized Gains')
ylabel('Normalized Gain')
axis([0.9 1.1 0 12])
axis 'auto y'
set(gca, 'XTick', []);
[gainsttest_normalized_hyper_de_noncholinergic(1),gainsttest_normalized_hyper_de_noncholinergic(2)]=ttest(ones(size(normalized_gains_all_devhyper_noncholinergic)),normalized_gains_all_devhyper_noncholinergic);

mean_imp_devhyper_noncholinergic=nanmean(imp_all_devhyper_noncholinergic);
std_imp_devhyper_noncholinergic=nanstd(imp_all_devhyper_noncholinergic);
mean_holdingvoltage_all_devhyper_noncholinergic=nanmean(holdingvoltage_all_devhyper_noncholinergic);
std_holdingvoltage_all_devhyper_noncholinergic=nanstd(holdingvoltage_all_devhyper_noncholinergic);
mean_rate_devhyper_noncholinergic=nanmean(rate_all_devhyper_noncholinergic);
std_rate_devhyper_noncholinergic=nanstd(rate_all_devhyper_noncholinergic);
ste_rate_devhyper_noncholinergic=std_rate_devhyper_noncholinergic./sqrt(sum(~isnan(rate_all_devhyper_noncholinergic)));

currents=0:10:200;
nlf_fi_hypervde_noncholinergic=nlinfit(currents,mean_rate_hypervde_noncholinergic,'sigFun',[320,50,10]);
nlf_fi_devhyper_noncholinergic=nlinfit(currents,mean_rate_devhyper_noncholinergic,'sigFun',[320,50,10]);

hypervde_noncholinergic_max=nlf_fi_hypervde_noncholinergic(1);
hypervde_noncholinergic_midpoint=nlf_fi_hypervde_noncholinergic(2);
hypervde_noncholinergic_slope=nlf_fi_hypervde_noncholinergic(1)/(4*nlf_fi_hypervde_noncholinergic(3));
devhyper_noncholinergic_max=nlf_fi_devhyper_noncholinergic(1);
devhyper_noncholinergic_midpoint=nlf_fi_devhyper_noncholinergic(2);
devhyper_noncholinergic_slope=nlf_fi_devhyper_noncholinergic(1)/(4*nlf_fi_devhyper_noncholinergic(3));

figure;errorbar([currents;currents]',[mean_rate_hypervde_noncholinergic;mean_rate_devhyper_noncholinergic]',[ste_rate_hypervde_noncholinergic;ste_rate_devhyper_noncholinergic]')
legend('Hyperpolarized','Depolarized')
hold on;plot(currents,sigFun(nlf_fi_hypervde_noncholinergic,currents),'m');plot(currents,sigFun(nlf_fi_devhyper_noncholinergic,currents),'r')
title('Average f-I Curves for Non-Cholinergic Hyperpolarized and Depolarized')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% difference between rates
difference_rate_hypervde_noncholinergic=rate_all_devhyper_noncholinergic-rate_all_hypervde_noncholinergic;
mean_difference_rate_hypervde_noncholinergic=nanmean(difference_rate_hypervde_noncholinergic);
std_difference_rate_hypervde_noncholinergic=nanstd(difference_rate_hypervde_noncholinergic);
ste_difference_rate_hypervde_noncholinergic=std_difference_rate_hypervde_noncholinergic./sqrt(sum(~isnan(difference_rate_hypervde_noncholinergic)));


%% Hyperpolarized Non-Cholinergic (5 sec pulse, 1 sec pause; Currents go from 0:10:200)
% For Hyperpolarized with Noise Non-Cholinergic

dates_all_hypervhypernoise_noncholinergic={'Mar_24_15' 'Mar_28_15' 'Mar_30_15' 'Mar_30_15' 'Mar_30_15' 'Apr_10_15'...
    'Apr_10_15' 'May_05_15' 'May_05_15' 'May_05_15'};
cellnum_all_hypervhypernoise_noncholinergic={'C' 'B' 'A' 'B' 'C' 'A'...
    'C' 'A' 'B' 'C'};
trials_all_hypervhypernoise_noncholinergic=[3 2 1 2 1 5 ...
    4 1 1 3]';

for k=1:numel(dates_all_hypervhypernoise_noncholinergic)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_hypervhypernoise_noncholinergic{k} '_' cellnum_all_hypervhypernoise_noncholinergic{k} num2str(trials_all_hypervhypernoise_noncholinergic(k)) '_fi.mat;'])
    peakrate_all_hypervhypernoise_noncholinergic(k,:)=peakrate;
    nofailrate_all_hypervhypernoise_noncholinergic(k,:)=nofailrate;
    gains_all_hypervhypernoise_noncholinergic(k,1)=pf_all{1}.beta(2);
    rsq_all_hypervhypernoise_noncholinergic(k,1)=pf_all{1}.rsquare;
    rate_all_hypervhypernoise_noncholinergic(k,:)=rate_all{1};
    imp_all_hypervhypernoise_noncholinergic(k,:)=imp;
    holdingvoltage_all_hypervhypernoise_noncholinergic(k,:)=mean_holdingvoltage;
    std_noise_all_hypervhypernoise_noncholinergic(k)=std_noise;
end

gains_all_hypervhypernoise_noncholinergic(isnan(rsq_all_hypervhypernoise_noncholinergic))=NaN; % filter out the gains that are NaNs

mean_peakrate_hypervhypernoise_noncholinergic=nanmean(peakrate_all_hypervhypernoise_noncholinergic);
std_peakrate_hypervhypernoise_noncholinergic=nanstd(peakrate_all_hypervhypernoise_noncholinergic);
mean_nofailrate_hypervhypernoise_noncholinergic=nanmean(nofailrate_all_hypervhypernoise_noncholinergic);
std_nofailrate_hypervhypernoise_noncholinergic=nanstd(nofailrate_all_hypervhypernoise_noncholinergic);
mean_gains_hypervhypernoise_noncholinergic=nanmean(gains_all_hypervhypernoise_noncholinergic);
std_gains_hypervhypernoise_noncholinergic=nanstd(gains_all_hypervhypernoise_noncholinergic);
ste_gains_hypervhypernoise_noncholinergic=std_gains_hypervhypernoise_noncholinergic/sqrt(sum(~isnan(gains_all_hypervhypernoise_noncholinergic)));
mean_imp_hypervhypernoise_noncholinergic=nanmean(imp_all_hypervhypernoise_noncholinergic);
std_imp_hypervhypernoise_noncholinergic=nanstd(imp_all_hypervhypernoise_noncholinergic);
mean_holdingvoltage_all_hypervhypernoise_noncholinergic=nanmean(holdingvoltage_all_hypervhypernoise_noncholinergic);
std_holdingvoltage_all_hypervhypernoise_noncholinergic=nanstd(holdingvoltage_all_hypervhypernoise_noncholinergic);
mean_std_noise_all_hypervhypernoise_noncholinergic=nanmean(std_noise_all_hypervhypernoise_noncholinergic);
std_std_noise_all_hypervhypernoise_noncholinergic=nanstd(std_noise_all_hypervhypernoise_noncholinergic);
mean_rate_hypervhypernoise_noncholinergic=nanmean(rate_all_hypervhypernoise_noncholinergic);
std_rate_hypervhypernoise_noncholinergic=nanstd(rate_all_hypervhypernoise_noncholinergic);
ste_rate_hypervhypernoise_noncholinergic=std_rate_hypervhypernoise_noncholinergic./sqrt(sum(~isnan(rate_all_hypervhypernoise_noncholinergic)));


% Hyperpolarized with Noise Non-Cholinergic (Currents go from 0:10:200)
% For Hyperpolarized Non-Cholinergic

dates_all_hyper_noisevhyper_noncholinergic={'Mar_24_15' 'Mar_28_15' 'Mar_30_15' 'Mar_30_15' 'Mar_30_15' 'Apr_10_15'...
    'Apr_10_15' 'May_05_15' 'May_05_15' 'May_05_15'};
cellnum_all_hyper_noisevhyper_noncholinergic={'C' 'B' 'A' 'B' 'C' 'A'...
    'C' 'A' 'B' 'C'};
trials_all_hyper_noisevhyper_noncholinergic=[1 1 1 1 1 3 ...
    1 1 1 3]';

for k=1:numel(dates_all_hyper_noisevhyper_noncholinergic)
    eval(['load ' pwd '\fi_analysis\FI_OU_' dates_all_hyper_noisevhyper_noncholinergic{k} '_' cellnum_all_hyper_noisevhyper_noncholinergic{k} num2str(trials_all_hyper_noisevhyper_noncholinergic(k)) '_fi.mat;'])
    peakrate_all_hyper_noisevhyper_noncholinergic(k,:)=peakrate;
    nofailrate_all_hyper_noisevhyper_noncholinergic(k,:)=nofailrate;
    gains_all_hyper_noisevhyper_noncholinergic(k,1)=pf_all{1}.beta(2);
    rsq_all_hyper_noisevhyper_noncholinergic(k,1)=pf_all{1}.rsquare;
    rate_all_hyper_noisevhyper_noncholinergic(k,:)=rate_all{1};
    imp_all_hyper_noisevhyper_noncholinergic(k,:)=imp;
    holdingvoltage_all_hyper_noisevhyper_noncholinergic(k,:)=mean_holdingvoltage;
    std_noise_all_hyper_noisevhyper_noncholinergic(k)=std_noise;
end

gains_all_hyper_noisevhyper_noncholinergic(isnan(rsq_all_hyper_noisevhyper_noncholinergic))=NaN; % filter out the gains that are NaNs

mean_peakrate_hyper_noisevhyper_noncholinergic=nanmean(peakrate_all_hyper_noisevhyper_noncholinergic);
std_peakrate_hyper_noisevhyper_noncholinergic=nanstd(peakrate_all_hyper_noisevhyper_noncholinergic);
mean_nofailrate_hyper_noisevhyper_noncholinergic=nanmean(nofailrate_all_hyper_noisevhyper_noncholinergic);
std_nofailrate_hyper_noisevhyper_noncholinergic=nanstd(nofailrate_all_hyper_noisevhyper_noncholinergic);
mean_gains_hyper_noisevhyper_noncholinergic=nanmean(gains_all_hyper_noisevhyper_noncholinergic);
std_gains_hyper_noisevhyper_noncholinergic=nanstd(gains_all_hyper_noisevhyper_noncholinergic);
ste_gains_hyper_noisevhyper_noncholinergic=std_gains_hyper_noisevhyper_noncholinergic/sqrt(sum(~isnan(gains_all_hyper_noisevhyper_noncholinergic)));

normalized_gains_all_hyper_noisevhyper_noncholinergic=gains_all_hyper_noisevhyper_noncholinergic./gains_all_hypervhypernoise_noncholinergic;
normalized_mean_gains_hyper_noisevhyper_noncholinergic=nanmean(normalized_gains_all_hyper_noisevhyper_noncholinergic);
normalized_std_gains_hyper_noisevhyper_noncholinergic=nanstd(normalized_gains_all_hyper_noisevhyper_noncholinergic);
normalized_ste_gains_hyper_noisevhyper_noncholinergic=normalized_std_gains_hyper_noisevhyper_noncholinergic/sqrt(sum(~isnan(normalized_gains_all_hyper_noisevhyper_noncholinergic)));
figure;plot(ones(size(normalized_gains_all_hyper_noisevhyper_noncholinergic)),normalized_gains_all_hyper_noisevhyper_noncholinergic,'.','LineWidth',3)
hold on;errorbar(1,normalized_mean_gains_hyper_noisevhyper_noncholinergic,normalized_ste_gains_hyper_noisevhyper_noncholinergic,'or','LineWidth',2)
title('Normalized Non-Cholinergic Hyperpolarized with Noise Gains')
ylabel('Normalized Gain')
axis([0.9 1.1 0.6 1.2])
axis 'auto y'
set(gca, 'XTick', []);
[gainsttest_normalized_hyper_hyper_noise_noncholinergic(1),gainsttest_normalized_hyper_hyper_noise_noncholinergic(2)]=ttest(ones(size(normalized_gains_all_hyper_noisevhyper_noncholinergic)),normalized_gains_all_hyper_noisevhyper_noncholinergic);

mean_imp_hyper_noisevhyper_noncholinergic=nanmean(imp_all_hyper_noisevhyper_noncholinergic);
std_imp_hyper_noisevhyper_noncholinergic=nanstd(imp_all_hyper_noisevhyper_noncholinergic);
mean_holdingvoltage_all_hyper_noisevhyper_noncholinergic=nanmean(holdingvoltage_all_hyper_noisevhyper_noncholinergic);
std_holdingvoltage_all_hyper_noisevhyper_noncholinergic=nanstd(holdingvoltage_all_hyper_noisevhyper_noncholinergic);
mean_std_noise_all_hyper_noisevhyper_noncholinergic=nanmean(std_noise_all_hyper_noisevhyper_noncholinergic);
std_std_noise_all_hyper_noisevhyper_noncholinergic=nanstd(std_noise_all_hyper_noisevhyper_noncholinergic);
mean_rate_hyper_noisevhyper_noncholinergic=nanmean(rate_all_hyper_noisevhyper_noncholinergic);
std_rate_hyper_noisevhyper_noncholinergic=nanstd(rate_all_hyper_noisevhyper_noncholinergic);
ste_rate_hyper_noisevhyper_noncholinergic=std_rate_hyper_noisevhyper_noncholinergic./sqrt(sum(~isnan(rate_all_hyper_noisevhyper_noncholinergic)));

currents=0:10:200;
nlf_fi_hypervhypernoise_noncholinergic=nlinfit(currents,mean_rate_hypervhypernoise_noncholinergic,'sigFun',[320,50,10]);
nlf_fi_hyper_noisevhyper_noncholinergic=nlinfit(currents,mean_rate_hyper_noisevhyper_noncholinergic,'sigFun',[320,50,10]);

hypervhypernoise_noncholinergic_max=nlf_fi_hypervhypernoise_noncholinergic(1);
hypervhypernoise_noncholinergic_midpoint=nlf_fi_hypervhypernoise_noncholinergic(2);
hypervhypernoise_noncholinergic_slope=nlf_fi_hypervhypernoise_noncholinergic(1)/(4*nlf_fi_hypervhypernoise_noncholinergic(3));
hyper_noisevhyper_noncholinergic_max=nlf_fi_hyper_noisevhyper_noncholinergic(1);
hyper_noisevhyper_noncholinergic_midpoint=nlf_fi_hyper_noisevhyper_noncholinergic(2);
hyper_noisevhyper_noncholinergic_slope=nlf_fi_hyper_noisevhyper_noncholinergic(1)/(4*nlf_fi_hyper_noisevhyper_noncholinergic(3));

figure;errorbar([currents;currents]',[mean_rate_hypervhypernoise_noncholinergic;mean_rate_hyper_noisevhyper_noncholinergic]',[ste_rate_hypervhypernoise_noncholinergic;ste_rate_hyper_noisevhyper_noncholinergic]')
legend('Hyperpolarized','Hyperpolarized with Noise')
hold on;plot(currents,sigFun(nlf_fi_hypervhypernoise_noncholinergic,currents),'m');plot(currents,sigFun(nlf_fi_hyper_noisevhyper_noncholinergic,currents),'r')
title('Average f-I Curves for Non-Cholinergic Hyperpolarized and Hyperpolarized with Noise')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% difference between rates (unpaired)
difference_rate_hypervhypernoise_noncholinergic=rate_all_hyper_noisevhyper_noncholinergic-rate_all_hypervhypernoise_noncholinergic;
mean_difference_rate_hypervhypernoise_noncholinergic=nanmean(difference_rate_hypervhypernoise_noncholinergic);
std_difference_rate_hypervhypernoise_noncholinergic=nanstd(difference_rate_hypervhypernoise_noncholinergic);
ste_difference_rate_hypervhypernoise_noncholinergic=std_difference_rate_hypervhypernoise_noncholinergic./sqrt(sum(~isnan(difference_rate_hypervhypernoise_noncholinergic)));

percent_difference_rate_hypervhypernoise_noncholinergic=(difference_rate_hypervhypernoise_noncholinergic./rate_all_hypervhypernoise_noncholinergic)*100;
percent_difference_rate_hypervhypernoise_noncholinergic(~isfinite(percent_difference_rate_hypervhypernoise_noncholinergic))=NaN;
mean_percent_difference_rate_hypervhypernoise_noncholinergic=nanmean(percent_difference_rate_hypervhypernoise_noncholinergic);
std_percent_difference_rate_hypervhypernoise_noncholinergic=nanstd(percent_difference_rate_hypervhypernoise_noncholinergic);
ste_percent_difference_rate_hypervhypernoise_noncholinergic=std_percent_difference_rate_hypervhypernoise_noncholinergic./sqrt(sum(~isnan(percent_difference_rate_hypervhypernoise_noncholinergic)));

new_percent_difference_rate_hypervhypernoise_noncholinergic=difference_rate_hypervhypernoise_noncholinergic./rate_all_hyper_noisevhyper_noncholinergic;
new_percent_difference_rate_hypervhypernoise_noncholinergic(~isfinite(new_percent_difference_rate_hypervhypernoise_noncholinergic))=NaN;
mean_new_percent_difference_rate_hypervhypernoise_noncholinergic=nanmean(new_percent_difference_rate_hypervhypernoise_noncholinergic);
std_new_percent_difference_rate_hypervhypernoise_noncholinergic=nanstd(new_percent_difference_rate_hypervhypernoise_noncholinergic);
ste_new_percent_difference_rate_hypervhypernoise_noncholinergic=std_new_percent_difference_rate_hypervhypernoise_noncholinergic./sqrt(sum(~isnan(new_percent_difference_rate_hypervhypernoise_noncholinergic)));

% difference between rates (paired)
paired_difference_rate_hypervhypernoise_noncholinergic=rate_all_hyper_noisevhyper_noncholinergic-rate_all_hypervhypernoise_noncholinergic;
paired_mean_difference_rate_hypervhypernoise_noncholinergic=nanmean(paired_difference_rate_hypervhypernoise_noncholinergic);
paired_std_difference_rate_hypervhypernoise_noncholinergic=nanstd(paired_difference_rate_hypervhypernoise_noncholinergic);
paired_ste_difference_rate_hypervhypernoise_noncholinergic=paired_std_difference_rate_hypervhypernoise_noncholinergic./sqrt(sum(~isnan(paired_difference_rate_hypervhypernoise_noncholinergic)));

paired_percent_difference_rate_hypervhypernoise_noncholinergic=(paired_difference_rate_hypervhypernoise_noncholinergic./rate_all_hypervhypernoise_noncholinergic)*100;
paired_percent_difference_rate_hypervhypernoise_noncholinergic(~isfinite(paired_percent_difference_rate_hypervhypernoise_noncholinergic))=NaN;
paired_mean_percent_difference_rate_hypervhypernoise_noncholinergic=nanmean(paired_percent_difference_rate_hypervhypernoise_noncholinergic);
paired_std_percent_difference_rate_hypervhypernoise_noncholinergic=nanstd(paired_percent_difference_rate_hypervhypernoise_noncholinergic);
paired_ste_percent_difference_rate_hypervhypernoise_noncholinergic=paired_std_percent_difference_rate_hypervhypernoise_noncholinergic./sqrt(sum(~isnan(paired_percent_difference_rate_hypervhypernoise_noncholinergic)));

paired_new_percent_difference_rate_hypervhypernoise_noncholinergic=paired_difference_rate_hypervhypernoise_noncholinergic./rate_all_hyper_noisevhyper_noncholinergic;
paired_new_percent_difference_rate_hypervhypernoise_noncholinergic(~isfinite(paired_new_percent_difference_rate_hypervhypernoise_noncholinergic))=NaN;
paired_mean_new_percent_difference_rate_hypervhypernoise_noncholinergic=nanmean(paired_new_percent_difference_rate_hypervhypernoise_noncholinergic);
paired_std_new_percent_difference_rate_hypervhypernoise_noncholinergic=nanstd(paired_new_percent_difference_rate_hypervhypernoise_noncholinergic);
paired_ste_new_percent_difference_rate_hypervhypernoise_noncholinergic=paired_std_new_percent_difference_rate_hypervhypernoise_noncholinergic./sqrt(sum(~isnan(paired_new_percent_difference_rate_hypervhypernoise_noncholinergic)));


%% Depolarized Non-Cholinergic (5 sec pulse, 1 sec pause; 200 pA range of currents)
% For Depolarized with Just Noise Non-Cholinergic

dates_all_devdenoise_noncholinergic={'Mar_23_15' 'Mar_28_15' 'Mar_30_15' 'Mar_30_15' 'Mar_30_15' 'Apr_10_15'...
    'Apr_10_15' 'May_05_15' 'May_05_15' 'May_05_15'};
cellnum_all_devdenoise_noncholinergic={'C' 'B' 'A' 'B' 'C' 'A'...
    'C' 'A' 'B' 'C'};
trials_all_devdenoise_noncholinergic=[4 3 2 3 2 6 ...
    5 2 2 4]';

for k=1:numel(dates_all_devdenoise_noncholinergic)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_devdenoise_noncholinergic{k} '_' cellnum_all_devdenoise_noncholinergic{k} num2str(trials_all_devdenoise_noncholinergic(k)) '_fi.mat;'])
    peakrate_all_devdenoise_noncholinergic(k,:)=peakrate;
    nofailrate_all_devdenoise_noncholinergic(k,:)=nofailrate;
    gains_all_devdenoise_noncholinergic(k,1)=pf_all{1}.beta(2);
    rsq_all_devdenoise_noncholinergic(k,1)=pf_all{1}.rsquare;
    rate_all_devdenoise_noncholinergic(k,:)=rate_all{1};
    imp_all_devdenoise_noncholinergic(k,:)=imp;
    holdingvoltage_all_devdenoise_noncholinergic(k,:)=mean_holdingvoltage;
    std_noise_all_devdenoise_noncholinergic(k)=std_noise;
end

gains_all_devdenoise_noncholinergic(isnan(rsq_all_devdenoise_noncholinergic))=NaN; % filter out the gains that are NaNs

mean_peakrate_devdenoise_noncholinergic=nanmean(peakrate_all_devdenoise_noncholinergic);
std_peakrate_devdenoise_noncholinergic=nanstd(peakrate_all_devdenoise_noncholinergic);
mean_nofailrate_devdenoise_noncholinergic=nanmean(nofailrate_all_devdenoise_noncholinergic);
std_nofailrate_devdenoise_noncholinergic=nanstd(nofailrate_all_devdenoise_noncholinergic);
mean_gains_devdenoise_noncholinergic=nanmean(gains_all_devdenoise_noncholinergic);
std_gains_devdenoise_noncholinergic=nanstd(gains_all_devdenoise_noncholinergic);
ste_gains_devdenoise_noncholinergic=std_gains_devdenoise_noncholinergic/sqrt(sum(~isnan(gains_all_devdenoise_noncholinergic)));
mean_imp_devdenoise_noncholinergic=nanmean(imp_all_devdenoise_noncholinergic);
std_imp_devdenoise_noncholinergic=nanstd(imp_all_devdenoise_noncholinergic);
mean_holdingvoltage_all_devdenoise_noncholinergic=nanmean(holdingvoltage_all_devdenoise_noncholinergic);
std_holdingvoltage_all_devdenoise_noncholinergic=nanstd(holdingvoltage_all_devdenoise_noncholinergic);
mean_std_noise_all_devdenoise_noncholinergic=nanmean(std_noise_all_devdenoise_noncholinergic);
std_std_noise_all_devdenoise_noncholinergic=nanstd(std_noise_all_devdenoise_noncholinergic);
mean_rate_devdenoise_noncholinergic=nanmean(rate_all_devdenoise_noncholinergic);
std_rate_devdenoise_noncholinergic=nanstd(rate_all_devdenoise_noncholinergic);
ste_rate_devdenoise_noncholinergic=std_rate_devdenoise_noncholinergic./sqrt(sum(~isnan(rate_all_devdenoise_noncholinergic)));


% Depolarized with Just Noise Non-Cholinergic (200 pA range of currents)
% For Depolarized Non-Cholinergic

dates_all_de_noisevde_noncholinergic={'Mar_24_15' 'Mar_28_15' 'Mar_30_15' 'Mar_30_15' 'Mar_30_15' 'Apr_10_15'...
    'Apr_10_15' 'May_05_15' 'May_05_15' 'May_05_15'};
cellnum_all_de_noisevde_noncholinergic={'C' 'B' 'A' 'B' 'C' 'A'...
    'C' 'A' 'B' 'C'};
trials_all_de_noisevde_noncholinergic=[2 2 2 2 2 4 ...
    2 2 2 4]';

for k=1:numel(dates_all_de_noisevde_noncholinergic)
    eval(['load ' pwd '\fi_analysis\FI_OU_' dates_all_de_noisevde_noncholinergic{k} '_' cellnum_all_de_noisevde_noncholinergic{k} num2str(trials_all_de_noisevde_noncholinergic(k)) '_fi.mat;'])
    peakrate_all_de_noisevde_noncholinergic(k,:)=peakrate;
    nofailrate_all_de_noisevde_noncholinergic(k,:)=nofailrate;
    gains_all_de_noisevde_noncholinergic(k,1)=pf_all{1}.beta(2);
    rsq_all_de_noisevde_noncholinergic(k,1)=pf_all{1}.rsquare;
    rate_all_de_noisevde_noncholinergic(k,:)=rate_all{1};
    imp_all_de_noisevde_noncholinergic(k,:)=imp;
    holdingvoltage_all_de_noisevde_noncholinergic(k,:)=mean_holdingvoltage;
    std_noise_all_de_noisevde_noncholinergic(k)=std_noise;
end

gains_all_de_noisevde_noncholinergic(isnan(rsq_all_de_noisevde_noncholinergic))=NaN; % filter out the gains that are NaNs

mean_peakrate_de_noisevde_noncholinergic=nanmean(peakrate_all_de_noisevde_noncholinergic);
std_peakrate_de_noisevde_noncholinergic=nanstd(peakrate_all_de_noisevde_noncholinergic);
mean_nofailrate_de_noisevde_noncholinergic=nanmean(nofailrate_all_de_noisevde_noncholinergic);
std_nofailrate_de_noisevde_noncholinergic=nanstd(nofailrate_all_de_noisevde_noncholinergic);
mean_gains_de_noisevde_noncholinergic=nanmean(gains_all_de_noisevde_noncholinergic);
std_gains_de_noisevde_noncholinergic=nanstd(gains_all_de_noisevde_noncholinergic);
ste_gains_de_noisevde_noncholinergic=std_gains_de_noisevde_noncholinergic/sqrt(sum(~isnan(gains_all_de_noisevde_noncholinergic)));

normalized_gains_all_de_noisevde_noncholinergic=gains_all_de_noisevde_noncholinergic./gains_all_devdenoise_noncholinergic;
normalized_mean_gains_de_noisevde_noncholinergic=nanmean(normalized_gains_all_de_noisevde_noncholinergic);
normalized_std_gains_de_noisevde_noncholinergic=nanstd(normalized_gains_all_de_noisevde_noncholinergic);
normalized_ste_gains_de_noisevde_noncholinergic=normalized_std_gains_de_noisevde_noncholinergic/sqrt(sum(~isnan(normalized_gains_all_de_noisevde_noncholinergic)));
figure;plot(ones(size(normalized_gains_all_de_noisevde_noncholinergic)),normalized_gains_all_de_noisevde_noncholinergic,'.','LineWidth',3)
hold on;errorbar(1,normalized_mean_gains_de_noisevde_noncholinergic,normalized_ste_gains_de_noisevde_noncholinergic,'or','LineWidth',2)
title('Normalized Non-Cholinergic Depolarized with Noise Gains')
ylabel('Normalized Gain')
axis([0.9 1.1 0.5 1.5])
axis 'auto y'
set(gca, 'XTick', []);
[gainsttest_normalized_de_de_noise_noncholinergic(1),gainsttest_normalized_de_de_noise_noncholinergic(2)]=ttest(ones(size(normalized_gains_all_de_noisevde_noncholinergic)),normalized_gains_all_de_noisevde_noncholinergic);

mean_imp_de_noisevde_noncholinergic=nanmean(imp_all_de_noisevde_noncholinergic);
std_imp_de_noisevde_noncholinergic=nanstd(imp_all_de_noisevde_noncholinergic);
mean_holdingvoltage_all_de_noisevde_noncholinergic=nanmean(holdingvoltage_all_de_noisevde_noncholinergic);
std_holdingvoltage_all_de_noisevde_noncholinergic=nanstd(holdingvoltage_all_de_noisevde_noncholinergic);
mean_std_noise_all_de_noisevde_noncholinergic=nanmean(std_noise_all_de_noisevde_noncholinergic);
std_std_noise_all_de_noisevde_noncholinergic=nanstd(std_noise_all_de_noisevde_noncholinergic);
mean_rate_de_noisevde_noncholinergic=nanmean(rate_all_de_noisevde_noncholinergic);
std_rate_de_noisevde_noncholinergic=nanstd(rate_all_de_noisevde_noncholinergic);
ste_rate_de_noisevde_noncholinergic=std_rate_de_noisevde_noncholinergic./sqrt(sum(~isnan(rate_all_de_noisevde_noncholinergic)));

currents=0:10:200;
nlf_fi_devdenoise_noncholinergic=nlinfit(currents,mean_rate_devdenoise_noncholinergic,'sigFun',[320,50,10]);
nlf_fi_de_noisevde_noncholinergic=nlinfit(currents,mean_rate_de_noisevde_noncholinergic,'sigFun',[320,50,10]);

devdenoise_noncholinergic_max=nlf_fi_devdenoise_noncholinergic(1);
devdenoise_noncholinergic_midpoint=nlf_fi_devdenoise_noncholinergic(2);
devdenoise_noncholinergic_slope=nlf_fi_devdenoise_noncholinergic(1)/(4*nlf_fi_devdenoise_noncholinergic(3));
de_noisevde_noncholinergic_max=nlf_fi_de_noisevde_noncholinergic(1);
de_noisevde_noncholinergic_midpoint=nlf_fi_de_noisevde_noncholinergic(2);
de_noisevde_noncholinergic_slope=nlf_fi_de_noisevde_noncholinergic(1)/(4*nlf_fi_de_noisevde_noncholinergic(3));

figure;errorbar([currents;currents]',[mean_rate_devdenoise_noncholinergic;mean_rate_de_noisevde_noncholinergic]',[ste_rate_devdenoise_noncholinergic;ste_rate_de_noisevde_noncholinergic]')
legend('Depolarized','Depolarized with Just Noise')
hold on;plot(currents,sigFun(nlf_fi_devdenoise_noncholinergic,currents),'m');plot(currents,sigFun(nlf_fi_de_noisevde_noncholinergic,currents),'r')
title('Average f-I Curves for Non-Cholinergic Depolarized and Depolarized with Just Noise')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% difference between rates (unpaired)
difference_rate_devdenoise_noncholinergic=rate_all_de_noisevde_noncholinergic-rate_all_devdenoise_noncholinergic;
mean_difference_rate_devdenoise_noncholinergic=nanmean(difference_rate_devdenoise_noncholinergic);
std_difference_rate_devdenoise_noncholinergic=nanstd(difference_rate_devdenoise_noncholinergic);
ste_difference_rate_devdenoise_noncholinergic=std_difference_rate_devdenoise_noncholinergic./sqrt(sum(~isnan(difference_rate_devdenoise_noncholinergic)));

percent_difference_rate_devdenoise_noncholinergic=(difference_rate_devdenoise_noncholinergic./rate_all_devdenoise_noncholinergic)*100;
percent_difference_rate_devdenoise_noncholinergic(~isfinite(percent_difference_rate_devdenoise_noncholinergic))=NaN;
mean_percent_difference_rate_devdenoise_noncholinergic=nanmean(percent_difference_rate_devdenoise_noncholinergic);
std_percent_difference_rate_devdenoise_noncholinergic=nanstd(percent_difference_rate_devdenoise_noncholinergic);
ste_percent_difference_rate_devdenoise_noncholinergic=std_percent_difference_rate_devdenoise_noncholinergic./sqrt(sum(~isnan(percent_difference_rate_devdenoise_noncholinergic)));

new_percent_difference_rate_devdenoise_noncholinergic=difference_rate_devdenoise_noncholinergic./rate_all_de_noisevde_noncholinergic;
new_percent_difference_rate_devdenoise_noncholinergic(~isfinite(new_percent_difference_rate_devdenoise_noncholinergic))=NaN;
mean_new_percent_difference_rate_devdenoise_noncholinergic=nanmean(new_percent_difference_rate_devdenoise_noncholinergic);
std_new_percent_difference_rate_devdenoise_noncholinergic=nanstd(new_percent_difference_rate_devdenoise_noncholinergic);
ste_new_percent_difference_rate_devdenoise_noncholinergic=std_new_percent_difference_rate_devdenoise_noncholinergic./sqrt(sum(~isnan(new_percent_difference_rate_devdenoise_noncholinergic)));

% difference between rates (paired)
paired_difference_rate_devdenoise_noncholinergic=rate_all_de_noisevde_noncholinergic-rate_all_devdenoise_noncholinergic;
paired_mean_difference_rate_devdenoise_noncholinergic=nanmean(paired_difference_rate_devdenoise_noncholinergic);
paired_std_difference_rate_devdenoise_noncholinergic=nanstd(paired_difference_rate_devdenoise_noncholinergic);
paired_ste_difference_rate_devdenoise_noncholinergic=paired_std_difference_rate_devdenoise_noncholinergic./sqrt(sum(~isnan(paired_difference_rate_devdenoise_noncholinergic)));

paired_percent_difference_rate_devdenoise_noncholinergic=(paired_difference_rate_devdenoise_noncholinergic./rate_all_devdenoise_noncholinergic)*100;
paired_percent_difference_rate_devdenoise_noncholinergic(~isfinite(paired_percent_difference_rate_devdenoise_noncholinergic))=NaN;
paired_mean_percent_difference_rate_devdenoise_noncholinergic=nanmean(paired_percent_difference_rate_devdenoise_noncholinergic);
paired_std_percent_difference_rate_devdenoise_noncholinergic=nanstd(paired_percent_difference_rate_devdenoise_noncholinergic);
paired_ste_percent_difference_rate_devdenoise_noncholinergic=paired_std_percent_difference_rate_devdenoise_noncholinergic./sqrt(sum(~isnan(paired_percent_difference_rate_devdenoise_noncholinergic)));

paired_new_percent_difference_rate_devdenoise_noncholinergic=paired_difference_rate_devdenoise_noncholinergic./rate_all_de_noisevde_noncholinergic;
paired_new_percent_difference_rate_devdenoise_noncholinergic(~isfinite(paired_new_percent_difference_rate_devdenoise_noncholinergic))=NaN;
paired_mean_new_percent_difference_rate_devdenoise_noncholinergic=nanmean(paired_new_percent_difference_rate_devdenoise_noncholinergic);
paired_std_new_percent_difference_rate_devdenoise_noncholinergic=nanstd(paired_new_percent_difference_rate_devdenoise_noncholinergic);
paired_ste_new_percent_difference_rate_devdenoise_noncholinergic=paired_std_new_percent_difference_rate_devdenoise_noncholinergic./sqrt(sum(~isnan(paired_new_percent_difference_rate_devdenoise_noncholinergic)));


%% Statistics

[gainsttest_hyper_de(1),gainsttest_hyper_de(2)]=ttest(gains_all_hypervde,gains_all_devhyper);
[gainsttest_hyper_hyper_noise(1),gainsttest_hyper_hyper_noise(2)]=ttest(gains_all_hypervhypernoise,gains_all_hyper_noisevhyper);
[gainsttest_hyper_hyper_negative_leak(1),gainsttest_hyper_hyper_negative_leak(2)]=ttest(gains_all_hypervhypernegativeleak,gains_all_hyper_negative_leakvhyper);
[gainsttest_hyper_hyper_current_subtracted(1),gainsttest_hyper_hyper_current_subtracted(2)]=ttest(gains_all_hypervhypercurrentsubtracted,gains_all_hyper_current_subtractedvhyper);
[gainsttest_de_de_leak(1),gainsttest_de_de_leak(2)]=ttest(gains_all_devdeleak,gains_all_de_leakvde);
[gainsttest_de_de_noise(1),gainsttest_de_de_noise(2)]=ttest(gains_all_devdenoise,gains_all_de_noisevde);
[gainsttest_de_de_leak_noise(1),gainsttest_de_de_leak_noise(2)]=ttest(gains_all_devdeleaknoise,gains_all_de_leak_noisevde);
[gainsttest_hyper_de_noncholinergic(1),gainsttest_hyper_de_noncholinergic(2)]=ttest(gains_all_hypervde_noncholinergic,gains_all_devhyper_noncholinergic);
[gainsttest_hyper_hyper_noise_noncholinergic(1),gainsttest_hyper_hyper_noise_noncholinergic(2)]=ttest(gains_all_hypervhypernoise_noncholinergic,gains_all_hyper_noisevhyper_noncholinergic);
[gainsttest_de_de_noise_noncholinergic(1),gainsttest_de_de_noise_noncholinergic(2)]=ttest(gains_all_devdenoise_noncholinergic,gains_all_de_noisevde_noncholinergic);


%% Plotting Gains

figure;errorbar(1:2,[mean_gains_hypervde mean_gains_devhyper],[ste_gains_hypervde ste_gains_devhyper],'.m','LineWidth',2);
hold on;bar(1:2,[mean_gains_hypervde mean_gains_devhyper],.5,'m')
title('History-Dependent Change in Gains')
ylabel('Gains [Hz/pA]')
xlabel('Hyperpolarized    Depolarized')
set(gca, 'XTick', []);
% axis([0.5 2.5 0 ])
% axis([0.4 2.6 0 0.2])
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
figure;errorbar(1:2,[mean_gains_devdeleak mean_gains_de_leakvde],[ste_gains_devdeleak ste_gains_de_leakvde],'.m','LineWidth',2);
hold on;bar(1:2,[mean_gains_devdeleak mean_gains_de_leakvde],.5,'m')
title('History-Dependent Change in Gains')
ylabel('Gains [Hz/pA]')
xlabel('Depolarized    Depolarized with Leak')
set(gca, 'XTick', []);
% axis([0.5 2.5 0 ])
% axis([0.4 2.6 0 0.2])
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
% 
% 
% %% Plotting Rate Differences
% 
figure;errorbar(0:10:200,mean_difference_rate_hypervde,ste_difference_rate_hypervde)
title('Difference in Frequencies for Hyperpolarized and Depolarized')
ylabel('Frequency Difference [Hz]')
xlabel('Current [pA]')
% axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,mean_difference_rate_hypervhypernoise,ste_difference_rate_hypervhypernoise)
% title('Difference in Frequencies for Hyperpolarized and Hyperpolarized with Noise')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(1:21,mean_difference_rate_hypervhypernegativeleak,ste_difference_rate_hypervhypernegativeleak)
% title('Difference in Frequencies for Hyperpolarized and Hyperpolarized with Negative Leak')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current Step')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,mean_difference_rate_hypervhypercurrentsubtracted,ste_difference_rate_hypervhypercurrentsubtracted)
% title('Difference in Frequencies for Hyperpolarized and Hyperpolarized with Current Subtracted')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(1:21,mean_difference_rate_devdeleak,ste_difference_rate_devdeleak)
% title('Difference in Frequencies for Depolarized and Depolarized with Leak')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current Step')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,mean_difference_rate_devdenoise,ste_difference_rate_devdenoise)
% title('Difference in Frequencies for Depolarized and Depolarized with Just Noise')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(1:21,mean_difference_rate_devdeleaknoise,ste_difference_rate_devdeleaknoise)
% title('Difference in Frequencies for Depolarized and Depolarized with Leak and Noise')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current Step')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,mean_difference_rate_hypervhypernoise,ste_difference_rate_hypervhypernoise)
% hold on;errorbar(0:10:200,mean_difference_rate_devdenoise,ste_difference_rate_devdenoise,'r')
% title('Difference in Frequencies with and without Noise for Hyperpolarized (Blue) and Depolarized (Red)')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,mean_percent_difference_rate_hypervhypernoise,ste_percent_difference_rate_hypervhypernoise)
% hold on;errorbar(0:10:200,mean_percent_difference_rate_devdenoise,ste_percent_difference_rate_devdenoise,'r')
% title('Percentage Difference in Frequencies with and without Noise for Hyperpolarized (Blue) and Depolarized (Red)')
% ylabel('Frequency Difference [%]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,mean_new_percent_difference_rate_hypervhypernoise,ste_new_percent_difference_rate_hypervhypernoise)
% hold on;errorbar(0:10:200,mean_new_percent_difference_rate_devdenoise,ste_new_percent_difference_rate_devdenoise,'r')
% title('Difference in Frequencies with and without Noise for Hyperpolarized (Blue) and Depolarized (Red)')
% ylabel('Frequency Difference [(fnoise - fnoiseless)/fnoise]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,paired_mean_new_percent_difference_rate_hypervhypernoise,paired_ste_new_percent_difference_rate_hypervhypernoise)
% hold on;errorbar(0:10:200,paired_mean_new_percent_difference_rate_devdenoise,paired_ste_new_percent_difference_rate_devdenoise,'r')
% title('Paired Differences in Frequencies with and without Noise for Hyperpolarized (Blue) and Depolarized (Red)')
% ylabel('Frequency Difference [(fnoise - fnoiseless)/fnoise]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% 
% %% Plotting Gains for Non-Cholinergic Neurons
% 
figure;errorbar(1:2,[mean_gains_hypervde_noncholinergic mean_gains_devhyper_noncholinergic],[ste_gains_hypervde_noncholinergic ste_gains_devhyper_noncholinergic],'.m','LineWidth',2);
hold on;bar(1:2,[mean_gains_hypervde_noncholinergic mean_gains_devhyper_noncholinergic],.5,'m')
title('History-Dependent Change in Gains')
ylabel('Gains [Hz/pA]')
xlabel('Hyperpolarized    Depolarized')
set(gca, 'XTick', []);
% axis([0.5 2.5 0 ])
% axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(1:2,[mean_gains_hypervhypernoise_noncholinergic mean_gains_hyper_noisevhyper_noncholinergic],[ste_gains_hypervhypernoise_noncholinergic ste_gains_hyper_noisevhyper_noncholinergic],'.m','LineWidth',2);
% hold on;bar(1:2,[mean_gains_hypervhypernoise_noncholinergic mean_gains_hyper_noisevhyper_noncholinergic],.5,'m')
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/pA]')
% xlabel('Hyperpolarized    Hyperpolarized with Noise')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(1:2,[mean_gains_devdenoise_noncholinergic mean_gains_de_noisevde_noncholinergic],[ste_gains_devdenoise_noncholinergic ste_gains_de_noisevde_noncholinergic],'.m','LineWidth',2);
% hold on;bar(1:2,[mean_gains_devdenoise_noncholinergic mean_gains_de_noisevde_noncholinergic],.5,'m')
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/pA]')
% xlabel('Depolarized    Depolarized with Noise')
% % axis([0.4 2.6 0 0.2])
% 
% 
% %% Plotting Rate Differences for Non-Cholinergic Neurons
% 
% figure;errorbar(0:10:200,mean_difference_rate_hypervde_noncholinergic,ste_difference_rate_hypervde_noncholinergic)
% title('Difference in Frequencies for Hyperpolarized and Depolarized in Non-Cholinergic Neurons')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,mean_difference_rate_hypervhypernoise_noncholinergic,ste_difference_rate_hypervhypernoise_noncholinergic)
% title('Difference in Frequencies for Hyperpolarized and Hyperpolarized with Noise in Non-Cholinergic Neurons')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,mean_difference_rate_devdenoise_noncholinergic,ste_difference_rate_devdenoise_noncholinergic)
% title('Difference in Frequencies for Depolarized and Depolarized with Just Noise in Non-Cholinergic Neurons')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,mean_difference_rate_hypervhypernoise_noncholinergic,ste_difference_rate_hypervhypernoise_noncholinergic)
% hold on;errorbar(0:10:200,mean_difference_rate_devdenoise_noncholinergic,ste_difference_rate_devdenoise_noncholinergic,'r')
% title('Difference in Frequencies with and without Noise for Hyperpolarized (Blue) and Depolarized (Red) in Non-Cholinergic Neurons')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,mean_percent_difference_rate_hypervhypernoise_noncholinergic,ste_percent_difference_rate_hypervhypernoise_noncholinergic)
% hold on;errorbar(0:10:200,mean_percent_difference_rate_devdenoise_noncholinergic,ste_percent_difference_rate_devdenoise_noncholinergic,'r')
% title('Percentage Difference in Frequencies with and without Noise for Hyperpolarized (Blue) and Depolarized (Red) in Non-Cholinergic Neurons')
% ylabel('Frequency Difference [%]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,mean_new_percent_difference_rate_hypervhypernoise_noncholinergic,ste_new_percent_difference_rate_hypervhypernoise_noncholinergic)
% hold on;errorbar(0:10:200,mean_new_percent_difference_rate_devdenoise_noncholinergic,ste_new_percent_difference_rate_devdenoise_noncholinergic,'r')
% title('Difference in Frequencies with and without Noise for Hyperpolarized (Blue) and Depolarized (Red) in Non-Cholinergic Neurons')
% ylabel('Frequency Difference [(fnoise - fnoiseless)/fnoise]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])
% 
% figure;errorbar(0:10:200,paired_mean_new_percent_difference_rate_hypervhypernoise_noncholinergic,paired_ste_new_percent_difference_rate_hypervhypernoise_noncholinergic)
% hold on;errorbar(0:10:200,paired_mean_new_percent_difference_rate_devdenoise_noncholinergic,paired_ste_new_percent_difference_rate_devdenoise_noncholinergic,'r')
% title('Paired Differences in Frequencies with and without Noise for Hyperpolarized (Blue) and Depolarized (Red) in Non-Cholinergic Neurons')
% ylabel('Frequency Difference [(fnoise - fnoiseless)/fnoise]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])