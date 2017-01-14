clear;clc;%close all

dates={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'...
    'May_31_13' 'May_31_13' };%leave out: 'Apr_12_13'
cellnum={'B' 'A' 'B' 'A' 'A' 'B'...
    'C' 'D' };%leave out: 'B'

for k=1:numel(dates)
    eval(['load ' pwd '\rates_analysis\fi_curves_' dates{k} '_' cellnum{k} '_rates.mat;'])
    gains(k,:)=pf_delay(:,1);
    init_gains(k,:)=pf_init(:,1);
end

meangains=mean(gains);
meaninitgains=mean(init_gains);
stdgains=std(gains);
stdinitgains=std(init_gains);

[gainsttest(1),gainsttest(2)]=ttest(init_gains(:,1),init_gains(:,2));

figure;errorbar(1:2,meangains,stdgains/sqrt(numel(dates)),'o');
title('Change in Gain after Delay')
ylabel('Gain [Hz/pA]')
xlabel('Hyperpolarized vs. Depolarized')
axis([0.8 2.2 0 0.4])

figure;errorbar(1:2,meaninitgains,stdinitgains/sqrt(numel(dates)),'o');
title('Change in Gain without Delay')
ylabel('Gain [Hz/pA]')
xlabel('Hyperpolarized vs. Depolarized')
axis([0.8 2.2 0 0.4])