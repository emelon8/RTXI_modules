clear;clc;close all
% Mar_11_15_A1 and 2 or Mar_16_15_B5 and 6 for f-I curve examples
%% Hyperpolarized with Noise (5 sec pulse, 1 sec pause; Currents go from 0:10:200)
% For Depolarized with Noise

% Paired with depolarized data only
dates_all_hyper_noisevdenoise={'Feb_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15' 'Mar_16_15' 'Feb_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_17_15' 'Mar_23_15' 'Apr_07_15'...
    'Mar_17_15' 'Mar_23_15' 'Mar_24_15' 'Apr_06_15' 'Apr_07_15'};
cellnum_all_hyper_noisevdenoise={'B' 'A' 'D' 'B' 'B' 'C' 'C' 'B' 'C' 'A' 'B' 'C' 'A'...
    'A' 'E' 'B' 'B' 'C'};
trials_all_hyper_noisevdenoise=[1 3 1 3 5 1  1 1 1 1 1 1 1 ...
    1 1 3 1 1]';

for k=1:numel(dates_all_hyper_noisevdenoise)
    eval(['load ' pwd '\fi_analysis\FI_OU_' dates_all_hyper_noisevdenoise{k} '_' cellnum_all_hyper_noisevdenoise{k} num2str(trials_all_hyper_noisevdenoise(k)) '_fi.mat;'])
    peakrate_all_hyper_noisevdenoise(k,:)=peakrate;
    nofailrate_all_hyper_noisevdenoise(k,:)=nofailrate;
    gains_all_hyper_noisevdenoise(k,1)=pf_all{1}.beta(2);
    rsq_all_hyper_noisevdenoise(k,1)=pf_all{1}.rsquare;
    rate_all_hyper_noisevdenoise(k,:)=rate_all{1};
    imp_all_hyper_noisevdenoise(k,:)=imp;
    holdingvoltage_all_hyper_noisevdenoise(k,:)=mean_holdingvoltage;
    std_noise_all_hyper_noisevdenoise(k)=std_noise;
end

gains_all_hyper_noisevdenoise(isnan(rsq_all_hyper_noisevdenoise))=NaN; % filter out the gains that are NaNs

mean_peakrate_hyper_noisevdenoise=nanmean(peakrate_all_hyper_noisevdenoise);
std_peakrate_hyper_noisevdenoise=nanstd(peakrate_all_hyper_noisevdenoise);
mean_nofailrate_hyper_noisevdenoise=nanmean(nofailrate_all_hyper_noisevdenoise);
std_nofailrate_hyper_noisevdenoise=nanstd(nofailrate_all_hyper_noisevdenoise);
mean_gains_hyper_noisevdenoise=nanmean(gains_all_hyper_noisevdenoise);
std_gains_hyper_noisevdenoise=nanstd(gains_all_hyper_noisevdenoise);
ste_gains_hyper_noisevdenoise=std_gains_hyper_noisevdenoise/sqrt(sum(~isnan(gains_all_hyper_noisevdenoise)));
mean_imp_hyper_noisevdenoise=nanmean(imp_all_hyper_noisevdenoise);
std_imp_hyper_noisevdenoise=nanstd(imp_all_hyper_noisevdenoise);
mean_holdingvoltage_all_hyper_noisevdenoise=nanmean(holdingvoltage_all_hyper_noisevdenoise);
std_holdingvoltage_all_hyper_noisevdenoise=nanstd(holdingvoltage_all_hyper_noisevdenoise);
mean_std_noise_all_hyper_noisevdenoise=nanmean(std_noise_all_hyper_noisevdenoise);
std_std_noise_all_hyper_noisevdenoise=nanstd(std_noise_all_hyper_noisevdenoise);
mean_rate_hyper_noisevdenoise=nanmean(rate_all_hyper_noisevdenoise);
std_rate_hyper_noisevdenoise=nanstd(rate_all_hyper_noisevdenoise);
ste_rate_hyper_noisevdenoise=std_rate_hyper_noisevdenoise./sqrt(sum(~isnan(rate_all_hyper_noisevdenoise)));

% Deepolarized with Noise (Currents go from 0:10:200)
% For Hyperpolarized with Noise

