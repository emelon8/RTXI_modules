clear

dates={'Aug_05_11' 'Aug_05_11' 'Aug_18_11'};
cellnum={'B' 'C' 'B'};
conc_propofol='100'; % Concentration of propofol in uM
start_current=10;    % Starting current in pA
finish_current=150;  % Finishing current in pA
increments=15;

celldata=zeros(numel(dates),6,increments);
matrixnames={'control_all_' 'control_init_' 'control_accom_' 'propofol_all_'...
    'propofol_init_' 'propofol_accom_'};

for k=1:numel(dates)
    eval(['load fi_curves_' dates{k} '_' cellnum{k} '_countrate_propofol.mat;'])
    eval(['load fi_curves_' dates{k} '_' cellnum{k} '_countrate_propofol2.mat;'])
	for j=1:3;
        eval(['celldata(k,j,:)=' matrixnames{j} dates{k} '_' cellnum{k} ';'])
	    eval(['celldata(k,j+3,:)=' matrixnames{j+3} dates{k} '_' cellnum{k} ';'])
	end
end

avg_propofol=zeros(3,increments);
ste_propofol=zeros(3,increments);
avg_propofol2=zeros(3,increments);
ste_propofol2=zeros(3,increments);

for k=1:3
    for j=1:increments
        avg_propofol(k,j)=mean(celldata(:,k,j));
        ste_propofol(k,j)=std(celldata(:,k,j))/sqrt(numel(dates));
	    avg_propofol2(k,j)=mean(celldata(:,k+3,j));
        ste_propofol2(k,j)=std(celldata(:,k+3,j))/sqrt(numel(dates));
	end
end

% Average the slopes of the different cells
for k=1:numel(dates)
    eval(['propofol_slopes_all(k)=control_pf_all_' dates{k} '_' cellnum{k} '_countrate(1);'])
    eval(['propofol_yintercept_all(k)=control_pf_all_' dates{k} '_' cellnum{k} '_countrate(2);'])
    eval(['propofol_slopes_init(k)=control_pf_init_' dates{k} '_' cellnum{k} '_countrate(1);'])
    eval(['propofol_yintercept_init(k)=control_pf_init_' dates{k} '_' cellnum{k} '_countrate(2);'])
    eval(['propofol_slopes_accom(k)=control_pf_accom_' dates{k} '_' cellnum{k} '_countrate(1);'])
    eval(['propofol_yintercept_accom(k)=control_pf_accom_' dates{k} '_' cellnum{k} '_countrate(2);'])
    
    eval(['propofol2_slopes_all(k)=propofol_pf_all_' dates{k} '_' cellnum{k} '_countrate(1);'])
    eval(['propofol2_yintercept_all(k)=propofol_pf_all_' dates{k} '_' cellnum{k} '_countrate(2);'])
    eval(['propofol2_slopes_init(k)=propofol_pf_init_' dates{k} '_' cellnum{k} '_countrate(1);'])
    eval(['propofol2_yintercept_init(k)=propofol_pf_init_' dates{k} '_' cellnum{k} '_countrate(2);'])
    eval(['propofol2_slopes_accom(k)=propofol_pf_accom_' dates{k} '_' cellnum{k} '_countrate(1);'])
    eval(['propofol2_yintercept_accom(k)=propofol_pf_accom_' dates{k} '_' cellnum{k} '_countrate(2);'])
end

[ttest_slope_all(1),ttest_slope_all(2)]=ttest(propofol_slopes_all,propofol2_slopes_all);
[ttest_slope_init(1),ttest_slope_init(2)]=ttest(propofol_slopes_init,propofol2_slopes_init);
[ttest_slope_accom(1),ttest_slope_accom(2)]=ttest(propofol_slopes_accom,propofol2_slopes_accom);

slope_all_avg(1)=mean(propofol_slopes_all);
slope_all_ste(1)=std(propofol_slopes_all)/sqrt(numel(dates));

yintercept_all_avg(1)=mean(propofol_yintercept_all);
yintercept_all_ste(1)=std(propofol_yintercept_all)/sqrt(numel(dates));

slope_init_avg(1)=mean(propofol_slopes_init);
slope_init_ste(1)=std(propofol_slopes_init)/sqrt(numel(dates));

