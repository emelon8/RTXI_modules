clear;clc;close all

dates_all={'Dec_22_14' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Feb_10_15' 'Mar_03_15'...
    'Mar_06_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15'...
    'Mar_16_15' 'Mar_16_15' 'Mar_16_15' 'Mar_17_15' 'Mar_17_15' 'Mar_18_15'...
    'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15'...
    'Apr_03_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15' 'Apr_08_15'...
    'Apr_08_15' 'Apr_08_15' 'Apr_29_15' 'May_01_15' 'May_05_15'};
cellnum_all={'C' 'A' 'B' 'B' 'C' 'A'...
    'A' 'A' 'C' 'D' 'B' 'A'...
    'B' 'C' 'D' 'A' 'B' 'A'...
    'B' 'B' 'C' 'D' 'E' 'B'...
    'B' 'B' 'A' 'C' 'D' 'C'...
    'D' 'E' 'E' 'C' 'D'};

for k=1:numel(dates_all)
    eval(['load ' pwd '\ss_analysis\fi_curves_' dates_all{k} '_' cellnum_all{k} '_ss.mat;'])
    hyper_spikeform(k,:)=lastspikeforms_increment(1,:)*1e3;
    de_spikeform(k,:)=lastspikeforms_increment(2,:)*1e3;
    rate_all(k,:)=rate;
end

mean_hyper_spikeform=nanmean(hyper_spikeform);
std_hyper_spikeform=nanstd(hyper_spikeform);
ste_hyper_spikeform=std_hyper_spikeform./sqrt(sum(~isnan(hyper_spikeform)));
mean_de_spikeform=nanmean(de_spikeform);
std_de_spikeform=nanstd(de_spikeform);
ste_de_spikeform=std_de_spikeform./sqrt(sum(~isnan(de_spikeform)));
% mean maximum rate of averaged spike shape ones
mean_rate_spike=nanmean(rate_all((~isnan(de_spikeform(:,1))),:));
std_rate_spike=nanstd(rate_all((~isnan(de_spikeform(:,1))),:));
ste_rate_spike=std_rate_spike./sqrt(sum(~isnan(rate_all((~isnan(de_spikeform(:,1))),1))));

% Overall mean maximum rate
mean_rate=nanmean(rate_all);
std_rate=nanstd(rate_all);
ste_rate=std_rate./sqrt(sum(~isnan(rate_all)));

figure;shadedErrorBar(0:0.1:22.5,mean_hyper_spikeform,ste_hyper_spikeform,'b');
hold on;shadedErrorBar(0:0.1:22.5,mean_de_spikeform,ste_de_spikeform,'k');
ylabel('membrane voltage [mV]')
xlabel('time [ms]')

hyper_upstroke_deriv=max(diff(hyper_spikeform'))*10;
hyper_downstroke_deriv=min(diff(hyper_spikeform'))*10;
de_upstroke_deriv=max(diff(de_spikeform'))*10;
de_downstroke_deriv=min(diff(de_spikeform'))*10;

mean_hyper_upstroke=nanmean(hyper_upstroke_deriv);
std_hyper_upstroke=nanstd(hyper_upstroke_deriv);
ste_hyper_upstroke=std_hyper_upstroke./sqrt(sum(~isnan(hyper_upstroke_deriv)));
mean_hyper_downstroke=nanmean(hyper_downstroke_deriv);
std_hyper_downstroke=nanstd(hyper_downstroke_deriv);
ste_hyper_downstroke=std_hyper_downstroke./sqrt(sum(~isnan(hyper_downstroke_deriv)));
mean_de_upstroke=nanmean(de_upstroke_deriv);
std_de_upstroke=nanstd(de_upstroke_deriv);
ste_de_upstroke=std_de_upstroke./sqrt(sum(~isnan(de_upstroke_deriv)));
mean_de_downstroke=nanmean(de_downstroke_deriv);
std_de_downstroke=nanstd(de_downstroke_deriv);
ste_de_downstroke=std_de_downstroke./sqrt(sum(~isnan(de_downstroke_deriv)));

% figure;errorbar(1:2,[mean_hyper_upstroke mean_de_upstroke],[ste_hyper_upstroke ste_de_upstroke],'.')
% hold on;bar(1:2,[mean_hyper_upstroke mean_de_upstroke],.5,'m')
% xlabel('hyper.     de.')
% ylabel('maximum derivative [mV/ms]')
% axis([0.5 2.5 0 130])
% set(gca, 'XTick', []);

% figure;errorbar(1:2,[mean_hyper_downstroke mean_de_downstroke],[ste_hyper_downstroke ste_de_downstroke],'.')
% hold on;bar(1:2,[mean_hyper_downstroke mean_de_downstroke],.5,'m')
% xlabel('hyper.     de.')
% ylabel('minimum derivative [mV/ms]')
% axis([0.5 2.5 -60 0])
% set(gca, 'XTick', []);

% mean_hyper_downstroke=10;
% mean_de_downstroke=10;
% ste_hyper_downstroke=1;
% ste_de_downstroke=1;

figure;errorbar(1:4,[mean_hyper_upstroke mean_de_upstroke mean_hyper_downstroke mean_de_downstroke],...
    [ste_hyper_upstroke ste_de_upstroke ste_hyper_downstroke ste_de_downstroke],'.')
hold on;bar(1:4,[mean_hyper_upstroke mean_de_upstroke mean_hyper_downstroke mean_de_downstroke],.5,'m')
xlabel('hyper.     de.')
ylabel('maximum derivative [mV/ms]')
% % axis([0.5 2.5 -60 130])
% % axis 'auto x'
set(gca, 'XTick', []);

[ttest_upstroke(1),ttest_upstroke(2)]=ttest(hyper_upstroke_deriv,de_upstroke_deriv);
[ttest_downstroke(1),ttest_downstroke(2)]=ttest(hyper_downstroke_deriv,de_downstroke_deriv);


% Plot spike downstroke derivative as a function of firing frequency
[cool,asdf]=sort(rate_all(:,1));

for j = 1:numel(cool)
    B(j) = hyper_downstroke_deriv(asdf(j)); 
end

figure;plot(cool,B)

[cool2,asdf2]=sort(rate_all(:,2));

for j = 1:numel(cool2)
    C(j) = de_downstroke_deriv(asdf2(j)); 
end

hold on;plot(cool2,C,'r')

% Plot spike downstroke derivative as a function of spike number
