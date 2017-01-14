clear;clc;close all;
%% Hyperpolarized (5 sec pulse, 1 sec pause)
% For Depolarized

setthreshold=0;

dates_all_hypervde={'Mar_24_15' 'Mar_27_15' 'Mar_28_15' 'Mar_28_15' 'Mar_30_15' 'Mar_30_15'...
    'Apr_10_15' 'Apr_10_15' 'May_05_15' 'May_05_15' 'May_05_15'};
cellnum_all_hypervde={'C' 'B' 'B' 'C' 'A' 'B'...
    'A' 'C' 'A' 'B' 'C'};
trials_all_hypervde=[3 4 2 3 1 2 ...
    5 4 1 1 3]';

% for k=1:numel(dates_all_hypervde)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_hypervde{k} '_' cellnum_all_hypervde{k} num2str(trials_all_hypervde(k)) '_fV.mat;'])
%     #peakrate_all_hypervde(k,:)=peakrate;
%     #nofailrate_all_hypervde(k,:)=nofailrate;
%     gains_all_hypervde(k,1)=pf_all{1}.beta(2);
% %     gains_all_hypervde(k,2)=pf_all{2}.beta(2);
%     rsq_all_hypervde(k,1)=pf_all{1}.rsquare;
% %     rsq_all_hypervde(k,2)=pf_all{2}.rsquare;
%     rate_all_hypervde(k,:)=rate_all{1};
%     imp_all_hypervde(k,:)=imp;
%     #holdingvoltage_all_hypervde(k,:)=mean_holdingvoltage;
% %     hold on;plot([1 2],gains_all_hypervde(k,:),'or')
% end
% 
% gains_all_hypervde(isnan(rsq_all_hypervde))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_hypervde=nanmean(peakrate_all_hypervde);
% std_peakrate_hypervde=nanstd(peakrate_all_hypervde);
% mean_nofailrate_hypervde=nanmean(nofailrate_all_hypervde);
% std_nofailrate_hypervde=nanstd(nofailrate_all_hypervde);
% mean_gains_hypervde=nanmean(gains_all_hypervde);
% std_gains_hypervde=nanstd(gains_all_hypervde);
% ste_gains_hypervde=std_gains_hypervde/sqrt(sum(~isnan(gains_all_hypervde)));
% mean_imp_hypervde=nanmean(imp_all_hypervde);
% std_imp_hypervde=nanstd(imp_all_hypervde);
% mean_holdingvoltage_all_hypervde=nanmean(holdingvoltage_all_hypervde);
% std_holdingvoltage_all_hypervde=nanstd(holdingvoltage_all_hypervde);
% 
sub_currents_hyper_all=NaN(numel(dates_all_hypervde),21);
sub_currents_de_all=NaN(numel(dates_all_hypervde),21);
avg_sub_voltage_hyper=NaN(numel(dates_all_hypervde),21);
avg_sub_voltage_de=NaN(numel(dates_all_hypervde),21);
sup_currents_hyper_all=NaN(numel(dates_all_hypervde),21);
sup_currents_de_all=NaN(numel(dates_all_hypervde),21);
avg_sup_voltage_hyper=NaN(numel(dates_all_hypervde),21);
avg_sup_voltage_de=NaN(numel(dates_all_hypervde),21);
% smooth_sub_resistance_hyper=NaN(numel(dates_all_hypervde),21);
% smooth_sub_resistance_de=NaN(numel(dates_all_hypervde),21);
smooth_voltages_hyper=NaN(numel(dates_all_hypervde),21);
smooth_voltages_de=NaN(numel(dates_all_hypervde),21);
bin_size=10; %in mV
bins=-90:bin_size:-30; %in mV
binned_resistances_hyper=NaN(numel(dates_all_hypervde),numel(bins));
binned_resistances_de=NaN(numel(dates_all_hypervde),numel(bins));

