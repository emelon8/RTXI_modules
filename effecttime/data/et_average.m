clear;clc;%close all

dates_all={'Nov_21_13' 'Nov_21_13' 'Nov_26_13' 'Jan_06_15' 'Jan_06_15' 'Jan_06_15'...
    'Mar_28_15'}; % 'Mar_24_15_A' didn't have the inline heater on, not using it
%these did longer hyperpolarization first: 'Nov_19_13' 'Oct_24_13' 'Oct_31_13'
cellnum_all={'A' 'B' 'A' 'A' 'A' 'A'...
    'A'}; %these did longer hyperpolarization first: 'A' 'B' 'A'

for k=1:numel(dates_all)
    eval(['load effecttime_' dates_all{k} '_' cellnum_all{k} '_et.mat;'])
    et_rates_all(k,:,:)=rate_all;
    mean_v_all(k,:)=mean_v;
end

mean_et(:,:)=mean(et_rates_all);
std_et(:,:)=std(et_rates_all);
mean_mean_v=mean(mean_v_all);
std_mean_v=std(mean_v_all);
ste_mean_v=std_mean_v/sqrt(numel(mean_v_all));

x=[1;1;1;1]*[0 0.01 0.05 0.1 0.5 1 5];

% figure;semilogx(x',mean_et)
% 
% hold on;errorbar(x',mean_et,std_et./sqrt(numel(dates_all)),'LineWidth',2); hold on; %%figure(k*3)
% % title({['Initial Rate for Cell ' recdate '_' cellnum '_' num2str(trials)];...
% %     ['Held at ' num2str(imp) ' mV; Delay: ' num2str(delay) ' sec; Pulse Duration: '...
% %     num2str(pulse_duration) ' sec; Pause Duration: ' num2str(pause_duration) ' sec']},'interpreter','none')
% legend('0-5 sec','5-10 sec','10-15 sec','15-20 sec')
% ylabel('Firing Rate [Hz]')

color=['y' 'm' 'c' 'r' 'g' 'b' 'k'];
windowsize=3;
slidesize=0.3;
pulse_length=20;

figure;
for h=1:7
    shadedErrorBar(slidesize:slidesize:(pulse_length-windowsize),mean_et(h,:),...
        std_et(h,:)./sqrt(numel(dates_all)),color(h)); hold on;
end
title('Hyperpolarization Time Required to Evoke the Effect','FontSize',12)
ylabel('Firing Rate [Hz]','FontSize',12)
xlabel('Time [sec]','FontSize',12)

figure;errorbar([slidesize:slidesize:(pulse_length-windowsize)]'*ones(1,size(mean_et,1)),mean_et',std_et'./sqrt(numel(dates_all)))
% title({['Initial Rate for Cell ' recdate '_' cellnum '_' num2str(trials)];...
%     ['Held at ' num2str(imp) ' mV; Delay: ' num2str(delay) ' sec; Pulse Duration: '...
%     num2str(pulse_duration) ' sec; Pause Duration: ' num2str(pause_duration) ' sec']},'interpreter','none')
legend('Depolarized','0.01 sec','0.05 sec','0.1 sec','0.5 sec','1 sec','5 sec')


% One-way ANOVA on the initial rates
rate_anova=[];
anova_times={};
hypert=logspace(-2,1,4)/2;

for k=1:2:7
    rate_anova(end+1:end+length(reshape(et_rates_all(:,k,1),1,[])))=reshape(et_rates_all(:,k,1),1,[]);
    [anova_times{end+1:end+length(reshape(et_rates_all(:,k,1),1,[]))}]=deal([num2str(hypert(k*0.5+0.5)) ' s']);
end

anova1(rate_anova,anova_times)

%Run t-test among the different pairs
signif=NaN(4);
pval=NaN(4);
for k=1:2:7
    for n=1:2:7
        [significance,pvalue]=ttest(et_rates_all(:,k,1),et_rates_all(:,n,1),0.05/6);
        signif(k*0.5+0.5,n*0.5+0.5)=significance;
        pval(k*0.5+0.5,n*0.5+0.5)=pvalue;
    end
end

% % depolarized compared to hyperpolarized for 0.05 s
% anovamatrix_td=[reshape(et_rates_all(:,1,:),[],1) reshape(et_rates_all(:,3,:),[],1)];
% anova_td=anova2(anovamatrix_td,7);
% % hyperpolarized for 0.05 s compared to hyperpolarized for 0.5 s
% anovamatrix_td2=[reshape(et_rates_all(:,3,:),[],1) reshape(et_rates_all(:,5,:),[],1)];
% anova_td2=anova2(anovamatrix_td2,7);
% % hyperpolarized for 0.5 s compared to hyperpolarized for 5 s
% anovamatrix_td3=[reshape(et_rates_all(:,5,:),[],1) reshape(et_rates_all(:,7,:),[],1)];
% anova_td3=anova2(anovamatrix_td3,7);


% % depolarized compared to hyperpolarized for 0.05 s
% g1_time_dependency=[];
% g2_time_dependency=[];
% td_matrix=[];
% 
% for k=1:numel(et_rates_all(1,1,:))
%     % g1 is the group that defines the hyperpolarization time
%     g1_time_dependency=[g1_time_dependency;repmat({'depolarized'},size(et_rates_all(:,1,k)));...
%         repmat({'0.05 s'},size(et_rates_all(:,3,k)))];
%     
%     % g2 is the group that defines the time bin
%     g2_time_dependency=[g2_time_dependency;repmat({num2str(k*0.3)},size(et_rates_all(:,1,k)));...
%         repmat({num2str(k*0.3)},size(et_rates_all(:,3,k)))];
%     
%     % td_matrix is the matrix the same size of g1 and g2 that contains the data
%     % with which their labels correspond
%     td_matrix=[td_matrix;et_rates_all(:,1,k);et_rates_all(:,3,k)];
% end
% 
% anova_td=anovan(td_matrix,{g1_time_dependency,g2_time_dependency});
% 
% % hyperpolarized for 0.05 s compared to hyperpolarized for 0.5 s
% g3_time_dependency=[];
% g4_time_dependency=[];
% td_matrix2=[];
% 
% for k=1:numel(et_rates_all(1,1,:))
%     % g1 is the group that defines the hyperpolarization time
%     g3_time_dependency=[g3_time_dependency;repmat({'0.05 s'},size(et_rates_all(:,3,k)));...
%         repmat({'0.5 s'},size(et_rates_all(:,5,k)))];
%     
%     % g2 is the group that defines the time bin
%     g4_time_dependency=[g4_time_dependency;repmat({num2str(k*0.3)},size(et_rates_all(:,3,k)));...
%         repmat({num2str(k*0.3)},size(et_rates_all(:,5,k)))];
%     
%     % td_matrix is the matrix the same size of g1 and g2 that contains the data
%     % with which their labels correspond
%     td_matrix2=[td_matrix2;et_rates_all(:,3,k);et_rates_all(:,5,k)];
% end
% 
% anova_td2=anovan(td_matrix2,{g3_time_dependency,g4_time_dependency});
% 
% % hyperpolarized for 0.5 s compared to hyperpolarized for 5 s
% g5_time_dependency=[];
% g6_time_dependency=[];
% td_matrix3=[];
% 
% for k=1:numel(et_rates_all(1,1,:))
%     % g1 is the group that defines the hyperpolarization time
%     g5_time_dependency=[g5_time_dependency;repmat({'0.5 s'},size(et_rates_all(:,5,k)));...
%         repmat({'5 s'},size(et_rates_all(:,7,k)))];
%     
%     % g2 is the group that defines the time bin
%     g6_time_dependency=[g6_time_dependency;repmat({num2str(k*0.3)},size(et_rates_all(:,5,k)));...
%         repmat({num2str(k*0.3)},size(et_rates_all(:,7,k)))];
%     
%     % td_matrix is the matrix the same size of g1 and g2 that contains the data
%     % with which their labels correspond
%     td_matrix3=[td_matrix3;et_rates_all(:,5,k);et_rates_all(:,7,k)];
% end
% 
% anova_td3=anovan(td_matrix3,{g5_time_dependency,g6_time_dependency});