% Paired with depolarized data only
dates_all_de_noisevhypernoise={'Feb_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15' 'Mar_16_15' 'Feb_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_17_15' 'Mar_23_15' 'Apr_07_15'...
    'Mar_17_15' 'Mar_23_15' 'Mar_24_15' 'Apr_06_15' 'Apr_07_15'};
cellnum_all_de_noisevhypernoise={'B' 'A' 'D' 'B' 'B' 'C' 'C' 'B' 'C' 'A' 'B' 'C' 'A'...
    'A' 'E' 'B' 'B' 'C'};
trials_all_de_noisevhypernoise=[2 4 2 4 6 2  2 2 2 2 2 2 2 ...
    2 2 4 2 2]';

sub_currents_de_noisevhypernoise_all=NaN(numel(dates_all_de_noisevhypernoise),21);
sub_noise_de_noisevhypernoise=NaN(numel(dates_all_de_noisevhypernoise),21);
sup_currents_de_noisevhypernoise_all=NaN(numel(dates_all_de_noisevhypernoise),21);
sup_noise_de_noisevhypernoise=NaN(numel(dates_all_de_noisevhypernoise),21);

for k=1:numel(dates_all_de_noisevhypernoise)
    eval(['load ' pwd '\fi_analysis\FI_OU_' dates_all_de_noisevhypernoise{k} '_' cellnum_all_de_noisevhypernoise{k} num2str(trials_all_de_noisevhypernoise(k)) '_fi.mat;'])
    peakrate_all_de_noisevhypernoise(k,:)=peakrate;
    nofailrate_all_de_noisevhypernoise(k,:)=nofailrate;
    gains_all_de_noisevhypernoise(k,1)=pf_all{1}.beta(2);
    rsq_all_de_noisevhypernoise(k,1)=pf_all{1}.rsquare;
    rate_all_de_noisevhypernoise(k,:)=rate_all{1};
%     resistance_all_de_noisevhypernoise(k)=mean_r_m;
%     capacitance_all_de_noisevhypernoise(k)=mean_c_m;
%     time_constant_all_de_noisevhypernoise(k)=mean_time_constant;
    imp_all_de_noisevhypernoise(k,:)=imp;
    holdingvoltage_all_de_noisevhypernoise(k,:)=mean_holdingvoltage;
    std_noise_all_de_noisevhypernoise(k)=std_noise;
    ISIratio_de_noisevhypernoise(k,:)=ISIratio{1};
    ISIs_all_de_noisevhypernoise=ISIs_all{1};
    firstISI_all_de_noisevhypernoise(k,:)=firstISI{1};
    lastISI_all_de_noisevhypernoise(k,:)=lastISI{1};
    std_noise_de_noisevhypernoise(k,:)=std_noise_all{1}; %not just the first second of the first pulse, but all pulses
    currents_de_noisevhypernoise_all(k,:)=0:10:200;
    if sum(rate_all_de_noisevhypernoise(k,:)>=1)
        de_noisevhypernoise_2threshold(k)=find(rate_all_de_noisevhypernoise(k,:)>=1,1);
        sub_currents_de_noisevhypernoise_all(k,1:de_noisevhypernoise_2threshold(k)-1)=currents_de_noisevhypernoise_all(k,1:de_noisevhypernoise_2threshold(k)-1);
        sub_noise_de_noisevhypernoise(k,1:de_noisevhypernoise_2threshold(k)-1)=std_noise_de_noisevhypernoise(k,1:de_noisevhypernoise_2threshold(k)-1);
        sup_currents_de_noisevhypernoise_all(k,de_noisevhypernoise_2threshold(k):end)=currents_de_noisevhypernoise_all(k,de_noisevhypernoise_2threshold(k):end);
        sup_noise_de_noisevhypernoise(k,de_noisevhypernoise_2threshold(k):end)=std_noise_de_noisevhypernoise(k,de_noisevhypernoise_2threshold(k):end);
    else
        de_noisevhypernoise_2threshold(k)=NaN;
        sub_currents_de_noisevhypernoise_all(k,:)=currents_de_noisevhypernoise_all(k,:);
        sub_noise_de_noisevhypernoise(k,:)=std_noise_de_noisevhypernoise(k,:);
    end
end

