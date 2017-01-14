clear

dates={'Oct_03_11' 'Oct_05_11' 'Oct_12_11' 'Oct_12_11' 'Oct_12_11' 'Oct_12_11'...
    'Oct_13_11' 'Oct_13_11' 'Oct_13_11'};
cellnum={'A' 'A' 'A' 'B' 'C' 'D' 'A' 'B' 'D'};

eval(['load input_resistance_' dates{1} '_' cellnum{1} '.mat;'])

matrixcontrol=zeros(1,numel(dates));
matrix0uMpropofol=zeros(1,numel(dates));

matrixcontrol(1)=resistance_control(1);
matrix0uMpropofol(1)=resistance_propofol(1);

for k=2:numel(dates)
    eval(['load input_resistance_' dates{k} '_' cellnum{k} '.mat;'])
    matrixcontrol(k)=resistance_control(1);
    matrix0uMpropofol(k)=resistance_propofol(1);
end

means(1)=mean(matrixcontrol);
stes(1)=std(matrixcontrol)/sqrt(numel(matrixcontrol));
means(2)=mean(matrix0uMpropofol);
stes(2)=std(matrix0uMpropofol)/sqrt(numel(matrix0uMpropofol));

[ttest_resistance(1),ttest_resistance(2)]=ttest(matrixcontrol,matrix0uMpropofol);

% Bargraph

% bargraph=[mean(control_slopes_accom) std(control_slopes_accom)/sqrt(numel(control_slopes_accom));...
%     mean(propofol_slopes_accom) std(propofol_slopes_accom)/sqrt(numel(propofol_slopes_accom))];

figure;bar(means,0.5,'b')
set(gca,'XTickLabel',{'Control', 'Delayed Control'},'FontSize',14)
title('Effects of Delay on Input Resistance','FontSize',16)
ylabel('Input Resistance [M\Omega]','FontSize',14)
hold on
errorbar(means,stes,'.b','LineWidth',2.5)