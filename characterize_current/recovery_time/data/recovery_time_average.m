clear;clc;close all
              %-80 mV                   -70 mV                    -60 mV
dates_all   ={'May_14_14' 'May_14_14'   'May_14_14' 'May_14_14'   'May_14_14' 'May_14_14'};
cellnum_all ={'B'         'C'           'B'         'C'           'B'         'C'};
trial       =[3           1             4           2             2           3];

activation_all=NaN(numel(dates_all),13);

for k=1:numel(dates_all)
    eval(['load recovery_time_' dates_all{k} '_' cellnum_all{k} num2str(trial(k)) '_recovery_time.mat;'])
    this_recovery_all(k,:)=this_recovery;
    max_recovery_pulse_all(k,:)=max_recovery_pulse*1e15;
    normalized_recovery_time_all(k,:)=normalized_recovery_pulse;
    recovery_fit_all(k,:)=recovery_fit;
end

recovery_fit_all(6,:)=NaN;

mean_max_recovery_pulse80=nanmean(max_recovery_pulse_all(1:numel(dates_all)/3,:));
std_max_recovery_pulse80=nanstd(max_recovery_pulse_all(1:numel(dates_all)/3,:));
ste_max_recovery_pulse80=std_max_recovery_pulse80./sqrt(numel(dates_all)/3);
mean_max_recovery_pulse70=nanmean(max_recovery_pulse_all(numel(dates_all)/3+1:2*numel(dates_all)/3,:));
std_max_recovery_pulse70=nanstd(max_recovery_pulse_all(numel(dates_all)/3+1:2*numel(dates_all)/3,:));
ste_max_recovery_pulse70=std_max_recovery_pulse70./sqrt(numel(dates_all)/3);
mean_max_recovery_pulse60=nanmean(max_recovery_pulse_all(2*numel(dates_all)/3+1:end,:));
std_max_recovery_pulse60=nanstd(max_recovery_pulse_all(2*numel(dates_all)/3+1:end,:));
ste_max_recovery_pulse60=std_max_recovery_pulse60./sqrt(numel(dates_all)/3);
mean_normalized_recovery_time80=nanmean(normalized_recovery_time_all(1:numel(dates_all)/3,:));
std_normalized_recovery_time80=nanstd(normalized_recovery_time_all(1:numel(dates_all)/3,:));
ste_normalized_recovery_time80=std_normalized_recovery_time80./sqrt(numel(dates_all)/3);
mean_normalized_recovery_time70=nanmean(normalized_recovery_time_all(numel(dates_all)/3+1:2*numel(dates_all)/3,:));
std_normalized_recovery_time70=nanstd(normalized_recovery_time_all(numel(dates_all)/3+1:2*numel(dates_all)/3,:));
ste_normalized_recovery_time70=std_normalized_recovery_time70./sqrt(numel(dates_all)/3);
mean_normalized_recovery_time60=nanmean(normalized_recovery_time_all(2*numel(dates_all)/3+1:end,:));
std_normalized_recovery_time60=nanstd(normalized_recovery_time_all(2*numel(dates_all)/3+1:end,:));
ste_normalized_recovery_time60=std_normalized_recovery_time60./sqrt(numel(dates_all)/3);
mean_time_constant80=nanmean(recovery_fit_all(1:numel(dates_all)/3,4));
std_time_constant80=nanstd(recovery_fit_all(1:numel(dates_all)/3,4));
ste_time_constant80=std_time_constant80./sqrt(numel(dates_all)/3);
mean_time_constant70=nanmean(recovery_fit_all(numel(dates_all)/3+1:2*numel(dates_all)/3,4));
std_time_constant70=nanstd(recovery_fit_all(numel(dates_all)/3+1:2*numel(dates_all)/3,4));
ste_time_constant70=std_time_constant70./sqrt(numel(dates_all)/3);
mean_time_constant60=nanmean(recovery_fit_all(2*numel(dates_all)/3+1:end,4));
std_time_constant60=nanstd(recovery_fit_all(2*numel(dates_all)/3+1:end,4));
ste_time_constant60=std_time_constant60./sqrt(numel(dates_all)/3);

% % Fit a sigmoid to the curve and find the maximum slope of the sigmoid
% nlf_activation=nlinfit(voltages_activation,mean_activation,'sigFun',[1.1456 -1.1261 24.6122 8.6676]);
% 
% sigfit_activation=sigFun(nlf_activation,voltages_activation);
% 
% sigslope_activation=max(diff(sigfit_activation));

% % Calculate the R^2 value for sigmoidal fit
% resid_activation_sig=mean_activation-sigfit_activation;
% 
% SSresid_activation_sig=sum(resid_activation_sig.^2);
% 
% SStotal_activation_sig=(length(mean_activation)-1)*var(mean_activation);
% 
% rsq_activation_sig=1-SSresid_activation_sig/SStotal_activation_sig;

figure(1);errorbar(this_recovery_all(1:3,:)',...
    [mean_normalized_recovery_time80;mean_normalized_recovery_time70;mean_normalized_recovery_time60]',...
    [ste_normalized_recovery_time80;ste_normalized_recovery_time70;ste_normalized_recovery_time60]','LineWidth',2)
title('Effect of Hyperpolarization Time and Voltage on Normalized Conductance')
legend('-80 mV','-70 mV','-60 mV')
xlabel('Time (sec)')
ylabel('Normalized Conductance')

figure(2);errorbar(this_recovery_all(1:3,:)',...
    [mean_max_recovery_pulse80;mean_max_recovery_pulse70;mean_max_recovery_pulse60]',...
    [ste_max_recovery_pulse80;ste_max_recovery_pulse70;ste_max_recovery_pulse60]','LineWidth',2)
title('Effect of Hyperpolarization Time and Voltage on Conductance')
legend('-80 mV','-70 mV','-60 mV')
xlabel('Time (sec)')
ylabel('Conductance (pS)')

% figure(1);hold on;plot(voltages_activation,sigfit_activation,'c','LineWidth',2)

mean_time_constants=[mean_time_constant80 mean_time_constant70 mean_time_constant60];
ste_time_constants=[ste_time_constant80 ste_time_constant70 ste_time_constant60];
figure(3);errorbar([-80 -70 -60],mean_time_constants,ste_time_constants,'LineWidth',2)
title('Effect of Hyperpolarization Time and Voltage on Conductance')
legend('-80 mV','-70 mV','-60 mV')
xlabel('Voltage (sec)')
ylabel('Recovery Time Constant (sec)')

save('inactivation_time_constants','mean_time_constants','ste_time_constants')