clear;%close all%;clc

dates_all={'Mar_14_14' 'Mar_31_14' 'Apr_03_14' 'Apr_08_14' 'Mar_25_14'}; %Bad quality: 'Mar_25_14 (for inactivation time constant measurements only, keep for activation/inactivation curves' 'Apr_15_14' 'Apr_15_14' 'Apr_16_14'
cellnum_all={'A' 'A' 'A' 'A' 'A'}; %'A' 'A' 'B' 'A'
trial=[2 1 1 1 1]; %1 1 1 1

activation_voltages_all=-100:5:20;
max_current_activation_all=NaN(numel(dates_all),25);
max_current_inactivation_all=NaN(numel(dates_all),25);
activation_all=NaN(numel(dates_all),25);
inactivation_all=NaN(numel(dates_all),25);
expf_activation_all=NaN(numel(dates_all),25);
expf_inactivation_all=NaN(numel(dates_all),25);
% dexpf_inactivation_all_large=NaN(numel(dates_all),25);
% dexpf_inactivation_all_small=NaN(numel(dates_all),25);
largeorsmall=NaN(numel(dates_all),25);
cool=NaN(numel(dates_all),25);
min_snippet_activation_all=nan(numel(dates_all),25);
max_snippet_activation_all=nan(numel(dates_all),25);
min_snippet_inactivation_all=nan(numel(dates_all),25);
max_snippet_inactivation_all=nan(numel(dates_all),25);

for k=1:numel(dates_all)
    eval(['load activation_inactivation_' dates_all{k} '_' cellnum_all{k} num2str(trial(k)) '_activation_inactivation.mat;'])
    firstvoltage=find(activation_voltages_all==activation_voltages(1));
    max_current_activation_all(k,firstvoltage:firstvoltage+numel(activation_voltages)-1)=mean_max_current_activation;
    max_current_inactivation_all(k,firstvoltage:firstvoltage+numel(activation_voltages)-1)=mean_max_current_inactivation;
    max_activation_all(k,firstvoltage:firstvoltage+numel(activation_voltages)-1)=mean_max_activation;
    max_inactivation_all(k,firstvoltage:firstvoltage+numel(activation_voltages)-1)=mean_max_inactivation;
    min_snippet_activation_all(k,1:numel(min_snippet_activation))=min_snippet_activation;
    max_snippet_activation_all(k,1:numel(max_snippet_activation))=max_snippet_activation;
    min_snippet_inactivation_all(k,1:numel(min_snippet_inactivation))=min_snippet_inactivation;
    max_snippet_inactivation_all(k,1:numel(max_snippet_inactivation))=max_snippet_inactivation;
    activation_all(k,firstvoltage:firstvoltage+numel(activation_voltages)-1)=normalized_activation_temp;
    nlf_normalized_activation_all(k,:)=nlf_normalized_activation;
%     % manually find V1/2 activation
%     if find(activation_all(k,9:end)>0.5,1)~=1
%         gthalf_activation(k)=find(activation_all(k,9:end)>0.5,1);
%     else
%         gthalf_activation_temp=find(activation_all(k,9:end)>0.5,2);
%         gthalf_activation(k)=gthalf_activation_temp(end);
%     end
%     p_activation(k,:)=polyfit([activation_all(k,8+gthalf_activation(k)-1) activation_all(k,8+gthalf_activation(k))],...
%         [activation_voltages_all(8+gthalf_activation(k)-1) activation_voltages_all(8+gthalf_activation(k))],1);
%     vhalf_activation(k)=polyval(p_activation(k,:),0.5);
    
    inactivation_all(k,firstvoltage:firstvoltage+numel(activation_voltages)-1)=normalized_inactivation_temp;
    nlf_normalized_inactivation_all(k,:)=nlf_normalized_inactivation;
