function [mean_starting,meanactivation,mean_max_current_activation,mean_max_activation,...
    mean_max_current_inactivation,mean_max_inactivation,normalized_activation_temp,normalized_inactivation_temp,...
    activation_voltages,baselinecurrent,conductancedata,expf_activation,expf_inactivation,rsq_activation_sig,rsq_inactivation_sig...
    sigslope_normalized_activation,sigslope_normalized_inactivation,rsq_normalized_activation_sig,rsq_normalized_inactivation_sig...
    nlf_normalized_activation,nlf_normalized_inactivation,min_snippet_activation,max_snippet_activation,min_snippet_inactivation,max_snippet_inactivation]=... %,tau_activation,dexpf_inactivation
    activation_inactivation(module,recdate,cellnum,trial,activation_step_starting_V,...
    activation_step_finishing_V,increments,activation_step_t,inactivation_step_V,...
    inactivation_step_t,pause_t,EK,activation_begintimes,sample_rate,leaksteps,...
    expf_activation_parameters,expf_inactivation_parameters,dexpf_inactivation_parameters)

warning off all

load([module '_' recdate '_' cellnum])

eval(['trialdata=' module '_' recdate '_' cellnum num2str(trial) ';'])

mean_starting=mean(trialdata(1:pause_t*sample_rate,1));

delta_V=(activation_step_finishing_V-activation_step_starting_V)/(increments-1); % in mV
activation_voltages=activation_step_starting_V:delta_V:activation_step_finishing_V;
conductancedata=trialdata; %conductance values are not found during pause periods

for k=1:increments
    activation_step_start_t(k)=(k*(pause_t+activation_step_t+inactivation_step_t)-(activation_step_t+inactivation_step_t))*sample_rate;
    inactivation_step_start_t(k)=(k*(pause_t+activation_step_t+inactivation_step_t)-inactivation_step_t)*sample_rate;
    inactivation_step_finish_t(k)=k*(pause_t+activation_step_t+inactivation_step_t)*sample_rate;
    
    baselinecurrent(k)=mean(trialdata((k*(pause_t+activation_step_t+inactivation_step_t)-...
        (activation_step_t+inactivation_step_t)-(pause_t/10))*sample_rate:activation_step_start_t(k)-1,1));
    currentzeroeddata(activation_step_start_t(k):inactivation_step_start_t(k)-1,1)=...
        trialdata(activation_step_start_t(k):inactivation_step_start_t(k)-1,1)-baselinecurrent(k);
    meanactivation(k)=mean(currentzeroeddata(activation_step_start_t(k):inactivation_step_start_t(k)-1,1));
    currentzeroeddata(inactivation_step_start_t(k):inactivation_step_finish_t(k)-1,1)=...
        trialdata(inactivation_step_start_t(k):inactivation_step_finish_t(k)-1,1)-baselinecurrent(k);
    
