clear

dates={'Jul_22_11' 'Aug_04_11' 'Aug_05_11' 'Aug_09_11' 'Aug_12_11' 'Aug_15_11' 'Aug_17_11' 'Aug_18_11' 'Aug_29_11' 'Sep_02_11'};
cellnum={'A' 'B' 'A' 'D' 'A' 'B' 'C' 'A' 'B' 'B'};
conc_propofol='100'; % Concentration of propofol in uM
start_current=10;    % Starting current in pA
finish_current=150;  % Finishing current in pA
increments=15;

celldata=zeros(numel(dates),6,increments);
matrixnames={'control_all_' 'control_init_' 'control_accom_' 'propofol_all_'...
    'propofol_init_' 'propofol_accom_'};

for k=1:numel(dates)
    eval(['load fV_curves_' dates{k} '_' cellnum{k} '_countrate_control.mat;'])
    eval(['load fV_curves_' dates{k} '_' cellnum{k} '_countrate_propofol.mat;'])
	for j=1:3;
        eval(['celldata(k,j,:)=' matrixnames{j} dates{k} '_' cellnum{k} ';'])
	    eval(['celldata(k,j+3,:)=' matrixnames{j+3} dates{k} '_' cellnum{k} ';'])
	end
end

avg_control=zeros(3,increments);
ste_control=zeros(3,increments);
avg_propofol=zeros(3,increments);
ste_propofol=zeros(3,increments);

for k=1:3
    for j=1:increments
        avg_control(k,j)=mean(celldata(:,k,j));
        ste_control(k,j)=std(celldata(:,k,j))/sqrt(numel(dates));
	    avg_propofol(k,j)=mean(celldata(:,k+3,j));
        ste_propofol(k,j)=std(celldata(:,k+3,j))/sqrt(numel(dates));
	end
end

% Average the slopes of the different cells
for k=1:numel(dates)
    eval(['control_slopes_all(k)=control_pf_all_' dates{k} '_' cellnum{k} '_countrate(1);'])
    eval(['control_yintercept_all(k)=control_pf_all_' dates{k} '_' cellnum{k} '_countrate(2);'])
    eval(['control_slopes_init(k)=control_pf_init_' dates{k} '_' cellnum{k} '_countrate(1);'])
    eval(['control_yintercept_init(k)=control_pf_init_' dates{k} '_' cellnum{k} '_countrate(2);'])
    eval(['control_slopes_accom(k)=control_pf_accom_' dates{k} '_' cellnum{k} '_countrate(1);'])
    eval(['control_yintercept_accom(k)=control_pf_accom_' dates{k} '_' cellnum{k} '_countrate(2);'])
    
    eval(['propofol_slopes_all(k)=propofol_pf_all_' dates{k} '_' cellnum{k} '_countrate(1);'])
    eval(['propofol_yintercept_all(k)=propofol_pf_all_' dates{k} '_' cellnum{k} '_countrate(2);'])
    eval(['propofol_slopes_init(k)=propofol_pf_init_' dates{k} '_' cellnum{k} '_countrate(1);'])
    eval(['propofol_yintercept_init(k)=propofol_pf_init_' dates{k} '_' cellnum{k} '_countrate(2);'])
    eval(['propofol_slopes_accom(k)=propofol_pf_accom_' dates{k} '_' cellnum{k} '_countrate(1);'])
    eval(['propofol_yintercept_accom(k)=propofol_pf_accom_' dates{k} '_' cellnum{k} '_countrate(2);'])
end

[ttest_slope_all(1),ttest_slope_all(2)]=ttest(control_slopes_all,propofol_slopes_all);
[ttest_slope_init(1),ttest_slope_init(2)]=ttest(control_slopes_init,propofol_slopes_init);
[ttest_slope_accom(1),ttest_slope_accom(2)]=ttest(control_slopes_accom,propofol_slopes_accom);

slope_all_avg(1)=mean(control_slopes_all);
slope_all_ste(1)=std(control_slopes_all)/sqrt(numel(dates));

yintercept_all_avg(1)=mean(control_yintercept_all);
yintercept_all_ste(1)=std(control_yintercept_all)/sqrt(numel(dates));

slope_init_avg(1)=mean(control_slopes_init);
slope_init_ste(1)=std(control_slopes_init)/sqrt(numel(dates));

yintercept_init_avg(1)=mean(control_yintercept_init);
yintercept_init_ste(1)=std(control_yintercept_init)/sqrt(numel(dates));