mean_std_noise_de_noisevhypernoise=nanmean(std_noise_de_noisevhypernoise);
std_std_noise_de_noisevhypernoise=nanstd(std_noise_de_noisevhypernoise);
ste_std_noise_de_noisevhypernoise=std_std_noise_de_noisevhypernoise./sqrt(sum(~isnan(std_noise_de_noisevhypernoise)));

mean_sub_noise_de_noisevhypernoise=nanmean(sub_noise_de_noisevhypernoise);
std_sub_noise_de_noisevhypernoise=nanstd(sub_noise_de_noisevhypernoise);
ste_sub_noise_de_noisevhypernoise=std_sub_noise_de_noisevhypernoise./sqrt(sum(~isnan(sub_noise_de_noisevhypernoise)));
mean_sup_noise_de_noisevhypernoise=nanmean(sup_noise_de_noisevhypernoise);
std_sup_noise_de_noisevhypernoise=nanstd(sup_noise_de_noisevhypernoise);
ste_sup_noise_de_noisevhypernoise=std_sup_noise_de_noisevhypernoise./sqrt(sum(~isnan(sup_noise_de_noisevhypernoise)));

gains_all_de_noisevhypernoise(isnan(rsq_all_de_noisevhypernoise))=NaN; % filter out the gains that are NaNs

mean_peakrate_de_noisevhypernoise=nanmean(peakrate_all_de_noisevhypernoise);
std_peakrate_de_noisevhypernoise=nanstd(peakrate_all_de_noisevhypernoise);
mean_nofailrate_de_noisevhypernoise=nanmean(nofailrate_all_de_noisevhypernoise);
std_nofailrate_de_noisevhypernoise=nanstd(nofailrate_all_de_noisevhypernoise);
mean_gains_de_noisevhypernoise=nanmean(gains_all_de_noisevhypernoise);
std_gains_de_noisevhypernoise=nanstd(gains_all_de_noisevhypernoise);
ste_gains_de_noisevhypernoise=std_gains_de_noisevhypernoise/sqrt(sum(~isnan(gains_all_de_noisevhypernoise)));

normalized_gains_all_de_noisevhypernoise=gains_all_de_noisevhypernoise./gains_all_hyper_noisevdenoise;
normalized_mean_gains_de_noisevhypernoise=nanmean(normalized_gains_all_de_noisevhypernoise([1:3 5:end]));
normalized_std_gains_de_noisevhypernoise=nanstd(normalized_gains_all_de_noisevhypernoise([1:3 5:end]));
normalized_ste_gains_de_noisevhypernoise=normalized_std_gains_de_noisevhypernoise/sqrt(sum(~isnan(normalized_gains_all_de_noisevhypernoise([1:3 5:end]))));
figure;plot(ones(size(normalized_gains_all_de_noisevhypernoise([1:3 5:end]))),normalized_gains_all_de_noisevhypernoise([1:3 5:end]),'.','LineWidth',3)
hold on;errorbar(1,normalized_mean_gains_de_noisevhypernoise,normalized_ste_gains_de_noisevhypernoise,'or','LineWidth',2)
title('Normalized Hyperpolarized with Noise Gains')
ylabel('Normalized Gain')
axis([0.9 1.1 0 140])
axis 'auto y'
set(gca, 'XTick', []);
[gainsttest_normalized_hyper_hyper_noise(1),gainsttest_normalized_hyper_hyper_noise(2)]=ttest(ones(size(normalized_gains_all_de_noisevhypernoise)),normalized_gains_all_de_noisevhypernoise);