% % If you want to remove the leak manually
% % Subtracts leak off by plotting the I-V curve for the first few steps,
% % and then extrapolating the current at higher voltages
% end
% leak_resistance=polyfit(activation_voltages(1:leaksteps),meanactivation(1:leaksteps)*1e12,1);
% for k=1:increments
%     currentzeroeddata(activation_step_start_t(k):inactivation_step_start_t(k)-1,1)=...
%         currentzeroeddata(activation_step_start_t(k):inactivation_step_start_t(k)-1,1)-(activation_voltages(k)/...
%         leak_resistance(1))*1e-12;
%     currentzeroeddata(inactivation_step_start_t(k):inactivation_step_finish_t(k)-1,1)=...
%         currentzeroeddata(inactivation_step_start_t(k):inactivation_step_finish_t(k)-1,1)-(inactivation_step_V/...
%         leak_resistance(1))*1e-12;
% % end manual leak subtraction
    
    conductancedata(activation_step_start_t(k):inactivation_step_start_t(k)-1,1)=...
        currentzeroeddata(activation_step_start_t(k):inactivation_step_start_t(k)-1,1)/((activation_voltages(k)-EK)*1e-3);
    conductancedata(inactivation_step_start_t(k):inactivation_step_finish_t(k)-1,1)=...
        currentzeroeddata(inactivation_step_start_t(k):inactivation_step_finish_t(k)-1,1)/((inactivation_step_V-EK)*1e-3);
    max_current_activation(k)=max(currentzeroeddata(activation_step_start_t(k)+activation_begintimes(k)*sample_rate:...
        inactivation_step_start_t(k)-1,1));
    mean_max_current_activation(k)=mean(currentzeroeddata(activation_step_start_t(k)+activation_begintimes(k)*sample_rate-1+...
        find(currentzeroeddata(activation_step_start_t(k)+activation_begintimes(k)*sample_rate:...
        inactivation_step_start_t(k)-1,1)==max_current_activation(k),1)-4:...
        activation_step_start_t(k)+activation_begintimes(k)*sample_rate-1+...
        find(currentzeroeddata(activation_step_start_t(k)+activation_begintimes(k)*sample_rate:...
        inactivation_step_start_t(k)-1,1)==max_current_activation(k),1)+5,1));
    max_activation(k)=max(conductancedata(activation_step_start_t(k)+activation_begintimes(k)*sample_rate:...
        inactivation_step_start_t(k)-1,1));
    mean_max_activation(k)=mean(conductancedata(activation_step_start_t(k)+activation_begintimes(k)*sample_rate-1+...
        find(conductancedata(activation_step_start_t(k)+activation_begintimes(k)*sample_rate:...
        inactivation_step_start_t(k)-1,1)==max_activation(k),1)-4:activation_step_start_t(k)+activation_begintimes(k)*sample_rate-1+...
        find(conductancedata(activation_step_start_t(k)+activation_begintimes(k)*sample_rate:...
        inactivation_step_start_t(k)-1,1)==max_activation(k),1)+5,1));
    snippet_activation(k,:)=currentzeroeddata(activation_step_start_t(k):inactivation_step_start_t(k)-1,1);
    snippet_activation2(k,:)=conductancedata((k-1)*(pause_t+activation_step_t+inactivation_step_t)*sample_rate+1:...
        inactivation_step_finish_t(k)-1,2)*1e3-80;
    max_current_inactivation(k)=max(currentzeroeddata(inactivation_step_start_t(k)+49:inactivation_step_finish_t(k)-1,1));
    mean_max_current_inactivation(k)=mean(currentzeroeddata(inactivation_step_start_t(k)+49-1+...
        find(currentzeroeddata(inactivation_step_start_t(k)+49:...
        inactivation_step_finish_t(k)-1,1)==max_current_inactivation(k),1)-4:...
        inactivation_step_start_t(k)+49-1+...
        find(currentzeroeddata(inactivation_step_start_t(k)+49:...
        inactivation_step_finish_t(k)-1,1)==max_current_inactivation(k),1)+5,1));
    max_inactivation(k)=max(conductancedata(inactivation_step_start_t(k)+49:inactivation_step_finish_t(k)-1,1));
    mean_max_inactivation(k)=mean(conductancedata(inactivation_step_start_t(k)+49-1+...
        find(conductancedata(inactivation_step_start_t(k)+49:...
        inactivation_step_finish_t(k)-1,1)==max_inactivation(k),1)-4:...
        inactivation_step_start_t(k)+49-1+...
        find(conductancedata(inactivation_step_start_t(k)+49:...
        inactivation_step_finish_t(k)-1,1)==max_inactivation(k),1)-4,1));
    snippet_inactivation(k,:)=currentzeroeddata(inactivation_step_start_t(k):inactivation_step_finish_t(k)-1,1);
    snippet_pause(k,:)=trialdata((k-1)*(pause_t+activation_step_t+inactivation_step_t)*sample_rate+1:activation_step_start_t(k)-1,1);
    
    min_snippet_activation(k)=min(snippet_activation(k,:))*1e12;
    max_snippet_activation(k)=max(snippet_activation(k,:))*1e12;
    min_snippet_inactivation(k)=min(snippet_inactivation(k,:))*1e12;
    max_snippet_inactivation(k)=max(snippet_inactivation(k,:))*1e12;
    
    % Find the time constants for activation
    if k>6
        peak{k}=find(snippet_activation(k,activation_begintimes(k)*sample_rate:end)==max(snippet_activation(k,activation_begintimes(k)*sample_rate:end)));
        risetime{k}=activation_begintimes(k):1/sample_rate:...
            activation_begintimes(k)+(peak{k}-1)/sample_rate;
        expf_activation(k,:)=nlinfit(risetime{k},snippet_activation(k,activation_begintimes(k)*sample_rate:activation_begintimes(k)*sample_rate+peak{k}-1)*1e12,...
            'activation_expFun',expf_activation_parameters);
