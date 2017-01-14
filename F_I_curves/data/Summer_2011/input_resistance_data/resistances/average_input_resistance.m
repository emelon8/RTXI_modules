clear

dates={'Sep_28_11' 'Sep_28_11' 'Sep_30_11' 'Sep_30_11' 'Oct_03_11'};
cellnum={'A' 'B' 'A' 'B' 'C'};
conc_propofol='100'; % Concentration of propofol in uM

eval(['load input_resistance_' dates{1} '_' cellnum{1} '.mat;'])

matrixcontrol=zeros(1,numel(dates));
matrixpropofol=zeros(1,numel(dates));

matrixcontrol(1)=resistance_control(1);
matrixpropofol(1)=resistance_propofol(1);

for k=2:numel(dates)
    eval(['load input_resistance_' dates{k} '_' cellnum{k} '.mat;'])
    matrixcontrol(k)=resistance_control(1);
    matrixpropofol(k)=resistance_propofol(1);
end

means(1)=mean(matrixcontrol);
stes(1)=std(matrixcontrol)/sqrt(numel(matrixcontrol));
means(2)=mean(matrixpropofol);
stes(2)=std(matrixpropofol)/sqrt(numel(matrixpropofol));

[ttest_resistance(1),ttest_resistance(2)]=ttest(matrixcontrol,matrixpropofol);

% Bargraph

% bargraph=[mean(control_slopes_accom) std(control_slopes_accom)/sqrt(numel(control_slopes_accom));...
%     mean(propofol_slopes_accom) std(propofol_slopes_accom)/sqrt(numel(propofol_slopes_accom))];

figure;bar(means,0.5,'b')
set(gca,'XTickLabel',{'Control', 'Propofol'},'FontSize',14)
title(['Effects of ' num2str(conc_propofol) ' \muM Propofol on Input Resistance'],...
    'FontSize',16)
ylabel('Input Resistance [M\Omega]','FontSize',14)
hold on
errorbar(means,stes,'.b','LineWidth',2.5)