%     % manually find V1/2 inactivation
%     if find(inactivation_all(k,1:13)<0.5,1)~=1
%         lthalf_inactivation(k)=find(inactivation_all(k,1:13)<0.5,1);
%     else
%         lthalf_inactivation_temp=find(inactivation_all(k,1:13)<0.5,2);
%         lthalf_inactivation(k)=lthalf_inactivation_temp(end);
%     end
%     p_inactivation(k,:)=polyfit([inactivation_all(k,lthalf_inactivation(k)-1) activation_all(k,lthalf_inactivation(k))],...
%         [activation_voltages_all(lthalf_inactivation(k)-1) activation_voltages_all(lthalf_inactivation(k))],1);
%     vhalf_inactivation(k)=polyval(p_inactivation(k,:),0.5);
    
    expf_activation_all(k,1:numel(expf_activation(:,4)))=expf_activation(:,4)';
    expf_inactivation_all(k,1:numel(expf_inactivation(:,4)))=expf_inactivation(:,4)';
    expf_activation_all(k,logical([0 0 0 0 0 0 rsq_activation_sig<.8]))=NaN;
    expf_inactivation_all(k,logical([0 0 0 0 0 0 rsq_inactivation_sig<.8]))=NaN;
    
%     % manually find k for activation and inactivation sigmoids
%     sigslope_normalized_activation_all(k)=sigslope_normalized_activation;
%     sigslope_normalized_inactivation_all(k)=sigslope_normalized_inactivation;
%     rsq_normalized_activation_all(k)=rsq_normalized_activation_sig;
%     rsq_normalized_inactivation_all(k)=rsq_normalized_inactivation_sig;

%     for h=1:numel(dexpf_inactivation(:,5))
%         if abs(dexpf_inactivation(h,2))>abs(dexpf_inactivation(h,5))
%             dexpf_inactivation_all_large(k,h)=dexpf_inactivation(h,4);
%             dexpf_inactivation_all_small(k,h)=dexpf_inactivation(h,7);
%             cool(k,h)=dexpf_inactivation(h,2)/dexpf_inactivation(h,5);
%         else
%             dexpf_inactivation_all_large(k,h)=dexpf_inactivation(h,7);
%             dexpf_inactivation_all_small(k,h)=dexpf_inactivation(h,4);
%             cool(k,h)=dexpf_inactivation(h,5)/dexpf_inactivation(h,2);
%         end
%     end
end

% find average v1/2s
% (range for activation is -33.0976 mV to -16.8473 mV)
% (range for inactivation is -66.8761 mV to -54.7600 mV)
mean_vhalf_activation=mean(nlf_normalized_activation_all(:,3));
mean_vhalf_inactivation=mean(nlf_normalized_inactivation_all(:,3));
std_vhalf_activation=std(nlf_normalized_activation_all(:,3));
std_vhalf_inactivation=std(nlf_normalized_inactivation_all(:,3));
ste_vhalf_activation=std_vhalf_activation/numel(dates_all);
ste_vhalf_inactivation=std_vhalf_inactivation/numel(dates_all);

% average and standard error of the slope of activation and inactivation
% curves
mean_sigslope_normalized_activation_all=mean(nlf_normalized_activation_all(:,4));
std_sigslope_normalized_activation_all=std(nlf_normalized_activation_all(:,4));
ste_sigslope_normalized_activation_all=std_sigslope_normalized_activation_all/sqrt(numel(dates_all));
mean_sigslope_normalized_inactivation_all=mean(nlf_normalized_inactivation_all(:,4));
std_sigslope_normalized_inactivation_all=std(nlf_normalized_inactivation_all(:,4));
ste_sigslope_normalized_inactivation_all=std_sigslope_normalized_inactivation_all/sqrt(numel(dates_all));

EK=-93.0802; % -82.2833;
activation_voltages_all_all=repmat(activation_voltages_all,numel(dates_all),1);
max_conductance_activation_all=max_current_activation_all*1e12./(activation_voltages_all_all-EK);