% mean_resistance_de_noisevhypernoise=nanmean(resistance_all_de_noisevhypernoise);
% std_resistance_de_noisevhypernoise=nanstd(resistance_all_de_noisevhypernoise);
% mean_capacitance_de_noisevhypernoise=nanmean(capacitance_all_de_noisevhypernoise);
% std_capacitance_de_noisevhypernoise=nanstd(capacitance_all_de_noisevhypernoise);
% mean_tau_m_de_noisevhypernoise=nanmean(time_constant_all_de_noisevhypernoise);
% std_tau_m_de_noisevhypernoise=nanstd(time_constant_all_de_noisevhypernoise);
mean_imp_de_noisevhypernoise=nanmean(imp_all_de_noisevhypernoise);
std_imp_de_noisevhypernoise=nanstd(imp_all_de_noisevhypernoise);
mean_holdingvoltage_all_de_noisevhypernoise=nanmean(holdingvoltage_all_de_noisevhypernoise);
std_holdingvoltage_all_de_noisevhypernoise=nanstd(holdingvoltage_all_de_noisevhypernoise);
mean_std_noise_all_de_noisevhypernoise=nanmean(std_noise_all_de_noisevhypernoise);
std_std_noise_all_de_noisevhypernoise=nanstd(std_noise_all_de_noisevhypernoise);
mean_rate_de_noisevhypernoise=nanmean(rate_all_de_noisevhypernoise);
std_rate_de_noisevhypernoise=nanstd(rate_all_de_noisevhypernoise);
ste_rate_de_noisevhypernoise=std_rate_de_noisevhypernoise./sqrt(sum(~isnan(rate_all_de_noisevhypernoise)));

currents=0:10:200;
nlf_fi_hyper_noisevdenoise=nlinfit(currents,mean_rate_hyper_noisevdenoise,'sigFun',[320,50,10]);
nlf_fi_de_noisevhypernoise=nlinfit(currents,mean_rate_de_noisevhypernoise,'sigFun',[320,50,10]);

hyper_noisevdenoise_max=nlf_fi_hyper_noisevdenoise(1);
hyper_noisevdenoise_midpoint=nlf_fi_hyper_noisevdenoise(2);
hyper_noisevdenoise_slope=nlf_fi_hyper_noisevdenoise(1)/(4*nlf_fi_hyper_noisevdenoise(3));
de_noisevhypernoise_max=nlf_fi_de_noisevhypernoise(1);
de_noisevhypernoise_midpoint=nlf_fi_de_noisevhypernoise(2);
de_noisevhypernoise_slope=nlf_fi_de_noisevhypernoise(1)/(4*nlf_fi_de_noisevhypernoise(3));

