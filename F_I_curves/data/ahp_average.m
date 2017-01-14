% clear;clc;close all

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
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_hypervde{k} '_' cellnum_all_hypervde{k} num2str(trials_all_hypervde(k)) '_fi.mat;'])
    currents_hyper_all(k,:)=currents{1};
    rate_hyper_all(k,:)=rate_all{1};
    ahp_depth_hyper(k,:)=ahp_depth{1}*1e3;
    ahp_duration_hyper(k,:)=ahp_duration{1};
end


% Depolarized (5 sec pulse, 1 sec pause)
% For Hyperpolarized

% Good quality data only
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
    eval(['load ' pwd '\..\..\F_I_curves\data\fi_analysis\fi_curves_' dates_all_devhyper{k} '_' cellnum_all_devhyper{k} num2str(trials_all_devhyper(k)) '_fi.mat;'])
    currents_de_all(k,:)=currents{1};
    rate_de_all(k,:)=rate_all{1};
    ahp_depth_de(k,:)=ahp_depth{1}*1e3;
    ahp_duration_de(k,:)=ahp_duration{1};
end

ahp_depth_rate_hyper=cell(1,11);
ahp_duration_rate_hyper=cell(1,11);
ahp_depth_rate_de=cell(1,11);
ahp_duration_rate_de=cell(1,11);

for k=1:numel(dates_all_hypervde)
    for h=1:numel(ahp_duration_hyper(1,:))
        for p=0:9
            if rate_hyper_all(k,h)>=p && rate_hyper_all(k,h)<p+1
                ahp_depth_rate_hyper{p+1}(end+1)=ahp_depth_hyper(k,h);
                ahp_duration_rate_hyper{p+1}(end+1)=ahp_duration_hyper(k,h);
            end
        end
    end
end

for k=1:numel(dates_all_devhyper)
    for h=1:numel(ahp_duration_de(1,:))
        for p=0:9
            if rate_de_all(k,h)>=p && rate_de_all(k,h)<p+1
                ahp_depth_rate_de{p+1}(end+1)=ahp_depth_de(k,h);
                ahp_duration_rate_de{p+1}(end+1)=ahp_duration_de(k,h);
            end
        end
    end
end

for p=0:9
    mean_depth_hyper(p+1)=nanmean(ahp_depth_rate_hyper{p+1});
    std_depth_hyper(p+1)=nanstd(ahp_depth_rate_hyper{p+1});
    ste_depth_hyper(p+1)=std_depth_hyper(p+1)/sqrt(numel(ahp_depth_rate_hyper{p+1}));
    mean_duration_hyper(p+1)=nanmean(ahp_duration_rate_hyper{p+1});
    std_duration_hyper(p+1)=nanstd(ahp_duration_rate_hyper{p+1});
    ste_duration_hyper(p+1)=std_duration_hyper(p+1)/sqrt(numel(ahp_duration_rate_hyper{p+1}));
    
    mean_depth_de(p+1)=nanmean(ahp_depth_rate_de{p+1});
    std_depth_de(p+1)=nanstd(ahp_depth_rate_de{p+1});
    ste_depth_de(p+1)=std_depth_de(p+1)/sqrt(numel(ahp_depth_rate_de{p+1}));
    mean_duration_de(p+1)=nanmean(ahp_duration_rate_de{p+1});
    std_duration_de(p+1)=nanstd(ahp_duration_rate_de{p+1});
    ste_duration_de(p+1)=std_duration_de(p+1)/sqrt(numel(ahp_duration_rate_de{p+1}));
    
    if numel(ahp_depth_rate_hyper{p+1})>0
        [ahp_depth_ttest(p+1,1),ahp_depth_ttest(p+1,2)]=ttest2(ahp_depth_rate_hyper{p+1},ahp_depth_rate_de{p+1});
        [ahp_duration_ttest(p+1,1),ahp_duration_ttest(p+1,2)]=ttest2(ahp_duration_rate_hyper{p+1},ahp_duration_rate_de{p+1});
    end
end

% find the mean depth for frequencies lower than 4 spikes/s
mean_ahp_depth_hyper_lt4=mean([ahp_depth_rate_hyper{1} ahp_depth_rate_hyper{2} ahp_depth_rate_hyper{3} ahp_depth_rate_hyper{4}]);
mean_ahp_depth_de_lt4=mean([ahp_depth_rate_de{1} ahp_depth_rate_de{2} ahp_depth_rate_de{3} ahp_depth_rate_de{4}]);
mean_ahp_depth_hyper_gt4=mean([ahp_depth_rate_hyper{5} ahp_depth_rate_hyper{6} ahp_depth_rate_hyper{7} ahp_depth_rate_hyper{8}]);
mean_ahp_depth_de_gt4=mean([ahp_depth_rate_de{5} ahp_depth_rate_de{6} ahp_depth_rate_de{7} ahp_depth_rate_de{8}]);

figure;errorbar([0:9;0:9]'+0.5,[mean_depth_hyper;mean_depth_de]',[ste_depth_hyper;ste_depth_de]')
xlabel('firing rate [spikes/s]')
ylabel('AHP depth [mV]')

figure;errorbar([0:9;0:9]'+0.5,[mean_duration_hyper;mean_duration_de]',[ste_duration_hyper;ste_duration_de]')
xlabel('firing rate [spikes/s]')
ylabel('AHP duration [s]')