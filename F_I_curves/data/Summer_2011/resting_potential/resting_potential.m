function resting_potential(recdate,varargin)
if nargin>1
    cellnum=varargin{1};
else
    cellnum='A'; % Cell number
end
if nargin>2
    trials_control=varargin{2};
else
    trials_control=1;
end
if nargin>3
    trials_propofol=varargin{3};
else
    trials_propofol=1;
end
if nargin>4
    conc_propofol=varargin{4};
else
    conc_propofol='100'; % Concentration of propofol in uM
end

if trials_control>0
    eval(['load resting_potential_' recdate '_' cellnum '_control.mat'])
end
if trials_propofol>0
    eval(['load resting_potential_' recdate '_' cellnum '_' conc_propofol 'uMpropofol.mat'])
end

dataname=cell(1,trials_control+trials_propofol);
vm=cell(1,trials_control+trials_propofol);

for k=1:trials_control+trials_propofol
    dataname{k}=['resting_potential_' recdate '_' cellnum num2str(k)];
    eval(['vm_mean(k)=mean(' dataname{k} ');'])
    eval(['vm_std(k)=std(' dataname{k} ');'])
end

bargraph=[vm_mean(1) vm_std(1); vm_mean(2) vm_std(2)];

save(['resting_potential_' recdate '_' cellnum],'bargraph')

figure;bar(vm_mean*1000)
set(gca,'XTickLabel',{'Control','Propofol'},'FontSize',14)
title(['Resting Membrane Potential for Control and ' conc_propofol ' \muM Propofol'],'fontsize',14)
legend('Control','Propofol')
ylabel('Hyperpolarization Amplitude [mV]','fontsize',12)
hold on
errorbar(bargraph(:,1)*1000,bargraph(:,2)*1000,'.','LineWidth',2.5)