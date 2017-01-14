clear

dates={'Oct_28_11' 'Nov_10_11' 'Nov_11_11' 'Nov_18_11' 'Nov_23_11' 'Nov_25_11'};
cellnum={'A' 'A' 'A' 'A' 'A' 'A'};
start_current=10;    % Starting current in pA
finish_current=150;  % Finishing current in pA
increments=10;

celldata=zeros(numel(dates),7);

for k=1:numel(dates)
    eval(['load input_resistance_' dates{k} '_' cellnum{k} '.mat;'])
    celldata(k,:)=resistance_control(:,1)';
end

avg_control=mean(celldata);
ste_control=std(celldata)/sqrt(numel(dates));

figure;errorbar(0:10:60,avg_control,ste_control)
title('Change in Input Resistance Over Time','fontsize',14)
xlabel('Time [min]','fontsize',12)
ylabel('Membrane Resistance [M\Omega]','fontsize',12)