for k=1:numel(dates_all_hypervde)
    eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_hypervde{k} '_' cellnum_all_hypervde{k} num2str(trials_all_hypervde(k)) '_fV.mat;'])
    gains_all(k,1)=pf_all{1}.beta(2);
    rsq_all(k,1)=pf_all{1}.rsquare;
    threshold_all(k,1)=threshold;
    avg_voltage_hyper_all(k,:)=avg_voltage{1};
    pf_supra_iv_hypervde(k)=pf_supra_iv{1}.beta(2);
    currents_hyper_all(k,:)=currents{1};
    rate_hyper_all(k,:)=rate_all{1};
    if sum(rate_hyper_all(k,:)>setthreshold)
        hyper_threshold(k)=find(rate_hyper_all(k,:)>setthreshold,1);
        sub_currents_hyper_all(k,1:hyper_threshold(k)-1)=currents_hyper_all(k,1:hyper_threshold(k)-1);
        avg_sub_voltage_hyper(k,1:hyper_threshold(k)-1)=avg_voltage_hyper_all(k,1:hyper_threshold(k)-1);
        sup_currents_hyper_all(k,hyper_threshold(k):end)=currents_hyper_all(k,hyper_threshold(k):end);
        avg_sup_voltage_hyper(k,hyper_threshold(k):end)=avg_voltage_hyper_all(k,hyper_threshold(k):end);
    else
        hyper_threshold(k)=NaN;
        sub_currents_hyper_all(k,:)=currents_hyper_all(k,:);
        avg_sub_voltage_hyper(k,:)=avg_voltage_hyper_all(k,:);
    end
    for h=1:numel(avg_sub_voltage_hyper(k,:))-3 % for measuring the resistance using running linear fits
        smooth_voltages_hyper(k,h)=mean(avg_sub_voltage_hyper(k,h:h+3));
        resistance_hyper_fit=polyfit(currents_hyper_all(k,h:h+3),avg_sub_voltage_hyper(k,h:h+3),1);
        smooth_sub_resistance_hyper(k,h)=resistance_hyper_fit(1);
    end
%     for h=1:numel(avg_sub_voltage_hyper(k,:))-1 % for measuring the resistance using the difference function instead of running linear fits
%         smooth_voltages_hyper(k,h)=mean(avg_sub_voltage_hyper(k,h:h+1));
%     end
%     smooth_sub_resistance_hyper(k,:)=diff(avg_sub_voltage_hyper(k,:))./diff(currents_hyper_all(k,:));
    for p=1:numel(bins)-1
        binned_resistances_hyper(k,p)=mean(smooth_sub_resistance_hyper(k,smooth_voltages_hyper(k,:)<bins(p+1) & bins(p)<smooth_voltages_hyper(k,:)));
    end
    
    % take average of last resistance before spiking
    lastsub_resistance_hyper(k)=mean(binned_resistances_hyper(k,find(~isnan(binned_resistances_hyper(k,:)),1,'last')))*1e3;
    lastsub_conductance_hyper(k)=(1/(lastsub_resistance_hyper(k)*1e6))*1e9;
end


% Depolarized (5 sec pulse, 1 sec pause)
% For Hyperpolarized

% Good quality data only
dates_all_devhyper={'Mar_24_15' 'Mar_27_15' 'Mar_28_15' 'Mar_28_15' 'Mar_30_15' 'Mar_30_15'...
    'Apr_10_15' 'Apr_10_15' 'May_05_15' 'May_05_15' 'May_05_15'};
cellnum_all_devhyper={'C' 'B' 'B' 'C' 'A' 'B'...
    'A' 'C' 'A' 'B' 'C'};
trials_all_devhyper=[4 5 3 4 2 3 ...
    6 5 2 2 4]';