% Getting rid of bad parts of trials
% expf_activation_all(8,17:19)=NaN; %(this is gotten rid of by the rsq)
% % dexpf_inactivation_all_large(8,17:19)=NaN;
% % dexpf_inactivation_all_small(8,17:19)=NaN;
% expf_activation_all(7,17:19)=NaN; %(this is gotten rid of by the rsq)
% % dexpf_inactivation_all_small(7,17:19)=NaN;
% % dexpf_inactivation_all_large(7,17:19)=NaN;
expf_activation_all(expf_activation_all<0)=NaN;
expf_inactivation_all(expf_inactivation_all<0)=NaN;

mean_max_current_activation=nanmean(max_current_activation_all*1e12);
std_max_current_activation=nanstd(max_current_activation_all*1e12);
mean_max_current_inactivation=nanmean(max_current_inactivation_all*1e12);
std_max_current_inactivation=nanstd(max_current_inactivation_all*1e12);
mean_max_conductance_activation=nanmean(max_conductance_activation_all);
std_max_conductance_activation=nanstd(max_conductance_activation_all);
mean_activation_temp=nanmean(activation_all);
std_activation=nanstd(activation_all);
mean_inactivation_temp=nanmean(inactivation_all);
std_inactivation=nanstd(inactivation_all);
mean_expf_activation=nanmean(expf_activation_all);
std_expf_activation=nanstd(expf_activation_all);
mean_expf_inactivation=nanmean(expf_inactivation_all);
std_expf_inactivation=nanstd(expf_inactivation_all);
% mean_dexpf_inactivation_large=nanmean(dexpf_inactivation_all_large);
% std_dexpf_inactivation_large=nanstd(dexpf_inactivation_all_large);
% mean_dexpf_inactivation_small=nanmean(dexpf_inactivation_all_small);
% std_dexpf_inactivation_small=nanstd(dexpf_inactivation_all_small);
mean_cool=nanmean(cool);
std_cool=nanstd(cool);

ste_max_current_activation=std_max_current_activation./sqrt(sum(~isnan(activation_all)));
ste_max_current_inactivation=std_max_current_inactivation./sqrt(sum(~isnan(inactivation_all)));
ste_max_conductance_activation=std_max_conductance_activation./sqrt(sum(~isnan(activation_all)));
ste_activation_temp=std_activation./sqrt(sum(~isnan(activation_all)));
ste_inactivation_temp=std_inactivation./sqrt(sum(~isnan(inactivation_all)));
ste_expf_activation=std_expf_activation./sqrt(sum(~isnan(std_expf_activation)));
ste_expf_inactivation=std_expf_inactivation./sqrt(sum(~isnan(std_expf_inactivation)));
% ste_dexpf_inactivation_large=std_dexpf_inactivation_large./sqrt(sum(~isnan(std_dexpf_inactivation_large)));
% ste_dexpf_inactivation_small=std_dexpf_inactivation_small./sqrt(sum(~isnan(std_dexpf_inactivation_small)));
ste_cool=std_cool./sqrt(sum(~isnan(std_cool)));

mean_mean_expf_activation=mean(mean_expf_activation(15:end));
% mean_mean_dexpf_inactivation_large=mean(mean_dexpf_inactivation_large(13:end));
% mean_mean_dexpf_inactivation_small=mean(mean_dexpf_inactivation_small(13:end));

% mean time constants for activation and inactivation, data pooled
mean_activation_time=mean(expf_activation_all(expf_activation_all>0));
std_activation_time=std(expf_activation_all(expf_activation_all>0));
ste_activation_time=std_activation_time/sqrt(numel(expf_activation_all(expf_activation_all>0)));
mean_inactivation_time=mean(expf_inactivation_all(expf_inactivation_all>0));
std_inactivation_time=std(expf_inactivation_all(expf_inactivation_all>0));
ste_inactivation_time=std_inactivation_time/sqrt(numel(expf_inactivation_all(expf_inactivation_all>0)));

