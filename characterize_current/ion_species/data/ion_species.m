function [mean_starting,max_step,step_voltages,linfit,xintercept]=...
    ion_species(module,recdate,cellnum,trial,prestep_V,prestep_t,starting_step_V,...
    finishing_step_V,increments,step_t,pause_t,sample_rate,resistance_increments_less_than_increments,measure_t)

warning off all

load([module '_' recdate '_' cellnum])

eval(['trialdata=' module '_' recdate '_' cellnum num2str(trial) ';'])

mean_starting=mean(trialdata(1:pause_t*sample_rate,1))*1e12;

delta_V=(finishing_step_V-starting_step_V)/(increments-1); % in mV
step_voltages=starting_step_V:delta_V:finishing_step_V;

for k=1:increments
    max_step(k)=max(trialdata((k*(pause_t+prestep_t+step_t)-...
        step_t)*sample_rate+9:...
        k*(pause_t+prestep_t+step_t)*sample_rate-1,1));
    snippet_step(k,:)=trialdata((k*(pause_t+prestep_t+step_t)-...
        step_t)*sample_rate:...
        k*(pause_t+prestep_t+step_t)*sample_rate-1,1)*1e12; % pA
    zeroed_snippet_step(k,:)=snippet_step(k,:)-mean_starting;
%     % zero out the baseline current by taking the average current from 4-5
%     % seconds after the tail current. Only do this if you're also
%     % deleting the leak resistance subtraction or it will double count it
%     zeroed_snippet_step(k,:)=snippet_step(k,:)-mean(snippet_step(k,40000:50000));
%     zeroed_snippet_step(k,:)=snippet_step(k,:);
    mean_snippet_step(k)=mean(zeroed_snippet_step(k,step_t/2*sample_rate:end));
%     snippet_step2(k,:)=trialdata((k-1)*(pause_t+prestep_t+step_t)*sample_rate+1:...
%         k*(pause_t+prestep_t+step_t)*sample_rate-1,2)*1e3-80;
%     snippet_pause(k,:)=trialdata(((k-1)*(pause_t+prestep_t+step_t))*sample_rate:...
%         (k*(pause_t+prestep_t+step_t)-(prestep_t+step_t))*sample_rate-1,1);
%     meanpause(k)=mean(snippet_pause(k,:));
    iv(k)=mean(zeroed_snippet_step(k,measure_t*sample_rate-9:measure_t*sample_rate+10)); %default measure_t=0.005
%     figure(1);hold on;plot(1/sample_rate:1/sample_rate:numel(zeroed_snippet_step(k,:))/sample_rate,zeroed_snippet_step(k,:),'Color',[1/sqrt(k) 0 1/sqrt(k)])
%     figure(2);hold on;plot(1/sample_rate:1/sample_rate:numel(snippet_step2(k,:))/sample_rate,snippet_step2(k,:),'Color',[1/sqrt(k) 0 1/sqrt(k)])
end

%can add -1 or whatever after end in order to cut off bad steps
leak_resistance=polyfit(step_voltages(1:increments-resistance_increments_less_than_increments),...
    mean_snippet_step(1:increments-resistance_increments_less_than_increments),1);

% % Use for Mar_03_14_A1
% leak_resistance=polyfit(step_voltages([1:6 8:11]),mean_snippet_step([1:6 8:11]),1);

iv_noleak=iv-step_voltages/leak_resistance(1);

pf=polyfit(step_voltages,iv_noleak,1);

% % Use for Mar_03_14_A1
% pf=polyfit(step_voltages([1:6 8:11]),iv_noleak([1:6 8:11]),1);

xintercept=-pf(2)/pf(1);

linfit=polyval(pf,step_voltages);

% Calculate the R^2 value for linear fit
resid_lin=iv_noleak-linfit;
SSresid_lin=sum(resid_lin.^2);
SStotal_lin=sum((iv_noleak-mean(iv_noleak)).^2);
rsq_lin=1-SSresid_lin/SStotal_lin;

% figure(1);title('Reversal Potential')
% xlabel('Time (sec)')
% ylabel('Current (pA)')

% figure(2);title('Reveral Potential Voltage Steps')
% xlabel('Time (sec)')
% ylabel('Voltage (mV)')

% figure(3);plot([step_voltages;step_voltages]',[iv_noleak;linfit]')
% legend('Raw Values',['Linear Fit; R^2 = ' num2str(rsq_lin)])
% hold on;plot(step_voltages,iv,'r')
% title('I-V Curve')
% xlabel('Voltage (mV)')
% ylabel('Current (pA)')

% figure(2);plot(step_voltages,max_step*1e12)