clear;clc;%close all

dates_all={'Dec_17_13' 'Dec_18_13' 'Dec_19_13' 'Jan_08_14' 'Jan_08_14' 'Jan_06_15'...
    'Jan_06_15'}; % 'Mar_24_15_A' didn't have the inline heater on, not using it
cellnum_all={'C' 'A' 'A' 'A' 'B' 'B'...
    'C'};
rate_all_all=cell(1,6);

for k=1:numel(dates_all)
    eval(['load ' pwd '\voltage_dependency_analysis\fi_curves_' dates_all{k} '_' cellnum_all{k} '_voltage_dependency.mat;'])
    for h=1:numel(rate_all_all)
%         if ~isempty(find(-5*h-35 < mean_v & mean_v < -5*h-30))
        binned_v{h}=find(-10*h-30 < mean_v & mean_v < -10*h-20);
        rate_this_cell_this_v=mean(rate_all(binned_v{h},:),1);
        if ~isempty(binned_v{h})
            rate_all_all{h}=[rate_all_all{h} ; rate_this_cell_this_v];
        end
    end
end

for h=1:numel(rate_all_all)
    mean_rates(h,:)=mean(rate_all_all{h});
    std_rates(h,:)=std(rate_all_all{h});
    ste_rates(h,:)=std_rates(h,:)/sqrt(size(rate_all_all{h},1));
end

pulse_length=20;
windowsize=3;
slidesize=.3;

% figure;errorbar([slidesize:slidesize:(pulse_length-windowsize)]'*ones(1,6),mean_rates',ste_rates','LineWidth',2);
% title('Level of Hyperpolarization Required to Evoke the Effect')
% legend('-30 to -40','-40 to -50','-50 to -60','-60 to -70','-70 to -80','-80 to -90')
% ylabel('Rate [Hz]')
% xlabel('Time')

color=['y' 'm' 'c' 'r' 'g' 'b'];

figure;
for h=1:6
    hold on;shadedErrorBar(slidesize:slidesize:(pulse_length-windowsize),mean_rates(h,:),ste_rates(h,:),color(h));
end
title('Level of Hyperpolarization Required to Evoke the Effect')
ylabel('Rate [Hz]')
xlabel('Time')

rate_anova=[];
anova_voltages={};

for k=1:4
    rate_anova(end+1:end+length(reshape(rate_all_all{k}(:,1),1,[])))=reshape(rate_all_all{k}(:,1),1,[]);
    [anova_voltages{end+1:end+length(reshape(rate_all_all{k}(:,1),1,[]))}]=deal([num2str(-k*10-20) ' to ' num2str(-k*10-30) ' mV']);
end

anova1(rate_anova,anova_voltages)

%Run t-test among the different pairs
signif=NaN(4);
pval=NaN(4);
for k=1:4
    for n=1:4
        [significance,pvalue]=ttest2(rate_all_all{k}(:,1),rate_all_all{n}(:,1));
        signif(k,n)=significance;
        pval(k,n)=pvalue;
    end
end

% % -35 +- 5 mV compared to -45 +- 5 mV
% g1_voltage_dependency=[];
% g2_voltage_dependency=[];
% vd_matrix=[];
% 
% for k=1:numel(rate_all_all{1}(1,:))
%     % g1 is the group that defines the voltage
%     g1_voltage_dependency=[g1_voltage_dependency;repmat({'-35 +- 5 mV'},size(rate_all_all{1}(:,k)));...
%         repmat({'-45 +- 5 mV'},size(rate_all_all{2}(:,k)))];
%     
%     % g2 is the group that defines the time bin
%     g2_voltage_dependency=[g2_voltage_dependency;repmat({num2str(k*0.3)},size(rate_all_all{1}(:,k)));...
%         repmat({num2str(k*0.3)},size(rate_all_all{2}(:,k)))];
%     
%     % vd_matrix is the matrix the same size of g1 and g2 that contains the data
%     % with which their labels correspond
%     vd_matrix=[vd_matrix;rate_all_all{1}(:,k);rate_all_all{2}(:,k)];
% end
% 
% anova_vd=anovan(vd_matrix,{g1_voltage_dependency,g2_voltage_dependency});
% 
% % -45 +- 5 mV compared to -55 +- 5 mV
% g3_voltage_dependency=[];
% g4_voltage_dependency=[];
% vd_matrix2=[];
% 
% for k=1:numel(rate_all_all{1}(1,:))
%     % g1 is the group that defines the voltage
%     g3_voltage_dependency=[g3_voltage_dependency;repmat({'-45 +- 5 mV'},size(rate_all_all{2}(:,k)));...
%         repmat({'-55 +- 5 mV'},size(rate_all_all{3}(:,k)))];
%     
%     % g2 is the group that defines the time bin
%     g4_voltage_dependency=[g4_voltage_dependency;repmat({num2str(k*0.3)},size(rate_all_all{2}(:,k)));...
%         repmat({num2str(k*0.3)},size(rate_all_all{3}(:,k)))];
%     
%     % vd_matrix is the matrix the same size of g1 and g2 that contains the data
%     % with which their labels correspond
%     vd_matrix2=[vd_matrix2;rate_all_all{2}(:,k);rate_all_all{3}(:,k)];
% end
% 
% anova_vd2=anovan(vd_matrix2,{g3_voltage_dependency,g4_voltage_dependency});
% 
% % -55 +- 5 mV compared to -65 +- 5 mV
% g5_voltage_dependency=[];
% g6_voltage_dependency=[];
% vd_matrix3=[];
% 
% for k=1:numel(rate_all_all{1}(1,:))
%     % g1 is the group that defines the voltage
%     g5_voltage_dependency=[g5_voltage_dependency;repmat({'-55 +- 5 mV'},size(rate_all_all{3}(:,k)));...
%         repmat({'-65 +- 5 mV'},size(rate_all_all{4}(:,k)))];
%     
%     % g2 is the group that defines the time bin
%     g6_voltage_dependency=[g6_voltage_dependency;repmat({num2str(k*0.3)},size(rate_all_all{3}(:,k)));...
%         repmat({num2str(k*0.3)},size(rate_all_all{4}(:,k)))];
%     
%     % vd_matrix is the matrix the same size of g1 and g2 that contains the data
%     % with which their labels correspond
%     vd_matrix3=[vd_matrix3;rate_all_all{3}(:,k);rate_all_all{4}(:,k)];
% end
% 
% anova_vd3=anovan(vd_matrix3,{g5_voltage_dependency,g6_voltage_dependency});