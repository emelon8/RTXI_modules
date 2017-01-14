clear;clc;%close all

dates_all={'Jul_03_13' 'Sep_05_13' 'Sep_10_13' 'Oct_08_13' 'Apr_29_15' 'May_01_15'}; %'Jul_03_13' Used different number of increments so must be analyzed separately, but data still good
% 'May_04_15' drift between hyperpolarized and depolarized
cellnum_all={'B' 'A' 'A' 'B' 'E' 'C'}; %'B'
% 'C'

for k=1:numel(dates_all)
    eval(['load ' pwd '\fi_4AP_analysis\fi_curves_' dates_all{k} '_' cellnum_all{k} '_fi_4AP.mat;'])
    gains_all(k,1)=pf_all{1}.beta(2);
    gains_all(k,2)=pf_all{2}.beta(2);
    rsq_all(k,1)=pf_all{1}.rsquare;
    rsq_all(k,2)=pf_all{2}.rsquare;
end

mean_gains=mean(gains_all);
std_gains=std(gains_all);

[gainsttest(1),gainsttest(2)]=ttest(gains_all(:,1),gains_all(:,2));

% figure;errorbar(1:2,mean_gains,std_gains/sqrt(numel(dates_all)),'or','LineWidth',2);
% title('History-Dependent Change in Gains')
% ylabel('Gains [mV/pA]')
% xlabel('Hyperpolarized vs. Depolarized')
% % axis([0.8 2.2 0 0.25])

figure;errorbar(1:2,mean_gains,std_gains/sqrt(numel(dates_all)),'.m','LineWidth',6);
hold on;bar(1:2,mean_gains,.5,'m')
title('History-Dependent Change in Gains')
ylabel('Gains [Hz/pA]')
xlabel('Hyperpolarized vs. Depolarized')
axis([0.4 2.6 0 0.18])