clear;clc;%close all

dates_all={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13' 'May_31_13'...
    'May_31_13' 'May_31_13' 'Jun_24_13' 'Jun_24_13' 'Jul_03_13' 'Jul_03_13'...
    'Jul_29_13' 'Jul_29_13' 'Aug_05_13' 'Aug_16_13' 'Sep_05_13' 'Sep_16_13'...
    'Oct_08_13' 'Oct_08_13' 'Mar_18_14'};% 'Sep_10_13' used synaptic blockers
cellnum_all={'B' 'A' 'B' 'A' 'A' 'B'...
    'C' 'D' 'A' 'B' 'A' 'B'...
    'A' 'B' 'A' 'A' 'A' 'A'...
    'A' 'B' 'A'};% Used synaptic blockers: 'A'

for k=1:numel(dates_all)
    eval(['load ' pwd '\deriv_freq_analysis\fi_curves_' dates_all{k} '_' cellnum_all{k} '_deriv_freq.mat;'])
    for o=1:length(deriv_rate(1,:))
        hyper_deriv_rates(k,o)=deriv_rate(1,o)*10000;
        de_deriv_rates(k,o)=deriv_rate(2,o)*10000;
    end
end

hyper_deriv_rates(hyper_deriv_rates==0)=NaN;
de_deriv_rates(de_deriv_rates==0)=NaN;

meanhyperderivs=nanmean(hyper_deriv_rates);
meandederivs=nanmean(de_deriv_rates);
stdhyperderivs=nanstd(hyper_deriv_rates);
stddederivs=nanstd(de_deriv_rates);

nh=length(hyper_deriv_rates(:,1))-sum(isnan(hyper_deriv_rates));
nd=length(de_deriv_rates(:,1))-sum(isnan(de_deriv_rates));
semhyperderivs=stdhyperderivs./sqrt(nh);
semdederivs=stddederivs./sqrt(nd);

% figure;errorbar(meanhyperderivs(1:6),semhyperderivs(1:6),'LineWidth',2);
% title('Average Maximum Derivative of Spikes for Each Frequency')
% ylabel('Maximum Derivative [mV/ms]')
% xlabel('Frequency [Hz]')
% axis([1 30 40 180])

% hold on;errorbar(meandederivs(1:25),semdederivs(1:25),'r','LineWidth',2);

figure;shadedErrorBar(1:6,meanhyperderivs(1:6),semhyperderivs(1:6));
hold on;shadedErrorBar(1:25,meandederivs(1:25),semdederivs(1:25),'r');
title('Average Maximum Derivative of Spikes for Each Frequency','FontSize',12)
ylabel('Maximum Derivative [mV/ms]','FontSize',12)
xlabel('Frequency [Hz]','FontSize',12)
axis([1 30 40 190])
