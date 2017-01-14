clear

dates={'Aug_04_11' 'Aug_09_11' 'Jul_22_11' 'Aug_05_11'};
cellnum={'B' 'D' 'A' 'A'};
conc_propofol='100'; % Concentration of propofol in uM
start_current=10;    % Starting current in pA
finish_current=150;  % Finishing current in pA
increments=15;

celldata=zeros(numel(dates),6,increments);
matrixnames={'control_all_' 'control_init_' 'control_accom_' 'propofol_all_'...
    'propofol_init_' 'propofol_accom_'};

for k=1:numel(dates)
    eval(['load fi_curves_' dates{k} '_' cellnum{k} '_ISIrate_control.mat;'])
    eval(['load fi_curves_' dates{k} '_' cellnum{k} '_ISIrate_propofol.mat;'])
	for j=1:3;
        eval(['celldata(k,j,:)=' matrixnames{j} dates{k} '_' cellnum{k} ';'])
	    eval(['celldata(k,j+3,:)=' matrixnames{j+3} dates{k} '_' cellnum{k} ';'])
	end
end

avg_control=zeros(3,increments);
avg_propofol=zeros(3,increments);

for k=1:3
    for j=1:increments
        avg_control(k,j)=mean(celldata(:,k,j));
	    avg_propofol(k,j)=mean(celldata(:,k+3,j));
	end
end

% Average the slopes of the different cells
for k=1:numel(dates)
    eval(['control_slopes_all(k)=control_pf_all_' dates{k} '_' cellnum{k} '_ISIrate(1);'])
    eval(['control_yintercept_all(k)=control_pf_all_' dates{k} '_' cellnum{k} '_ISIrate(2);'])
    eval(['control_slopes_init(k)=control_pf_init_' dates{k} '_' cellnum{k} '_ISIrate(1);'])
    eval(['control_yintercept_init(k)=control_pf_init_' dates{k} '_' cellnum{k} '_ISIrate(2);'])
    eval(['control_slopes_accom(k)=control_pf_accom_' dates{k} '_' cellnum{k} '_ISIrate(1);'])
    eval(['control_yintercept_accom(k)=control_pf_accom_' dates{k} '_' cellnum{k} '_ISIrate(2);'])
    
    eval(['propofol_slopes_all(k)=propofol_pf_all_' dates{k} '_' cellnum{k} '_ISIrate(1);'])
    eval(['propofol_yintercept_all(k)=propofol_pf_all_' dates{k} '_' cellnum{k} '_ISIrate(2);'])
    eval(['propofol_slopes_init(k)=propofol_pf_init_' dates{k} '_' cellnum{k} '_ISIrate(1);'])
    eval(['propofol_yintercept_init(k)=propofol_pf_init_' dates{k} '_' cellnum{k} '_ISIrate(2);'])
    eval(['propofol_slopes_accom(k)=propofol_pf_accom_' dates{k} '_' cellnum{k} '_ISIrate(1);'])
    eval(['propofol_yintercept_accom(k)=propofol_pf_accom_' dates{k} '_' cellnum{k} '_ISIrate(2);'])
end

control_slope_all_avg=mean(control_slopes_all);
control_yintercept_all_avg=mean(control_yintercept_all);
control_slope_init_avg=mean(control_slopes_init);
control_yintercept_init_avg=mean(control_yintercept_init);
control_slope_accom_avg=mean(control_slopes_accom);
control_yintercept_accom_avg=mean(control_yintercept_accom);
propofol_slope_all_avg=mean(propofol_slopes_all);
propofol_yintercept_all_avg=mean(propofol_yintercept_all);
propofol_slope_init_avg=mean(propofol_slopes_init);
propofol_yintercept_init_avg=mean(propofol_yintercept_init);
propofol_slope_accom_avg=mean(propofol_slopes_accom);
propofol_yintercept_accom_avg=mean(propofol_yintercept_accom);

currents=linspace(start_current,finish_current,increments);

% polyfit(currents,avg_control(1,:),1)
% polyfit(currents,avg_control(2,:),1)
% polyfit(currents,avg_control(3,:),1)
% polyfit(currents,avg_propofol(1,:),1)
% polyfit(currents,avg_propofol(2,:),1)
% polyfit(currents,avg_propofol(3,:),1)

figure;plot(currents,avg_control(1,:),currents,control_slope_all_avg*currents+...
    control_yintercept_all_avg,currents,avg_propofol(1,:),currents,propofol_slope_all_avg*...
    currents+propofol_yintercept_all_avg)
title('f-I Curve of Overall Firing Rate','fontsize',14)
legend('Control','Fitted Control',[conc_propofol '\muM Propofol'],'Fitted Propofol','Location','Best')
xlabel('Current (pA)','fontsize',12)
ylabel('Firing Rate (Hz)','fontsize',12)
figure;plot(currents,avg_control(2,:),currents,control_slope_init_avg*currents+...
    control_yintercept_init_avg,currents,avg_propofol(2,:),currents,propofol_slope_init_avg*...
    currents+propofol_yintercept_init_avg)
title('f-I Curve of Initial Firing Rate','fontsize',14)
legend('Control','Fitted Control',[conc_propofol '\muM Propofol'],'Fitted Propofol','Location','Best')
xlabel('Current (pA)','fontsize',12)
ylabel('Firing Rate (Hz)','fontsize',12)
figure;plot(currents,avg_control(3,:),currents,control_slope_accom_avg*currents+...
    control_yintercept_accom_avg,currents,avg_propofol(3,:),currents,propofol_slope_accom_avg*...
    currents+propofol_yintercept_accom_avg)
title('f-I Curve of Accommodated Firing Rate','fontsize',14)
legend('Control','Fitted Control',[conc_propofol '\muM Propofol'],'Fitted Propofol','Location','Best')
xlabel('Current (pA)','fontsize',12)
ylabel('Firing Rate (Hz)','fontsize',12)