for k=1:numel(dates_all_devhyper)
    eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_devhyper{k} '_' cellnum_all_devhyper{k} num2str(trials_all_devhyper(k)) '_fV.mat;'])
    gains_all(k,2)=pf_all{1}.beta(2);
    rsq_all(k,2)=pf_all{1}.rsquare;
    threshold_all(k,2)=threshold;
    avg_voltage_de_all(k,:)=avg_voltage{1};
    pf_supra_iv_devhyper(k)=pf_supra_iv{1}.beta(2);
    currents_de_all(k,:)=currents{1};
    rate_de_all(k,:)=rate_all{1};
    if sum(rate_de_all(k,:)>setthreshold)
        de_threshold(k)=find(rate_de_all(k,:)>setthreshold,1);
        sub_currents_de_all(k,1:de_threshold(k)-1)=currents_de_all(k,1:de_threshold(k)-1);
        avg_sub_voltage_de(k,1:de_threshold(k)-1)=avg_voltage_de_all(k,1:de_threshold(k)-1);
        sup_currents_de_all(k,de_threshold(k):end)=currents_de_all(k,de_threshold(k):end);
        avg_sup_voltage_de(k,de_threshold(k):end)=avg_voltage_de_all(k,de_threshold(k):end);
    else
        de_threshold(k)=NaN;
        sub_currents_de_all(k,:)=currents_de_all(k,:);
        avg_sub_voltage_de(k,:)=avg_voltage_de_all(k,:);
    end
    for h=1:numel(avg_sub_voltage_hyper(k,:))-3 % for measuring the resistance using running linear fits
        smooth_voltages_de(k,h)=mean(avg_sub_voltage_de(k,h:h+3));
        resistance_de_fit=polyfit(currents_de_all(k,h:h+3),avg_sub_voltage_de(k,h:h+3),1);
        smooth_sub_resistance_de(k,h)=resistance_de_fit(1);
    end
%     for h=1:numel(avg_sub_voltage_hyper(k,:))-1 % for measuring the resistance using the difference function instead of running linear fits
%         smooth_voltages_de(k,h)=mean(avg_sub_voltage_de(k,h:h+1));
%     end
%     smooth_sub_resistance_de(k,:)=diff(avg_sub_voltage_de(k,:))./diff(currents_de_all(k,:));
%     for h=1:numel(avg_sub_voltage_hyper(k,:))-3 % for when you want the running linear fits for resistances for sub and suprathreshold together
%         smooth_voltages_de_allfreq(k,h)=mean(avg_voltage_de_all(k,h:h+3));
%         resistance_de_fit_allfreq=polyfit(currents_de_all(k,h:h+3),avg_voltage_de_all(k,h:h+3),1);
%         smooth_resistance_de(k,h)=resistance_de_fit_allfreq(1);
%     end
    for p=1:numel(bins)-1
        binned_resistances_de(k,p)=mean(smooth_sub_resistance_de(k,smooth_voltages_de(k,:)<bins(p+1) & bins(p)<smooth_voltages_de(k,:)));
%         binned_resistances_de_allfreq(k,p)=mean(smooth_resistance_de(k,smooth_voltages_de_allfreq(k,:)<bins(p+1) & bins(p)<smooth_voltages_de_allfreq(k,:)));
    end
    
    % take average of last resistance before spiking
%     lastsub_resistance_de(k)=mean(binned_resistances_de(k,find(~isnan(binned_resistances_de(k,:)),1,'last')))*1e3; % use when you want to find the last subthreshold resistance for depolarized separately from hyperpolarized
%     lastsub_resistance_de(k)=mean(binned_resistances_de_allfreq(k,find(~isnan(binned_resistances_hyper(k,:)),1,'last')))*1e3; % all frequencies for the depolarized resistances
    if ~isnan(binned_resistances_de(k,find(~isnan(binned_resistances_hyper(k,:)),1,'last')))
        lastsub_resistance_de(k)=binned_resistances_de(k,find(~isnan(binned_resistances_hyper(k,:)),1,'last'))*1e3;
    else
        lastsub_resistance_de(k)=NaN;
    end
    lastsub_conductance_de(k)=(1/(lastsub_resistance_de(k)*1e6))*1e9;
end

mean_binned_resistances_hyper=nanmean(binned_resistances_hyper);
std_binned_resistances_hyper=nanstd(binned_resistances_hyper);
ste_binned_resistances_hyper=std_binned_resistances_hyper./sqrt(sum(isfinite(binned_resistances_hyper)));
mean_binned_resistances_de=nanmean(binned_resistances_de);
std_binned_resistances_de=nanstd(binned_resistances_de);
ste_binned_resistances_de=std_binned_resistances_de./sqrt(sum(isfinite(binned_resistances_de)));

