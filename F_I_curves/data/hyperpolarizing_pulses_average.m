clear;clc;close all

%% No Hyperpolarizing Pulses
% For Hyperpolarizing Pulses

dates_all_nhp={'Apr_03_15' 'Apr_03_15' 'Apr_06_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15'...
    'Apr_07_15' 'Apr_07_15' 'Apr_08_15' 'Apr_08_15' 'Apr_08_15' 'Apr_08_15'};
cellnum_all_nhp={'A' 'B' 'A' 'B' 'A' 'B'...
    'C' 'D' 'B' 'C' 'D' 'E'};
trials_all_nhp=[1 3 1 4 1 1 ...
    1 1 1 1 1 1]';
delay_all_nhp=[0 0 2 2 2 2 ...
    2 2 2 2 2 2]';
holding_current=[130 0 -10 50 50 20 ...
    0 10 20 30 30 20];

thresholds_all_nhp=NaN(numel(dates_all_nhp),24);

for k=1:numel(dates_all_nhp)
    eval(['load ' pwd '\..\..\F_I_curves\data\hyperpolarizing_pulses_analysis\fi_curves_' dates_all_nhp{k} '_' cellnum_all_nhp{k} num2str(trials_all_nhp(k)) '_hp.mat;'])
    currents_all_nhp(k,:)=currents{1};
    for h=1:numel(thresholds{1})
        thresholds_all_nhp(k,h)=nanmean(thresholds{1}{h});
    end
    rate_all_nhp(k,:)=rate_all{1};
    imp_all_nhp(k)=imp;
    nhpv(k,:)=hyperpolarization_pulse_voltages{1};
    ndpv(k,:)=depolarization_pulse_voltages{1};
end