%         figure(1);hold on;plot(1/sample_rate:1/sample_rate:numel(snippet_activation(k,:))/sample_rate,snippet_activation(k,:)*1e12,'Color',[1/sqrt(k) 0 1/sqrt(k)])
%         figure(1);hold on;plot(10/sample_rate:10/sample_rate:numel(snippet_activation(k,:))/sample_rate,snippet_activation(k,10:10:end)*1e12,'Color',[k/28 k/28 k/28]) %plots it at a lower sample rate
%         figure(2);hold on;plot(10/sample_rate:10/sample_rate:numel(snippet_inactivation(k,:))/sample_rate,snippet_inactivation(k,10:10:end)*1e12,'Color',[k/28 k/28 k/28]) %plots it at a lower sample rate
%         figure(10);hold on;plot(1/sample_rate:1/sample_rate:numel(snippet_activation2(k,:))/sample_rate,snippet_activation2(k,:),'Color',[k/28 k/28 k/28])
%         figure(1);hold on;plot(risetime{k},activation_expFun(expf_activation(k,:),risetime{k}),'g','LineWidth',2)
        
        sigfit_activation=activation_expFun(expf_activation(k,:),risetime{k});
        sigslope_activation=max(diff(sigfit_activation));
%         
%         % Calculate the R^2 value for sigmoidal fit
        resid_activation_sig=snippet_activation(k,activation_begintimes(k)*sample_rate:activation_begintimes(k)*sample_rate+peak{k}-1)*1e12-sigfit_activation;
        SSresid_activation_sig=sum(resid_activation_sig.^2);
        SStotal_activation_sig=(length(snippet_activation(k,activation_begintimes(k)*sample_rate:activation_begintimes(k)*sample_rate+peak{k}-1)*1e12)-1)*var(snippet_activation(k,activation_begintimes(k)*sample_rate:activation_begintimes(k)*sample_rate+peak{k}-1)*1e12);
        rsq_activation_sig(k-6)=1-SSresid_activation_sig/SStotal_activation_sig;
        
        falltime{k}=activation_begintimes(k)+(peak{k}-1)/sample_rate:1/sample_rate:activation_step_t;
        
        fall_delay=1/sample_rate; % in seconds (e.g. 2)
        if falltime{k}(end)-falltime{k}(1)<fall_delay
            fall_delay=1/sample_rate;
        end
        
        expf_inactivation(k,:)=nlinfit(falltime{k}(fall_delay*sample_rate:end),snippet_activation(k,activation_begintimes(k)*sample_rate+peak{k}+fall_delay*sample_rate-1-1:end)*1e12,...
            'inactivation_expFun',expf_inactivation_parameters);
%         figure(1);hold on;plot(falltime{k}(fall_delay*sample_rate:end),inactivation_expFun(expf_inactivation(k,:),falltime{k}(fall_delay*sample_rate:end)),'b','LineWidth',2)
        
        sigfit_inactivation=inactivation_expFun(expf_inactivation(k,:),falltime{k}(fall_delay*sample_rate:end));

%         dexpf_inactivation(k,:)=nlinfit(falltime{k}(fall_delay*sample_rate:end),snippet_activation(k,activation_begintimes(k)*sample_rate+peak{k}+fall_delay*sample_rate-1-1:end)*1e12,...
%             'inactivation_dexpFun',dexpf_inactivation_parameters);
%         figure(1);hold on;plot(falltime{k}(fall_delay*sample_rate:end),inactivation_dexpFun(dexpf_inactivation(k,:),falltime{k}(fall_delay*sample_rate:end)),'b','LineWidth',2)
%         
%         sigfit_inactivation=inactivation_dexpFun(dexpf_inactivation(k,:),falltime{k});
        sigslope_inactivation=min(diff(sigfit_inactivation));
        
        % Calculate the R^2 value for sigmoidal fit
        resid_inactivation_sig=snippet_activation(k,activation_begintimes(k)*sample_rate+peak{k}+fall_delay*sample_rate-1-1:end)*1e12-sigfit_inactivation;
        SSresid_inactivation_sig=sum(resid_inactivation_sig.^2);
        SStotal_inactivation_sig=(length(snippet_activation(k,activation_begintimes(k)*sample_rate+peak{k}+fall_delay*sample_rate-1-1:end)*1e12)-1)*var(snippet_activation(k,activation_begintimes(k)*sample_rate+peak{k}+fall_delay*sample_rate-1-1:end)*1e12);
        rsq_inactivation_sig(k-6)=1-SSresid_inactivation_sig/SStotal_inactivation_sig;
        
