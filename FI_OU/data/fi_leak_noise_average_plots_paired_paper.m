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
    rsq_all_hypervde(k,1)=pf_all{1}.rsquare;
    rate_all_hypervde(k,:)=rate_all{1};
    imp_all_hypervde(k,:)=imp;
    holdingvoltage_all_hypervde(k,:)=mean_holdingvoltage;
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
    ahp_depth_hypervde(k,:)=ahp_depth{1}*1e3;
    ahp_duration_hypervde(k,:)=ahp_duration{1};
    if iscell(ahp_depth_increment)
        if numel(ahp_depth_increment{1})<21
            ahp_depth_increment{1}=cat(2,ahp_depth_increment{1},repmat({[]},1,21-numel(ahp_depth_increment{1})));
            ahp_duration_increment{1}=cat(2,ahp_duration_increment{1},repmat({[]},1,21-numel(ahp_duration_increment{1})));
        end
    end
    ahp_depth_increments_hypervde{k}=ahp_depth_increment;
    ahp_duration_increments_hypervde{k}=ahp_duration_increment;
    first_spike_delay_hypervde(k,:)=first_spike_delay{1}/10000;
    interspike_voltage_hypervde(k,:)=interspike_voltage{1}*1e3;
    voltage_resistance2_all(k,:)=resistance_voltage2{1};
    voltage_resistance1_all(k,:)=resistance_voltage1{1};
    resistance_all(k,:)=r_m;
    mean_voltage_resistance_diff(k)=mean(voltage_resistance2_all(k,~isnan(resistance_all(k,:)))-voltage_resistance1_all(k,~isnan(resistance_all(k,:))));
    mean_voltage_resistance2(k)=mean(voltage_resistance2_all(k,~isnan(resistance_all(k,:))));
    mean_voltage_resistance1(k)=mean(voltage_resistance1_all(k,~isnan(resistance_all(k,:))));
    resistance_all_hypervde(k)=mean_r_m;
    capacitance_all_hypervde(k)=mean_c_m;
    time_constant_all_hypervde(k)=mean_time_constant;
    std_noise_all(k)=std_noise;
    noise_V_all(k)=noise_V;
end

%measure the standard deviation of the noise with 0 pA input
mean_std_noise=mean(std_noise_all);
std_std_noise=std(std_noise_all);
ste_std_noise=std_std_noise/sqrt(sum(~isnan(std_noise_all)));
mean_noise_V=mean(noise_V_all);
std_noise_V=std(noise_V_all);
ste_noise_V=std_noise_V/sqrt(sum(~isnan(noise_V_all)));

%measure the voltage at which the resistance and capacitance were measured
mean_resistance_voltage=nanmean(mean([mean_voltage_resistance2;mean_voltage_resistance1]));
std_resistance_voltage=nanstd(mean([mean_voltage_resistance2;mean_voltage_resistance1]));
ste_resistance_voltage=std_resistance_voltage/sqrt(sum(~isnan(mean([mean_voltage_resistance2;mean_voltage_resistance1]))));

mean_resistance_hypervde=nanmean(resistance_all_hypervde);
std_resistance_hypervde=nanstd(resistance_all_hypervde);
ste_resistance_hypervde=std_resistance_hypervde/sqrt(sum(~isnan(resistance_all_hypervde)));
max_resistance_hypervde=max(resistance_all_hypervde);
min_resistance_hypervde=min(resistance_all_hypervde);
mean_capacitance_hypervde=nanmean(capacitance_all_hypervde);
std_capacitance_hypervde=nanstd(capacitance_all_hypervde);
ste_capacitance_hypervde=std_capacitance_hypervde/sqrt(sum(~isnan(capacitance_all_hypervde)));
max_capacitance_hypervde=max(capacitance_all_hypervde);
min_capacitance_hypervde=min(capacitance_all_hypervde);
mean_tau_m_hypervde=nanmean(time_constant_all_hypervde);
std_tau_m_hypervde=nanstd(time_constant_all_hypervde);
ste_tau_m_hypervde=std_tau_m_hypervde/sqrt(sum(~isnan(time_constant_all_hypervde)));
max_tau_m_hypervde=max(time_constant_all_hypervde);
min_tau_m_hypervde=min(time_constant_all_hypervde);

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
ste_imp_hypervde=std_imp_hypervde/sqrt(sum(~isnan(imp_all_hypervde)));
mean_holdingvoltage_all_hypervde=nanmean(holdingvoltage_all_hypervde);
std_holdingvoltage_all_hypervde=nanstd(holdingvoltage_all_hypervde);
ste_holdingvoltage_all_hypervde=std_holdingvoltage_all_hypervde/sqrt(sum(~isnan(holdingvoltage_all_hypervde)));
mean_rate_hypervde=nanmean(rate_all_hypervde);
std_rate_hypervde=nanstd(rate_all_hypervde);
ste_rate_hypervde=std_rate_hypervde./sqrt(sum(~isnan(rate_all_hypervde)));

mean_spikeform_hypervde=nanmean(mean_spikeform_all_hypervde);
std_spikeform_hypervde=nanstd(mean_spikeform_all_hypervde);
ste_spikeform_hypervde=std_spikeform_hypervde./sqrt(sum(~isnan(mean_spikeform_all_hypervde)));

% find averages and standard errors for ahp depth, ahp duration, delay to
% first spike, and interspike voltage.

% mean_ahp_depth_hypervde=nanmean(ahp_depth_hypervde);
% std_ahp_depth_hypervde=nanstd(ahp_depth_hypervde);
% ste_ahp_depth_hypervde=std_ahp_depth_hypervde./sqrt(sum(~isnan(ahp_depth_hypervde)));
% mean_ahp_duration_hypervde=nanmean(ahp_duration_hypervde);
% std_ahp_duration_hypervde=nanstd(ahp_duration_hypervde);
% ste_ahp_duration_hypervde=std_ahp_duration_hypervde./sqrt(sum(~isnan(ahp_duration_hypervde)));

mean_first_spike_delay_hypervde=nanmean(first_spike_delay_hypervde);
std_first_spike_delay_hypervde=nanstd(first_spike_delay_hypervde);
ste_first_spike_delay_hypervde=std_first_spike_delay_hypervde./sqrt(sum(~isnan(first_spike_delay_hypervde)));

interspike_voltage_hypervde(rate_all_hypervde==0)=NaN;
mean_interspike_voltage_hypervde=nanmean(interspike_voltage_hypervde);
std_interspike_voltage_hypervde=nanstd(interspike_voltage_hypervde);
ste_interspike_voltage_hypervde=std_interspike_voltage_hypervde./sqrt(sum(~isnan(interspike_voltage_hypervde)));


% Depolarized (5 sec pulse, 1 sec pause)
% For Hyperpolarized

% % These are the 1 sec pulse, 1 sec pauses
% dates_all_devhyper={'Oct_03_14' 'Oct_03_14' 'Oct_06_14' 'Oct_06_14' 'Oct_06_14' 'Oct_14_14'...
%     'Oct_14_14'};
% cellnum_all_devhyper={'A' 'B' 'A' 'B' 'C' 'A'...
%     'B'};
% trials_all_devhyper=[2 2 2 2 2 2 ...
%     2]';

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
    ahp_depth_devhyper(k,:)=ahp_depth{1}*1e3;
    ahp_duration_devhyper(k,:)=ahp_duration{1};
    if iscell(ahp_depth_increment)
        if numel(ahp_depth_increment{1})<21
            ahp_depth_increment{1}=cat(2,ahp_depth_increment{1},repmat({[]},1,21-numel(ahp_depth_increment{1})));
            ahp_duration_increment{1}=cat(2,ahp_duration_increment{1},repmat({[]},1,21-numel(ahp_duration_increment{1})));
        end
    end
    ahp_depth_increments_devhyper{k}=ahp_depth_increment;
    ahp_duration_increments_devhyper{k}=ahp_duration_increment;
    first_spike_delay_devhyper(k,:)=first_spike_delay{1}/10000;
    interspike_voltage_devhyper(k,:)=interspike_voltage{1}*1e3;
    resistance_all_devhyper(k)=mean_r_m;
    capacitance_all_devhyper(k)=mean_c_m;
    time_constant_all_devhyper(k)=mean_time_constant;
end

mean_resistance_devhyper=nanmean(resistance_all_devhyper);
std_resistance_devhyper=nanstd(resistance_all_devhyper);
ste_resistance_devhyper=std_resistance_devhyper/sqrt(sum(~isnan(resistance_all_devhyper)));
max_resistance_devhyper=max(resistance_all_devhyper);
min_resistance_devhyper=min(resistance_all_devhyper);
mean_capacitance_devhyper=nanmean(capacitance_all_devhyper);
std_capacitance_devhyper=nanstd(capacitance_all_devhyper);
ste_capacitance_devhyper=std_capacitance_devhyper/sqrt(sum(~isnan(capacitance_all_devhyper)));
max_capacitance_devhyper=max(capacitance_all_devhyper);
min_capacitance_devhyper=min(capacitance_all_devhyper);
mean_tau_m_devhyper=nanmean(time_constant_all_devhyper);
std_tau_m_devhyper=nanstd(time_constant_all_devhyper);
ste_tau_m_devhyper=std_tau_m_devhyper/sqrt(sum(~isnan(time_constant_all_devhyper)));
max_tau_m_devhyper=max(time_constant_all_devhyper);
min_tau_m_devhyper=min(time_constant_all_devhyper);

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

% figure;errorbar(1:2,[mean_ISIratio_hypervde mean_ISIratio_devhyper],[ste_ISIratio_hypervde ste_ISIratio_devhyper],'.')
% hold on;bar(1:2,[mean_ISIratio_hypervde mean_ISIratio_devhyper],.5,'m')
[ttestISIratio_hypervde(1),ttestISIratio_hypervde(2)]=ttest(matchfreq_ISIratio_hypervde,matchfreq_ISIratio_devhyper);

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
normalized_mean_gains_devhyper=nanmean(normalized_gains_all_devhyper([1:10 12:24 27:end]));
normalized_std_gains_devhyper=nanstd(normalized_gains_all_devhyper([1:10 12:24 27:end]));
normalized_ste_gains_devhyper=normalized_std_gains_devhyper/sqrt(sum(~isnan(normalized_gains_all_devhyper([1:10 12:24 27:end]))));
figure;plot(ones(size(normalized_gains_all_devhyper([1:10 12:24 27:end]))),normalized_gains_all_devhyper([1:10 12:24 27:end]),'.','LineWidth',3)
hold on;errorbar(1,normalized_mean_gains_devhyper,normalized_ste_gains_devhyper,'or','LineWidth',2)
title('Normalized Depolarized Gains')
ylabel('Normalized Gain')
axis([0.9 1.1 -20 120])
axis 'auto y'
set(gca, 'XTick', []);
[gainsttest_normalized_hyper_de(1),gainsttest_normalized_hyper_de(2)]=ttest(ones(size(normalized_gains_all_devhyper([1:10 12:end-1]))),normalized_gains_all_devhyper([1:10 12:end-1]));

%better normalized that we used in the paper
nanmean(gains_all_hypervde./gains_all_devhyper)
nanstd(gains_all_hypervde./gains_all_devhyper)/sqrt(sum(~isnan(gains_all_hypervde./gains_all_devhyper)))

figure;errorbar(1,normalized_mean_gains_devhyper,normalized_ste_gains_devhyper)
hold on;bar(1,normalized_mean_gains_devhyper,.5,'m')
ylabel('normalized gain [de./hyper.]')
axis([0.5 1.5 0 1])
set(gca, 'XTick', []);
axis 'auto y'

