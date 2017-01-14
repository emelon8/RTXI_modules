clear;clc;close all

tic

%no noise cases

dates_all={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'...
    'May_31_13' 'May_31_13' 'Jun_24_13' 'Jun_24_13' 'Jul_03_13' 'Jul_03_13'...
    'Jul_29_13' 'Jul_29_13' 'Aug_05_13' 'Aug_16_13' 'Sep_05_13' 'Sep_16_13'...
    'Oct_08_13' 'Oct_08_13' 'Mar_18_14'};
cellnum_all={'B' 'A' 'B' 'A' 'A' 'B'...
    'C' 'D' 'A' 'B' 'A' 'B'...
    'A' 'B' 'A' 'A' 'A' 'A'...
    'A' 'B' 'A'};
trials_all=[2 3 2 2 2 2 ...
    2 2 2 2 2 2 ...
    2 4 2 2 2 3 ...
    3 3 1]';

spikes_all=cell(1,numel(dates_all));

for k=1:numel(dates_all)
    eval(['load ' pwd '\..\..\F_I_curves\data\spikes_analysis\fi_curves_' dates_all{k} '_' cellnum_all{k} '_spikes.mat;'])
    spike1_hyper_all(k,:)=spike1avg(1,:)';
    spike2_hyper_all(k,:)=spike2avg(1,:)';
    spike3_hyper_all(k,:)=spike3avg(1,:)';
    spikelast_hyper_all(k,:)=spikelastavg(1,:)';
    spikelastrise_all(k,1)=spikelastriseavg(1);
    spike1_de_all(k,:)=spike1avg(2,:)';
    spike2_de_all(k,:)=spike2avg(2,:)';
    spike3_de_all(k,:)=spike3avg(2,:)';
    spikelast_de_all(k,:)=spikelastavg(2,:)';
    spikelastrise_all(k,2)=spikelastriseavg(2);
end

mean_hyper_spike1=nanmean(spike1_hyper_all)*1e3;
mean_hyper_spike2=nanmean(spike2_hyper_all)*1e3;
mean_hyper_spike3=nanmean(spike3_hyper_all)*1e3;
mean_hyper_spikelast=nanmean(spikelast_hyper_all)*1e3;
mean_de_spike1=nanmean(spike1_de_all)*1e3;
mean_de_spike2=nanmean(spike2_de_all)*1e3;
mean_de_spike3=nanmean(spike3_de_all)*1e3;
mean_de_spikelast=nanmean(spikelast_de_all)*1e3;
mean_spikelastrise=nanmean(spikelastrise_all)*1e3;
ste_hyper_spike1=nanstd(spike1_hyper_all)/sqrt(sum(isfinite(spike1_hyper_all(:,1))))*1e3;
ste_hyper_spike2=nanstd(spike2_hyper_all)/sqrt(sum(isfinite(spike2_hyper_all(:,1))))*1e3;
ste_hyper_spike3=nanstd(spike3_hyper_all)/sqrt(sum(isfinite(spike3_hyper_all(:,1))))*1e3;
ste_hyper_spikelast=nanstd(spikelast_hyper_all)/sqrt(sum(isfinite(spikelast_hyper_all(:,1))))*1e3;
ste_de_spike1=nanstd(spike1_de_all)/sqrt(sum(isfinite(spike1_de_all(:,1))))*1e3;
ste_de_spike2=nanstd(spike2_de_all)/sqrt(sum(isfinite(spike2_de_all(:,1))))*1e3;
ste_de_spike3=nanstd(spike3_de_all)/sqrt(sum(isfinite(spike3_de_all(:,1))))*1e3;
ste_de_spikelast=nanstd(spikelast_de_all)/sqrt(sum(isfinite(spikelast_de_all(:,1))))*1e3;
ste_spikelastrise=nanstd(spikelastrise_all)/sqrt(sum(isfinite(spikelastrise_all(:,1))))*1e3;


%noise cases

