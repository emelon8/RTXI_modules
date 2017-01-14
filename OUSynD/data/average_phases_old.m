clear;clc;close all

dates={'Aug_30_12' 'Aug_30_12' 'Aug_30_12' 'Sep_04_12' 'Sep_04_12' 'Sep_04_12'...
    'Nov_05_12' 'Nov_08_12' 'Nov_13_12' 'Nov_13_12'};
cellnum={'A' 'B' 'C' 'A' 'B' 'C' 'A' 'A' 'A' 'B'};

length_meanvectors=NaN(numel(dates),6);

for k=1:numel(dates)
    eval(['load OUSynD_' dates{k} '_' cellnum{k} '_phases.mat;'])
    length_meanvectors(k,:)=length_meanvector;
end

meanvectors=mean(length_meanvectors);
stdvectors=std(length_meanvectors);

figure;errorbar([0.5 1 5 10 20 30],meanvectors,stdvectors/sqrt(numel(dates)))
title('Spike Phase Locking in Response to Different Input Current Frequencies')
ylabel('Phase Locking Index')
xlabel('Frequency [Hz]')