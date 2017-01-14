clear

dates={'Sep_28_11' 'Sep_30_11' 'Oct_05_11'};
cellnum={'A' 'B' 'B'};
conc_propofol='100'; % Concentration of propofol in uM
avg_rate_comparison=8;

eval(['load spikeform_' dates{1} '_' cellnum{1} '.mat;'])

matrixcontrol=zeros(numel(dates),numel(control_spike(1,:)));
matrixpropofol=zeros(numel(dates),numel(control_spike(1,:)));
matrixcontrol2=zeros(numel(dates),numel(control_spike(1,:)));
matrixpropofol2=zeros(numel(dates),numel(control_spike(1,:)));
ratecontrol=zeros(numel(dates),1);
ratepropofol=zeros(numel(dates),1);
ratecontrol2=zeros(numel(dates),1);
ratepropofol2=zeros(numel(dates),1);

matrixcontrol(1,:)=control_spike(1,:);
matrixcontrol2(1,:)=control_spike(2,:);
matrixpropofol(1,:)=propofol_spike(1,:);
matrixpropofol2(1,:)=propofol_spike(2,:);
ratecontrol(1)=rate(1,1);
ratecontrol2(1)=rate(1,2);
ratepropofol(1)=rate(2,1);
ratepropofol2(1)=rate(2,2);

for k=2:numel(dates)
    eval(['load spikeform_' dates{k} '_' cellnum{k} '.mat;'])
    matrixcontrol(k,:)=control_spike(1,:);
    matrixcontrol2(k,:)=control_spike(2,:);
    matrixpropofol(k,:)=propofol_spike(1,:);
    matrixpropofol2(k,:)=propofol_spike(2,:);
    ratecontrol(k)=rate(1,1);
    ratecontrol2(k)=rate(1,2);
    ratepropofol(k)=rate(2,1);
    ratepropofol2(k)=rate(2,2);
end

matrix_avg_control=zeros(1,numel(control_spike(1,:)));
matrix_avg_propofol=zeros(1,numel(control_spike(1,:)));

for k=1:numel(dates)
    if avg_rate_comparison-0.25<ratecontrol(k)<avg_rate_comparison+0.25
        if avg_rate_comparison-0.25<ratecontrol2(k)<avg_rate_comparison+0.25
            matrix_avg_control(end+1,:)=mean([matrixcontrol(k,:); matrixcontrol2(k,:)]);
        else
            matrix_avg_control(end+1,:)=matrixcontrol(k,:);
        end
    elseif avg_rate_comparison-0.25<ratecontrol2(k)<avg_rate_comparison+0.25
        matrix_avg_control(end+1,:)=matrixcontrol2(k,:);
    end

    if avg_rate_comparison-0.25<ratepropofol(k)<avg_rate_comparison+0.25
        if avg_rate_comparison-0.25<ratepropofol2(k)<avg_rate_comparison+0.25
            matrix_avg_propofol(end+1,:)=mean([matrixpropofol(k,:); matrixpropofol2(k,:)]);
        else
            matrix_avg_propofol(end+1,:)=matrixpropofol(k,:);
        end
    elseif avg_rate_comparison-0.25<ratepropofol2(k)<avg_rate_comparison+0.25
        matrix_avg_propofol(end+1,:)=matrixpropofol2(k,:);
    end
end

matrix_avg_control=matrix_avg_control(2:end,:);
matrix_avg_propofol=matrix_avg_propofol(2:end,:);

means(1,:)=mean(matrix_avg_control);
stes(1,:)=std(matrix_avg_control)/sqrt(numel(matrix_avg_control));
means(2,:)=mean(matrix_avg_propofol);
stes(2,:)=std(matrix_avg_propofol)/sqrt(numel(matrix_avg_propofol));

figure;errorbar(means(1,:)*1000,stes(1,:)*1000,'b','LineWidth',2.5)
hold on
errorbar(means(2,:)*1000,stes(2,:)*1000,'g','LineWidth',2.5)
title(['Effects of ' num2str(conc_propofol) ' \muM Propofol on the Spike Waveform at '...
    num2str(avg_rate_comparison) ' \pm 0.25 Hz'],'FontSize',16)
legend('Control','Propofol')
ylabel('Membrane Voltage [mV]','FontSize',14)
xlabel('Time [tenths of ms]','Fontsize',14)
axis([0 70 -50 50])