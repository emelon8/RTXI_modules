clear;clc;%close all

dates_all={'Jul_29_13' 'Sep_05_13' 'Sep_10_13'};
cellnum_all={'A' 'B' 'B'};
trials_control=[1 1 1];
trials_4AP=[2 2 2];

for k=1:numel(dates_all)
    eval(['load v_clamp_resistance_' dates_all{k} '_' cellnum_all{k} num2str(trials_control(k)) '_resistance.mat;'])
    resistance_control_all(k,:,:)=mean_resistance;
    eval(['load v_clamp_resistance_' dates_all{k} '_' cellnum_all{k} num2str(trials_4AP(k)) '_resistance.mat;'])
    resistance_4AP_all(k,:,:)=mean_resistance;
end

mean_resistance_control(:,:)=mean(resistance_control_all);
mean_resistance_4AP(:,:)=mean(resistance_4AP_all);
std_resistance_control(:,:)=std(resistance_control_all);
std_resistance_4AP(:,:)=std(resistance_4AP_all);

% [resistancettest(1),resistancettest(2)]=ttest(resistance_all(1,:,:),resistance_all(2,:,:));

figure
for k=1:5
    hold on;resistanceplot=errorbar(1:5,mean_resistance_control(k,:),std_resistance_control(k,:)/sqrt(numel(dates_all)),'LineWidth',2);
    set(resistanceplot,'Color',[1/sqrt(k) 0 1/sqrt(k)]) % darker color = higher k
    title('History-Dependent Change in Resistance without 4-AP')
    ylabel('Resistance [M\Omega]')
    xlabel('Pulse Number')
    % axis([0.8 2.2 0 0.25])
end

figure
for k=1:5
    hold on;resistanceplot=errorbar(1:5,mean_resistance_4AP(k,:),std_resistance_4AP(k,:)/sqrt(numel(dates_all)),'LineWidth',2);
    set(resistanceplot,'Color',[1/sqrt(k) 0 1/sqrt(k)]) % darker color = higher k
    title('History-Dependent Change in Resistance with 4-AP')
    ylabel('Resistance [M\Omega]')
    xlabel('Pulse Number')
    % axis([0.8 2.2 0 0.25])
end