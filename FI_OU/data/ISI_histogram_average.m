clear;clc;close all

dates_all_hyper_noisevhyper={'Feb_10_15' 'Mar_10_15' 'Mar_10_15' 'Mar_11_15' 'Mar_16_15' 'Mar_16_15'... 'Feb_03_15' 'Feb_03_15' 'Feb_10_15' 'Mar_03_15' 'Mar_06_15' 'Mar_10_15'
    'Mar_17_15' 'Mar_18_15' 'Mar_18_15' 'Mar_23_15' 'Mar_23_15' 'Mar_23_15'...
    'Mar_24_15' 'Apr_03_15' 'Apr_06_15' 'Apr_07_15' 'Apr_07_15'};
cellnum_all_hyper_noisevhyper={'B' 'A' 'D' 'B' 'B' 'C'... 'A' 'B' 'C' 'A' 'A' 'C'
    'A' 'A' 'B' 'B' 'D' 'E'...
    'B' 'B' 'B' 'C' 'D'};
trials_all_hyper_noisevhyper=[1 3 1 3 5 1 ... 1 1 1 1 1 1
    1 3 1 1 1 1 ...
    3 1 1 1 1]';

for k=1:numel(dates_all_hyper_noisevhyper)
    eval(['load ' pwd '\ISI_analysis\FI_OU_' dates_all_hyper_noisevhyper{k} '_' cellnum_all_hyper_noisevhyper{k} num2str(trials_all_hyper_noisevhyper(k)) '_ISI.mat;'])
    for h=1:numel(ISI{1})
        ISI_all{k,h}=ISI{1}{h};
        rate_all_all(k,h)=rate_all{1}(h);
    end
end

ISIs=[];%NaN(numel(dates_all)*numel(ISI{1}),1);

for k=1:numel(dates_all_hyper_noisevhyper)
    for h=1:numel(ISI{1})
        if numel(ISI_all{k,h})>0 && (6 < rate_all_all(k,h) && rate_all_all(k,h) < 14)
            for numISIs=1:numel(ISI_all{k,h})
                ISIs(end+1)=ISI_all{k,h}(numISIs);
            end
        end
    end
end

hist(ISIs,100);
title('Histogram of ISIs')
ylabel('Number of Spikes')
xlabel('ISI Time [sec]')