% cropping it so it only includes the activation and inactivation voltages
voltages_activation=activation_voltages_all(9:25);
voltages_inactivation=activation_voltages_all(1:13);
mean_activation=mean_activation_temp(9:25);
mean_inactivation=mean_inactivation_temp(1:13);
ste_activation=ste_activation_temp(9:25);
ste_inactivation=ste_inactivation_temp(1:13);

% Fit a sigmoid to the curve and find the maximum slope of the sigmoid
nlf_activation=nlinfit(voltages_activation(1:13),mean_activation(1:13),'sigFun',[1.1456 -1.1261 24.6122 8.6676]);
nlf_inactivation=nlinfit(voltages_inactivation,mean_inactivation,'sigFun',[0 1 -70 -30]);

sigfit_activation=sigFun(nlf_activation,-100:5:0); % voltages_activation(1:13)
sigfit_inactivation=sigFun(nlf_inactivation,-100:5:0); % voltages_inactivation

sigslope_activation=max(diff(sigfit_activation));
sigslope_inactivation=max(diff(sigfit_inactivation));

% Calculate the R^2 value for sigmoidal fit
resid_activation_sig=mean_activation(1:13)-sigfit_activation(9:end);
resid_inactivation_sig=mean_inactivation-sigfit_inactivation(1:13);

SSresid_activation_sig=sum(resid_activation_sig.^2);
SSresid_inactivation_sig=sum(resid_inactivation_sig.^2);

SStotal_activation_sig=(length(mean_activation(1:13))-1)*var(mean_activation(1:13));
SStotal_inactivation_sig=(length(mean_inactivation)-1)*var(mean_inactivation);

rsq_activation_sig=1-SSresid_activation_sig/SStotal_activation_sig;
rsq_inactivation_sig=1-SSresid_inactivation_sig/SStotal_inactivation_sig;