%rheobase measures
rheobase_currents=0:10:200;
rheobase_hypervde=nan(1,numel(dates_all_hypervde));
rheobase_devhyper=nan(1,numel(dates_all_hypervde));
for k=1:numel(dates_all_hypervde)
    if numel(find(rate_all_hypervde(k,:)>0,1))>0
        rheobase_hypervde(k)=rheobase_currents(find(rate_all_hypervde(k,:)>0,1));
    end
    if numel(find(rate_all_devhyper(k,:)>0,1))>0
        rheobase_devhyper(k)=rheobase_currents(find(rate_all_devhyper(k,:)>0,1));
    end
end

mean_rheobase_hypervde=nanmean(rheobase_hypervde);
std_rheobase_hypervde=nanstd(rheobase_hypervde);
ste_rheobase_hypervde=std_rheobase_hypervde/sqrt(sum(~isnan(rheobase_hypervde)));
mean_rheobase_devhyper=nanmean(rheobase_devhyper);
std_rheobase_devhyper=nanstd(rheobase_devhyper);
ste_rheobase_devhyper=std_rheobase_devhyper/sqrt(sum(~isnan(rheobase_devhyper)));

for k=1:numel(rheobase_hypervde)
    figure(10);hold on;plot([0 1],[rheobase_hypervde(k) rheobase_devhyper(k)])
end

[rheobasettest(1),rheobasettest(2)]=ttest(rheobase_hypervde,rheobase_devhyper);

mean_imp_devhyper=nanmean(imp_all_devhyper);
std_imp_devhyper=nanstd(imp_all_devhyper);
ste_imp_devhyper=std_imp_devhyper/sqrt(sum(~isnan(imp_all_devhyper)));
mean_holdingvoltage_all_devhyper=nanmean(holdingvoltage_all_devhyper);
std_holdingvoltage_all_devhyper=nanstd(holdingvoltage_all_devhyper);
ste_holdingvoltage_all_devhyper=std_holdingvoltage_all_devhyper/sqrt(sum(~isnan(holdingvoltage_all_devhyper)));
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

