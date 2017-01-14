clear;clc;close all

% dates_all={'Mar_19_13' 'Mar_21_13' 'Mar_21_13' 'Apr_12_13' 'May_30_13'... don't include for threshold measurements: 'May_31_13'
%     'May_31_13' 'May_31_13' 'Jun_24_13' 'Jul_03_13' 'Jul_03_13'... don't include for threshold measurements: 'Jun_24_13'
%     'Jul_29_13' 'Jul_29_13' 'Aug_16_13' 'Sep_05_13' 'Sep_16_13'... don't include for threshold measurements: 'Aug_05_13'
%     'Oct_08_13' 'Oct_08_13' 'Mar_18_14'}; % Used synaptic blockers: 'Sep_10_13'
% cellnum_all={'B' 'A' 'B' 'A' 'A'... don't include for threshold measurements: 'B'
%     'C' 'D' 'B' 'A' 'B'... don't include for threshold measurements: 'A'
%     'A' 'B' 'A' 'A' 'A'... don't include for threshold measurements: 'A'
%     'A' 'B' 'A'}; % Used synaptic blockers: 'A'

dates_all_hypervde={'Dec_22_14' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Feb_10_15' 'Mar_03_15'...
    'Mar_06_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15'...
    'Mar_16_15' 'Mar_16_15' 'Mar_16_15' 'Mar_17_15' 'Mar_17_15' 'Mar_18_15'...
    'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15'...
    'Apr_03_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15' 'Apr_08_15'...
    'Apr_08_15' 'Apr_08_15' 'Apr_29_15' 'May_01_15' 'May_05_15'};
cellnum_all_hypervde={'C' 'A' 'B' 'B' 'C' 'A'...
    'A' 'A' 'C' 'D' 'B' 'A'...
    'B' 'C' 'D' 'A' 'B' 'A'...
    'B' 'B' 'C' 'D' 'E' 'B'...
    'B' 'B' 'A' 'C' 'D' 'C'...
    'D' 'E' 'E' 'C' 'D'};
trials_all_hypervde=[1 1 1 1 1 1 ...
    1 3 1 1 3 3 ...
    7 1 3 1 1 5 ...
    3 1 1 1 1 3 ...
    6 5 5 5 3 3 ...
    6 4 1 1 1]';

for k=1:numel(dates_all_hypervde)
    eval(['load ' pwd '\fi_analysis\fi_curves_' dates_all_hypervde{k} '_' cellnum_all_hypervde{k} num2str(trials_all_hypervde(k)) '_fi.mat;'])
    rate_threshold_all(k,1)=rate_all;
    thresholds_all{k,1}=thresholds;
end

dates_all_devhyper={'Dec_22_14' 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Feb_10_15' 'Mar_03_15'...
    'Mar_06_15' 'Mar_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15'...
    'Mar_16_15' 'Mar_16_15' 'Mar_16_15' 'Mar_17_15' 'Mar_17_15' 'Mar_18_15'...
    'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15' 'Mar_24_15'...
    'Apr_03_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15' 'Apr_08_15'...
    'Apr_08_15' 'Apr_08_15' 'Apr_29_15' 'May_01_15' 'May_05_15'};
cellnum_all_devhyper={'C' 'A' 'B' 'B' 'C' 'A'...
    'A' 'A' 'C' 'D' 'B' 'A'...
    'B' 'C' 'D' 'A' 'B' 'A'...
    'B' 'B' 'C' 'D' 'E' 'B'...
    'B' 'B' 'A' 'C' 'D' 'C'...
    'D' 'E' 'E' 'C' 'D'};
trials_all_devhyper=[2 2 2 2 2 2 ...
    2 4 2 2 2 4 ...
    8 2 4 2 2 6 ...
    4 2 2 2 2 4 ...
    7 6 6 6 4 4 ...
    7 5 2 3 2]';

for k=1:numel(dates_all_devhyper)
    eval(['load ' pwd '\fi_analysis\fi_curves_' dates_all_devhyper{k} '_' cellnum_all_devhyper{k} num2str(trials_all_devhyper(k)) '_fi.mat;'])
    rate_threshold_all(k,2)=rate_all;
    thresholds_all{k,2}=thresholds;
end

threshold_rate=cell(2,11);

for k=1:numel(dates_all_hypervde)
    for l=1:2
        for h=1:numel(thresholds_all{k,l}{1})
            mean_thresholds{k,l}(h)=mean(thresholds_all{k,l}{1}{h}*1e3);
            for p=0:9
                if rate_threshold_all{k,l}(h)>=p && rate_threshold_all{k,l}(h)<p+1
                    disp([k l h p])
                    threshold_rate{l,p+1}(end+1)=mean_thresholds{k,l}(h);
                end
            end
        end
    end
    
    hyper_thresholds_all_together(k,:)=mean_thresholds{k,1};
    de_thresholds_all_together(k,:)=mean_thresholds{k,2}';
end

for l=1:2
    for p=0:9
        mean_threshold(l,p+1)=nanmean(threshold_rate{l,p+1});
        std_threshold(l,p+1)=nanstd(threshold_rate{l,p+1});
        ste_threshold(l,p+1)=std_threshold(l,p+1)/sqrt(numel(threshold_rate{l,p+1}));
    end
end
        
figure;errorbar([0:9;0:9]'+0.5,mean_threshold',ste_threshold')
xlabel('firing rate [spikes/s]')
ylabel('threshold [mV]')

mean_hyper_thresholds=nanmean(hyper_thresholds_all_together);
std_hyper_thresholds=nanstd(hyper_thresholds_all_together);
ste_hyper_thresholds=std_hyper_thresholds./sqrt(sum(isfinite(hyper_thresholds_all_together)));
mean_de_thresholds=nanmean(de_thresholds_all_together);
std_de_thresholds=nanstd(de_thresholds_all_together);
ste_de_thresholds=std_de_thresholds./sqrt(sum(isfinite(de_thresholds_all_together)));

mean_mean_hyper_thresholds=nanmean(mean_hyper_thresholds);
std_mean_hyper_thresholds=nanstd(mean_hyper_thresholds);
ste_mean_hyper_thresholds=std_mean_hyper_thresholds./sqrt(sum(isfinite(mean_hyper_thresholds)));
mean_mean_de_thresholds=nanmean(mean_de_thresholds);
std_mean_de_thresholds=nanstd(mean_de_thresholds);
ste_mean_de_thresholds=std_mean_de_thresholds./sqrt(sum(isfinite(mean_de_thresholds)));

% mean_rate=nanmean(rate_all{k,:});
% std_rate=nanstd(rate_all);

figure;shadedErrorBar(0:10:200,mean_hyper_thresholds,ste_hyper_thresholds,'c');
hold on;shadedErrorBar(0:10:200,ones(size(mean_hyper_thresholds))*mean_mean_hyper_thresholds,ones(size(mean_hyper_thresholds))*ste_mean_hyper_thresholds,'b')
hold on;shadedErrorBar(0:10:200,mean_de_thresholds,ste_de_thresholds,'m');
hold on;shadedErrorBar(0:10:200,ones(size(mean_de_thresholds))*mean_mean_de_thresholds,ones(size(mean_de_thresholds))*ste_mean_de_thresholds,'r')
title('Hyperpolarized (Cyan and Blue) and Depolarized (Magenta and Red) Thresholds')
xlabel('Current [pA]')
ylabel('Threshold [mV]')