thresholds_nhp=nanmean(thresholds_all_nhp,2);
mean_thresholds_nhp=nanmean(thresholds_nhp);
std_thresholds_nhp=nanstd(thresholds_nhp);
ste_thresholds_nhp=std_thresholds_nhp/sqrt(numel(~isnan(thresholds_nhp)));
mean_imp_nhp=nanmean(imp_all_nhp);
std_imp_nhp=nanstd(imp_all_nhp);
mean_rate_nhp=nanmean(rate_all_nhp);
std_rate_nhp=nanstd(rate_all_nhp);
ste_rate_nhp=std_rate_nhp./sqrt(sum(~isnan(rate_all_nhp)));
% mean_nhpv=mean(nhpv);
% std_nhpv=std(nhpv);
% ste_nhpv=std_nhpv./sqrt(sum(~isnan(nhpv)));
mean_nhpv=mean(reshape(nhpv,1,[]));
std_nhpv=std(reshape(nhpv,1,[]));
ste_nhpv=std_nhpv/sqrt(numel(nhpv));
mean_ndpv=mean(mean(ndpv'));
std_ndpv=std(mean(ndpv'));
ste_ndpv=std_ndpv./sqrt(sum(~isnan(mean(ndpv'))));


% Hyperpolarizing Pulses
% For No Hyperpolarizing Pulses

dates_all_hp={'Apr_03_15' 'Apr_03_15' 'Apr_06_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15'...
    'Apr_07_15' 'Apr_07_15' 'Apr_08_15' 'Apr_08_15' 'Apr_08_15' 'Apr_08_15'};
cellnum_all_hp={'A' 'B' 'A' 'B' 'A' 'B'...
    'C' 'D' 'B' 'C' 'D' 'E'};
trials_all_hp=[2 2 2 3 2 2 ...
    2 2 2 2 3 2]';
delay_all_hp=[0 0 2 2 2 2 ...
    2 2 2 2 2 2]';

thresholds_all_hp=NaN(numel(dates_all_hp),24);

for k=1:numel(dates_all_hp)
    eval(['load ' pwd '\..\..\F_I_curves\data\hyperpolarizing_pulses_analysis\fi_curves_' dates_all_hp{k} '_' cellnum_all_hp{k} num2str(trials_all_hp(k)) '_hp.mat;'])
    currents_all_hp(k,:)=currents{1};
    for h=1:numel(thresholds{1})
        thresholds_all_hp(k,h)=nanmean(thresholds{1}{h});
    end
    rate_all_hp(k,:)=rate_all{1};
    imp_all_hp(k)=imp;
    hpv(k,:)=hyperpolarization_pulse_voltages{1};
    dpv(k,:)=depolarization_pulse_voltages{1};
end

thresholds_hp=nanmean(thresholds_all_hp,2);
mean_thresholds_hp=nanmean(thresholds_hp);
std_thresholds_hp=nanstd(thresholds_hp);
ste_thresholds_hp=std_thresholds_hp/sqrt(numel(~isnan(thresholds_hp)));
mean_imp_hp=nanmean(imp_all_hp);
std_imp_hp=nanstd(imp_all_hp);
mean_rate_hp=nanmean(rate_all_hp);
std_rate_hp=nanstd(rate_all_hp);
ste_rate_hp=std_rate_hp./sqrt(sum(~isnan(rate_all_hp)));
% mean_hpv=mean(hpv);
% std_hpv=std(hpv);
% ste_hpv=std_hpv./sqrt(sum(~isnan(hpv)));
mean_hpv=mean(reshape(hpv,1,[]));
std_hpv=std(reshape(hpv,1,[]));
ste_hpv=std_hpv/sqrt(numel(hpv));
mean_dpv=mean(mean(dpv'));
std_dpv=std(mean(dpv'));
ste_dpv=std_dpv./sqrt(sum(~isnan(mean(dpv'))));

figure(1);shadedErrorBar(1:24,mean_rate_nhp,ste_rate_nhp,'k')
hold on;shadedErrorBar(1:24,mean_rate_hp,ste_rate_hp,'g')
title('Cholinergic Neuron with and without Hyperpolarizing Pulses')
xlabel('Pulse Number')
ylabel('Firing Rate [Hz]')
axis([0 25 1 4])

% normalized rates
individual_mean_rate_nhp=nanmean(rate_all_nhp');
for k=1:numel(rate_all_nhp(:,1))
    normalized_rate_hp(k,:)=rate_all_hp(k,:)/individual_mean_rate_nhp(k);
    normalized_rate_nhp(k,:)=rate_all_nhp(k,:)/individual_mean_rate_nhp(k);
end
mean_normalized_rate_hp=nanmean(normalized_rate_hp);
std_normalized_rate_hp=nanstd(normalized_rate_hp);
ste_normalized_rate_hp=std_normalized_rate_hp./sqrt(sum(~isnan(normalized_rate_hp)));
mean_normalized_rate_nhp=nanmean(normalized_rate_nhp);
std_normalized_rate_nhp=nanstd(normalized_rate_nhp);
ste_normalized_rate_nhp=std_normalized_rate_nhp./sqrt(sum(~isnan(normalized_rate_nhp)));
figure(2);shadedErrorBar(1:24,mean_normalized_rate_nhp,ste_normalized_rate_nhp,'k')
hold on;shadedErrorBar(1:24,mean_normalized_rate_hp,ste_normalized_rate_hp,'g')
title('Cholinergic Neuron with and without Hyperpolarizing Pulses')
xlabel('pulse number')
ylabel('normalized firing rate')
% axis([0 25 0.3 1.2])

[ttestnormalizedhppulses(1),ttestnormalizedhppulses(2)]=ttest(mean(normalized_rate_nhp'),mean(normalized_rate_hp'));

% figure(1);errorbar([1:24;1:24]',[mean_rate_nhp;mean_rate_hp]',[ste_rate_nhp;ste_rate_hp]')
% legend('No Hyperpolarizing Pulses','Hyperpolarizing Pulses')
% title('Cholinergic Neuron with and without Hyperpolarizing Pulses')
% xlabel('Pulse Number')
% ylabel('Firing Rate [Hz]')

percent_diff=(rate_all_nhp(2:end,:)-rate_all_hp(2:end,:))./rate_all_nhp(2:end,:);
mean_percent_diff=nanmean(percent_diff);
std_percent_diff=nanstd(percent_diff);
ste_percent_diff=std_percent_diff./sqrt(sum(~isnan(percent_diff)));

figure(3);errorbar(1:24,mean_percent_diff,ste_percent_diff,'r')
title('Percent Firing Reduction with Hyperpolarizing Pulses in Cholinergic (Blue) and Non-Cholinergic (Red) Neurons')
xlabel('Pulse Number')
ylabel('Percent Firing Reduction')

% figure;errorbar([1:24;1:24]',[mean_nhpv;mean_hpv]',[ste_nhpv;ste_hpv]')
% legend('No Hyperpolarizing Pulses','Hyperpolarizing Pulses')
% title('Cholinergic Neuron During Hyperpolarizing Pulses')
% xlabel('Pulse Number')
% ylabel('Voltage [mV]')

current_diff=holding_current-currents_all_hp(:,1)';

% anova2matrix=[reshape(rate_all_nhp,[],1) reshape(rate_all_hp,[],1)];
% anova2(anova2matrix,12)

%ttest
[ttesthppulses(1),ttesthppulses(2)]=ttest(mean(rate_all_nhp'),mean(rate_all_hp'));
mean(mean(rate_all_nhp')) %average cells, then average between cells
std(mean(rate_all_nhp'))/sqrt(12)
mean(mean(nhpv')) %control voltage instead of hyperpolarization (depolarization)
std(mean(nhpv'))/sqrt(12)
mean(mean(rate_all_hp'))
std(mean(rate_all_hp'))/sqrt(12)
mean(mean(hpv')) %we hyperpolarized the cells to this
std(mean(hpv'))/sqrt(12)
mean(mean(dpv')) %we held the cells at this
std(mean(dpv'))/sqrt(12)

%% No Hyperpolarizing Pulses Non-Cholinergic
% For Hyperpolarizing Pulses Non-Cholinergic

dates_all_nhpnc={'Apr_28_15' 'Apr_28_15' 'Apr_29_15' 'Apr_29_15' 'Apr_29_15' 'Apr_29_15'...
    'May_01_15' 'May_01_15' 'May_04_15' 'May_04_15' 'May_05_15' 'May_05_15'...
    'May_05_15'}; % Rate is too high: 'Apr_10_15' 'Apr_10_15' 'Apr_10_15'
cellnum_all_nhpnc={'A' 'B' 'A' 'B' 'C' 'D'...
    'A' 'B' 'A' 'B' 'A' 'B'...
    'C'}; %'A' 'B' 'C'
trials_all_nhpnc=[1 2 2 4 4 2 ...
    5 4 6 5 6 3 ...
    5]'; %1 1 1
delay_all_nhpnc=[2 2 2 2 2 2 ...
    2 2 2 2 2 2 ...
    2]'; %2 2 2
holding_current_nc=[0 -35 0 -10 -20 -10 ...
    -95 -45 -45 -100 -30 60 ...
    -45]; %0 0 -110

thresholds_all_nhpnc=NaN(numel(dates_all_nhpnc),24);

for k=1:numel(dates_all_nhpnc)
    eval(['load ' pwd '\..\..\F_I_curves\data\hyperpolarizing_pulses_analysis\fi_curves_' dates_all_nhpnc{k} '_' cellnum_all_nhpnc{k} num2str(trials_all_nhpnc(k)) '_hp.mat;'])
    currents_all_nhpnc(k,:)=currents{1};
    for h=1:numel(thresholds{1})
        thresholds_all_nhpnc(k,h)=nanmean(thresholds{1}{h});
    end
    rate_all_nhpnc(k,:)=rate_all{1};
    imp_all_nhpnc(k)=imp;
    nhpvnc(k,:)=hyperpolarization_pulse_voltages{1};
    ndpvnc(k,:)=depolarization_pulse_voltages{1};
end

thresholds_nhpnc=nanmean(thresholds_all_nhpnc,2);
mean_thresholds_nhpnc=nanmean(thresholds_nhpnc);
std_thresholds_nhpnc=nanstd(thresholds_nhpnc);
ste_thresholds_nhpnc=std_thresholds_nhpnc/sqrt(numel(~isnan(thresholds_nhpnc)));
mean_imp_nhpnc=nanmean(imp_all_nhpnc);
std_imp_nhpnc=nanstd(imp_all_nhpnc);
mean_rate_nhpnc=nanmean(rate_all_nhpnc);
std_rate_nhpnc=nanstd(rate_all_nhpnc);
ste_rate_nhpnc=std_rate_nhpnc./sqrt(sum(~isnan(rate_all_nhpnc)));
% mean_nhpvnc=mean(nhpvnc);
% std_nhpvnc=std(nhpvnc);
% ste_nhpvnc=std_nhpvnc./sqrt(sum(~isnan(nhpvnc)));
mean_nhpvnc=mean(reshape(nhpvnc,1,[]));
std_nhpvnc=std(reshape(nhpvnc,1,[]));
ste_nhpvnc=std_nhpvnc/sqrt(numel(nhpvnc));
mean_ndpvnc=mean(mean(ndpvnc'));
std_ndpvnc=std(mean(ndpvnc'));
ste_ndpvnc=std_ndpvnc./sqrt(sum(~isnan(mean(ndpvnc'))));


% Hyperpolarizing Pulses Non-Cholinergic
% For No Hyperpolarizing Pulses Non-Cholinergic

dates_all_hpnc={'Apr_28_15' 'Apr_28_15' 'Apr_29_15' 'Apr_29_15' 'Apr_29_15' 'Apr_29_15'...
    'May_01_15' 'May_01_15' 'May_04_15' 'May_04_15' 'May_05_15' 'May_05_15'...
    'May_05_15'}; %Rate is too high: 'Apr_10_15' 'Apr_10_15' 'Apr_10_15'
cellnum_all_hpnc={'A' 'B' 'A' 'B' 'C' 'D'...
    'A' 'B' 'A' 'B' 'A' 'B'...
    'C'}; %'A' 'B' 'C'
trials_all_hpnc=[2 1 1 2 3 1 ...
    6 5 7 6 7 4 ...
    6]'; %2 2 2
delay_all_hpnc=[2 2 2 2 2 2 ...
    2 2 2 2 2 2 ...
    2]'; %2 2 2

thresholds_all_hpnc=NaN(numel(dates_all_hpnc),24);

for k=1:numel(dates_all_hpnc)
    eval(['load ' pwd '\..\..\F_I_curves\data\hyperpolarizing_pulses_analysis\fi_curves_' dates_all_hpnc{k} '_' cellnum_all_hpnc{k} num2str(trials_all_hpnc(k)) '_hp.mat;'])
    currents_all_hpnc(k,:)=currents{1};
    for h=1:numel(thresholds{1})
        thresholds_all_hpnc(k,h)=nanmean(thresholds{1}{h});
    end
    rate_all_hpnc(k,:)=rate_all{1};
    imp_all_hpnc(k)=imp;
    hpvnc(k,:)=hyperpolarization_pulse_voltages{1};
    dpvnc(k,:)=depolarization_pulse_voltages{1};
end

thresholds_hpnc=nanmean(thresholds_all_hpnc,2);
mean_thresholds_hpnc=nanmean(thresholds_hpnc);
std_thresholds_hpnc=nanstd(thresholds_hpnc);
ste_thresholds_hpnc=std_thresholds_hpnc/sqrt(numel(~isnan(thresholds_hpnc)));
mean_imp_hpnc=nanmean(imp_all_hpnc);
std_imp_hpnc=nanstd(imp_all_hpnc);
mean_rate_hpnc=nanmean(rate_all_hpnc);
std_rate_hpnc=nanstd(rate_all_hpnc);
ste_rate_hpnc=std_rate_hpnc./sqrt(sum(~isnan(rate_all_hpnc)));
% mean_hpvnc=mean(hpvnc);
% std_hpvnc=std(hpvnc);
% ste_hpvnc=std_hpvnc./sqrt(sum(~isnan(hpvnc)));
mean_hpvnc=mean(reshape(hpvnc,1,[]));
std_hpvnc=std(reshape(hpvnc,1,[]));
ste_hpvnc=std_hpvnc/sqrt(numel(hpvnc));
mean_dpvnc=mean(mean(dpvnc'));
std_dpvnc=std(mean(dpvnc'));
ste_dpvnc=std_dpvnc./sqrt(sum(~isnan(mean(dpvnc'))));

figure(4);shadedErrorBar(1:24,mean_rate_nhpnc,ste_rate_nhpnc,'k')
hold on;shadedErrorBar(1:24,mean_rate_hpnc,ste_rate_hpnc,'g')
title('Non-Cholinergic Neuron with and without Hyperpolarizing Pulses')
xlabel('Pulse Number')
ylabel('Firing Rate [Hz]')

% normalized rates
individual_mean_rate_nhpnc=nanmean(rate_all_nhpnc');
for k=1:numel(rate_all_nhpnc(:,1))
    normalized_rate_hpnc(k,:)=rate_all_hpnc(k,:)/individual_mean_rate_nhpnc(k);
    normalized_rate_nhpnc(k,:)=rate_all_nhpnc(k,:)/individual_mean_rate_nhpnc(k);
end
normalized_rate_hpnc(~isfinite(normalized_rate_hpnc))=NaN; %change Infs to NaN
mean_normalized_rate_hpnc=nanmean(normalized_rate_hpnc);
std_normalized_rate_hpnc=nanstd(normalized_rate_hpnc);
ste_normalized_rate_hpnc=std_normalized_rate_hpnc./sqrt(sum(~isnan(normalized_rate_hpnc)));
mean_normalized_rate_nhpnc=nanmean(normalized_rate_nhpnc);
std_normalized_rate_nhpnc=nanstd(normalized_rate_nhpnc);
ste_normalized_rate_nhpnc=std_normalized_rate_nhpnc./sqrt(sum(~isnan(normalized_rate_nhpnc)));
figure(5);shadedErrorBar(1:24,mean_normalized_rate_nhpnc,ste_normalized_rate_nhpnc,'k')
hold on;shadedErrorBar(1:24,mean_normalized_rate_hpnc,ste_normalized_rate_hpnc,'g')
title('Non-Cholinergic Neuron with and without Hyperpolarizing Pulses')
xlabel('pulse number')
ylabel('normalized firing rate')
% axis([0 25 0.6 1.8])

[ttestnormalizedhppulses_noncholinergic(1),ttestnormalizedhppulses_noncholinergic(2)]=ttest(mean(normalized_rate_nhpnc([1:2 4:end],:)'),mean(normalized_rate_hpnc([1:2 4:end],:)'));

% figure;errorbar([1:24;1:24]',[mean_rate_nhpnc;mean_rate_hpnc]',[ste_rate_nhpnc;ste_rate_hpnc]')
% legend('No Hyperpolarizing Pulses','Hyperpolarizing Pulses')
% title('Non-Cholinergic Neuron with and without Hyperpolarizing Pulses')
% xlabel('Pulse Number')
% ylabel('Firing Rate [Hz]')

percent_diff_nc=(rate_all_nhpnc-rate_all_hpnc)./rate_all_nhpnc;
mean_percent_diff_nc=nanmean(percent_diff_nc);
std_percent_diff_nc=nanstd(percent_diff_nc);
ste_percent_diff_nc=std_percent_diff_nc./sqrt(sum(~isnan(percent_diff_nc)));

figure(3);hold on;errorbar(1:24,mean_percent_diff_nc,ste_percent_diff_nc)

% figure;errorbar([1:24;1:24]',[mean_nhpvnc;mean_hpvnc]',[ste_nhpvnc;ste_hpvnc]')
% legend('No Hyperpolarizing Pulses','Hyperpolarizing Pulses')
% title('Non-Cholinergic Neuron During Hyperpolarizing Pulses')
% xlabel('Pulse Number')
% ylabel('Voltage [mV]')

current_diff_nc=holding_current_nc-currents_all_hpnc(:,1)';

% anova2matrix_noncholinergic=[reshape(rate_all_nhpnc,[],1) reshape(rate_all_hpnc,[],1)];
% anova2(anova2matrix_noncholinergic,12)

%ttest
[ttesthppulses_noncholinergic(1),ttesthppulses_noncholinergic(2)]=ttest(mean(rate_all_nhpnc'),mean(rate_all_hpnc'));
mean(mean(rate_all_nhpnc'))
std(mean(rate_all_nhpnc'))/sqrt(13)
mean(mean(nhpvnc'))
std(mean(nhpvnc'))/sqrt(13)
mean(mean(rate_all_hpnc'))
std(mean(rate_all_hpnc'))/sqrt(13)
mean(mean(hpvnc'))
std(mean(hpvnc'))/sqrt(13)