figure;shadedErrorBar(currents,mean_rate_hypervde,ste_rate_hypervde,'g')
hold on;shadedErrorBar(currents,mean_rate_devhyper,ste_rate_devhyper,'k')
hold on;plot(currents,sigFun(nlf_fi_hypervde,currents),'m');plot(currents,sigFun(nlf_fi_devhyper,currents),'r')
title('Average f-I Curves for Hyperpolarized and Depolarized')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% figure;errorbar([currents;currents]',[mean_rate_hypervde;mean_rate_devhyper]',[ste_rate_hypervde;ste_rate_devhyper]')
% legend('Hyperpolarized','Depolarized')
% hold on;plot(currents,sigFun(nlf_fi_hypervde,currents),'m');plot(currents,sigFun(nlf_fi_devhyper,currents),'r')
% title('Average f-I Curves for Hyperpolarized and Depolarized')
% xlabel('Current [pA]')
% ylabel('Frequency [Hz]')

% difference between rates
difference_rate_hypervde=rate_all_devhyper-rate_all_hypervde;
mean_difference_rate_hypervde=nanmean(difference_rate_hypervde);
std_difference_rate_hypervde=nanstd(difference_rate_hypervde);
ste_difference_rate_hypervde=std_difference_rate_hypervde./sqrt(sum(~isnan(difference_rate_hypervde)));

% find averages and standard errors for ahp depth, ahp duration, delay to
% first spike, and interspike voltage.
bins=0:10;
for p=1:numel(bins)-1
    binned_ahp_depth_hypervde{p}=ahp_depth_hypervde(rate_all_hypervde<bins(p+1) & bins(p)<=rate_all_hypervde);
    mean_binned_ahp_depth_hypervde(p)=nanmean(binned_ahp_depth_hypervde{p});
    std_binned_ahp_depth_hypervde(p)=nanstd(binned_ahp_depth_hypervde{p});
    ste_binned_ahp_depth_hypervde(p)=std_binned_ahp_depth_hypervde(p)/sqrt(sum(~isnan(binned_ahp_depth_hypervde{p})));
    %find the number of cells involved in each bin
    number_of_hyper_cells_depth(p)=sum(sum([rate_all_hypervde<bins(p+1) & bins(p)<=rate_all_hypervde]')>0);
    
    binned_ahp_depth_devhyper{p}=ahp_depth_devhyper(rate_all_devhyper<bins(p+1) & bins(p)<=rate_all_devhyper);
    mean_binned_ahp_depth_devhyper(p)=nanmean(binned_ahp_depth_devhyper{p});
    std_binned_ahp_depth_devhyper(p)=nanstd(binned_ahp_depth_devhyper{p});
    ste_binned_ahp_depth_devhyper(p)=std_binned_ahp_depth_devhyper(p)/sqrt(sum(~isnan(binned_ahp_depth_devhyper{p})));
    %find the number of cells involved in each bin
    number_of_de_cells_depth(p)=sum(sum([rate_all_devhyper<bins(p+1) & bins(p)<=rate_all_devhyper]')>0);
    
    binned_ahp_duration_hypervde{p}=ahp_duration_hypervde(rate_all_hypervde<bins(p+1) & bins(p)<=rate_all_hypervde);
    mean_binned_ahp_duration_hypervde(p)=nanmean(binned_ahp_duration_hypervde{p});
    std_binned_ahp_duration_hypervde(p)=nanstd(binned_ahp_duration_hypervde{p});
    ste_binned_ahp_duration_hypervde(p)=std_binned_ahp_duration_hypervde(p)/sqrt(sum(~isnan(binned_ahp_duration_hypervde{p})));
    
    binned_ahp_duration_devhyper{p}=ahp_duration_devhyper(rate_all_devhyper<bins(p+1) & bins(p)<=rate_all_devhyper);
    mean_binned_ahp_duration_devhyper(p)=nanmean(binned_ahp_duration_devhyper{p});
    std_binned_ahp_duration_devhyper(p)=nanstd(binned_ahp_duration_devhyper{p});
    ste_binned_ahp_duration_devhyper(p)=std_binned_ahp_duration_devhyper(p)/sqrt(sum(~isnan(binned_ahp_duration_devhyper{p})));
    
    [rowhyper{p},columnhyper{p}]=find(rate_all_hypervde<bins(p+1) & bins(p)<=rate_all_hypervde); % number of neurons in each bin
    [rowde{p},columnde{p}]=find(rate_all_devhyper<bins(p+1) & bins(p)<=rate_all_devhyper); % number of neurons in each bin
    num_neurons_depthhyper(p)=numel(unique(rowhyper{p}));
    num_neurons_depthde(p)=numel(unique(rowde{p}));
    
    if numel(binned_ahp_depth_hypervde{p})>0
        [ahp_depth_ttest(p,1),ahp_depth_ttest(p,2)]=ttest2(binned_ahp_depth_hypervde{p},binned_ahp_depth_devhyper{p},0.05/7);
        [ahp_duration_ttest(p,1),ahp_duration_ttest(p,2)]=ttest2(binned_ahp_duration_hypervde{p},binned_ahp_duration_devhyper{p},0.05/7);
    else
        ahp_depth_ttest(p,:)=[NaN NaN];
        ahp_duration_ttest(p,:)=[NaN NaN];
    end
end
for p=1:numel(bins) 
   % pools all ahps into frequency bins, instead of averaging pulses first
    for k=1:numel(dates_all_hypervde)
        if iscell(ahp_duration_increments_hypervde{k})
            if p==numel(bins)
                binned_ahp_depth_increments_hypervde{p}{k}=cat(2,ahp_depth_increments_hypervde{k}{1}{bins(p)<rate_all_hypervde(k,:)});
                binned_ahp_duration_increments_hypervde{p}{k}=cat(2,ahp_duration_increments_hypervde{k}{1}{bins(p)<rate_all_hypervde(k,:)});
            else
                binned_ahp_depth_increments_hypervde{p}{k}=cat(2,ahp_depth_increments_hypervde{k}{1}{rate_all_hypervde(k,:)<bins(p+1) & bins(p)<=rate_all_hypervde(k,:)});
                binned_ahp_duration_increments_hypervde{p}{k}=cat(2,ahp_duration_increments_hypervde{k}{1}{rate_all_hypervde(k,:)<bins(p+1) & bins(p)<=rate_all_hypervde(k,:)});
            end
        end
    end
    binned_ahp_depth_pooled_hypervde{p}=cat(2,binned_ahp_depth_increments_hypervde{p}{:});
    binned_ahp_duration_pooled_hypervde{p}=cat(2,binned_ahp_duration_increments_hypervde{p}{:});
    mean_binned_ahp_depth_pooled_hypervde(p)=nanmean(binned_ahp_depth_pooled_hypervde{p});
    std_binned_ahp_depth_pooled_hypervde(p)=nanstd(binned_ahp_depth_pooled_hypervde{p});
    ste_binned_ahp_depth_pooled_hypervde(p)=std_binned_ahp_depth_pooled_hypervde(p)/sqrt(sum(~isnan(binned_ahp_depth_pooled_hypervde{p})));
    mean_binned_ahp_duration_pooled_hypervde(p)=nanmean(binned_ahp_duration_pooled_hypervde{p});
    std_binned_ahp_duration_pooled_hypervde(p)=nanstd(binned_ahp_duration_pooled_hypervde{p});
    ste_binned_ahp_duration_pooled_hypervde(p)=std_binned_ahp_duration_pooled_hypervde(p)/sqrt(sum(~isnan(binned_ahp_duration_pooled_hypervde{p})));
    for k=1:numel(dates_all_devhyper)
        if iscell(ahp_duration_increments_devhyper{k})
            if p==numel(bins)
                binned_ahp_depth_increments_devhyper{p}{k}=cat(2,ahp_depth_increments_devhyper{k}{1}{bins(p)<rate_all_devhyper(k,:)});
                binned_ahp_duration_increments_devhyper{p}{k}=cat(2,ahp_duration_increments_devhyper{k}{1}{bins(p)<rate_all_devhyper(k,:)});
            else
                binned_ahp_depth_increments_devhyper{p}{k}=cat(2,ahp_depth_increments_devhyper{k}{1}{rate_all_devhyper(k,:)<bins(p+1) & bins(p)<=rate_all_devhyper(k,:)});
                binned_ahp_duration_increments_devhyper{p}{k}=cat(2,ahp_duration_increments_devhyper{k}{1}{rate_all_devhyper(k,:)<bins(p+1) & bins(p)<=rate_all_devhyper(k,:)});
            end
        end
    end
    binned_ahp_depth_pooled_devhyper{p}=cat(2,binned_ahp_depth_increments_devhyper{p}{:});
    binned_ahp_duration_pooled_devhyper{p}=cat(2,binned_ahp_duration_increments_devhyper{p}{:});
    mean_binned_ahp_depth_pooled_devhyper(p)=nanmean(binned_ahp_depth_pooled_devhyper{p});
    std_binned_ahp_depth_pooled_devhyper(p)=nanstd(binned_ahp_depth_pooled_devhyper{p});
    ste_binned_ahp_depth_pooled_devhyper(p)=std_binned_ahp_depth_pooled_devhyper(p)/sqrt(sum(~isnan(binned_ahp_depth_pooled_devhyper{p})));
    mean_binned_ahp_duration_pooled_devhyper(p)=nanmean(binned_ahp_duration_pooled_devhyper{p});
    std_binned_ahp_duration_pooled_devhyper(p)=nanstd(binned_ahp_duration_pooled_devhyper{p});
    ste_binned_ahp_duration_pooled_devhyper(p)=std_binned_ahp_duration_pooled_devhyper(p)/sqrt(sum(~isnan(binned_ahp_duration_pooled_devhyper{p})));
    
    if numel(binned_ahp_depth_pooled_hypervde{p})>0
        [ahp_depth_pooled_ttest(p,1),ahp_depth_pooled_ttest(p,2)]=ttest2(binned_ahp_depth_pooled_hypervde{p},binned_ahp_depth_pooled_devhyper{p},0.05/8);
        [ahp_duration_pooled_ttest(p,1),ahp_duration_pooled_ttest(p,2)]=ttest2(binned_ahp_duration_pooled_hypervde{p},binned_ahp_duration_pooled_devhyper{p},0.05/8);
    else
        ahp_depth_pooled_ttest(p,:)=[NaN NaN];
        ahp_duration_pooled_ttest(p,:)=[NaN NaN];
    end
end
[mean_binned_ahp_depth_pooled_hypervde;ste_binned_ahp_depth_pooled_hypervde]'*1e3
[mean_binned_ahp_depth_pooled_devhyper;ste_binned_ahp_depth_pooled_devhyper]'*1e3
[mean_binned_ahp_duration_pooled_hypervde;ste_binned_ahp_duration_pooled_hypervde]'
[mean_binned_ahp_duration_pooled_devhyper;ste_binned_ahp_duration_pooled_devhyper]'

% g1 is the group that defines hyperpolarized (1) or depolarized (2)
g1_pooled_depth=[repmat({'hyper'},size(binned_ahp_depth_pooled_hypervde{1}'));repmat({'de'},size(binned_ahp_depth_pooled_devhyper{1}'));...
    repmat({'hyper'},size(binned_ahp_depth_pooled_hypervde{2}'));repmat({'de'},size(binned_ahp_depth_pooled_devhyper{2}'));...
    repmat({'hyper'},size(binned_ahp_depth_pooled_hypervde{3}'));repmat({'de'},size(binned_ahp_depth_pooled_devhyper{3}'));...
    repmat({'hyper'},size(binned_ahp_depth_pooled_hypervde{4}'));repmat({'de'},size(binned_ahp_depth_pooled_devhyper{4}'));...
    repmat({'hyper'},size(binned_ahp_depth_pooled_hypervde{5}'));repmat({'de'},size(binned_ahp_depth_pooled_devhyper{5}'));...
    repmat({'hyper'},size(binned_ahp_depth_pooled_hypervde{6}'));repmat({'de'},size(binned_ahp_depth_pooled_devhyper{6}'));...
    repmat({'hyper'},size(binned_ahp_depth_pooled_hypervde{7}'));repmat({'de'},size(binned_ahp_depth_pooled_devhyper{7}'));...
    repmat({'hyper'},size(binned_ahp_depth_pooled_hypervde{8}'));repmat({'de'},size(binned_ahp_depth_pooled_devhyper{8}'))];
g1_pooled_duration=[repmat({'hyper'},size(binned_ahp_duration_pooled_hypervde{1}'));repmat({'de'},size(binned_ahp_duration_pooled_devhyper{1}'));...
    repmat({'hyper'},size(binned_ahp_duration_pooled_hypervde{2}'));repmat({'de'},size(binned_ahp_duration_pooled_devhyper{2}'));...
    repmat({'hyper'},size(binned_ahp_duration_pooled_hypervde{3}'));repmat({'de'},size(binned_ahp_duration_pooled_devhyper{3}'));...
    repmat({'hyper'},size(binned_ahp_duration_pooled_hypervde{4}'));repmat({'de'},size(binned_ahp_duration_pooled_devhyper{4}'));...
    repmat({'hyper'},size(binned_ahp_duration_pooled_hypervde{5}'));repmat({'de'},size(binned_ahp_duration_pooled_devhyper{5}'));...
    repmat({'hyper'},size(binned_ahp_duration_pooled_hypervde{6}'));repmat({'de'},size(binned_ahp_duration_pooled_devhyper{6}'));...
    repmat({'hyper'},size(binned_ahp_duration_pooled_hypervde{7}'));repmat({'de'},size(binned_ahp_duration_pooled_devhyper{7}'));...
    repmat({'hyper'},size(binned_ahp_duration_pooled_hypervde{8}'));repmat({'de'},size(binned_ahp_duration_pooled_devhyper{8}'))];

% g2 is the group that defines the frequency bin
g2_pooled_depth=[repmat(1,size(binned_ahp_depth_pooled_hypervde{1}'));repmat(1,size(binned_ahp_depth_pooled_devhyper{1}'));...
    repmat(2,size(binned_ahp_depth_pooled_hypervde{2}'));repmat(2,size(binned_ahp_depth_pooled_devhyper{2}'));...
    repmat(3,size(binned_ahp_depth_pooled_hypervde{3}'));repmat(3,size(binned_ahp_depth_pooled_devhyper{3}'));...
    repmat(4,size(binned_ahp_depth_pooled_hypervde{4}'));repmat(4,size(binned_ahp_depth_pooled_devhyper{4}'));...
    repmat(5,size(binned_ahp_depth_pooled_hypervde{5}'));repmat(5,size(binned_ahp_depth_pooled_devhyper{5}'));...
    repmat(6,size(binned_ahp_depth_pooled_hypervde{6}'));repmat(6,size(binned_ahp_depth_pooled_devhyper{6}'));...
    repmat(7,size(binned_ahp_depth_pooled_hypervde{7}'));repmat(7,size(binned_ahp_depth_pooled_devhyper{7}'));...
    repmat(8,size(binned_ahp_depth_pooled_hypervde{8}'));repmat(8,size(binned_ahp_depth_pooled_devhyper{8}'))];
g2_pooled_duration=[repmat(1,size(binned_ahp_duration_pooled_hypervde{1}'));repmat(1,size(binned_ahp_duration_pooled_devhyper{1}'));...
    repmat(2,size(binned_ahp_duration_pooled_hypervde{2}'));repmat(2,size(binned_ahp_duration_pooled_devhyper{2}'));...
    repmat(3,size(binned_ahp_duration_pooled_hypervde{3}'));repmat(3,size(binned_ahp_duration_pooled_devhyper{3}'));...
    repmat(4,size(binned_ahp_duration_pooled_hypervde{4}'));repmat(4,size(binned_ahp_duration_pooled_devhyper{4}'));...
    repmat(5,size(binned_ahp_duration_pooled_hypervde{5}'));repmat(5,size(binned_ahp_duration_pooled_devhyper{5}'));...
    repmat(6,size(binned_ahp_duration_pooled_hypervde{6}'));repmat(6,size(binned_ahp_duration_pooled_devhyper{6}'));...
    repmat(7,size(binned_ahp_duration_pooled_hypervde{7}'));repmat(7,size(binned_ahp_duration_pooled_devhyper{7}'));...
    repmat(8,size(binned_ahp_duration_pooled_hypervde{8}'));repmat(8,size(binned_ahp_duration_pooled_devhyper{8}'))];

anova_pooled_depth=anovan([binned_ahp_depth_pooled_hypervde{1}'*1e3;binned_ahp_depth_pooled_devhyper{1}'*1e3;...
    binned_ahp_depth_pooled_hypervde{2}'*1e3;binned_ahp_depth_pooled_devhyper{2}'*1e3;...
    binned_ahp_depth_pooled_hypervde{3}'*1e3;binned_ahp_depth_pooled_devhyper{3}'*1e3;...
    binned_ahp_depth_pooled_hypervde{4}'*1e3;binned_ahp_depth_pooled_devhyper{4}'*1e3;...
    binned_ahp_depth_pooled_hypervde{5}'*1e3;binned_ahp_depth_pooled_devhyper{5}'*1e3;...
    binned_ahp_depth_pooled_hypervde{6}'*1e3;binned_ahp_depth_pooled_devhyper{6}'*1e3;...
    binned_ahp_depth_pooled_hypervde{7}'*1e3;binned_ahp_depth_pooled_devhyper{7}'*1e3;...
    binned_ahp_depth_pooled_hypervde{8}'*1e3;binned_ahp_depth_pooled_devhyper{8}'*1e3],...
    {g1_pooled_depth,g2_pooled_depth});
anova_pooled_duration=anovan([binned_ahp_duration_pooled_hypervde{1}';binned_ahp_duration_pooled_devhyper{1}';...
    binned_ahp_duration_pooled_hypervde{2}';binned_ahp_duration_pooled_devhyper{2}';...
    binned_ahp_duration_pooled_hypervde{3}';binned_ahp_duration_pooled_devhyper{3}';...
    binned_ahp_duration_pooled_hypervde{4}';binned_ahp_duration_pooled_devhyper{4}';...
    binned_ahp_duration_pooled_hypervde{5}';binned_ahp_duration_pooled_devhyper{5}';...
    binned_ahp_duration_pooled_hypervde{6}';binned_ahp_duration_pooled_devhyper{6}';...
    binned_ahp_duration_pooled_hypervde{7}';binned_ahp_duration_pooled_devhyper{7}';...
    binned_ahp_duration_pooled_hypervde{8}';binned_ahp_duration_pooled_devhyper{8}'],...
    {g1_pooled_duration,g2_pooled_duration});

figure(50);errorbar([0:10;0:10]'+.5,[mean_binned_ahp_depth_pooled_hypervde;mean_binned_ahp_depth_pooled_devhyper]'*1e3,[ste_binned_ahp_depth_pooled_hypervde;ste_binned_ahp_depth_pooled_devhyper]'*1e3)
% axis([0 10 0 2.5])
% axis 'auto y'
figure(51);errorbar([0:10;0:10]'+.5,[mean_binned_ahp_duration_pooled_hypervde;mean_binned_ahp_duration_pooled_devhyper]',[ste_binned_ahp_duration_pooled_hypervde;ste_binned_ahp_duration_pooled_devhyper]')

for k=1:numel(dates_all_devhyper)
    if iscell(ahp_duration_increments_devhyper{k})
        for p=0.2:0.2:7.2
            if sum(round(rate_all_hypervde(k,:)*10)/10==p)>0
                numratehypervde=sum(round(rate_all_hypervde(k,:)*10)/10==p);
                indexratehypervde=find(round(rate_all_hypervde(k,:)*10)/10==p);
                for h=1:numratehypervde
                    figure(50);hold on;scatter(p*ones(numel(ahp_depth_increments_hypervde{k}{1}{indexratehypervde(numratehypervde)}),1),ahp_depth_increments_hypervde{k}{1}{indexratehypervde(numratehypervde)}*1e3,[],'.b')
                end
            end
        end
        for p=0.2:0.2:13.8
            if sum(round(rate_all_devhyper(k,:)*10)/10==p)>0
                numratedevhyper=sum(round(rate_all_devhyper(k,:)*10)/10==p);
                indexratedevhyper=find(round(rate_all_devhyper(k,:)*10)/10==p);
                for h=1:numratehypervde
                    figure(50);hold on;scatter(p*ones(numel(ahp_depth_increments_devhyper{k}{1}{indexratedevhyper(numratedevhyper)}),1),ahp_depth_increments_devhyper{k}{1}{indexratedevhyper(numratedevhyper)}*1e3,[],'.r')
                end
            end
        end
        
        for p=0.2:0.2:7.2
            if sum(round(rate_all_hypervde(k,:)*10)/10==p)>0
                numratehypervde=sum(round(rate_all_hypervde(k,:)*10)/10==p);
                indexratehypervde=find(round(rate_all_hypervde(k,:)*10)/10==p);
                for h=1:numratehypervde
                    figure(51);hold on;scatter(p*ones(numel(ahp_duration_increments_hypervde{k}{1}{indexratehypervde(numratehypervde)}),1),ahp_duration_increments_hypervde{k}{1}{indexratehypervde(numratehypervde)},[],'.b')
                end
            end
        end
        for p=0.2:0.2:13.8
            if sum(round(rate_all_devhyper(k,:)*10)/10==p)>0
                numratedevhyper=sum(round(rate_all_devhyper(k,:)*10)/10==p);
                indexratedevhyper=find(round(rate_all_devhyper(k,:)*10)/10==p);
                for h=1:numratehypervde
                    figure(51);hold on;scatter(p*ones(numel(ahp_duration_increments_devhyper{k}{1}{indexratedevhyper(numratedevhyper)}),1),ahp_duration_increments_devhyper{k}{1}{indexratedevhyper(numratedevhyper)},[],'.r')
                end
            end
        end
    end
end
figure(50);ylabel('AHP depth [mV]')
xlabel('firing rate [spikes/s]')
figure(51);ylabel('AHP duration [s]')
xlabel('firing rate [spikes/s]')

binned_ahp_depth_hypervde{11}=ahp_depth_hypervde(bins(11)<rate_all_hypervde);
mean_binned_ahp_depth_hypervde(11)=nanmean(binned_ahp_depth_hypervde{11});
std_binned_ahp_depth_hypervde(11)=nanstd(binned_ahp_depth_hypervde{11});
ste_binned_ahp_depth_hypervde(11)=std_binned_ahp_depth_hypervde(11)/sqrt(sum(~isnan(binned_ahp_depth_hypervde{11})));

binned_ahp_depth_devhyper{11}=ahp_depth_devhyper(bins(11)<rate_all_devhyper);
mean_binned_ahp_depth_devhyper(11)=nanmean(binned_ahp_depth_devhyper{11});
std_binned_ahp_depth_devhyper(11)=nanstd(binned_ahp_depth_devhyper{11});
ste_binned_ahp_depth_devhyper(11)=std_binned_ahp_depth_devhyper(11)/sqrt(sum(~isnan(binned_ahp_depth_devhyper{11})));

binned_ahp_duration_hypervde{11}=ahp_duration_hypervde(bins(11)<rate_all_hypervde);
mean_binned_ahp_duration_hypervde(11)=nanmean(binned_ahp_duration_hypervde{11});
std_binned_ahp_duration_hypervde(11)=nanstd(binned_ahp_duration_hypervde{11});
ste_binned_ahp_duration_hypervde(11)=std_binned_ahp_duration_hypervde(11)/sqrt(sum(~isnan(binned_ahp_duration_hypervde{11})));

binned_ahp_duration_devhyper{11}=ahp_duration_devhyper(bins(11)<rate_all_devhyper);
mean_binned_ahp_duration_devhyper(11)=nanmean(binned_ahp_duration_devhyper{11});
std_binned_ahp_duration_devhyper(11)=nanstd(binned_ahp_duration_devhyper{11});
ste_binned_ahp_duration_devhyper(11)=std_binned_ahp_duration_devhyper(11)/sqrt(sum(~isnan(binned_ahp_duration_devhyper{11})));

% g1 is the group that defines hyperpolarized (1) or depolarized (2)
g1_depth=[repmat({'hyper'},size(binned_ahp_depth_hypervde{1}));repmat({'de'},size(binned_ahp_depth_devhyper{1}));...
    repmat({'hyper'},size(binned_ahp_depth_hypervde{2}));repmat({'de'},size(binned_ahp_depth_devhyper{2}));...
    repmat({'hyper'},size(binned_ahp_depth_hypervde{3}));repmat({'de'},size(binned_ahp_depth_devhyper{3}));...
    repmat({'hyper'},size(binned_ahp_depth_hypervde{4}));repmat({'de'},size(binned_ahp_depth_devhyper{4}));...
    repmat({'hyper'},size(binned_ahp_depth_hypervde{5}));repmat({'de'},size(binned_ahp_depth_devhyper{5}));...
    repmat({'hyper'},size(binned_ahp_depth_hypervde{6}));repmat({'de'},size(binned_ahp_depth_devhyper{6}));...
    repmat({'hyper'},size(binned_ahp_depth_hypervde{7}));repmat({'de'},size(binned_ahp_depth_devhyper{7}));...
    repmat({'hyper'},size(binned_ahp_depth_hypervde{8}));repmat({'de'},size(binned_ahp_depth_devhyper{8}))];
g1_duration=[repmat({'hyper'},size(binned_ahp_duration_hypervde{1}));repmat({'de'},size(binned_ahp_duration_devhyper{1}));...
    repmat({'hyper'},size(binned_ahp_duration_hypervde{2}));repmat({'de'},size(binned_ahp_duration_devhyper{2}));...
    repmat({'hyper'},size(binned_ahp_duration_hypervde{3}));repmat({'de'},size(binned_ahp_duration_devhyper{3}));...
    repmat({'hyper'},size(binned_ahp_duration_hypervde{4}));repmat({'de'},size(binned_ahp_duration_devhyper{4}));...
    repmat({'hyper'},size(binned_ahp_duration_hypervde{5}));repmat({'de'},size(binned_ahp_duration_devhyper{5}));...
    repmat({'hyper'},size(binned_ahp_duration_hypervde{6}));repmat({'de'},size(binned_ahp_duration_devhyper{6}));...
    repmat({'hyper'},size(binned_ahp_duration_hypervde{7}));repmat({'de'},size(binned_ahp_duration_devhyper{7}));...
    repmat({'hyper'},size(binned_ahp_duration_hypervde{8}));repmat({'de'},size(binned_ahp_duration_devhyper{8}))];

% g2 is the group that defines the frequency bin
g2_depth=[repmat(1,size(binned_ahp_depth_hypervde{1}));repmat(1,size(binned_ahp_depth_devhyper{1}));...
    repmat(2,size(binned_ahp_depth_hypervde{2}));repmat(2,size(binned_ahp_depth_devhyper{2}));...
    repmat(3,size(binned_ahp_depth_hypervde{3}));repmat(3,size(binned_ahp_depth_devhyper{3}));...
    repmat(4,size(binned_ahp_depth_hypervde{4}));repmat(4,size(binned_ahp_depth_devhyper{4}));...
    repmat(5,size(binned_ahp_depth_hypervde{5}));repmat(5,size(binned_ahp_depth_devhyper{5}));...
    repmat(6,size(binned_ahp_depth_hypervde{6}));repmat(6,size(binned_ahp_depth_devhyper{6}));...
    repmat(7,size(binned_ahp_depth_hypervde{7}));repmat(7,size(binned_ahp_depth_devhyper{7}));...
    repmat(8,size(binned_ahp_depth_hypervde{8}));repmat(8,size(binned_ahp_depth_devhyper{8}))];
g2_duration=[repmat(1,size(binned_ahp_duration_hypervde{1}));repmat(1,size(binned_ahp_duration_devhyper{1}));...
    repmat(2,size(binned_ahp_duration_hypervde{2}));repmat(2,size(binned_ahp_duration_devhyper{2}));...
    repmat(3,size(binned_ahp_duration_hypervde{3}));repmat(3,size(binned_ahp_duration_devhyper{3}));...
    repmat(4,size(binned_ahp_duration_hypervde{4}));repmat(4,size(binned_ahp_duration_devhyper{4}));...
    repmat(5,size(binned_ahp_duration_hypervde{5}));repmat(5,size(binned_ahp_duration_devhyper{5}));...
    repmat(6,size(binned_ahp_duration_hypervde{6}));repmat(6,size(binned_ahp_duration_devhyper{6}));...
    repmat(7,size(binned_ahp_duration_hypervde{7}));repmat(7,size(binned_ahp_duration_devhyper{7}));...
    repmat(8,size(binned_ahp_duration_hypervde{8}));repmat(8,size(binned_ahp_duration_devhyper{8}))];

anova_depth=anovan([binned_ahp_depth_hypervde{1};binned_ahp_depth_devhyper{1};...
    binned_ahp_depth_hypervde{2};binned_ahp_depth_devhyper{2};...
    binned_ahp_depth_hypervde{3};binned_ahp_depth_devhyper{3};...
    binned_ahp_depth_hypervde{4};binned_ahp_depth_devhyper{4};...
    binned_ahp_depth_hypervde{5};binned_ahp_depth_devhyper{5};...
    binned_ahp_depth_hypervde{6};binned_ahp_depth_devhyper{6};...
    binned_ahp_depth_hypervde{7};binned_ahp_depth_devhyper{7};...
    binned_ahp_depth_hypervde{8};binned_ahp_depth_devhyper{8}],...
    {g1_depth,g2_depth});
anova_duration=anovan([binned_ahp_duration_hypervde{1};binned_ahp_duration_devhyper{1};...
    binned_ahp_duration_hypervde{2};binned_ahp_duration_devhyper{2};...
    binned_ahp_duration_hypervde{3};binned_ahp_duration_devhyper{3};...
    binned_ahp_duration_hypervde{4};binned_ahp_duration_devhyper{4};...
    binned_ahp_duration_hypervde{5};binned_ahp_duration_devhyper{5};...
    binned_ahp_duration_hypervde{6};binned_ahp_duration_devhyper{6};...
    binned_ahp_duration_hypervde{7};binned_ahp_duration_devhyper{7};...
    binned_ahp_duration_hypervde{8};binned_ahp_duration_devhyper{8}],...
    {g1_duration,g2_duration});

% mean_ahp_depth_devhyper=nanmean(ahp_depth_devhyper);
% std_ahp_depth_devhyper=nanstd(ahp_depth_devhyper);
% ste_ahp_depth_devhyper=std_ahp_depth_devhyper./sqrt(sum(~isnan(ahp_depth_devhyper)));
% mean_ahp_duration_devhyper=nanmean(ahp_duration_devhyper);
% std_ahp_duration_devhyper=nanstd(ahp_duration_devhyper);
% ste_ahp_duration_devhyper=std_ahp_duration_devhyper./sqrt(sum(~isnan(ahp_duration_devhyper)));

mean_first_spike_delay_devhyper=nanmean(first_spike_delay_devhyper);
std_first_spike_delay_devhyper=nanstd(first_spike_delay_devhyper);
ste_first_spike_delay_devhyper=std_first_spike_delay_devhyper./sqrt(sum(~isnan(first_spike_delay_devhyper)));

interspike_voltage_devhyper(rate_all_devhyper==0)=NaN;
mean_interspike_voltage_devhyper=nanmean(interspike_voltage_devhyper);
std_interspike_voltage_devhyper=nanstd(interspike_voltage_devhyper);
ste_interspike_voltage_devhyper=std_interspike_voltage_devhyper./sqrt(sum(~isnan(interspike_voltage_devhyper)));

%find the range of the mean suprathreshold interspike voltages
mean_range_suprathreshold_interspike_hypervde=nanmean(range(interspike_voltage_hypervde'));
std_range_suprathreshold_interspike_hypervde=nanstd(range(interspike_voltage_hypervde'));
ste_range_suprathreshold_interspike_hypervde=std_range_suprathreshold_interspike_hypervde/sqrt(sum(~isnan(range(interspike_voltage_hypervde'))));
mean_range_suprathreshold_interspike_devhyper=nanmean(range(interspike_voltage_devhyper'));
std_range_suprathreshold_interspike_devhyper=nanstd(range(interspike_voltage_devhyper'));
ste_range_suprathreshold_interspike_devhyper=std_range_suprathreshold_interspike_devhyper/sqrt(sum(~isnan(range(interspike_voltage_devhyper'))));

mean_min_suprathreshold_interspike_hypervde=nanmean(nanmin(interspike_voltage_hypervde'));
std_min_suprathreshold_interspike_hypervde=nanstd(nanmin(interspike_voltage_hypervde'));
ste_min_suprathreshold_interspike_hypervde=std_min_suprathreshold_interspike_hypervde/sqrt(sum(~isnan(nanmin(interspike_voltage_hypervde'))));
mean_min_suprathreshold_interspike_devhyper=nanmean(nanmin(interspike_voltage_devhyper'));
std_min_suprathreshold_interspike_devhyper=nanstd(nanmin(interspike_voltage_devhyper'));
ste_min_suprathreshold_interspike_devhyper=std_min_suprathreshold_interspike_devhyper/sqrt(sum(~isnan(nanmin(interspike_voltage_devhyper'))));

mean_max_suprathreshold_interspike_hypervde=nanmean(nanmax(interspike_voltage_hypervde'));
std_max_suprathreshold_interspike_hypervde=nanstd(nanmax(interspike_voltage_hypervde'));
ste_max_suprathreshold_interspike_hypervde=std_max_suprathreshold_interspike_hypervde/sqrt(sum(~isnan(nanmax(interspike_voltage_hypervde'))));
mean_max_suprathreshold_interspike_devhyper=nanmean(nanmax(interspike_voltage_devhyper'));
std_max_suprathreshold_interspike_devhyper=nanstd(nanmax(interspike_voltage_devhyper'));
ste_max_suprathreshold_interspike_devhyper=std_max_suprathreshold_interspike_devhyper/sqrt(sum(~isnan(nanmax(interspike_voltage_devhyper'))));

min_interspike_voltage_hypervde=min(mean_interspike_voltage_hypervde);
max_interspike_voltage_hypervde=max(mean_interspike_voltage_hypervde);
min_interspike_voltage_devhyper=min(mean_interspike_voltage_devhyper);
max_interspike_voltage_devhyper=max(mean_interspike_voltage_devhyper);

figure;errorbar([0:10:200;0:10:200]',[mean_first_spike_delay_hypervde;mean_first_spike_delay_devhyper]',[ste_first_spike_delay_hypervde;ste_first_spike_delay_devhyper]')
xlabel('current [pA]')
ylabel('delay to first spike [s]')
axis([0 200 0 2.5])
axis 'auto y'

% hyperpolarized compared to depolarized delay to first spike ANOVA
g1_delay=[];
g2_delay=[];
delay_matrix=[];

for k=1:numel(first_spike_delay_devhyper(1,:))
    % g1 is the group that defines the voltage
    g1_delay=[g1_delay;repmat({'hyper'},size(first_spike_delay_hypervde(:,k)));...
        repmat({'de'},size(first_spike_delay_devhyper(:,k)))];
    
    % g2 is the group that defines the time bin
    g2_delay=[g2_delay;repmat({num2str(k)},size(first_spike_delay_hypervde(:,k)));...
        repmat({num2str(k)},size(first_spike_delay_devhyper(:,k)))];
    
    % vd_matrix is the matrix the same size of g1 and g2 that contains the data
    % with which their labels correspond
    delay_matrix=[delay_matrix;first_spike_delay_hypervde(:,k);first_spike_delay_devhyper(:,k)];
end

anova_delay=anovan(delay_matrix,{g1_delay,g2_delay});

% hyperpolarized compared to depolarized delay to first spike t-test
[delay_ttest(1),delay_ttest(2)]=ttest(mean_first_spike_delay_hypervde,mean_first_spike_delay_devhyper);
cd ../../F_I_curves/data/
figure;errorbar([0:10:200;0:10:200]',[mean_interspike_voltage_hypervde;mean_interspike_voltage_devhyper]',[ste_interspike_voltage_hypervde;ste_interspike_voltage_devhyper]')
xlabel('current [pA]')
ylabel('mean interspike voltage [mV]')
axis([0 200 0 2.5])
axis 'auto y'

figure;errorbar([0:10;0:10]'+.5,[mean_binned_ahp_depth_hypervde;mean_binned_ahp_depth_devhyper]',[ste_binned_ahp_depth_hypervde;ste_binned_ahp_depth_devhyper]')
xlabel('current [pA]')
ylabel('AHP depth [mV]')
% axis([0 10 0 2.5])
% axis 'auto y'

reshape_rate_hypervde=reshape(rate_all_hypervde,1,[]);
reshape_ahp_depth_hypervde=reshape(ahp_depth_hypervde,1,[]);
hold on;scatter(reshape_rate_hypervde(reshape_rate_hypervde>0),reshape_ahp_depth_hypervde(reshape_rate_hypervde>0),[],'.b')

reshape_rate_devhyper=reshape(rate_all_devhyper,1,[]);
reshape_ahp_depth_devhyper=reshape(ahp_depth_devhyper,1,[]);
hold on;scatter(reshape_rate_devhyper(reshape_rate_devhyper>0),reshape_ahp_depth_devhyper(reshape_rate_devhyper>0),[],'.r')
ylabel('AHP depth [mV]')
xlabel('firing rate [spikes/s]')

figure;errorbar([0:10;0:10]'+.5,[mean_binned_ahp_duration_hypervde;mean_binned_ahp_duration_devhyper]',[ste_binned_ahp_duration_hypervde;ste_binned_ahp_duration_devhyper]')
xlabel('current [pA]')
ylabel('AHP duration [s]')
% axis([0 10 0 2.5])
% axis 'auto y'

reshape_rate_hypervde=reshape(rate_all_hypervde,1,[]);
reshape_ahp_duration_hypervde=reshape(ahp_duration_hypervde,1,[]);
hold on;scatter(reshape_rate_hypervde(reshape_rate_hypervde>0),reshape_ahp_duration_hypervde(reshape_rate_hypervde>0),[],'.b')

reshape_rate_devhyper=reshape(rate_all_devhyper,1,[]);
reshape_ahp_duration_devhyper=reshape(ahp_duration_devhyper,1,[]);
hold on;scatter(reshape_rate_devhyper(reshape_rate_devhyper>0),reshape_ahp_duration_devhyper(reshape_rate_devhyper>0),[],'.r')
ylabel('AHP duration [s]')
xlabel('firing rate [spikes/s]')

% average values for paper
average_ahp_depth_hypervdelow=nanmean(ahp_depth_hypervde(rate_all_hypervde<4.2 & 0<=rate_all_hypervde));
std_ahp_depth_hypervdelow=nanstd(ahp_depth_hypervde(rate_all_hypervde<4.2 & 0<=rate_all_hypervde));
ste_ahp_depth_hypervdelow=std_ahp_depth_hypervdelow/sqrt(numel(~isnan(ahp_depth_hypervde(rate_all_hypervde<4.2 & 0<=rate_all_hypervde))));

average_ahp_depth_devhyperlow=nanmean(ahp_depth_devhyper(rate_all_devhyper<4.2 & 0<=rate_all_devhyper));
std_ahp_depth_devhyperlow=nanstd(ahp_depth_devhyper(rate_all_devhyper<4.2 & 0<=rate_all_devhyper));
ste_ahp_depth_devhyperlow=std_ahp_depth_devhyperlow/sqrt(numel(~isnan(ahp_depth_devhyper(rate_all_devhyper<4.2 & 0<=rate_all_devhyper))));

average_ahp_depth_hypervdehigh=nanmean(ahp_depth_hypervde(rate_all_hypervde<7.2 & 4.2<=rate_all_hypervde));
std_ahp_depth_hypervdehigh=nanstd(ahp_depth_hypervde(rate_all_hypervde<7.2 & 4.2<=rate_all_hypervde));
ste_ahp_depth_hypervdehigh=std_ahp_depth_hypervdehigh/sqrt(numel(~isnan(ahp_depth_hypervde(rate_all_hypervde<7.2 & 4.2<=rate_all_hypervde))));

average_ahp_depth_devhyperhigh=nanmean(ahp_depth_devhyper(rate_all_devhyper<7.2 & 4.2<=rate_all_devhyper));
std_ahp_depth_devhyperhigh=nanstd(ahp_depth_devhyper(rate_all_devhyper<7.2 & 4.2<=rate_all_devhyper));
ste_ahp_depth_devhyperhigh=std_ahp_depth_devhyperhigh/sqrt(numel(~isnan(ahp_depth_devhyper(rate_all_devhyper<7.2 & 4.2<=rate_all_devhyper))));

average_ahp_duration_hypervde=nanmean(reshape(ahp_duration_hypervde,1,[]));
std_ahp_duration_hypervde=nanstd(reshape(ahp_duration_hypervde,1,[]));
ste_ahp_duration_hypervde=std_ahp_duration_hypervde/sqrt(numel(~isnan(reshape(ahp_duration_hypervde,1,[]))));

average_ahp_duration_devhyper=nanmean(reshape(ahp_duration_devhyper,1,[]));
std_ahp_duration_devhyper=nanstd(reshape(ahp_duration_devhyper,1,[]));
ste_ahp_duration_devhyper=std_ahp_duration_devhyper/sqrt(numel(~isnan(reshape(ahp_duration_devhyper,1,[]))));


%% Hyperpolarized with 4-AP (5 sec pulse, 1 sec pause)
% For Depolarized with 4-AP

dates_all_hypervde4AP={'Apr_29_15' 'May_01_15' 'May_04_15' 'May_05_15' 'May_05_15'};
cellnum_all_hypervde4AP={'E' 'C' 'C' 'E' 'F'};
trials_all_hypervde4AP=[7 9 8 3 3]';

for k=1:numel(dates_all_hypervde4AP)
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_hypervde4AP{k} '_' cellnum_all_hypervde4AP{k} num2str(trials_all_hypervde4AP(k)) '_fi.mat;'])
    peakrate_all_hypervde4AP(k,:)=peakrate;
    nofailrate_all_hypervde4AP(k,:)=nofailrate;
    gains_all_hypervde4AP(k,1)=pf_all{1}.beta(2);
    rsq_all_hypervde4AP(k,1)=pf_all{1}.rsquare;
    rate_all_hypervde4AP(k,:)=rate_all{1};
    imp_all_hypervde4AP(k,:)=imp;
    holdingvoltage_all_hypervde4AP(k,:)=mean_holdingvoltage;
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
    ahp_depth_hypervde4AP(k,:)=ahp_depth{1}*1e3;
    ahp_duration_hypervde4AP(k,:)=ahp_duration{1};
    first_spike_delay_hypervde4AP(k,:)=first_spike_delay{1}/10000;
    interspike_voltage_hypervde4AP(k,:)=interspike_voltage{1}*1e3;
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
ste_holdingvoltage_all_hypervde4AP=std_holdingvoltage_all_hypervde4AP./sqrt(sum(~isnan(holdingvoltage_all_hypervde4AP)));
mean_rate_hypervde4AP=nanmean(rate_all_hypervde4AP);
std_rate_hypervde4AP=nanstd(rate_all_hypervde4AP);
ste_rate_hypervde4AP=std_rate_hypervde4AP./sqrt(sum(~isnan(rate_all_hypervde4AP)));

mean_spikeform_hypervde4AP=nanmean(mean_spikeform_all_hypervde4AP);
std_spikeform_hypervde4AP=nanstd(mean_spikeform_all_hypervde4AP);
ste_spikeform_hypervde4AP=std_spikeform_hypervde4AP./sqrt(sum(~isnan(mean_spikeform_all_hypervde4AP)));

% find averages and standard errors for ahp depth, ahp duration, delay to
% first spike, and interspike voltage.
% mean_ahp_depth_hypervde4AP=nanmean(ahp_depth_hypervde4AP);
% std_ahp_depth_hypervde4AP=nanstd(ahp_depth_hypervde4AP);
% ste_ahp_depth_hypervde4AP=std_ahp_depth_hypervde4AP./sqrt(sum(~isnan(ahp_depth_hypervde4AP)));
% mean_ahp_duration_hypervde4AP=nanmean(ahp_duration_hypervde4AP);
% std_ahp_duration_hypervde4AP=nanstd(ahp_duration_hypervde4AP);
% ste_ahp_duration_hypervde4AP=std_ahp_duration_hypervde4AP./sqrt(sum(~isnan(ahp_duration_hypervde4AP)));
mean_first_spike_delay_hypervde4AP=nanmean(first_spike_delay_hypervde4AP);
std_first_spike_delay_hypervde4AP=nanstd(first_spike_delay_hypervde4AP);
ste_first_spike_delay_hypervde4AP=std_first_spike_delay_hypervde4AP./sqrt(sum(~isnan(first_spike_delay_hypervde4AP)));
mean_interspike_voltage_hypervde4AP=nanmean(interspike_voltage_hypervde4AP);
std_interspike_voltage_hypervde4AP=nanstd(interspike_voltage_hypervde4AP);
ste_interspike_voltage_hypervde4AP=std_interspike_voltage_hypervde4AP./sqrt(sum(~isnan(interspike_voltage_hypervde4AP)));


% Depolarized with 4-AP (5 sec pulse, 1 sec pause)
% For Hyperpolarized with 4-AP

dates_all_devhyper4AP={'Apr_29_15' 'May_01_15' 'May_04_15' 'May_05_15' 'May_05_15'};
cellnum_all_devhyper4AP={'E' 'C' 'C' 'E' 'F'};
trials_all_devhyper4AP=[8 10 9 4 4]';

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
    ahp_depth_devhyper4AP(k,:)=ahp_depth{1}*1e3;
    ahp_duration_devhyper4AP(k,:)=ahp_duration{1};
    first_spike_delay_devhyper4AP(k,:)=first_spike_delay{1}/10000;
    interspike_voltage_devhyper4AP(k,:)=interspike_voltage{1}*1e3;
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

% figure;errorbar(1:2,[mean_ISIratio_hypervde4AP mean_ISIratio_devhyper4AP],[ste_ISIratio_hypervde4AP ste_ISIratio_devhyper4AP],'.')
% hold on;bar(1:2,[mean_ISIratio_hypervde4AP mean_ISIratio_devhyper4AP],.5,'m')
[ttestISIratio_hypervde4AP(1),ttestISIratio_hypervde4AP(2)]=ttest(matchfreq_ISIratio_hypervde4AP,matchfreq_ISIratio_devhyper4AP);

figure;errorbar(1:4,[mean_ISIratio_hypervde mean_ISIratio_devhyper mean_ISIratio_hypervde4AP mean_ISIratio_devhyper4AP],...
    [ste_ISIratio_hypervde ste_ISIratio_devhyper ste_ISIratio_hypervde4AP ste_ISIratio_devhyper4AP],'.')
hold on;bar(1:4,[mean_ISIratio_hypervde mean_ISIratio_devhyper mean_ISIratio_hypervde4AP mean_ISIratio_devhyper4AP],.5,'m')
xlabel('hyper.     de.')
ylabel('adaptation ratio [last ISI / first ISI]')
axis([0.5 2.5 0 2.5])
axis 'auto x'
set(gca, 'XTick', []);

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

figure;shadedErrorBar(currents,mean_rate_hypervde4AP,ste_rate_hypervde4AP,'g')
hold on;shadedErrorBar(currents,mean_rate_devhyper4AP,ste_rate_devhyper4AP,'k')
hold on;plot(currents,sigFun(nlf_fi_hypervde4AP,currents),'m');plot(currents,sigFun(nlf_fi_devhyper4AP,currents),'r')
title('Average f-I Curves for Hyperpolarized and Depolarized')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% figure;errorbar([currents;currents]',[mean_rate_hypervde4AP;mean_rate_devhyper4AP]',[ste_rate_hypervde4AP;ste_rate_devhyper4AP]')
% legend('Hyperpolarized','Depolarized')
% hold on;plot(currents,sigFun(nlf_fi_hypervde4AP,currents),'m');plot(currents,sigFun(nlf_fi_devhyper4AP,currents),'r')
% title('Average f-I Curves for Hyperpolarized and Depolarized')
% xlabel('Current [pA]')
% ylabel('Frequency [Hz]')

% difference between rates
difference_rate_hypervde4AP=rate_all_devhyper4AP-rate_all_hypervde4AP;
mean_difference_rate_hypervde4AP=nanmean(difference_rate_hypervde4AP);
std_difference_rate_hypervde4AP=nanstd(difference_rate_hypervde4AP);
ste_difference_rate_hypervde4AP=std_difference_rate_hypervde4AP./sqrt(sum(~isnan(difference_rate_hypervde4AP)));

% find averages and standard errors for ahp depth, ahp duration, delay to
% first spike, and interspike voltage.
% mean_ahp_depth_devhyper4AP=nanmean(ahp_depth_devhyper4AP);
% std_ahp_depth_devhyper4AP=nanstd(ahp_depth_devhyper4AP);
% ste_ahp_depth_devhyper4AP=std_ahp_depth_devhyper4AP./sqrt(sum(~isnan(ahp_depth_devhyper4AP)));
% mean_ahp_duration_devhyper4AP=nanmean(ahp_duration_devhyper4AP);
% std_ahp_duration_devhyper4AP=nanstd(ahp_duration_devhyper4AP);
% ste_ahp_duration_devhyper4AP=std_ahp_duration_devhyper4AP./sqrt(sum(~isnan(ahp_duration_devhyper4AP)));
mean_first_spike_delay_devhyper4AP=nanmean(first_spike_delay_devhyper4AP);
std_first_spike_delay_devhyper4AP=nanstd(first_spike_delay_devhyper4AP);
ste_first_spike_delay_devhyper4AP=std_first_spike_delay_devhyper4AP./sqrt(sum(~isnan(first_spike_delay_devhyper4AP)));
mean_interspike_voltage_devhyper4AP=nanmean(interspike_voltage_devhyper4AP);
std_interspike_voltage_devhyper4AP=nanstd(interspike_voltage_devhyper4AP);
ste_interspike_voltage_devhyper4AP=std_interspike_voltage_devhyper4AP./sqrt(sum(~isnan(interspike_voltage_devhyper4AP)));

figure;errorbar([0:10:200;0:10:200]',[mean_first_spike_delay_hypervde4AP;mean_first_spike_delay_devhyper4AP]',[ste_first_spike_delay_hypervde4AP;ste_first_spike_delay_devhyper4AP]')
xlabel('current [pA]')
ylabel('delay to first spike [s]')
axis([0 200 0 2.5])
axis 'auto y'

% hyperpolarized compared to depolarized delay to first spike ANOVA with 4-AP
g3_delay=[];
g4_delay=[];
delay_matrix4AP=[];

for k=1:numel(first_spike_delay_devhyper4AP(1,:))
    % g1 is the group that defines the voltage
    g3_delay=[g3_delay;repmat({'hyper'},size(first_spike_delay_hypervde4AP(:,k)));...
        repmat({'de'},size(first_spike_delay_devhyper4AP(:,k)))];
    
    % g2 is the group that defines the time bin
    g4_delay=[g4_delay;repmat({num2str(k)},size(first_spike_delay_hypervde4AP(:,k)));...
        repmat({num2str(k)},size(first_spike_delay_devhyper4AP(:,k)))];
    
    % vd_matrix is the matrix the same size of g3 and g4 that contains the data
    % with which their labels correspond
    delay_matrix4AP=[delay_matrix4AP;first_spike_delay_hypervde4AP(:,k);first_spike_delay_devhyper4AP(:,k)];
end

anova_delay4AP=anovan(delay_matrix4AP,{g3_delay,g4_delay},'varnames',{'Hyperpolarized with 4-AP';'Depolarized with 4-AP'});

% hyperpolarized compared to depolarized delay to first spike t-test with 4-AP
[delay_ttest4AP(1),delay_ttest4AP(2)]=ttest(mean_first_spike_delay_hypervde4AP,mean_first_spike_delay_devhyper4AP);

% hyperpolarized compared to hyperpolarized with 4-AP delay to first spike ANOVA
g5_delay=[];
g6_delay=[];
delay_matrix4AP2=[];

for k=1:numel(first_spike_delay_hypervde(1,:))
    % g1 is the group that defines the voltage
    g5_delay=[g5_delay;repmat({'hyper'},size(first_spike_delay_hypervde(:,k)));...
        repmat({'hyper4AP'},size(first_spike_delay_hypervde4AP(:,k)))];
    
    % g2 is the group that defines the time bin
    g6_delay=[g6_delay;repmat({num2str(k)},size(first_spike_delay_hypervde(:,k)));...
        repmat({num2str(k)},size(first_spike_delay_hypervde4AP(:,k)))];
    
    % vd_matrix is the matrix the same size of g3 and g4 that contains the data
    % with which their labels correspond
    delay_matrix4AP2=[delay_matrix4AP2;first_spike_delay_hypervde(:,k);first_spike_delay_hypervde4AP(:,k)];
end

anova_delay4AP2=anovan(delay_matrix4AP2,{g5_delay,g6_delay},'varnames',{'Hyperpolarized without 4-AP';'Hyperpolarized with 4-AP'});

% hyperpolarized compared to hyperpolarized with 4-AP delay to first spike t-test
[delay_ttest4AP2(1),delay_ttest4AP2(2)]=ttest(mean_first_spike_delay_hypervde,mean_first_spike_delay_hypervde4AP);

figure;errorbar([0:10:200;0:10:200]',[mean_interspike_voltage_hypervde4AP;mean_interspike_voltage_devhyper4AP]',[ste_interspike_voltage_hypervde4AP;ste_interspike_voltage_devhyper4AP]')
xlabel('current [pA]')
ylabel('mean interspike voltage [mV]')
axis([0 200 0 2.5])
axis 'auto y'

% figure;errorbar([0:10:200;0:10:200]',[mean_ahp_depth_hypervde4AP;mean_ahp_depth_devhyper4AP]',[ste_ahp_depth_hypervde4AP;ste_ahp_depth_devhyper4AP]')
% xlabel('current [pA]')
% ylabel('AHP depth [mV]')
% axis([0 200 0 2.5])
% axis 'auto y'
% 
% figure;errorbar([0:10:200;0:10:200]',[mean_ahp_duration_hypervde4AP;mean_ahp_duration_devhyper4AP]',[ste_ahp_duration_hypervde4AP;ste_ahp_duration_devhyper4AP]')
% xlabel('current [pA]')
% ylabel('AHP duration [s]')
% axis([0 200 0 2.5])
% axis 'auto y'


% %% Depolarized (5 sec pulse, 1 sec pause; 200 pA range of currents)
% % For Depolarized with Leak
% 
% dates_all_devdeleak={'Oct_28_14' 'Oct_30_14' 'Oct_30_14' 'Nov_26_14' 'Jan_07_15' 'Jan_07_15'...
%     'Mar_17_15' 'Mar_18_15' 'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15'...
%     'Apr_06_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15'};
% cellnum_all_devdeleak={'A' 'A' 'B' 'A' 'A' 'B'...
%     'A' 'A' 'B' 'B' 'E' 'B'...
%     'B' 'A' 'C' 'D'};
% trials_all_devdeleak=[2 2 2 2 2 2 ...
%     1 5 3 2 2 4 ...
%     6 6 6 4]';
% 
% for k=1:numel(dates_all_devdeleak)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_devdeleak{k} '_' cellnum_all_devdeleak{k} num2str(trials_all_devdeleak(k)) '_fi.mat;'])
%     peakrate_all_devdeleak(k,:)=peakrate;
%     nofailrate_all_devdeleak(k,:)=nofailrate;
%     gains_all_devdeleak(k,1)=pf_all{1}.beta(2);
%     rsq_all_devdeleak(k,1)=pf_all{1}.rsquare;
%     rate_all_devdeleak(k,:)=rate_all{1};
%     imp_all_devdeleak(k,:)=imp;
%     holdingvoltage_all_devdeleak(k,:)=mean_holdingvoltage;
%     interspike_voltage_devdeleak(k,:)=interspike_voltage{1}*1e3;
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
% mean_rate_devdeleak=nanmean(rate_all_devdeleak);
% std_rate_devdeleak=nanstd(rate_all_devdeleak);
% ste_rate_devdeleak=std_rate_devdeleak./sqrt(sum(~isnan(rate_all_devdeleak)));
% 
% interspike_voltage_devdeleak(rate_all_devdeleak==0)=NaN;
% mean_interspike_voltage_devdeleak=nanmean(interspike_voltage_devdeleak);
% std_interspike_voltage_devdeleak=nanstd(interspike_voltage_devdeleak);
% ste_interspike_voltage_devdeleak=std_interspike_voltage_devdeleak./sqrt(sum(~isnan(interspike_voltage_devdeleak)));
% 
% 
% % Depolarized with Leak (400 pA range of currents)
% % For Depolarized
% % Justification for 3 nS Leak: 1/200e6; ans+3e-9; 1/ans; ans/1e6
% 
% dates_all_de_leakvde={'Oct_28_14' 'Oct_30_14' 'Oct_30_14' 'Nov_26_14' 'Jan_07_15' 'Jan_07_15'...
%     'Mar_17_15' 'Mar_18_15' 'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15'...
%     'Apr_06_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15'};
% cellnum_all_de_leakvde={'A' 'A' 'B' 'A' 'A' 'B'...
%     'A' 'A' 'B' 'B' 'E' 'B'...
%     'B' 'A' 'C' 'D'};
% trials_all_de_leakvde=[3 3 3 3 3 3 ...
%     5 7 5 6 3 5 ...
%     7 7 7 5]';
% 
% for k=1:numel(dates_all_de_leakvde)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_de_leakvde{k} '_' cellnum_all_de_leakvde{k} num2str(trials_all_de_leakvde(k)) '_fi.mat;'])
%     peakrate_all_de_leakvde(k,:)=peakrate;
%     nofailrate_all_de_leakvde(k,:)=nofailrate;
%     gains_all_de_leakvde(k,1)=pf_all{1}.beta(2);
%     rsq_all_de_leakvde(k,1)=pf_all{1}.rsquare;
%     rate_all_de_leakvde(k,:)=rate_all{1};
%     imp_all_de_leakvde(k,:)=imp;
%     holdingvoltage_all_de_leakvde(k,:)=mean_holdingvoltage;
%     interspike_voltage_de_leakvde(k,:)=interspike_voltage{1}*1e3;
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
% mean_rate_de_leakvde=nanmean(rate_all_de_leakvde);
% std_rate_de_leakvde=nanstd(rate_all_de_leakvde);
% ste_rate_de_leakvde=std_rate_de_leakvde./sqrt(sum(~isnan(rate_all_de_leakvde)));
% 
% currents=0:10:200;
% currents_leak=0:20:400;
% nlf_fi_devdeleak=nlinfit(currents,mean_rate_devdeleak,'sigFun',[320,50,10]);
% nlf_fi_de_leakvde=nlinfit(currents_leak,mean_rate_de_leakvde,'sigFun',[320,50,10]);
% 
% devdeleak_max=nlf_fi_devdeleak(1);
% devdeleak_midpoint=nlf_fi_devdeleak(2);
% devdeleak_slope=nlf_fi_devdeleak(1)/(4*nlf_fi_devdeleak(3));
% de_leakvde_max=nlf_fi_de_leakvde(1);
% de_leakvde_midpoint=nlf_fi_de_leakvde(2);
% de_leakvde_slope=nlf_fi_de_leakvde(1)/(4*nlf_fi_de_leakvde(3));
% 
% figure;shadedErrorBar(currents,mean_rate_devdeleak,ste_rate_devdeleak,'g')
% hold on;shadedErrorBar(currents_leak,mean_rate_de_leakvde,ste_rate_de_leakvde,'k')
% hold on;plot(currents,sigFun(nlf_fi_devdeleak,currents),'m');plot(currents_leak,sigFun(nlf_fi_de_leakvde,currents_leak),'r')
% title('Average f-I Curves for Depolarized and Depolarized with Leak (3 nS)')
% xlabel('Current [pA]')
% ylabel('Frequency [Hz]')
% 
% % figure;errorbar([currents;currents_leak]',[mean_rate_devdeleak;mean_rate_de_leakvde]',[ste_rate_devdeleak;ste_rate_de_leakvde]')
% % legend('Depolarized','Depolarized with Leak (3 nS)')
% % hold on;plot(currents,sigFun(nlf_fi_devdeleak,currents),'m');plot(currents_leak,sigFun(nlf_fi_de_leakvde,currents_leak),'r')
% % title('Average f-I Curves for Depolarized and Depolarized with Leak (3 nS)')
% % xlabel('Current [pA]')
% % ylabel('Frequency [Hz]')
% 
% % difference between rates
% difference_rate_devdeleak=rate_all_de_leakvde-rate_all_devdeleak;
% mean_difference_rate_devdeleak=nanmean(difference_rate_devdeleak);
% std_difference_rate_devdeleak=nanstd(difference_rate_devdeleak);
% ste_difference_rate_devdeleak=std_difference_rate_devdeleak./sqrt(sum(~isnan(difference_rate_devdeleak)));
% 
% interspike_voltage_de_leakvde(rate_all_de_leakvde==0)=NaN;
% mean_interspike_voltage_de_leakvde=nanmean(interspike_voltage_de_leakvde);
% std_interspike_voltage_de_leakvde=nanstd(interspike_voltage_de_leakvde);
% ste_interspike_voltage_de_leakvde=std_interspike_voltage_de_leakvde./sqrt(sum(~isnan(interspike_voltage_de_leakvde)));
% 
% figure;errorbar([0:10:200;0:20:400]',[mean_interspike_voltage_devdeleak;mean_interspike_voltage_de_leakvde]',[ste_interspike_voltage_devdeleak;ste_interspike_voltage_de_leakvde]')
% xlabel('current [pA]')
% ylabel('mean interspike voltage [mV]')
% axis([0 400 0 2.5])
% axis 'auto y'


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
    voltage_resistance2_all_noncholinergic(k,:)=resistance_voltage2{1};
    voltage_resistance1_all_noncholinergic(k,:)=resistance_voltage1{1};
    resistance_all_noncholinergic(k,:)=r_m;
    mean_voltage_resistance_diff_noncholinergic(k)=mean(voltage_resistance2_all_noncholinergic(k,~isnan(resistance_all_noncholinergic(k,:)))-voltage_resistance1_all_noncholinergic(k,~isnan(resistance_all_noncholinergic(k,:))));
    mean_voltage_resistance2_noncholinergic(k)=mean(voltage_resistance2_all_noncholinergic(k,~isnan(resistance_all_noncholinergic(k,:))));
    mean_voltage_resistance1_noncholinergic(k)=mean(voltage_resistance1_all_noncholinergic(k,~isnan(resistance_all_noncholinergic(k,:))));
    resistance_all_hypervde_noncholinergic(k)=mean_r_m;
    capacitance_all_hypervde_noncholinergic(k)=mean_c_m;
    time_constant_all_hypervde_noncholinergic(k)=mean_time_constant;
end

%measure the voltage at which the resistance and capacitance were measured
mean_resistance_voltage_noncholinergic=nanmean(mean([mean_voltage_resistance2_noncholinergic;mean_voltage_resistance1_noncholinergic]));
std_resistance_voltage_noncholinergic=nanstd(mean([mean_voltage_resistance2_noncholinergic;mean_voltage_resistance1_noncholinergic]));
ste_resistance_voltage_noncholinergic=std_resistance_voltage_noncholinergic/sqrt(sum(~isnan(mean([mean_voltage_resistance2_noncholinergic;mean_voltage_resistance1_noncholinergic]))));

mean_resistance_hypervde_noncholinergic=nanmean(resistance_all_hypervde_noncholinergic);
std_resistance_hypervde_noncholinergic=nanstd(resistance_all_hypervde_noncholinergic);
ste_resistance_hypervde_noncholinergic=std_resistance_hypervde_noncholinergic/sqrt(sum(~isnan(resistance_all_hypervde_noncholinergic)));
max_resistance_hypervde_noncholinergic=max(resistance_all_hypervde_noncholinergic);
min_resistance_hypervde_noncholinergic=min(resistance_all_hypervde_noncholinergic);
mean_capacitance_hypervde_noncholinergic=nanmean(capacitance_all_hypervde_noncholinergic);
std_capacitance_hypervde_noncholinergic=nanstd(capacitance_all_hypervde_noncholinergic);
ste_capacitance_hypervde_noncholinergic=std_capacitance_hypervde_noncholinergic/sqrt(sum(~isnan(capacitance_all_hypervde_noncholinergic)));
max_capacitance_hypervde_noncholinergic=max(capacitance_all_hypervde_noncholinergic);
min_capacitance_hypervde_noncholinergic=min(capacitance_all_hypervde_noncholinergic);
mean_tau_m_hypervde_noncholinergic=nanmean(time_constant_all_hypervde_noncholinergic);
std_tau_m_hypervde_noncholinergic=nanstd(time_constant_all_hypervde_noncholinergic);
ste_tau_m_hypervde_noncholinergic=std_tau_m_hypervde_noncholinergic/sqrt(sum(~isnan(time_constant_all_hypervde_noncholinergic)));
max_tau_m_hypervde_noncholinergic=max(time_constant_all_hypervde_noncholinergic);
min_tau_m_hypervde_noncholinergic=min(time_constant_all_hypervde_noncholinergic);

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
ste_holdingvoltage_all_hypervde_noncholinergic=std_holdingvoltage_all_hypervde_noncholinergic/sqrt(sum(~isnan(holdingvoltage_all_hypervde_noncholinergic)));
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
    resistance_all_devhyper_noncholinergic(k)=mean_r_m;
    capacitance_all_devhyper_noncholinergic(k)=mean_c_m;
    time_constant_all_devhyper_noncholinergic(k)=mean_time_constant;
end

mean_resistance_devhyper_noncholinergic=nanmean(resistance_all_devhyper_noncholinergic);
std_resistance_devhyper_noncholinergic=nanstd(resistance_all_devhyper_noncholinergic);
ste_resistance_devhyper_noncholinergic=std_resistance_devhyper_noncholinergic/sqrt(sum(~isnan(resistance_all_devhyper_noncholinergic)));
max_resistance_devhyper_noncholinergic=max(resistance_all_devhyper_noncholinergic);
min_resistance_devhyper_noncholinergic=min(resistance_all_devhyper_noncholinergic);
mean_capacitance_devhyper_noncholinergic=nanmean(capacitance_all_devhyper_noncholinergic);
std_capacitance_devhyper_noncholinergic=nanstd(capacitance_all_devhyper_noncholinergic);
ste_capacitance_devhyper_noncholinergic=std_capacitance_devhyper_noncholinergic/sqrt(sum(~isnan(capacitance_all_devhyper_noncholinergic)));
max_capacitance_devhyper_noncholinergic=max(capacitance_all_devhyper_noncholinergic);
min_capacitance_devhyper_noncholinergic=min(capacitance_all_devhyper_noncholinergic);
mean_tau_m_devhyper_noncholinergic=nanmean(time_constant_all_devhyper_noncholinergic);
std_tau_m_devhyper_noncholinergic=nanstd(time_constant_all_devhyper_noncholinergic);
ste_tau_m_devhyper_noncholinergic=std_tau_m_devhyper_noncholinergic/sqrt(sum(~isnan(time_constant_all_devhyper_noncholinergic)));
max_tau_m_devhyper_noncholinergic=max(time_constant_all_devhyper_noncholinergic);
min_tau_m_devhyper_noncholinergic=min(time_constant_all_devhyper_noncholinergic);

% figure;errorbar(1:6,[mean_resistance_hypervde mean_resistance_hypervde_noncholinergic...
%     mean_capacitance_hypervde mean_capacitance_hypervde_noncholinergic...
%     mean_tau_m_hypervde mean_tau_m_hypervde_noncholinergic],...
%     [ste_resistance_hypervde ste_resistance_hypervde_noncholinergic...
%     ste_capacitance_hypervde ste_capacitance_hypervde_noncholinergic...
%     ste_tau_m_hypervde ste_tau_m_hypervde_noncholinergic],'.')
% hold on;bar(1:6,[mean_resistance_hypervde mean_resistance_hypervde_noncholinergic...
%     mean_capacitance_hypervde mean_capacitance_hypervde_noncholinergic...
%     mean_tau_m_hypervde mean_tau_m_hypervde_noncholinergic],.5,'m')

figure;errorbar(1:6,[mean_resistance_hypervde mean_resistance_hypervde_noncholinergic...
    mean_resistance_hypervde mean_resistance_hypervde_noncholinergic...
    mean_resistance_hypervde mean_resistance_hypervde_noncholinergic]*1e3,...
    [ste_resistance_hypervde ste_resistance_hypervde_noncholinergic...
    ste_resistance_hypervde ste_resistance_hypervde_noncholinergic...
    ste_resistance_hypervde ste_resistance_hypervde_noncholinergic]*1e3,'.')
hold on;bar(1:6,[mean_resistance_hypervde mean_resistance_hypervde_noncholinergic...
    mean_resistance_hypervde mean_resistance_hypervde_noncholinergic...
    mean_resistance_hypervde mean_resistance_hypervde_noncholinergic]*1e3,.5,'m')

figure;errorbar(1:6,[mean_capacitance_hypervde mean_capacitance_hypervde_noncholinergic...
    mean_capacitance_hypervde mean_capacitance_hypervde_noncholinergic...
    mean_capacitance_hypervde mean_capacitance_hypervde_noncholinergic]*1e3,...
    [ste_capacitance_hypervde ste_capacitance_hypervde_noncholinergic...
    ste_capacitance_hypervde ste_capacitance_hypervde_noncholinergic...
    ste_capacitance_hypervde ste_capacitance_hypervde_noncholinergic]*1e3,'.')
hold on;bar(1:6,[mean_capacitance_hypervde mean_capacitance_hypervde_noncholinergic...
    mean_capacitance_hypervde mean_capacitance_hypervde_noncholinergic...
    mean_capacitance_hypervde mean_capacitance_hypervde_noncholinergic]*1e3,.5,'m')

figure;errorbar(1:6,[mean_tau_m_hypervde mean_tau_m_hypervde_noncholinergic...
    mean_tau_m_hypervde mean_tau_m_hypervde_noncholinergic...
    mean_tau_m_hypervde mean_tau_m_hypervde_noncholinergic]*1e3,...
    [ste_tau_m_hypervde ste_tau_m_hypervde_noncholinergic...
    ste_tau_m_hypervde ste_tau_m_hypervde_noncholinergic...
    ste_tau_m_hypervde ste_tau_m_hypervde_noncholinergic]*1e3,'.')
hold on;bar(1:6,[mean_tau_m_hypervde mean_tau_m_hypervde_noncholinergic...
    mean_tau_m_hypervde mean_tau_m_hypervde_noncholinergic...
    mean_tau_m_hypervde mean_tau_m_hypervde_noncholinergic]*1e3,.5,'m')

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

figure;errorbar(1,normalized_mean_gains_devhyper_noncholinergic,normalized_ste_gains_devhyper_noncholinergic)
hold on;bar(1,normalized_mean_gains_devhyper_noncholinergic,.5,'m')
ylabel('normalized gain [de./hyper.]')
axis([0.5 1.5 0 1])
set(gca, 'XTick', []);
axis 'auto y'

mean_imp_devhyper_noncholinergic=nanmean(imp_all_devhyper_noncholinergic);
std_imp_devhyper_noncholinergic=nanstd(imp_all_devhyper_noncholinergic);
mean_holdingvoltage_all_devhyper_noncholinergic=nanmean(holdingvoltage_all_devhyper_noncholinergic);
std_holdingvoltage_all_devhyper_noncholinergic=nanstd(holdingvoltage_all_devhyper_noncholinergic);
ste_holdingvoltage_all_devhyper_noncholinergic=std_holdingvoltage_all_devhyper_noncholinergic/sqrt(sum(~isnan(holdingvoltage_all_devhyper_noncholinergic)));
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

figure;shadedErrorBar(currents,mean_rate_hypervde_noncholinergic,ste_rate_hypervde_noncholinergic,'g')
hold on;shadedErrorBar(currents,mean_rate_devhyper_noncholinergic,ste_rate_devhyper_noncholinergic,'k')
hold on;plot(currents,sigFun(nlf_fi_hypervde_noncholinergic,currents),'m');plot(currents,sigFun(nlf_fi_devhyper_noncholinergic,currents),'r')
title('Average f-I Curves for Non-Cholinergic Hyperpolarized and Depolarized')
xlabel('Current [pA]')
ylabel('Frequency [Hz]')

% figure;errorbar([currents;currents]',[mean_rate_hypervde_noncholinergic;mean_rate_devhyper_noncholinergic]',[ste_rate_hypervde_noncholinergic;ste_rate_devhyper_noncholinergic]')
% legend('Hyperpolarized','Depolarized')
% hold on;plot(currents,sigFun(nlf_fi_hypervde_noncholinergic,currents),'m');plot(currents,sigFun(nlf_fi_devhyper_noncholinergic,currents),'r')
% title('Average f-I Curves for Non-Cholinergic Hyperpolarized and Depolarized')
% xlabel('Current [pA]')
% ylabel('Frequency [Hz]')

% difference between rates
difference_rate_hypervde_noncholinergic=rate_all_devhyper_noncholinergic-rate_all_hypervde_noncholinergic;
mean_difference_rate_hypervde_noncholinergic=nanmean(difference_rate_hypervde_noncholinergic);
std_difference_rate_hypervde_noncholinergic=nanstd(difference_rate_hypervde_noncholinergic);
ste_difference_rate_hypervde_noncholinergic=std_difference_rate_hypervde_noncholinergic./sqrt(sum(~isnan(difference_rate_hypervde_noncholinergic)));

%% Resting membrane potential (used in the paper; load these files manually)
% restingV=[mean(fi_curves_Oct_14_14_B2(1:20000,1)) mean(fi_curves_Oct_23_14_A2(1:20000,1))...
%     mean(fi_curves_Dec_22_14_A3(1:20000,1)) mean(fi_curves_Jan_06_15_C1(1:20000,1))...
%     mean(fi_curves_Jan_13_15_B2(1:20000,1)) mean(fi_curves_Jan_30_15_A2(1:20000,1))...
%     mean(fi_curves_Feb_10_15_B2(1:20000,1)) mean(fi_curves_Feb_27_15_B2(1:20000,1))...
%     mean(fi_curves_Mar_23_15_C2(1:20000,1)) mean(fi_curves_Mar_27_15_A5(1:20000,1))...
%     mean(fi_curves_Apr_03_15_B1(1:20000,1)) mean(fi_curves_Apr_07_15_C1(1:20000,1))...
%     mean(fi_curves_Apr_29_15_E2(1:20000,1))]*1e3;
% mean_restingV=mean(restingV);
% std_restingV=std(restingV);
% ste_restingV=std_restingV/sqrt(numel(restingV));

%% Statistics

[gainsttest_hyper_de(1),gainsttest_hyper_de(2)]=ttest(gains_all_hypervde,gains_all_devhyper);
[gainsttest_hyper_de_4AP(1),gainsttest_hyper_de_4AP(2)]=ttest(gains_all_hypervde4AP,gains_all_devhyper4AP);
% [gainsttest_de_de_leak(1),gainsttest_de_de_leak(2)]=ttest(gains_all_devdeleak,gains_all_de_leakvde);
[gainsttest_hyper_de_noncholinergic(1),gainsttest_hyper_de_noncholinergic(2)]=ttest(gains_all_hypervde_noncholinergic,gains_all_devhyper_noncholinergic);
[resistancettest(1),resistancettest(2)]=ttest2(resistance_all_hypervde,resistance_all_hypervde_noncholinergic);
[capacitancettest(1),capacitancettest(2)]=ttest2(capacitance_all_hypervde,capacitance_all_hypervde_noncholinergic);
[time_constantttest(1),time_constantttest(2)]=ttest2(time_constant_all_hypervde,time_constant_all_hypervde_noncholinergic);

%% Plotting Gains
% 
figure;errorbar(1:2,[mean_gains_hypervde mean_gains_devhyper],[ste_gains_hypervde ste_gains_devhyper],'.m','LineWidth',2);
hold on;bar(1:2,[mean_gains_hypervde mean_gains_devhyper],.5,'m')
title('History-Dependent Change in Gains')
ylabel('Gains [Hz/pA]')
xlabel('Hyperpolarized    Depolarized')
set(gca, 'XTick', []);
axis([0.5 2.5 0 0.045])
% axis([0.4 2.6 0 0.2])

figure;errorbar(1:2,[mean_gains_hypervde4AP mean_gains_devhyper4AP],[ste_gains_hypervde4AP ste_gains_devhyper4AP],'.m','LineWidth',2);
hold on;bar(1:2,[mean_gains_hypervde4AP mean_gains_devhyper4AP],.5,'m')
title('History-Dependent Change in Gains with 4-AP')
ylabel('Gains [Hz/pA]')
xlabel('Hyperpolarized    Depolarized')
set(gca, 'XTick', []);
axis([0.5 2.5 0 0.06])
% axis([0.4 2.6 0 0.2])

% figure;errorbar(1:2,[mean_gains_devdeleak mean_gains_de_leakvde],[ste_gains_devdeleak ste_gains_de_leakvde],'.m','LineWidth',2);
% hold on;bar(1:2,[mean_gains_devdeleak mean_gains_de_leakvde],.5,'m')
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/pA]')
% xlabel('Depolarized    Depolarized with Leak')
% set(gca, 'XTick', []);
% axis([0.5 2.5 0 0.06])
% % axis([0.4 2.6 0 0.2])


%% Plotting Rate Differences

figure;errorbar(0:10:200,mean_difference_rate_hypervde,ste_difference_rate_hypervde)
title('Difference in Frequencies for Hyperpolarized and Depolarized')
ylabel('Frequency Difference [Hz]')
xlabel('Current [pA]')
% axis([0.4 2.6 0 0.2])

% figure;errorbar(1:21,mean_difference_rate_devdeleak,ste_difference_rate_devdeleak)
% title('Difference in Frequencies for Depolarized and Depolarized with Leak')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current Step')
% % axis([0.4 2.6 0 0.2])


%% Plotting Gains for Non-Cholinergic Neurons

figure;errorbar(1:2,[mean_gains_hypervde_noncholinergic mean_gains_devhyper_noncholinergic],[ste_gains_hypervde_noncholinergic ste_gains_devhyper_noncholinergic],'.m','LineWidth',2);
hold on;bar(1:2,[mean_gains_hypervde_noncholinergic mean_gains_devhyper_noncholinergic],.5,'m')
title('History-Dependent Change in Gains')
ylabel('Gains [Hz/pA]')
xlabel('Hyperpolarized    Depolarized')
set(gca, 'XTick', []);
axis([0.5 2.5 0 0.35])
% axis([0.4 2.6 0 0.2])
% 
% 
%% Plotting Rate Differences for Non-Cholinergic Neurons

% figure;errorbar(0:10:200,mean_difference_rate_hypervde_noncholinergic,ste_difference_rate_hypervde_noncholinergic)
% title('Difference in Frequencies for Hyperpolarized and Depolarized in Non-Cholinergic Neurons')
% ylabel('Frequency Difference [Hz]')
% xlabel('Current [pA]')
% % axis([0.4 2.6 0 0.2])