%         figure(2);hold on;plot(1/sample_rate:1/sample_rate:numel(snippet_inactivation(k,:))/sample_rate,snippet_inactivation(k,:)*1e12,'Color',[1/sqrt(k) 0 1/sqrt(k)])
%         figure(3);hold on;plot(1/sample_rate:1/sample_rate:numel(snippet_pause(k,:))/sample_rate,snippet_pause(k,:)*1e12,'Color',[1/sqrt(k) 0 1/sqrt(k)])
%         figure(5);hold on;plot(activation_voltages(k),expf_activation(k,4),'k*')
%         figure(6);hold on;plot(activation_voltages(k),dexpf_inactivation(k,4),'k*')
%         figure(6);hold on;plot(activation_voltages(k),dexpf_inactivation(k,7),'b*')
    end
end

%fit an exponential to the activation time constants
% tau_activation=nlinfit(activation_voltages(13:end)',expf_activation(13:end,4),'expFun',[0 1e-3 1 10]);
% figure(5);hold on;plot(activation_voltages(13:end),expFun(tau_activation,activation_voltages(13:end)),'r','LineWidth',2)

normalized_activation_temp=mean_max_activation/mean_max_activation(find(activation_voltages==0)); % alternatively, max(max_activation(end-6:end));
normalized_inactivation_temp=mean_max_inactivation/max(mean_max_inactivation(1:6));

voltages_activation=activation_voltages(9:end);
voltages_inactivation=activation_voltages(1:13);
normalized_activation=normalized_activation_temp(9:end);
normalized_inactivation=normalized_inactivation_temp(1:13);

nlf_normalized_activation=nlinfit(voltages_activation(1:13),normalized_activation(1:13),'sigFun',[1.1456 -1.1261 24.6122 8.6676]);
nlf_normalized_inactivation=nlinfit(voltages_inactivation,normalized_inactivation,'sigFun',[0 1 -70 -30]);

sigfit_normalized_activation=sigFun(nlf_normalized_activation,voltages_activation(1:13));
sigfit_normalized_inactivation=sigFun(nlf_normalized_inactivation,voltages_inactivation);

sigslope_normalized_activation=max(diff(sigfit_normalized_activation));
sigslope_normalized_inactivation=min(diff(sigfit_normalized_inactivation));

% Calculate the R^2 value for sigmoidal fit
resid_normalized_activation_sig=normalized_activation(1:13)-sigfit_normalized_activation;
resid_normalized_inactivation_sig=normalized_inactivation-sigfit_normalized_inactivation;

SSresid_normalized_activation_sig=sum(resid_normalized_activation_sig.^2);
SSresid_normalized_inactivation_sig=sum(resid_normalized_inactivation_sig.^2);

SStotal_normalized_activation_sig=(length(normalized_activation(1:13))-1)*var(normalized_activation(1:13));
SStotal_normalized_inactivation_sig=(length(normalized_inactivation)-1)*var(normalized_inactivation);

rsq_normalized_activation_sig=1-SSresid_normalized_activation_sig/SStotal_normalized_activation_sig;
rsq_normalized_inactivation_sig=1-SSresid_normalized_inactivation_sig/SStotal_normalized_inactivation_sig;

figure;plot(voltages_activation(1:13),normalized_activation(1:13))
hold on;plot(voltages_activation(1:13),sigfit_normalized_activation,'r')
figure;plot(voltages_inactivation,normalized_inactivation)
hold on;plot(voltages_inactivation,sigfit_normalized_inactivation,'r')

% figure(7);plot(activation_voltages,mean_max_current_activation)
% hold on;plot(activation_voltages,mean_max_current_inactivation,'r')

% for h=7:numel(dexpf_inactivation(:,5))
%     if abs(dexpf_inactivation(h,2))>abs(dexpf_inactivation(h,5))
%         dexpf_inactivation_all_large(h)=dexpf_inactivation(h,4);
%         dexpf_inactivation_all_small(h)=dexpf_inactivation(h,7);
%         cool(h)=dexpf_inactivation(h,2)/dexpf_inactivation(h,5);
%     else
%         dexpf_inactivation_all_large(h)=dexpf_inactivation(h,7);
%         dexpf_inactivation_all_small(h)=dexpf_inactivation(h,4);
%         cool(k,h)=dexpf_inactivation(h,5)/dexpf_inactivation(h,2);
%     end
% end

% figure(3);plot(activation_voltages,max_activation*1e12)
% figure(4);plot(inactivation_voltages,max_inactivation*1e12)
% figure(3);plot(activation_voltages,normalized_activation)
% figure(4);plot(inactivation_voltages,normalized_inactivation)