%min and max currents during voltage clamp
% min_current_v_clamp=min(min([max_current_activation_all(:,9:9+12) max_current_inactivation_all(:,1:13)]'*1e12));
min_current_v_clamp=min(min(([min_snippet_activation_all(:,9:9+12) min_snippet_inactivation_all(:,1:13)])));
max_current_v_clamp=max(max(([max_snippet_activation_all(:,9:9+12) max_snippet_inactivation_all(:,1:13)])));

% PLOT THE ACTIVATION AND INACTIVATION CURVES
figure(2);shadedErrorBar(voltages_activation(1:13),mean_activation(1:13),ste_activation(1:13),'b')
title('Activation Curve')
xlabel('membrane voltage [mV]')
ylabel('normalized activation')
figure(2);hold on;shadedErrorBar(voltages_inactivation,mean_inactivation,ste_inactivation,'r')
title('Inactivation Curve')
xlabel('membrane voltage [mV]')
ylabel('normalized activation')

figure(2);hold on;plot(-100:5:0,sigfit_activation,'c','LineWidth',2) %(voltages_activation(1:13),sigfit_activation(1:13),'c','LineWidth',2)
figure(2);hold on;plot(-100:5:0,sigfit_inactivation,'m','LineWidth',2) %(voltages_inactivation,sigfit_inactivation,'m','LineWidth',2)
% figure(3);errorbar(activation_voltages,mean_max_current_activation,ste_max_current_activation)
% figure(3);hold on;errorbar(activation_voltages,mean_max_current_inactivation,ste_max_current_inactivation,'r')
% xlabel('Voltage (mV)')
% ylabel('Current (pA)')

% figure(5);shadedErrorBar(activation_voltages_all,mean_expf_activation,ste_expf_activation,'b')
figure(6);shadedErrorBar(activation_voltages_all,mean_expf_inactivation,ste_expf_inactivation,'b')
% figure(6);errorbar(activation_voltages_all,mean_dexpf_inactivation_large,ste_dexpf_inactivation_large,'b','LineWidth',2)
% hold on;figure(6);errorbar(activation_voltages_all,mean_dexpf_inactivation_small,ste_dexpf_inactivation_small,'r','LineWidth',2)

%find inactivation time constant function
load C:\Users\eric\Dropbox\Documents\School\rtxi\Modules\characterize_current\recovery_time\data\inactivation_time_constants

inactivation_time_constants=[mean_time_constants mean_expf_inactivation(11:2:end)];
ste_inactivation_time_constants=[ste_time_constants ste_expf_inactivation(11:2:end)];

inactivation_fit=nlinfit(-80:10:20,inactivation_time_constants,'inactivation_time_Fun',[5 130 -10 10]);

fit_inactivation=inactivation_time_Fun(inactivation_fit,-80:10:20);
% slope_inactivation=max(diff(fit_inactivation));

% Calculate the R^2 value for sigmoidal fit
resid_inactivation_time=inactivation_time_constants-fit_inactivation;
SSresid_inactivation_time=sum(resid_inactivation_time.^2);
SStotal_inactivation_time=(length(inactivation_time_constants)-1)*var(inactivation_time_constants);
rsq_inactivation_time=1-SSresid_inactivation_time/SStotal_inactivation_time;

figure(7);shadedErrorBar(-80:10:20,inactivation_time_constants,ste_inactivation_time_constants)
hold on;plot(-80:0.1:20,inactivation_time_Fun(inactivation_fit,-80:0.1:20),'r','LineWidth',2)

% make non-normalized activation and inactivation curves of conductances
mean_max_activation_all=nanmean(max_activation_all*1e9);
std_max_activation_all=nanstd(max_activation_all*1e9);
ste_max_activation_all=std_max_activation_all./sqrt(sum(~isnan(max_activation_all)));
mean_max_inactivation_all=nanmean(max_inactivation_all*1e9);
std_max_inactivation_all=nanstd(max_inactivation_all*1e9);
ste_max_inactivation_all=std_max_inactivation_all./sqrt(sum(~isnan(max_inactivation_all)));

figure(8);shadedErrorBar(voltages_activation(1:13),mean_max_activation_all(9:21),ste_max_activation_all(9:21),'b')
title('Activation Curve')
xlabel('membrane voltage [mV]')
ylabel('activation conductance [nS]')
figure(8);hold on;shadedErrorBar(voltages_inactivation,mean_max_inactivation_all(1:13),ste_max_inactivation_all(1:13),'r')
title('Inactivation Curve')
xlabel('membrane voltage [mV]')
ylabel('inactivation conductance [nS]')

% find where the activation and inactivation curves intersect
for k=1:numel(max_activation_all(:,1))
    [windowcurrentv(k),windowcurrentg(k)]=intersections(voltages_activation(1:13),max_activation_all(k,9:21)*1e9,...
        voltages_inactivation,max_inactivation_all(k,1:13)*1e9);
end
meanwindowcurrentv=mean(windowcurrentv);
stdwindowcurrentv=std(windowcurrentv);
stewindowcurrentv=stdwindowcurrentv/sqrt(numel(windowcurrentv));
meanwindowcurrentg=mean(windowcurrentg);
stdwindowcurrentg=std(windowcurrentg);
stewindowcurrentg=stdwindowcurrentg/sqrt(numel(windowcurrentg));

nlf_conductance_activation=nlinfit(voltages_activation(1:13),mean_max_activation_all(9:21),'sigFun',[1 1 1 1]);
nlf_conductance_inactivation=nlinfit(voltages_inactivation,mean_max_inactivation_all(1:13),'sigFun',[10 10 -10 10]);
sigfit_conductance_activation=sigFun(nlf_conductance_activation,-100:5:0); %voltages_activation(1:13)
sigfit_conductance_inactivation=sigFun(nlf_conductance_inactivation,-100:5:0); %voltages_inactivation
figure(8);hold on;plot(-100:5:0,sigfit_conductance_activation,'c','LineWidth',2) %(voltages_activation(1:13),sigfit_conductance_activation(1:13),'c','LineWidth',2)
figure(8);hold on;plot(-100:5:0,sigfit_conductance_inactivation,'m','LineWidth',2) % (voltages_inactivation,sigfit_conductance_inactivation,'m','LineWidth',2)