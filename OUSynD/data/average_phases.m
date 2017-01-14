clear;clc;close all

dates={'Jun_19_14' 'Jun_19_14' 'Jun_20_14' 'Jun_20_14' 'Jun_20_14' 'Jun_20_14' 'Jun_25_14' 'Jun_25_14'};
cellnum={'B' 'C' 'A' 'B' 'C' 'D' 'A' 'B'};

frequency_all=cell(1,numel(dates));
length_meanvectors=cell(1,numel(dates));
mean_vectors_all=NaN(numel(dates),7);

for k=1:numel(dates)
    eval(['load OUSynD_' dates{k} '_' cellnum{k} '_phases.mat;'])
    frequency_all{k}=frequency;
    length_meanvectors{k}=length_meanvector;
    
    for j=1:numel(frequency_all{k})
        if frequency_all{k}(j)==0.1
            mean_vectors_all(k,1)=length_meanvectors{k}(j);
        elseif frequency_all{k}(j)==1
            mean_vectors_all(k,2)=length_meanvectors{k}(j);
        elseif frequency_all{k}(j)==5
            mean_vectors_all(k,3)=length_meanvectors{k}(j);
        elseif frequency_all{k}(j)==10
            mean_vectors_all(k,4)=length_meanvectors{k}(j);
        elseif frequency_all{k}(j)==20
            mean_vectors_all(k,5)=length_meanvectors{k}(j);
        elseif frequency_all{k}(j)==30
            mean_vectors_all(k,6)=length_meanvectors{k}(j);
        elseif frequency_all{k}(j)==50
            mean_vectors_all(k,7)=length_meanvectors{k}(j);
        end
    end
end

meanvectors=nanmean(mean_vectors_all);
stdvectors=nanstd(mean_vectors_all);
stevectors=stdvectors./sqrt(sum(~isnan(mean_vectors_all)));

fig = figure;
errorbar([0.1 1 5 10 20 30 50],meanvectors,stevectors);
% ax = get(fig,'CurrentAxes');
% set(ax,'XScale','log','YScale','lin')
title('Spike Phase Locking in Response to Different Input Current Frequencies')
ylabel('Phase Locking Index')
xlabel('Frequency [Hz]')