figure(1);errorbar([bins+bin_size/2;bins+bin_size/2]',[mean_binned_resistances_hyper;mean_binned_resistances_de]'*1e3,[ste_binned_resistances_hyper;ste_binned_resistances_de]'*1e3)

%find average and ste of the last subthreshold resistances of each cell
mean_lastsub_resistance_hyper=nanmean(lastsub_resistance_hyper);
std_lastsub_resistance_hyper=nanstd(lastsub_resistance_hyper);
ste_lastsub_resistance_hyper=std_lastsub_resistance_hyper./sqrt(sum(isfinite(lastsub_resistance_hyper)));
mean_lastsub_resistance_de=nanmean(lastsub_resistance_de);
std_lastsub_resistance_de=nanstd(lastsub_resistance_de);
ste_lastsub_resistance_de=std_lastsub_resistance_de./sqrt(sum(isfinite(lastsub_resistance_de)));

figure(2);errorbar(1:2,[mean_lastsub_resistance_hyper mean_lastsub_resistance_de],[ste_lastsub_resistance_hyper ste_lastsub_resistance_de])

% figure out the average difference in the last subthreshold conductance
%1/(mean_lastsub_resistance_de*1e6);ans+(3e-9);1/ans;ans/1e6;
diff_conductance=(lastsub_conductance_hyper-lastsub_conductance_de); % measures the conductance difference between hyperpolarized and depolarized
% diff_conductance=(lastsub_conductance_hyper./lastsub_conductance_de); % measures the conductance ratio between hyperpolarized and depolarized
mean_diff_conductance=nanmean(diff_conductance);
std_diff_conductance=nanstd(diff_conductance);
ste_diff_conductance=std_diff_conductance./sqrt(sum(isfinite(diff_conductance)));

figure(3);errorbar(1,mean_diff_conductance,ste_diff_conductance)
hold on;bar(1,mean_diff_conductance,.5,'m')
ylabel('conductance difference [nS]')
axis([0.5 1.5 0 1])
set(gca, 'XTick', []);
axis 'auto y'

% f-V curve gains
mean_gains=mean(gains_all);
std_gains=std(gains_all);
ste_gains=std_gains./sqrt(sum(isfinite(gains_all)));
mean_threshold=mean(threshold_all);
std_threshold=std(threshold_all);
ste_threshold=std_threshold./sqrt(sum(isfinite(threshold_all)));

[gainsttest_hyper_de(1),gainsttest_hyper_de(2)]=ttest(gains_all(:,1),gains_all(:,2));

figure(4);errorbar(1:2,mean_gains,ste_gains,'.m','LineWidth',2);
hold on;bar(1:2,mean_gains,.5,'m')
title('History-Dependent Change in Gains')
ylabel('Gains [Hz/pA]')
xlabel('Hyperpolarized    Depolarized')
axis([0.5 2.5 0 .6])
set(gca, 'XTick', []);
axis 'auto y'

diff_voltage_all=avg_voltage_hyper_all-avg_voltage_de_all;

mean_avg_voltage_hyper=mean(avg_voltage_hyper_all);
std_avg_voltage_hyper=std(avg_voltage_hyper_all);
ste_avg_voltage_hyper=std_avg_voltage_hyper/sqrt(numel(dates_all_hypervde));
mean_avg_voltage_de=mean(avg_voltage_de_all);
std_avg_voltage_de=std(avg_voltage_de_all);
ste_avg_voltage_de=std_avg_voltage_de/sqrt(numel(dates_all_hypervde));
mean_diff_voltage=mean(diff_voltage_all);
std_diff_voltage=std(diff_voltage_all);
ste_diff_voltage=std_diff_voltage/sqrt(numel(dates_all_hypervde));

mean_avg_rate_hyper=mean(rate_hyper_all);
std_avg_rate_hyper=std(rate_hyper_all);
ste_avg_rate_hyper=std_avg_rate_hyper/sqrt(numel(dates_all_hypervde));
mean_avg_rate_de=mean(rate_de_all);
std_avg_rate_de=std(rate_de_all);
ste_avg_rate_de=std_avg_rate_de/sqrt(numel(dates_all_hypervde));

figure(5);[awesomex,awesomey]=errorbarxy(0,0,mean_avg_voltage_hyper,mean_avg_rate_hyper,ste_avg_voltage_hyper,ste_avg_rate_hyper,{'b', 'b', 'b'});
hold on;errorbarxy(awesomex,awesomey,mean_avg_voltage_de,mean_avg_rate_de,ste_avg_voltage_de,ste_avg_rate_de,{'k', 'k', 'k'})

% for k=1:numel(avg_sub_voltage_hyper(:,1))
%     pf_sup_hyper{k}=regstats(0:10:200,avg_sup_voltage_hyper(k,:),'linear',{'beta' 'yhat' 'rsquare'});
%     pf_sup_de{k}=regstats(0:10:200,avg_sup_voltage_de(k,:),'linear',{'beta' 'yhat' 'rsquare'});
% end

figure(6);shadedErrorBar(0:10:200,nanmean(avg_sub_voltage_hyper),nanstd(avg_sub_voltage_hyper)./sqrt(sum(~isnan(avg_sub_voltage_hyper))));
hold on;shadedErrorBar(0:10:200,nanmean(avg_sup_voltage_hyper),nanstd(avg_sup_voltage_hyper)./sqrt(sum(~isnan(avg_sup_voltage_hyper))),'r');
hold on;shadedErrorBar(0:10:200,nanmean(avg_sub_voltage_de),nanstd(avg_sub_voltage_de)./sqrt(sum(~isnan(avg_sub_voltage_de))),'g');
hold on;shadedErrorBar(0:10:200,nanmean(avg_sup_voltage_de),nanstd(avg_sup_voltage_de)./sqrt(sum(~isnan(avg_sup_voltage_de))),'m');
title({'Subthreshold Hyperpolarized (Blue)';'Suprathreshold Hyperpolarized (Red)';'Subthreshold Depolarized (Green)';'Suprathreshold Depolarized (Magenta)'})

sub_resistance_hyper=(diff(avg_sub_voltage_hyper')'/(currents_hyper_all(k,2)-currents_hyper_all(k,1)))/1e-9; % find the resistance in ohms
sub_resistance_de=(diff(avg_sub_voltage_de')'/(currents_de_all(k,2)-currents_de_all(k,1)))/1e-9;
diff_sub_resistance=sub_resistance_hyper-sub_resistance_de;

mean_sub_resistance_hyper=nanmean(sub_resistance_hyper);
std_sub_resistance_hyper=nanstd(sub_resistance_hyper);
nh=length(sub_resistance_hyper(:,1))-sum(isnan(sub_resistance_hyper));
ste_sub_resistance_hyper=std_sub_resistance_hyper./sqrt(nh);
mean_sub_resistance_de=nanmean(sub_resistance_de);
std_sub_resistance_de=nanstd(sub_resistance_de);
nd=length(sub_resistance_de(:,1))-sum(isnan(sub_resistance_de));
ste_sub_resistance_de=std_sub_resistance_de./sqrt(nd);
mean_sub_diff_resistance=nanmean(diff_sub_resistance);
std_sub_diff_resistance=nanstd(diff_sub_resistance);
ndiff=length(diff_sub_resistance(:,1))-sum(isnan(diff_sub_resistance));
ste_sub_diff_resistance=std_sub_diff_resistance./sqrt(ndiff);


figure(7);shadedErrorBar(0:10:200,mean_avg_voltage_hyper,ste_avg_voltage_hyper)
hold on;shadedErrorBar(0:10:200,mean_avg_voltage_de,ste_avg_voltage_de,'r')
title('I-V Curves for Hyperpolarized (Black) and Depolarized (Red)')

% [gainsttest_hyper_de(1),gainsttest_hyper_de(2)]=ttest(gains_all_hypervde,gains_all_devhyper)

%look at ratio between slopes
pf_iv_ratio_hyper_de=pf_supra_iv_devhyper./pf_supra_iv_hypervde;
mean_pf_iv_ratio_hyper_de=nanmean(pf_iv_ratio_hyper_de);
std_pf_iv_ratio_hyper_de=nanstd(pf_iv_ratio_hyper_de);
ste_pf_iv_ratio_hyper_de=std_pf_iv_ratio_hyper_de./sqrt(sum(~isnan(pf_iv_ratio_hyper_de)));

figure(15);errorbar(1,mean_pf_iv_ratio_hyper_de,ste_pf_iv_ratio_hyper_de)
hold on;bar(1,mean_pf_iv_ratio_hyper_de,.5,'m')
ylabel('I-V slope ratio')
axis([0.5 1.5 0 1])
set(gca, 'XTick', []);
axis 'auto y'

% look at ratio between slopes (using the same pulses that were used for
% the f-I and f-V curves (Comment out the 2nd level of if statements and just use the else if to measure from spiking to the end no matter what)
for k=1:numel(dates_all_devhyper)
    if sum(rate_hyper_all(k,:)>0)>2
%         if find(rate_hyper_all(k,:)==max(rate_hyper_all(k,:)),1) - find(rate_hyper_all(k,:)>0,1) > 1
%             pf_supra_hyper{k}=regstats(avg_sup_voltage_hyper(k,find(rate_hyper_all(k,:)>0,1):find(rate_hyper_all(k,:)==max(rate_hyper_all(k,:)),1)),...
%                 sup_currents_hyper_all(k,find(rate_hyper_all(k,:)>0,1):find(rate_hyper_all(k,:)==max(rate_hyper_all(k,:)),1)),...
%                 'linear',{'beta' 'yhat' 'rsquare'});
%         elseif find(rate_hyper_all(k,:)==max(rate_hyper_all(k,:)),1) - find(rate_hyper_all(k,:)>0,1) <= 1
            pf_supra_hyper{k}=regstats(avg_sup_voltage_hyper(k,find(rate_hyper_all(k,:)>0,1):numel(rate_hyper_all(k,:))),...
                sup_currents_hyper_all(k,find(rate_hyper_all(k,:)>0,1):numel(rate_hyper_all(k,:))),...
                'linear',{'beta' 'yhat' 'rsquare'});
%         end
    else
        pf_supra_hyper{k}.beta=[NaN;NaN];
    end
    if sum(rate_de_all(k,:)>0)>2
%         if find(rate_de_all(k,:)==max(rate_de_all(k,:)),1) - find(rate_de_all(k,:)>0,1) > 1
%             pf_supra_de{k}=regstats(avg_sup_voltage_de(k,find(rate_de_all(k,:)>0,1):find(rate_de_all(k,:)==max(rate_de_all(k,:)),1)),...
%                 sup_currents_de_all(k,find(rate_de_all(k,:)>0,1):find(rate_de_all(k,:)==max(rate_de_all(k,:)),1)),...
%                 'linear',{'beta' 'yhat' 'rsquare'});
%         elseif find(rate_de_all(k,:)==max(rate_de_all(k,:)),1) - find(rate_de_all(k,:)>0,1) <= 1
            pf_supra_de{k}=regstats(avg_sup_voltage_de(k,find(rate_de_all(k,:)>0,1):numel(rate_de_all(k,:))),...
                sup_currents_de_all(k,find(rate_de_all(k,:)>0,1):numel(rate_de_all(k,:))),...
                'linear',{'beta' 'yhat' 'rsquare'});
%         end
    else
        pf_supra_de{k}.beta=[NaN;NaN];
    end
    pf_supra_ratio(k)=pf_supra_de{k}.beta(2)/pf_supra_hyper{k}.beta(2); % resistance ratio
%     pf_supra_ratio(k)=((1/(pf_supra_de{k}.beta(2)*1e9))*1e9)/((1/(pf_supra_hyper{k}.beta(2)*1e9))*1e9); % conductance ratio
%     pf_supra_diff(k)=(pf_supra_de{k}.beta(2)-pf_supra_hyper{k}.beta(2))*1e3; % resistance difference
    pf_supra_diff(k)=(1/(pf_supra_de{k}.beta(2)*1e9))*1e9-(1/(pf_supra_hyper{k}.beta(2)*1e9))*1e9;
end

mean_pf_supra_ratio=nanmean(pf_supra_ratio);
std_pf_supra_ratio=nanstd(pf_supra_ratio);
ste_pf_supra_ratio=std_pf_supra_ratio./sqrt(sum(~isnan(pf_supra_ratio)));

figure(17);errorbar(1,mean_pf_supra_ratio,ste_pf_supra_ratio)
hold on;bar(1,mean_pf_supra_ratio,.5,'m')
ylabel('I-V slope ratio')
axis([0.5 1.5 0 1])
set(gca, 'XTick', []);
axis 'auto y'

mean_pf_supra_diff=nanmean(pf_supra_diff);
std_pf_supra_diff=nanstd(pf_supra_diff);
ste_pf_supra_diff=std_pf_supra_diff./sqrt(sum(~isnan(pf_supra_diff)));

figure(18);errorbar(1,mean_pf_supra_diff,ste_pf_supra_diff)
hold on;bar(1,mean_pf_supra_diff,.5,'m')
ylabel('suprathreshold conductance difference [nS]')
axis([0.5 1.5 0 1])
set(gca, 'XTick', []);
axis 'auto y'

clear

% figure;shadedErrorBar(0:10:200,mean_diff_voltage,ste_diff_voltage)
% title('Difference Between I-V Curves (Hyperpolarized - Depolarized)')

% figure;shadedErrorBar(0:10:200,mean_sub_resistance_hyper,ste_sub_resistance_hyper)
% hold on;shadedErrorBar(0:10:200,mean_sub_resistance_de,ste_sub_resistance_de,'r')
% title('Resistance Curves for Hyperpolarized (Black) and Depolarized (Red)')

% %find averages of 5 different spots on the Resistance Curve
% diff_currents=0:10:200;
% currents1=mean(diff_currents(1:4));
% mean_sub_resistance_hyper1=mean(mean_sub_resistance_hyper(1:4));
% ste_sub_resistance_hyper1=mean(ste_sub_resistance_hyper(1:4));
% mean_sub_resistance_de1=mean(mean_sub_resistance_de(1:4));
% ste_sub_resistance_de1=mean(ste_sub_resistance_de(1:4));
% currents2=mean(diff_currents(5:8));
% mean_sub_resistance_hyper2=mean(mean_sub_resistance_hyper(5:8));
% ste_sub_resistance_hyper2=mean(ste_sub_resistance_hyper(5:8));
% mean_sub_resistance_de2=mean(mean_sub_resistance_de(5:8));
% ste_sub_resistance_de2=mean(ste_sub_resistance_de(5:8));
% currents3=mean(diff_currents(9:12));
% mean_sub_resistance_hyper3=mean(mean_sub_resistance_hyper(9:12));
% ste_sub_resistance_hyper3=mean(ste_sub_resistance_hyper(9:12));
% mean_sub_resistance_de3=mean(mean_sub_resistance_de(9:12));
% ste_sub_resistance_de3=mean(ste_sub_resistance_de(9:12));
% currents4=mean(diff_currents(13:16));
% mean_sub_resistance_hyper4=mean(mean_sub_resistance_hyper(13:16));
% ste_sub_resistance_hyper4=mean(ste_sub_resistance_hyper(13:16));
% mean_sub_resistance_de4=mean(mean_sub_resistance_de(13:16));
% ste_sub_resistance_de4=mean(ste_sub_resistance_de(13:16));
% currents5=mean(diff_currents(17:20));
% mean_sub_resistance_hyper5=mean(mean_sub_resistance_hyper(17:20));
% ste_sub_resistance_hyper5=mean(ste_sub_resistance_hyper(17:20));
% mean_sub_resistance_de5=mean(mean_sub_resistance_de(17:20));
% ste_sub_resistance_de5=mean(ste_sub_resistance_de(17:20));
% 
% currents_points=[currents1 currents2 currents3 currents4 currents5];
% mean_sub_resistance_points_hyper=[mean_sub_resistance_hyper1 mean_sub_resistance_hyper2 mean_sub_resistance_hyper3 mean_sub_resistance_hyper4 mean_sub_resistance_hyper5];
% ste_sub_resistance_points_hyper=[ste_sub_resistance_hyper1 ste_sub_resistance_hyper2 ste_sub_resistance_hyper3 ste_sub_resistance_hyper4 ste_sub_resistance_hyper5];
% mean_sub_resistance_points_de=[mean_sub_resistance_de1 mean_sub_resistance_de2 mean_sub_resistance_de3 mean_sub_resistance_de4 mean_sub_resistance_de5];
% ste_sub_resistance_points_de=[ste_sub_resistance_de1 ste_sub_resistance_de2 ste_sub_resistance_de3 ste_sub_resistance_de4 ste_sub_resistance_de5];
% 
% figure;errorbar(currents_points,mean_sub_resistance_points_hyper,ste_sub_resistance_points_hyper,'k')
% hold on;errorbar(currents_points,mean_sub_resistance_points_de,ste_sub_resistance_points_de,'r')
% 
% %find running average of Average Resistance Curves
% for k=2:numel(mean_sub_resistance_hyper)-1
%     smooth_mean_sub_resistance_hyper(k-1)=mean(mean_sub_resistance_hyper(k-1:k+1));
%     smooth_ste_sub_resistance_hyper(k-1)=mean(ste_sub_resistance_hyper(k-1:k+1)); %should I take the mean of the stes?
%     smooth_mean_sub_resistance_de(k-1)=mean(mean_sub_resistance_de(k-1:k+1));
%     smooth_ste_sub_resistance_de(k-1)=mean(ste_sub_resistance_de(k-1:k+1));
% end
% figure;shadedErrorBar(10:10:190,smooth_mean_sub_resistance_hyper,smooth_ste_sub_resistance_hyper)
% hold on;shadedErrorBar(10:10:190,smooth_mean_sub_resistance_de,smooth_ste_sub_resistance_de,'r')
% title('Smoothed Resistance Curves for Hyperpolarized (Black) and Depolarized (Red)')

% figure;shadedErrorBar(10:10:200,mean_sub_diff_resistance,ste_sub_diff_resistance)
% title('Difference Between Resistance Curves (Hyperpolarized - Depolarized)')

% [gainsttest(1),gainsttest(2)]=ttest(gains_all(:,1),gains_all(:,2));
% [thresholdttest(1),thresholdttest(2)]=ttest(threshold_all(:,1),threshold_all(:,2));
% 
% figure;errorbar(1:2,mean_gains,std_gains/sqrt(numel(dates_all_hypervde)),'or','LineWidth',2);
% title('History-Dependent Change in Gains')
% ylabel('Gains [Hz/mV]')
% xlabel('Hyperpolarized vs. Depolarized')
% % axis([0.8 2.2 0 0.25])
% 
% figure;errorbar(1:2,mean_threshold,std_threshold/sqrt(numel(dates_all_hypervde)),'or','LineWidth',2);
% title('History-Dependent Change in Threshold')
% ylabel('Threshold [mV]')
% xlabel('Hyperpolarized vs. Depolarized')
% % axis([0.8 2.2 0 0.25])

% for k=1:numel(dates_all_devhyper)
%     eval(['load ' pwd '\..\..\F_I_curves\data\fV_analysis\fi_curves_' dates_all_devhyper{k} '_' cellnum_all_devhyper{k} num2str(trials_all_devhyper(k)) '_fV.mat;'])
%     peakrate_all_devhyper(k,:)=peakrate;
%     nofailrate_all_devhyper(k,:)=nofailrate;
%     gains_all_devhyper(k,1)=pf_all{1}.beta(2);
%     rsq_all_devhyper(k,1)=pf_all{1}.rsquare;
%     rate_all_devhyper(k,:)=rate_all{1};
%     imp_all_devhyper(k,:)=imp;
%     holdingvoltage_all_devhyper(k,:)=mean_holdingvoltage;
% end
% 
% gains_all_devhyper(isnan(rsq_all_devhyper))=NaN; % filter out the gains that are NaNs
% 
% mean_peakrate_devhyper=nanmean(peakrate_all_devhyper);
% std_peakrate_devhyper=nanstd(peakrate_all_devhyper);
% mean_nofailrate_devhyper=nanmean(nofailrate_all_devhyper);
% std_nofailrate_devhyper=nanstd(nofailrate_all_devhyper);
% mean_gains_devhyper=nanmean(gains_all_devhyper);
% std_gains_devhyper=nanstd(gains_all_devhyper);
% ste_gains_devhyper=std_gains_devhyper/sqrt(sum(~isnan(gains_all_devhyper)));
% mean_imp_devhyper=nanmean(imp_all_devhyper);
% std_imp_devhyper=nanstd(imp_all_devhyper);
% mean_holdingvoltage_all_devhyper=nanmean(holdingvoltage_all_devhyper);
% std_holdingvoltage_all_devhyper=nanstd(holdingvoltage_all_devhyper);
% 
% % difference between rates
% difference_rate_hypervde=rate_all_devhyper-rate_all_hypervde;
% mean_difference_rate_hypervde=nanmean(difference_rate_hypervde);
% std_difference_rate_hypervde=nanstd(difference_rate_hypervde);
% ste_difference_rate_hypervde=std_difference_rate_hypervde./sqrt(sum(~isnan(difference_rate_hypervde)));