clear

dates={'Oct_28_11' 'Nov_10_11' 'Nov_11_11' 'Nov_18_11' 'Nov_23_11' 'Nov_25_11'};
cellnum={'A' 'A' 'A' 'A' 'A' 'A'};
start_current=10;    % Starting current in pA
finish_current=150;  % Finishing current in pA
increments=10;

celldata=zeros(numel(dates),3,7);
matrixnames={'control_pf_all_' 'control_pf_init_' 'control_pf_accom_'};

for k=1:numel(dates)
    eval(['load fi_curves_' dates{k} '_' cellnum{k} '_countrate_control.mat;'])
	for j=1:3;
        eval(['celldata(k,j,:)=' matrixnames{j} dates{k} '_' cellnum{k} '_countrate(:,1);'])
	end
end

avg_control=reshape(mean(celldata),3,7);
ste_control=reshape(std(celldata)/sqrt(numel(dates)),3,7);

figure;errorbar([0:10:60;0:10:60;0:10:60]',avg_control',ste_control')
title('Change in Gain of f-I Curves Over Time','fontsize',14)
legend({'Overall Gain \pm SE';'Initial Gain \pm SE';'Steady-State Gain \pm SE'},'Location','Best')
xlabel('Time [min]','fontsize',12)
ylabel('Gain [Hz/pA]','fontsize',12)