yintercept_init_avg(1)=mean(propofol_yintercept_init);
yintercept_init_ste(1)=std(propofol_yintercept_init)/sqrt(numel(dates));

slope_accom_avg(1)=mean(propofol_slopes_accom);
slope_accom_ste(1)=std(propofol_slopes_accom)/sqrt(numel(dates));

yintercept_accom_avg(1)=mean(propofol_yintercept_accom);
yintercept_accom_ste(1)=std(propofol_yintercept_accom)/sqrt(numel(dates));

slope_all_avg(2)=mean(propofol2_slopes_all);
slope_all_ste(2)=std(propofol2_slopes_all)/sqrt(numel(dates));

yintercept_all_avg(2)=mean(propofol2_yintercept_all);
yintercept_all_ste(2)=std(propofol2_yintercept_all)/sqrt(numel(dates));

slope_init_avg(2)=mean(propofol2_slopes_init);
slope_init_ste(2)=std(propofol2_slopes_init)/sqrt(numel(dates));

yintercept_init_avg(2)=mean(propofol2_yintercept_init);
yintercept_init_ste(2)=std(propofol2_yintercept_init)/sqrt(numel(dates));

slope_accom_avg(2)=mean(propofol2_slopes_accom);
slope_accom_ste(2)=std(propofol2_slopes_accom)/sqrt(numel(dates));

yintercept_accom_avg(2)=mean(propofol2_yintercept_accom);
yintercept_accom_ste(2)=std(propofol2_yintercept_accom)/sqrt(numel(dates));

currents=linspace(start_current,finish_current,increments);

% polyfit(currents,avg_propofol(1,:),1)
% polyfit(currents,avg_propofol(2,:),1)
% polyfit(currents,avg_propofol(3,:),1)
% polyfit(currents,avg_propofol2(1,:),1)
% polyfit(currents,avg_propofol2(2,:),1)
% polyfit(currents,avg_propofol2(3,:),1)

figure;errorbar(currents,avg_propofol(1,:),ste_propofol(1,:),'ob','LineWidth',2)
hold on
errorbar(currents,avg_propofol2(1,:),ste_propofol2(1,:),'or','LineWidth',2)
hold on
plot(currents,slope_all_avg(1)*currents+yintercept_all_avg(1),currents,...
    slope_all_avg(2)*currents+yintercept_all_avg(2),'r','LineWidth',2)
title('f-I Curve of Overall Firing Rate','fontsize',14)
legend([conc_propofol '\muM Propofol \pm SE'],[conc_propofol '\muM Propofol2 \pm SE'],...
    'Fitted Propofol','Fitted Propofol2','Location','Best')
xlabel('Current [pA]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)
axis([0 160 0 12])
figure;errorbar(currents,avg_propofol(2,:),ste_propofol(2,:),'ob','LineWidth',2)
hold on
errorbar(currents,avg_propofol2(2,:),ste_propofol2(2,:),'or','LineWidth',2)
hold on
plot(currents,slope_init_avg(1)*currents+yintercept_init_avg(1),currents,...
    slope_init_avg(2)*currents+yintercept_init_avg(2),'r','LineWidth',2)
title('f-I Curve of Initial Firing Rate','fontsize',14)
legend([conc_propofol '\muM Propofol \pm SE'],[conc_propofol '\muM Propofol2 \pm SE'],...
    'Fitted Propofol','Fitted Propofol2','Location','Best')
xlabel('Current [pA]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)
axis([0 160 0 25])
figure;errorbar(currents,avg_propofol(3,:),ste_propofol(3,:),'ob','LineWidth',2)
hold on
errorbar(currents,avg_propofol2(3,:),ste_propofol2(3,:),'or','LineWidth',2)
hold on
plot(currents,slope_accom_avg(1)*currents+yintercept_accom_avg(1),currents,...
    slope_accom_avg(2)*currents+yintercept_accom_avg(2),'r','LineWidth',2)
title('f-I Curve of Accommodated Firing Rate','fontsize',14)
legend([conc_propofol '\muM Propofol \pm SE'],[conc_propofol '\muM Propofol2 \pm SE'],...
    'Fitted Propofol','Fitted Propofol2','Location','Best')
xlabel('Current [pA]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)
axis([0 160 0 12])