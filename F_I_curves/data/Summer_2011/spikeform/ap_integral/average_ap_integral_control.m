clear

dates={'Oct_05_11' 'Oct_12_11' 'Oct_12_11' 'Oct_12_11' 'Oct_12_11'...
    'Oct_13_11' 'Oct_13_11' 'Oct_13_11'};
cellnum={'A' 'A' 'B' 'C' 'D' 'B' 'C' 'D'};
conc_propofol='0'; % Concentration of propofol in uM
avg_rate_comparison=8;

matrixcontrol=zeros(numel(dates),1);
matrixpropofol=zeros(numel(dates),1);
matrixcontrol2=zeros(numel(dates),1);
matrixpropofol2=zeros(numel(dates),1);
ratecontrol=zeros(numel(dates),1);
ratepropofol=zeros(numel(dates),1);
ratecontrol2=zeros(numel(dates),1);
ratepropofol2=zeros(numel(dates),1);

for k=1:numel(dates)
    eval(['load ap_integral_' dates{k} '_' cellnum{k} '.mat;'])
    matrixcontrol(k)=bargraph(1,1);
    matrixcontrol2(k)=bargraph(3,1);
    matrixpropofol(k)=bargraph(2,1);
    matrixpropofol2(k)=bargraph(4,1);
    ratecontrol(k)=rate(1,1);
    ratecontrol2(k)=rate(1,2);
    ratepropofol(k)=rate(2,1);
    ratepropofol2(k)=rate(2,2);
end

matrix_avg_control=0;
matrix_avg_propofol=0;

for k=1:numel(dates)
    if avg_rate_comparison-0.25<ratecontrol(k)<avg_rate_comparison+0.25
        if avg_rate_comparison-0.25<ratecontrol2(k)<avg_rate_comparison+0.25
            matrix_avg_control(end+1)=mean([matrixcontrol(k) matrixcontrol2(k)]);
        else
            matrix_avg_control(end+1)=matrixcontrol(k);
        end
    elseif avg_rate_comparison-0.25<ratecontrol2(k)<avg_rate_comparison+0.25
        matrix_avg_control(end+1)=matrixcontrol2(k);
    end

    if avg_rate_comparison-0.25<ratepropofol(k)<avg_rate_comparison+0.25
        if avg_rate_comparison-0.25<ratepropofol2(k)<avg_rate_comparison+0.25
            matrix_avg_propofol(end+1)=mean([matrixpropofol(k) matrixpropofol2(k)]);
        else
            matrix_avg_propofol(end+1)=matrixpropofol(k);
        end
    elseif avg_rate_comparison-0.25<ratepropofol2(k)<avg_rate_comparison+0.25
        matrix_avg_propofol(end+1)=matrixpropofol2(k);
    end
end

matrix_avg_control=matrix_avg_control(2:end);
matrix_avg_propofol=matrix_avg_propofol(2:end);

means(1)=mean(matrix_avg_control);
stes(1)=std(matrix_avg_control)/sqrt(numel(matrix_avg_control));
means(2)=mean(matrix_avg_propofol);
stes(2)=std(matrix_avg_propofol)/sqrt(numel(matrix_avg_propofol));

[ttest_AP(1),ttest_AP(2)]=ttest(matrix_avg_control,matrix_avg_propofol);

figure;bar(means*1000/10,0.5,'b')
set(gca,'XTickLabel',{'Control','Delayed Control'},'FontSize',14)
title(['Effects of ' num2str(conc_propofol) ' \muM Propofol on AP Integral at '...
    num2str(avg_rate_comparison) ' \pm 0.25 Hz'],'fontsize',16)
ylabel('AP Integral [mV ms]','fontsize',12)
hold on
errorbar(means*1000/10,stes*1000/10,'.','LineWidth',2.5)