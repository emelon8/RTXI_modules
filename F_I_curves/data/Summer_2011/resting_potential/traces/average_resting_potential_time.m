clear

dates={'Oct_28_11' 'Nov_10_11' 'Nov_11_11' 'Nov_18_11' 'Nov_23_11' 'Nov_25_11'};
cellnum={'A' 'A' 'A' 'A' 'A' 'A'};
start_current=10;    % Starting current in pA
finish_current=150;  % Finishing current in pA
increments=10;

celldata=zeros(numel(dates),7);

for k=1:numel(dates)
    eval(['load resting_potential_' dates{k} '_' cellnum{k} '_control.mat;'])
    for j=1:7
        eval(['celldata(k,j)=mean(resting_potential_' dates{k} '_' cellnum{k} num2str(j) '(:,2))*1000;'])
    end
end

avg_control=mean(celldata);
ste_control=std(celldata)/sqrt(numel(dates));

figure;errorbar(0:10:60,avg_control,ste_control)
title('Change in Resting Membrane Potential Over Time','fontsize',14)
xlabel('Time [min]','fontsize',12)
ylabel('Membrane Potential [mV]','fontsize',12)