dates_noise_all={'Oct_03_14' 'Oct_06_14' 'Oct_06_14' 'Oct_14_14' 'Oct_14_14' 'Oct_14_14'...
    'Oct_15_14' 'Oct_23_14' 'Oct_24_14' 'Oct_24_14' 'Nov_26_14' 'Jan_27_15'...
    'Jan_27_15' 'Feb_03_15' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Feb_10_15'};
cellnum_noise_all={'B' 'A' 'C' 'A' 'B' 'C'...
    'A' 'A' 'A' 'B' 'A' 'A'...
    'B' 'A' 'B' 'C' 'B' 'C'};
trials_noise_all=[4 3 3 2 1 1 ...
    1 1 2 2 2 1 ...
    1 1 1 1 1 1]';

spikes_noise_all=cell(1,numel(dates_noise_all));

for k=1:numel(dates_noise_all)
    eval(['load ' pwd '\spikes_analysis\FI_OU_' dates_noise_all{k} '_' cellnum_noise_all{k} num2str(trials_noise_all(k)) '_spikes.mat;'])
    spike1_noise_all(k,:)=spike1avg(1,:);
    spike2_noise_all(k,:)=spike2avg(1,:);
    spike3_noise_all(k,:)=spike3avg(1,:);
    spikelast_noise_all(k,:)=spikelastavg(1,:);
    spikelastrise_noise_all(k)=spikelastriseavg(1);
end

mean_spike1_noise=nanmean(spike1_noise_all);
mean_spike2_noise=nanmean(spike2_noise_all);
mean_spike3_noise=nanmean(spike3_noise_all);
mean_spikelast_noise=nanmean(spikelast_noise_all);
mean_spikelastrise_noise=nanmean(spikelastrise_noise_all);
ste_spike1_noise=nanstd(spike1_noise_all)/sqrt(sum(isfinite(spike1_noise_all(:,1))));
ste_spike2_noise=nanstd(spike2_noise_all)/sqrt(sum(isfinite(spike2_noise_all(:,1))));
ste_spike3_noise=nanstd(spike3_noise_all)/sqrt(sum(isfinite(spike3_noise_all(:,1))));
ste_spikelast_noise=nanstd(spikelast_noise_all)/sqrt(sum(isfinite(spikelast_noise_all(:,1))));
ste_spikelastrise_noise=nanstd(spikelastrise_noise_all)/sqrt(sum(isfinite(spikelastrise_noise_all)));

% Paired t-test
[risettest(1),risettest(2)]=ttest(spikelastrise_all(:,1),spikelastrise_all(:,2));
% Two sample (non-paired) t-test
[risehypernoisettest(1),risehypernoisettest(2)]=ttest2(spikelastrise_all(:,1),spikelastrise_noise_all);

figure;shadedErrorBar([1:length(mean_hyper_spike1)]/10,mean_hyper_spike1,ste_hyper_spike1);hold on;
shadedErrorBar([1:length(mean_de_spike1)]/10,mean_de_spike1,ste_de_spike1,'r');hold on;
shadedErrorBar([1:length(mean_spike1_noise)]/10,mean_spike1_noise,ste_spike1_noise,'g');
title('History-Dependent Change in First Spike Shape')
ylabel('Membrane Voltage [mV]')
xlabel('Time [ms]')

figure;shadedErrorBar([1:length(mean_hyper_spike2)]/10,mean_hyper_spike2,ste_hyper_spike2);hold on;
shadedErrorBar([1:length(mean_de_spike2)]/10,mean_de_spike2,ste_de_spike2,'r');hold on;
shadedErrorBar([1:length(mean_spike2_noise)]/10,mean_spike2_noise,ste_spike2_noise,'g');
title('History-Dependent Change in Second Spike Shape')
ylabel('Membrane Voltage [mV]')
xlabel('Time [ms]')

figure;shadedErrorBar([1:length(mean_hyper_spike3)]/10,mean_hyper_spike3,ste_hyper_spike3);hold on;
shadedErrorBar([1:length(mean_de_spike3)]/10,mean_de_spike3,ste_de_spike3,'r');hold on;
shadedErrorBar([1:length(mean_spike3_noise)]/10,mean_spike3_noise,ste_spike3_noise,'g');
title('History-Dependent Change in Third Spike Shape')
ylabel('Membrane Voltage [mV]')
xlabel('Time [ms]')

figure;shadedErrorBar([1:length(mean_hyper_spikelast)]/10,mean_hyper_spikelast,ste_hyper_spikelast);hold on;
shadedErrorBar([1:length(mean_de_spikelast)]/10,mean_de_spikelast,ste_de_spikelast,'r');hold on;
shadedErrorBar([1:length(mean_spikelast_noise)]/10,mean_spikelast_noise,ste_spikelast_noise,'g');
title({'History-Dependent Change in Last Spike Shape';['Hyperpolarized (Black) and Depolarized (Red) Difference: p = ' num2str(risettest(2))];...
    ['Hyperpolarized with (Green) and without (Black) Noise Difference: p = ' num2str(risehypernoisettest(2))]})
ylabel('Membrane Voltage [mV]')
xlabel('Time [ms]')