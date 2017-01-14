clear;clc;close all

tic

dates_all={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'...
    'May_31_13' 'May_31_13' 'Jun_24_13' 'Jun_24_13' 'Jul_03_13' 'Jul_03_13'...
    'Jul_29_13' 'Jul_29_13' 'Aug_05_13' 'Aug_16_13' 'Sep_05_13' 'Sep_16_13'...
    'Oct_08_13' 'Oct_08_13'}; %'Sep_10_13'
cellnum_all={'B' 'A' 'B' 'A' 'A' 'B'...
    'C' 'D' 'A' 'B' 'A' 'B'...
    'A' 'B' 'A' 'A' 'A' 'A'...
    'A' 'B'}; % 'A'
trials_all=[2 5;3 4;2 3;2 3;2 3;2 3;...
    2 3;2 3;2 3;2 3;2 3;2 3;...
    2 3;4 5;2 3;2 3;2 3;3 2;...
    3 2;3 2;]; % 2 3;

spikes_all=cell(1,numel(dates_all));

for k=1:numel(dates_all)
    eval(['load ' pwd '\spikes_analysis\fi_curves_' dates_all{k} '_' cellnum_all{k} '_spikes.mat;'])
    spike1_hyper_all(k,:)=spike1avg(1,:)';
    spike2_hyper_all(k,:)=spike2avg(1,:)';
    spike3_hyper_all(k,:)=spike3avg(1,:)';
    spikelast_hyper_all(k,:)=spikelastavg(1,:)';
    spike1_de_all(k,:)=spike1avg(2,:)';
    spike2_de_all(k,:)=spike2avg(2,:)';
    spike3_de_all(k,:)=spike3avg(2,:)';
    spikelast_de_all(k,:)=spikelastavg(2,:)';
end

mean_spike1_hyper=nanmean(spike1_hyper_all)*1e3;
mean_spike2_hyper=nanmean(spike2_hyper_all)*1e3;
mean_spike3_hyper=nanmean(spike3_hyper_all)*1e3;
mean_spikelast_hyper=nanmean(spikelast_hyper_all)*1e3;
mean_spike1_de=nanmean(spike1_de_all)*1e3;
mean_spike2_de=nanmean(spike2_de_all)*1e3;
mean_spike3_de=nanmean(spike3_de_all)*1e3;
mean_spikelast_de=nanmean(spikelast_de_all)*1e3;
ste_spike1_hyper=nanstd(spike1_hyper_all)/sqrt(sum(isfinite(spike1_hyper_all(:,1))))*1e3;
ste_spike2_hyper=nanstd(spike2_hyper_all)/sqrt(sum(isfinite(spike2_hyper_all(:,1))))*1e3;
ste_spike3_hyper=nanstd(spike3_hyper_all)/sqrt(sum(isfinite(spike3_hyper_all(:,1))))*1e3;
ste_spikelast_hyper=nanstd(spikelast_hyper_all)/sqrt(sum(isfinite(spikelast_hyper_all(:,1))))*1e3;
ste_spike1_de=nanstd(spike1_de_all)/sqrt(sum(isfinite(spike1_de_all(:,1))))*1e3;
ste_spike2_de=nanstd(spike2_de_all)/sqrt(sum(isfinite(spike2_de_all(:,1))))*1e3;
ste_spike3_de=nanstd(spike3_de_all)/sqrt(sum(isfinite(spike3_de_all(:,1))))*1e3;
ste_spikelast_de=nanstd(spikelast_de_all)/sqrt(sum(isfinite(spikelast_de_all(:,1))))*1e3;

% figure;errorbar([1:length(mean_spike1_hyper)]/10,mean_spike1_hyper,ste_spike1_hyper);hold on;
% errorbar([1:length(mean_spike1_de)]/10,mean_spike1_de,ste_spike1_de,'r');
% title('History-Dependent Change in First Spike Shape')
% ylabel('Membrane Voltage [mV]')
% xlabel('Time [ms]')
% 
% figure;errorbar([1:length(mean_spike2_hyper)]/10,mean_spike2_hyper,ste_spike2_hyper);hold on;
% errorbar([1:length(mean_spike2_de)]/10,mean_spike2_de,ste_spike2_de,'r');
% title('History-Dependent Change in Second Spike Shape')
% ylabel('Membrane Voltage [mV]')
% xlabel('Time [ms]')
% 
% figure;errorbar([1:length(mean_spike3_hyper)]/10,mean_spike3_hyper,ste_spike3_hyper);hold on;
% errorbar([1:length(mean_spike3_de)]/10,mean_spike3_de,ste_spike3_de,'r');
% title('History-Dependent Change in Third Spike Shape')
% ylabel('Membrane Voltage [mV]')
% xlabel('Time [ms]')

figure;shadedErrorBar([1:length(mean_spike1_hyper)]/10,mean_spike1_hyper,ste_spike1_hyper);hold on;
shadedErrorBar([1:length(mean_spike1_de)]/10,mean_spike1_de,ste_spike1_de,'r');
title('History-Dependent Change in First Spike Shape')
ylabel('Membrane Voltage [mV]')
xlabel('Time [ms]')

figure;shadedErrorBar([1:length(mean_spike2_hyper)]/10,mean_spike2_hyper,ste_spike2_hyper);hold on;
shadedErrorBar([1:length(mean_spike2_de)]/10,mean_spike2_de,ste_spike2_de,'r');
title('History-Dependent Change in Second Spike Shape')
ylabel('Membrane Voltage [mV]')
xlabel('Time [ms]')

figure;shadedErrorBar([1:length(mean_spike3_hyper)]/10,mean_spike3_hyper,ste_spike3_hyper);hold on;
shadedErrorBar([1:length(mean_spike3_de)]/10,mean_spike3_de,ste_spike3_de,'r');
title('History-Dependent Change in Third Spike Shape')
ylabel('Membrane Voltage [mV]')
xlabel('Time [ms]')

figure;shadedErrorBar([1:length(mean_spikelast_hyper)]/10,mean_spikelast_hyper,ste_spikelast_hyper);hold on;
shadedErrorBar([1:length(mean_spikelast_de)]/10,mean_spikelast_de,ste_spikelast_de,'r');
title('History-Dependent Change in Last Spike Shape')
ylabel('Membrane Voltage [mV]')
xlabel('Time [ms]')