figure;errorbar([currents;currents]',[mean_rate_hyper_noisevdenoise;mean_rate_de_noisevhypernoise]',[ste_rate_hyper_noisevdenoise;ste_rate_de_noisevhypernoise]')
hold on;plot(currents,sigFun(nlf_fi_hyper_noisevdenoise,currents),'m');plot(currents,sigFun(nlf_fi_de_noisevhypernoise,currents),'r')
xlabel('current [pA]')
ylabel('firing rate [spikes/s]')
axis([0 200 0 7])

figure;shadedErrorBar(currents,mean_rate_hyper_noisevdenoise,ste_rate_hyper_noisevdenoise,'g')
hold on;shadedErrorBar(currents,mean_rate_de_noisevhypernoise,ste_rate_de_noisevhypernoise,'k')
hold on;plot(currents,sigFun(nlf_fi_hyper_noisevdenoise,currents),'m');plot(currents,sigFun(nlf_fi_de_noisevhypernoise,currents),'r')
xlabel('current [pA]')
ylabel('firing rate [spikes/s]')
axis([0 200 0 7])

% difference between rates (unpaired)
difference_rate_hyper_noisevdenoise=rate_all_de_noisevhypernoise-rate_all_hyper_noisevdenoise;
mean_difference_rate_hyper_noisevdenoise=nanmean(difference_rate_hyper_noisevdenoise);
std_difference_rate_hyper_noisevdenoise=nanstd(difference_rate_hyper_noisevdenoise);
ste_difference_rate_hyper_noisevdenoise=std_difference_rate_hyper_noisevdenoise./sqrt(sum(~isnan(difference_rate_hyper_noisevdenoise)));

percent_difference_rate_hyper_noisevdenoise=(difference_rate_hyper_noisevdenoise./rate_all_hyper_noisevdenoise)*100;
percent_difference_rate_hyper_noisevdenoise(~isfinite(percent_difference_rate_hyper_noisevdenoise))=NaN;
mean_percent_difference_rate_hyper_noisevdenoise=nanmean(percent_difference_rate_hyper_noisevdenoise);
std_percent_difference_rate_hyper_noisevdenoise=nanstd(percent_difference_rate_hyper_noisevdenoise);
ste_percent_difference_rate_hyper_noisevdenoise=std_percent_difference_rate_hyper_noisevdenoise./sqrt(sum(~isnan(percent_difference_rate_hyper_noisevdenoise)));

new_percent_difference_rate_hyper_noisevdenoise=difference_rate_hyper_noisevdenoise./rate_all_de_noisevhypernoise;
new_percent_difference_rate_hyper_noisevdenoise(~isfinite(new_percent_difference_rate_hyper_noisevdenoise))=NaN;
mean_new_percent_difference_rate_hyper_noisevdenoise=nanmean(new_percent_difference_rate_hyper_noisevdenoise);
std_new_percent_difference_rate_hyper_noisevdenoise=nanstd(new_percent_difference_rate_hyper_noisevdenoise);
ste_new_percent_difference_rate_hyper_noisevdenoise=std_new_percent_difference_rate_hyper_noisevdenoise./sqrt(sum(~isnan(new_percent_difference_rate_hyper_noisevdenoise)));

% difference between rates (paired) #####recount which trials are paired
% and which aren't
paired_difference_rate_hyper_noisevdenoise=rate_all_de_noisevhypernoise([1 2 4 5 7 9:end],:)-rate_all_hyper_noisevdenoise([1 2 4 5 7 9:end],:);
paired_mean_difference_rate_hyper_noisevdenoise=nanmean(paired_difference_rate_hyper_noisevdenoise);
paired_std_difference_rate_hyper_noisevdenoise=nanstd(paired_difference_rate_hyper_noisevdenoise);
paired_ste_difference_rate_hyper_noisevdenoise=paired_std_difference_rate_hyper_noisevdenoise./sqrt(sum(~isnan(paired_difference_rate_hyper_noisevdenoise)));

paired_percent_difference_rate_hyper_noisevdenoise=(paired_difference_rate_hyper_noisevdenoise./rate_all_hyper_noisevdenoise([1 2 4 5 7 9:end],:))*100;
paired_percent_difference_rate_hyper_noisevdenoise(~isfinite(paired_percent_difference_rate_hyper_noisevdenoise))=NaN;
paired_mean_percent_difference_rate_hyper_noisevdenoise=nanmean(paired_percent_difference_rate_hyper_noisevdenoise);
paired_std_percent_difference_rate_hyper_noisevdenoise=nanstd(paired_percent_difference_rate_hyper_noisevdenoise);
paired_ste_percent_difference_rate_hyper_noisevdenoise=paired_std_percent_difference_rate_hyper_noisevdenoise./sqrt(sum(~isnan(paired_percent_difference_rate_hyper_noisevdenoise)));

paired_new_percent_difference_rate_hyper_noisevdenoise=paired_difference_rate_hyper_noisevdenoise./rate_all_de_noisevhypernoise([1 2 4 5 7 9:end],:);
paired_new_percent_difference_rate_hyper_noisevdenoise(~isfinite(paired_new_percent_difference_rate_hyper_noisevdenoise))=NaN;
paired_mean_new_percent_difference_rate_hyper_noisevdenoise=nanmean(paired_new_percent_difference_rate_hyper_noisevdenoise);
paired_std_new_percent_difference_rate_hyper_noisevdenoise=nanstd(paired_new_percent_difference_rate_hyper_noisevdenoise);
paired_ste_new_percent_difference_rate_hyper_noisevdenoise=paired_std_new_percent_difference_rate_hyper_noisevdenoise./sqrt(sum(~isnan(paired_new_percent_difference_rate_hyper_noisevdenoise)));

[gainsttest_hyper_noisevdenoise(1),gainsttest_hyper_noisevdenoise(2)]=ttest(gains_all_hyper_noisevdenoise,gains_all_de_noisevhypernoise);

figure;errorbar(1:2,[mean_gains_hyper_noisevdenoise mean_gains_de_noisevhypernoise],[ste_gains_hyper_noisevdenoise ste_gains_de_noisevhypernoise],'.m','LineWidth',2);
hold on;bar(1:2,[mean_gains_hyper_noisevdenoise mean_gains_de_noisevhypernoise],.5,'m')
ylabel('gain [spikes/(pA*s)')
xlabel('Hyperpolarized    Depolarized')
set(gca, 'XTick', []);
axis([0.5 2.5 0 0.06])