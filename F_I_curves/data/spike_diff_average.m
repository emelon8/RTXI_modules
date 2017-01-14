clear;clc;%close all

dates_all={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'...
    'May_31_13' 'May_31_13' 'Jun_24_13' 'Jun_24_13' 'Jul_03_13' 'Jul_03_13'...
    'Jul_29_13' 'Jul_29_13' 'Aug_05_13' 'Aug_16_13' 'Sep_05_13' 'Sep_10_13'...
    'Sep_16_13' 'Oct_08_13' 'Oct_08_13'};
cellnum_all={'B' 'A' 'B' 'A' 'A' 'B'...
    'C' 'D' 'A' 'B' 'A' 'B'...
    'A' 'B' 'A' 'A' 'A' 'A'...
    'A' 'A' 'B'};

for k=1:numel(dates_all)
    eval(['load ' pwd '\spike_diff_analysis\fi_curves_' dates_all{k} '_' cellnum_all{k} '_spike_diff.mat;'])
    avg_linfit_hyperpolarized(k)=mean(linfit_hyperpolarized);
    avg_linfit_depolarized(k)=mean(linfit_depolarized);
    pf_hyperpolarized_all(k)=pf_hyperpolarized.beta(2);
    pf_depolarized_all(k)=pf_depolarized.beta(2);
end

mean_linfit_hyperpolarized=mean(avg_linfit_hyperpolarized);
std_linfit_hyperpolarized=std(avg_linfit_hyperpolarized);
mean_linfit_depolarized=mean(avg_linfit_depolarized);
std_linfit_depolarized=std(avg_linfit_depolarized);
mean_pf_hyperpolarized=mean(pf_hyperpolarized_all);
std_pf_hyperpolarized=std(pf_hyperpolarized_all);
mean_pf_depolarized=mean(pf_depolarized_all);
std_pf_depolarized=std(pf_depolarized_all);

[mean_linfit_ttest(1),mean_linfit_ttest(2)]=ttest(avg_linfit_hyperpolarized,avg_linfit_depolarized);
[pf_ttest(1),pf_ttest(2)]=ttest(pf_hyperpolarized_all,pf_depolarized_all);

figure;errorbar(1:2,[mean_linfit_hyperpolarized mean_linfit_depolarized],...
    [std_linfit_hyperpolarized std_linfit_depolarized]/sqrt(numel(dates_all)),'or','LineWidth',2);
title('History-Dependent Change in Mean Maximum Slope of First Spike')
ylabel('Gains [Hz/mV]')
xlabel('Hyperpolarized vs. Depolarized')
% axis([0.8 2.2 0 0.25])

figure;errorbar(1:2,[mean_pf_hyperpolarized mean_pf_depolarized],...
    [std_pf_hyperpolarized std_pf_depolarized]/sqrt(numel(dates_all)),'or','LineWidth',2);
title('History-Dependent Change in Maximum Slope of First Spike vs. Current')
ylabel('Threshold [Max Slope]')
xlabel('Hyperpolarized vs. Depolarized')
% axis([0.8 2.2 0 0.25])