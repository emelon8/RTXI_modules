clear;clc;%close all

dates={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'...
    'May_31_13' 'May_31_13' };%leave out: 'Apr_12_13'
cellnum={'B' 'A' 'B' 'A' 'A' 'B'...
    'C' 'D' };%leave out: 'B'

for k=1:numel(dates)
    eval(['load ' pwd '\rates_analysis\fi_curves_' dates{k} '_' cellnum{k} '_rates.mat;'])
    gain_ratio(find(NaN))=0;
    gain_ratios(k,:)=gain_ratio;
end

mean_gain_ratio=mean(gain_ratios);
std_gain_ratio=std(gain_ratios);

figure;errorbar(1:2,mean_gain_ratio,std_gain_ratio/sqrt(numel(dates)),'o');
title('History-Dependent Change in Gain Ratio')
ylabel('Gain Ratio')
xlabel('Hyperpolarized vs. Depolarized')
axis([0.8 2.2 -1 1])