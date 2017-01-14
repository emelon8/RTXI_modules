clear;clc;close all

dates={'Mar_21_12' 'Apr_11_12' 'Apr_11_12' 'Apr_11_12' 'Apr_25_12' 'Apr_30_12' 'May_07_12' 'May_07_12'}; %'Apr_25_12' 'Apr_26_12'
cellnum={'A' 'A' 'B' 'C' 'A' 'A' 'A' 'B'}; %'B' 'A'
trials=[2 4; 1 2; 3 2; 1 3; 1 2; 1 2; 1 2; 1 7]; %1 2; 1 4;
module='fi_curves';
sample_rate=10000;
shouldplot=0;

differences=cell(1,numel(dates));
depolarizedplot=cell(1,numel(dates));
hyperpolarizedplot=cell(1,numel(dates));

for k=1:numel(dates)
    [rate_all,rate_init,rate_accom,imp,pulse_duration,pause_duration,delay,increments,currents,pf_init,pf_accom,fit_init,fit_accom]=...
        ISI_rate(module,dates{k},cellnum{k},trials(k,:),sample_rate,shouldplot);
    
%     figure(2*k+1);plot(currents{1},rate_init{1},'b')
%     hold on;plot(currents{1},rate_accom{1},'r')
%     plot(currents{1},rate_init{1} - rate_accom{1},'*k')
%     hold off
%     title({'F-I Curves for Hyperpolarized Cell';[module '_' dates{k} '_' cellnum{k}...
%         ', Trial ' num2str(trials(k,1))]},'interpreter','none')
%     legend('Initial Rate','Steady-State Rate','Difference','location','NorthWest')
%     xlabel('Currents [pA]')
%     ylabel('Firing Rate [Hz]')
%     
%     figure(2*k+2);plot(currents{2},rate_init{2},'b')
%     hold on;plot(currents{2},rate_accom{2},'r')
%     plot(currents{2},rate_init{2} - rate_accom{2},'*k')
%     hold off
%     title({'F-I Curves for Depolarized Cell';[module '_' dates{k} '_' cellnum{k}...
%         ', Trial ' num2str(trials(k,2))]},'interpreter','none')
%     legend('Initial Rate','Steady-State Rate','Difference','location','NorthWest')
%     xlabel('Currents [pA]')
%     ylabel('Firing Rate [Hz]')
    
    differences{1,k}=rate_init{1} - rate_accom{1};
    
%     if numel(x)>numel(y)
%         hello=mean([x(1:numel(y));y]);
%     else
%         hello=mean([y(1:numel(x));x]);
%     end
    
    figure(1);hold on; depolarizedplot{k}=plot(currents{1},differences{1,k});hold off;
    set(depolarizedplot{k},'Color',[rand rand rand])
    title('Hyperpolarized F-I Curve Differences')
    xlabel('Currents [pA]')
    ylabel('Firing Rate [Hz]')
    
    differences{2,k}=rate_init{2} - rate_accom{2};
    
    figure(2);hold on; hyperpolarizedplot{k}=plot(currents{2},differences{2,k});hold off;
    set(hyperpolarizedplot{k},'Color',[rand rand rand])
    title('Depolarized F-I Curve Differences')
    xlabel('Currents [pA]')
    ylabel('Firing Rate [Hz]')
end

M1=strcat(dates','_',cellnum',num2str(trials(:,1)));
M2=strcat(dates','_',cellnum',num2str(trials(:,2)));
figure(1);legend(M1,'location','NorthWest','interpreter','none');axis([-50 350 -50 350])
figure(2);legend(M2,'location','NorthWest','interpreter','none');axis([-50 350 -50 350])