slope_accom_avg(1)=mean(control_slopes_accom);
slope_accom_ste(1)=std(control_slopes_accom)/sqrt(numel(dates));

yintercept_accom_avg(1)=mean(control_yintercept_accom);
yintercept_accom_ste(1)=std(control_yintercept_accom)/sqrt(numel(dates));

slope_all_avg(2)=mean(propofol_slopes_all);
slope_all_ste(2)=std(propofol_slopes_all)/sqrt(numel(dates));

yintercept_all_avg(2)=mean(propofol_yintercept_all);
yintercept_all_ste(2)=std(propofol_yintercept_all)/sqrt(numel(dates));

slope_init_avg(2)=mean(propofol_slopes_init);
slope_init_ste(2)=std(propofol_slopes_init)/sqrt(numel(dates));

yintercept_init_avg(2)=mean(propofol_yintercept_init);
yintercept_init_ste(2)=std(propofol_yintercept_init)/sqrt(numel(dates));

slope_accom_avg(2)=mean(propofol_slopes_accom);
slope_accom_ste(2)=std(propofol_slopes_accom)/sqrt(numel(dates));

yintercept_accom_avg(2)=mean(propofol_yintercept_accom);
yintercept_accom_ste(2)=std(propofol_yintercept_accom)/sqrt(numel(dates));

% polyfit(control_voltage_avg_all,avg_control(1,:),1)
% polyfit(control_voltage_avg_init,avg_control(2,:),1)
% polyfit(control_voltage_avg_accom,avg_control(3,:),1)
% polyfit(propofol_voltage_avg_all,avg_propofol(1,:),1)
% polyfit(propofol_voltage_avg_init,avg_propofol(2,:),1)
% polyfit(propofol_voltage_avg_accom,avg_propofol(3,:),1)

figure;errorbar(control_voltage_avg_all,avg_control(1,:),ste_control(1,:),'ob','LineWidth',2)
hold on
errorbar(propofol_voltage_avg_all,avg_propofol(1,:),ste_propofol(1,:),'or','LineWidth',2)
hold on
plot(control_voltage_avg_all,slope_all_avg(1)*control_voltage_avg_all+...
    yintercept_all_avg(1),propofol_voltage_avg_all,...
    slope_all_avg(2)*propofol_voltage_avg_all+yintercept_all_avg(2),'r','LineWidth',2)
title('f-V Curve of Overall Firing Rate','fontsize',14)
legend('Control \pm SE',[conc_propofol '\muM Propofol \pm SE'],'Fitted Control',...
    'Fitted Propofol','Location','Best')
xlabel('Membrane Voltage [V]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)
% axis([0 160 0 12])
figure;errorbar(control_voltage_avg_init,avg_control(2,:),ste_control(2,:),'ob','LineWidth',2)
hold on
errorbar(propofol_voltage_avg_init,avg_propofol(2,:),ste_propofol(2,:),'or','LineWidth',2)
hold on
plot(control_voltage_avg_init,slope_init_avg(1)*control_voltage_avg_init+...
    yintercept_init_avg(1),propofol_voltage_avg_init,...
    slope_init_avg(2)*propofol_voltage_avg_init+yintercept_init_avg(2),'r','LineWidth',2)
title('f-V Curve of Initial Firing Rate','fontsize',14)
legend('Control \pm SE',[conc_propofol '\muM Propofol \pm SE'],'Fitted Control',...
    'Fitted Propofol','Location','Best')
xlabel('Membrane Voltage [V]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)
% axis([0 160 0 25])
figure;errorbar(control_voltage_avg_accom,avg_control(3,:),ste_control(3,:),'ob','LineWidth',2)
hold on
errorbar(propofol_voltage_avg_accom,avg_propofol(3,:),ste_propofol(3,:),'or','LineWidth',2)
hold on
plot(control_voltage_avg_accom,slope_accom_avg(1)*control_voltage_avg_accom+...
    yintercept_accom_avg(1),propofol_voltage_avg_accom,...
    slope_accom_avg(2)*propofol_voltage_avg_accom+yintercept_accom_avg(2),'r','LineWidth',2)
title('f-V Curve of Steady-State Firing Rate','fontsize',14)
legend('Control \pm SE',[conc_propofol '\muM Propofol \pm SE'],'Fitted Control',...
    'Fitted Propofol','Location','Best')
xlabel('Membrane Voltage [V]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)
% axis([0 160 0 12])