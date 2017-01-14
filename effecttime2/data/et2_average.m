clear;clc;%close all

dates_all={'Nov_26_13' 'Dec_03_13' 'Dec_17_13' 'Dec_17_13' 'Dec_17_13' 'Dec_18_13'...
    'Mar_28_15'}; % 'Mar_24_15_A' didn't have the inline heater on, not using it
cellnum_all={'A' 'B' 'A' 'B' 'C' 'A'...
    'A'};

for k=1:numel(dates_all)
    eval(['load effecttime2_' dates_all{k} '_' cellnum_all{k} '_et2.mat;'])
    et_rates_all(k,:,:)=rate_all;
    sliding_rate_all_all(k,:,:)=sliding_rate_all';
    time_constants(k)=1/coeff(3);
    hpv_all(k)=hpv;
end

mean_et(:,:)=mean(et_rates_all);
std_et(:,:)=std(et_rates_all);
mean_sliding_rate_all(:,:)=mean(sliding_rate_all_all);
std_sliding_rate_all(:,:)=std(sliding_rate_all_all);
ste_sliding_rate_all(:,:)=std_sliding_rate_all./sqrt(numel(dates_all));
mean_time_constant=mean(time_constants);
std_time_constant=std(time_constants);
ste_time_constant=std_time_constant./sqrt(numel(dates_all));
mean_hpv_all=mean(hpv_all);
std_hpv_all=std(hpv_all);
ste_hpv_all=std_hpv_all./sqrt(numel(~isnan(hpv_all)));

x=[1;1;1;1]*[5];

slidesize=.3;
windowsize=3;
pulse_length=60;

figure;shadedErrorBar(slidesize:slidesize:(pulse_length-windowsize),mean_sliding_rate_all(:,1),ste_sliding_rate_all(:,1),'g');
hold on;shadedErrorBar(slidesize:slidesize:(pulse_length-windowsize),mean_sliding_rate_all(:,2),ste_sliding_rate_all(:,2),'r');
title('Firing Rate Over Time','FontSize',12)
xlabel('Time [sec]','FontSize',12)
ylabel('Firing Rate [Hz]','FontSize',12)

% figure;errorbar([slidesize:slidesize:(pulse_length-windowsize);slidesize:slidesize:(pulse_length-windowsize)]',...
%     mean_sliding_rate_all,ste_sliding_rate_all,'LineWidth',2);
% xlabel('Time [sec]')
% ylabel('Firing Rate [Hz]')