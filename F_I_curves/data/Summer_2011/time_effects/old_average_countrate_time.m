clear

dates={'Oct_28_11' 'Nov_10_11' 'Nov_11_11'};
cellnum={'A' 'A' 'A'};
start_current=10;    % Starting current in pA
finish_current=150;  % Finishing current in pA
increments=10;

celldata=zeros(numel(dates),3,increments);
matrixnames={'rate_all_' 'rate_init_' 'rate_accom_'};

for k=1:numel(dates)
    eval(['load fi_curves_' dates{k} '_' cellnum{k} '_countrate_control.mat;'])
	for j=1:3;
        eval(['celldata(k,j,:)=' matrixnames{j} dates{k} '_' cellnum{k} ';'])
	end
end

avg_control=zeros(3,increments);
ste_control=zeros(3,increments);

for k=1:3
    for j=1:increments
        avg_control(k,j)=mean(celldata(:,k,j));
        ste_control(k,j)=std(celldata(:,k,j))/sqrt(numel(dates));
    end
end

% Average the slopes of the different cells
for j=1:7;
    for k=1:numel(dates)
        eval(['control_slopes_all(k,j)=control_pf_all_' dates{k} '_' cellnum{k} '_countrate(j,1);'])
        eval(['control_yintercept_all(k,j)=control_pf_all_' dates{k} '_' cellnum{k} '_countrate(j,2);'])
        eval(['control_slopes_init(k,j)=control_pf_init_' dates{k} '_' cellnum{k} '_countrate(j,1);'])
        eval(['control_yintercept_init(k,j)=control_pf_init_' dates{k} '_' cellnum{k} '_countrate(j,2);'])
        eval(['control_slopes_accom(k,j)=control_pf_accom_' dates{k} '_' cellnum{k} '_countrate(j,1);'])
        eval(['control_yintercept_accom(k,j)=control_pf_accom_' dates{k} '_' cellnum{k} '_countrate(j,2);'])
    end
    
    slope_all_avg(j)=mean(control_slopes_all(:,j));
    slope_all_ste(j)=std(control_slopes_all(:,j))/sqrt(numel(dates));
    
    yintercept_all_avg(j)=mean(control_yintercept_all(:,j));
    yintercept_all_ste(j)=std(control_yintercept_all(:,j))/sqrt(numel(dates));
    
    slope_init_avg(j)=mean(control_slopes_init(:,j));
    slope_init_ste(j)=std(control_slopes_init(:,j))/sqrt(numel(dates));
    
    yintercept_init_avg(j)=mean(control_yintercept_init(:,j));
    yintercept_init_ste(j)=std(control_yintercept_init(:,j))/sqrt(numel(dates));
    
    slope_accom_avg(j)=mean(control_slopes_accom(:,j));
    slope_accom_ste(j)=std(control_slopes_accom(:,j))/sqrt(numel(dates));
    
    yintercept_accom_avg(j)=mean(control_yintercept_accom(:,j));
    yintercept_accom_ste(j)=std(control_yintercept_accom(:,j))/sqrt(numel(dates));
end

% polyfit(currents,avg_control(1,:),1)
% polyfit(currents,avg_control(2,:),1)
% polyfit(currents,avg_control(3,:),1)

errorbar(0:10:60,slope_all_avg,slope_all_ste)
hold on
errorbar(0:10:60,slope_init_avg,slope_init_ste)
hold on
errorbar(0:10:60,slope_accom_avg,slope_accom_ste)
title('Change in Gain of f-I Curves Over Time','fontsize',14)
legend('Overall Gain \pm SE','Initial Gain \pm SE','Steady-State Gain \pm SE',Location','Best')
xlabel('Time [min]','fontsize',12)
ylabel('Gain [Hz/pA]','fontsize',12)