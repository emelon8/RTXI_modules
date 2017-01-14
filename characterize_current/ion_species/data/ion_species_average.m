clear;clc;close all

dates_all   ={'Feb_06_14' 'Feb_13_14' 'Feb_14_14' 'Feb_19_14' 'Feb_27_14' 'Feb_27_14' 'Feb_27_14' 'Mar_03_14' 'Mar_04_14' 'Mar_04_14' 'Mar_13_14'}; % 'Feb_06_14' 'Feb_19_14'
cellnum_all ={'B'         'B'         'A'         'A'         'A'         'B'         'C'         'A'         'A'         'C'         'A'}; % 'B' 'A'
trial       =[1           1           1           1           1           1           1           1           1           1           1]; % 2 2

xintercept_all=NaN(numel(dates_all),1);

for k=1:numel(dates_all)
    eval(['load ion_species_' dates_all{k} '_' cellnum_all{k} num2str(trial(k)) '_iv.mat;'])
    xintercept_all_temp(k)=xintercept;
end

xintercept_all=xintercept_all_temp;
% % ONLY USE IF YOU INCLUDE THE OTHER TWO EXTRA TRIALS
% xintercept_all=[mean(xintercept_all_temp(1:2)) xintercept_all_temp(3:4) mean(xintercept_all_temp(5:6)) xintercept_all_temp(7:end)];

mean_xintercept=nanmean(xintercept_all);
std_xintercept=nanstd(xintercept_all);
ste_xintercept=std_xintercept./sqrt(numel(xintercept_all));