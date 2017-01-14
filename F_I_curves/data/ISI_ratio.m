function [rate_all,ISI,rate_init,rate_accom,spikeform,imp,gain_ratio,...
    pulse_duration,pause_duration,delay,increments,currents,pf_init,pf_accom,gain_ratio]=...
    ISI_ratio(module,recdate,cellnum,trials,sample_rate,shouldplotFI)
% MODULE is the name of the rtxi module used (e.g. 'fi_curves'); RECDATE is
% the date of recording (i.e. 'Jul_19_11'); CELLNUM is the letter of the
% cell number (e.g. 'A'); TRIALS is the number of trials for the cell (e.g.
% 9); SAMPLE_RATE is the sample rate in Hz; SHOULDPLOTFI, SHOULDPLOTISI,
% and SHOULDPLOTSPIKEFORM denote whether or not each of those things should
% be plotted, with a 0 meaning no and a 1 meaning yes.
% 
% The current must return to the starting value after the last pulse for
% some amount of time for this to work.
% 
% What if the first current pulse is 0 pA? It doesn't find it, but the size
% of the increments remains the same.

warning off all

load([module '_' recdate '_' cellnum])

howmany=numel(trials);

% Preallocate vectors associated with currents
first_pulse=NaN(1,howmany); first_pause=NaN(1,howmany); second_pulse=NaN(1,howmany);
second_pause=NaN(1,howmany); third_pulse=NaN(1,howmany); last_pause=NaN(1,howmany);
delay=NaN(1,howmany); pulse_duration=NaN(1,howmany); pause_duration=NaN(1,howmany);
start_current=NaN(1,howmany); finish_current=NaN(1,howmany); increments=NaN(1,howmany);
currents=cell(1,howmany);

% Preallocate vectors associated with rates
accom_time=NaN(1,howmany); spiketimes=cell(1,howmany); thresholdspikes=cell(1,howmany);
pulse_finish=cell(1,howmany); pulse_start=cell(1,howmany); accom_start=cell(1,howmany); increment_spikes=cell(1,howmany);
spikes=cell(1,howmany); spikeform=cell(1,howmany); ISI=cell(1,howmany);
ISI_accom=cell(1,howmany); rate_all=cell(1,howmany); rate_init=cell(1,howmany);
rate_accom=cell(1,howmany); init_trunc=cell(1,howmany); currents_init=cell(1,howmany);
accom_trunc=cell(1,howmany); currents_accom=cell(1,howmany); pf_init=NaN(howmany,2);
pf_accom=NaN(howmany,2); linfit_init=cell(1,howmany); linfit_accom=cell(1,howmany);
resid_init_lin=cell(1,howmany); resid_accom_lin=cell(1,howmany); SSresid_init_lin=NaN(1,howmany);
SSresid_accom_lin=NaN(1,howmany); SStotal_init_lin=NaN(1,howmany); SStotal_accom_lin=NaN(1,howmany);
rsq_init_lin=NaN(1,howmany); rsq_accom_lin=NaN(1,howmany); nlf_init=NaN(howmany,3);
nlf_accom=NaN(howmany,3); sigfit_init=cell(1,howmany); sigfit_accom=cell(1,howmany);
sigslope_init=NaN(1,howmany); sigslope_accom=NaN(1,howmany); resid_init_sig=cell(1,howmany);
resid_accom_sig=cell(1,howmany); SSresid_init_sig=NaN(1,howmany); SSresid_accom_sig=NaN(1,howmany);
SStotal_init_sig=NaN(1,howmany); SStotal_accom_sig=NaN(1,howmany); rsq_init_sig=NaN(1,howmany);
rsq_accom_sig=NaN(1,howmany); true_init_slope=NaN(1,howmany); true_accom_slope=NaN(1,howmany);
gain_ratio=NaN(1,howmany); gain_measure=cell(1,howmany); imp=NaN(1,howmany);

% How much time (in tenths of ms) before and after the spike to average
beforespike=9;
afterspike=60;

for k=1:howmany
    eval(['trialdata=' module '_' recdate '_' cellnum num2str(trials(k)) ';'])
    
    % Find out the currents used in each individual trial. If the entire
    % trial has an input current of 0 pA, then skip this step.
    if ~isequal(trialdata(:,2),ones(size(trialdata(:,2)))*trialdata(1,2))
        % Find the time in 100s of microseconds (assuming the sample_rate is 10000)
        % that the first current pulse starts
        first_pulse(k)=find(trialdata(:,2)~=trialdata(1,2),1,'first');
        
        % Find the time in 100s of microseconds that the first pause starts
        first_pause(k)=first_pulse(k)+find(trialdata(first_pulse(k):end,2)~=...
            trialdata(first_pulse(k),2),1,'first');
        
        % Find the time in 100s of microseconds that the second current pulse starts
        second_pulse(k)=first_pause(k)+find(trialdata(first_pause(k):end,2)~=...
            trialdata(first_pause(k),2),1,'first');
        
        % Find the time in 100s of microseconds that the second pause starts
        second_pause(k)=second_pulse(k)+find(trialdata(second_pulse(k):end,2)~=...
            trialdata(second_pulse(k),2),1,'first');
        
        % Find the time in 100s of microseconds that the third current pulse starts
        third_pulse(k)=second_pause(k)+find(trialdata(second_pause(k):end,2)~=...
            trialdata(second_pause(k),2),1,'first');
        
        % Find the time in 100s of microseconds that the last current pulse ends
        last_pause(k)=find(trialdata(:,2)~=trialdata(end,2),1,'last');
        
        % Find the length of time in seconds for the delay
        delay(k)=(first_pulse(k)-1)/sample_rate;
        
        % Find the pulse duration
        pulse_duration(k)=(first_pause(k)-first_pulse(k))/sample_rate;
        
        % Find the pause duration
        % If statement is important in case the first pause is followed by
        % a pulse of 0 pA (or whatever the offset value is).
        if third_pulse(k)-second_pause(k)<second_pulse(k)-first_pause(k)
            pause_duration(k)=(third_pulse(k)-second_pause(k))/sample_rate;
        else
            pause_duration(k)=(second_pulse(k)-first_pause(k))/sample_rate;
        end
        
        % Find the start current in pA
        start_current(k)=trialdata(first_pulse(k),2)*1e12;
        
        % Find the finish current in pA
        finish_current(k)=trialdata(last_pause(k),2)*1e12;
        
        % Find the number of increments
        increments(k)=round((last_pause(k)-(first_pulse(k)-1)+pause_duration(k)*sample_rate)/...
            ((pulse_duration(k)+pause_duration(k))*sample_rate));
        
        currents{k}=linspace(start_current(k),finish_current(k),increments(k));
    else
        delay(k)=0;
        pulse_duration(k)=numel(trialdata(:,2))/sample_rate;
        pause_duration(k)=0;
        increments(k)=1;
        currents{k}=0;
    end
    
    % Define the steady-state time
    accom_time(k)=round((pulse_duration(k)/2)*sample_rate)/sample_rate;
    % as opposed to pulse_duration-init_time;
    
    % Preallocate vectors for ISI and ISI_accom
    ISI{k}=cell(1,increments(k));
    ISI_accom{k}=cell(1,increments(k));
    
    % Evaluate spike times using a rate of rise threshold (voltage
    % threshold method is commented out)
    spiketimes{k}=zeros(numel(trialdata(:,1)),1);
%     thresholdspikes{k}(trialdata(:,1)>=-0.02)=1;
    thresholdspikes{k}(diff(trialdata(:,1))>0.005)=1;
    spiketimes{k}(find(diff(thresholdspikes{k})>0)+1)=1;
    for h=1:increments(k);
        % Define these three so I don't have to use them over and over
        % again
        pulse_finish{k}(h)=(delay(k)+pulse_duration(k))*sample_rate+(h-1)*((pulse_duration(k)+pause_duration(k))*sample_rate);
        pulse_start{k}(h)=pulse_finish{k}(h)-(pulse_duration(k)*sample_rate-1);
        accom_start{k}(h)=pulse_finish{k}(h)-(accom_time(k)*sample_rate-1);
        
        % Find rates based on the interspike intervals
        ISI{k}{h}=diff(find(diff(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)))>0)+1)/sample_rate; % Finds the ISI in seconds
        ISI_accom{k}{h}=diff(find(diff(spiketimes{k}(accom_start{k}(h):pulse_finish{k}(h)))>0)+1)/sample_rate; % Finds the ISI in seconds
        if numel(ISI{k}{h})>0
            rate_all{k}(h)=1./mean(ISI{k}{h});
        else
            rate_all{k}(h)=0;
        end
        if numel(ISI{k}{h})>3
            rate_init{k}(h)=1./mean(ISI{k}{h}(1:3));
            if numel(ISI_accom{k}{h})>0
                rate_accom{k}(h)=1./mean(ISI_accom{k}{h}); % rate_accom{k}(h)=1./mean(ISI{k}{h}(4:end));
            else
                rate_accom{k}(h)=0;
            end
        elseif numel(ISI{k}{h})>0 && numel(ISI{k}{h})<4
            rate_init{k}(h)=1./mean(ISI{k}{h}(1:end));
            rate_accom{k}(h)=0;
        else
            rate_init{k}(h)=0;
            rate_accom{k}(h)=0;
        end
        
        % Find the spike times for each of the steady-state portions of the
        % current pulses
        increment_spikes{k}{h}=find(spiketimes{k}(accom_start{k}(h):pulse_finish{k}(h)))+accom_start{k}(h)-1;
        
        % This method uses the last 3 spikes as the SS
%         increment_spikes{k}{h}=find(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)));
        
        % Segment out each spike and then calculate the average
        % steady-state spike waveform
        
        % This method uses the last 3 spikes as the SS
%         if numel(increment_spikes{k}{h})>=4
%             for p=numel(increment_spikes{k}{h})-3:numel(increment_spikes{k}{h})
%                 spikes{k}{h}(p-numel(increment_spikes{k}{h})+4,:)=...
%                     trialdata(pulse_start{k}(h)-1+increment_spikes{k}{h}(p)-beforespike:...
%                     pulse_start{k}(h)-1+increment_spikes{k}{h}(p)+afterspike);
%             end
%         elseif numel(increment_spikes{k}{h})==3
%             for p=numel(increment_spikes{k}{h})-2:numel(increment_spikes{k}{h})
%                 spikes{k}{h}(p-numel(increment_spikes{k}{h})+3,:)=...
%                     trialdata(pulse_start{k}(h)-1+increment_spikes{k}{h}(p)-beforespike:...
%                     pulse_start{k}(h)-1+increment_spikes{k}{h}(p)+afterspike);
%             end
%         elseif numel(increment_spikes{k}{h})==2
%             for p=numel(increment_spikes{k}{h})-1:numel(increment_spikes{k}{h})
%                 spikes{k}{h}(p-numel(increment_spikes{k}{h})+2,:)=...
%                     trialdata(pulse_start{k}(h)-1+increment_spikes{k}{h}(p)-beforespike:...
%                     pulse_start{k}(h)-1+increment_spikes{k}{h}(p)+afterspike);
%             end
%         elseif numel(increment_spikes{k}{h})==1
%             spikes{k}{h}=trialdata(pulse_start{k}(h)-1+increment_spikes{k}{h}-beforespike:...
%                 pulse_start{k}(h)-1+increment_spikes{k}{h}+afterspike);
%         end
        
        % This method uses the last half of the pulse time as SS
        for p=1:numel(increment_spikes{k}{h})
            spikes{k}{h}(p,:)=trialdata(increment_spikes{k}{h}(p)-beforespike:increment_spikes{k}{h}(p)+afterspike);
        end
        
        if numel(increment_spikes{k}{h})==1
            spikeform{k}{h}=spikes{k}{h};
        elseif numel(increment_spikes{k}{h})>1
            spikeform{k}{h}=mean(spikes{k}{h});
        else
            spikeform{k}{h}=NaN;
        end
    end
    
    % Fit a line to the f-I curve
    init_trunc{k}=rate_init{k}(find(rate_init{k}>0,1):end);
    currents_init{k}=currents{k}(find(rate_init{k}>0,1):end);
    accom_trunc{k}=rate_accom{k}(find(rate_accom{k}>0,1):end);
    currents_accom{k}=currents{k}(find(rate_accom{k}>0,1):end);
    
    % Only use non-zero rates
%     init_trunc{k}=rate_init{k}(rate_init{k}>0);
%     currents_init{k}=currents{k}(rate_init{k}>0);
%     accom_trunc{k}=rate_accom{k}(rate_accom{k}>0);
%     currents_accom{k}=currents{k}(rate_accom{k}>0);
    
    pf_init(k,:)=polyfit(currents_init{k},init_trunc{k},1);
    pf_accom(k,:)=polyfit(currents_accom{k},accom_trunc{k},1);
    
    linfit_init{k}=polyval(pf_init(k,:),currents_init{k});
    linfit_accom{k}=polyval(pf_accom(k,:),currents_accom{k});
    
    % Calculate the R^2 value for linear fit
    resid_init_lin{k}=init_trunc{k}-linfit_init{k};
    resid_accom_lin{k}=accom_trunc{k}-linfit_accom{k};
    
    SSresid_init_lin(k)=sum(resid_init_lin{k}.^2);
    SSresid_accom_lin(k)=sum(resid_accom_lin{k}.^2);
    
    SStotal_init_lin(k)=(length(init_trunc{k})-1)*var(init_trunc{k});
    SStotal_accom_lin(k)=(length(accom_trunc{k})-1)*var(accom_trunc{k});
    
    rsq_init_lin(k)=1-SSresid_init_lin(k)/SStotal_init_lin(k);
    rsq_accom_lin(k)=1-SSresid_accom_lin(k)/SStotal_accom_lin(k);
        
    % Choose the fits with the higher sum of R^2 values, and find the gain
    % ratio for those fits
%     gain_measure{k}='best fits';
%     if rsq_init_sig(k)>rsq_init_lin(k)
%         true_init_slope(k)=sigslope_init(k);
%     else
%         true_init_slope(k)=pf_init(k,1);
%     end
%     if rsq_accom_sig(k)>rsq_accom_lin(k)
%         true_accom_slope(k)=sigslope_accom(k);
%     else
%         true_accom_slope(k)=pf_accom(k,1);
%     end
%     
%     gain_ratio(k)=true_accom_slope(k)/true_init_slope(k);
    
%     ALTERNATIVE METHOD
%     if rsq_init_sig(k)+rsq_accom_sig(k)>rsq_init_lin(k)+rsq_accom_lin(k)
%         gain_ratio(k)=sigslope_accom(k)/sigslope_init(k);
%         gain_measure{k}='Sigmoidal Fit';
%     else
        gain_ratio(k)=pf_accom(k,1)/pf_init(k,1);
        gain_measure{k}='Linear Regression';
%     end
    
    % Initial membrane potential
    imp(k)=mean(trialdata(1:delay(k)*sample_rate,1))*1000;
    
    if shouldplotFI~=0
        if ~isequal(currents{k},0)
            figure(k*3);subplot(2,1,1);plot(currents{k},rate_init{k},'*k'); hold on;
            plot(currents_init{k},linfit_init{k},'r'); hold on;
            plot(currents_init{k},sigfit_init{k})
            title({['Initial Rate for Cell ' cellnum ', Trial ' num2str(trials(k))];...
                ['Held at ' num2str(imp(k)) ' mV; Delay: ' num2str(delay(k)) ' sec; Pulse Duration: '...
                num2str(pulse_duration(k)) ' sec; Pause Duration: ' num2str(pause_duration(k)) ' sec'];...
                ['Steady-State/Inital Gain Ratio (from ' gain_measure{k} '): ' num2str(gain_ratio(k))]})
            legend('Original Values',['Linear Fit, R^2=' num2str(rsq_init_lin(k))],...
                ['Sigmoidal Fit, R^2=' num2str(rsq_init_sig(k))])
            xlabel('Current [pA]')
            ylabel('Firing Rate [Hz]')
            axis([currents{k}(1) currents{k}(end) 0 150])
            subplot(2,1,2);plot(currents{k},rate_accom{k},'.k'); hold on;
            plot(currents_accom{k},linfit_accom{k},'r'); hold on;
            plot(currents_accom{k},sigfit_accom{k})
            title({['Steady-State Rate for Cell ' cellnum ', Trial ' num2str(trials(k))];...
                ['Held at ' num2str(imp(k)) ' mV; Delay: ' num2str(delay(k)) ' sec; Pulse Duration: '...
                num2str(pulse_duration(k)) ' sec; Pause Duration: ' num2str(pause_duration(k)) ' sec'];...
                ['Steady-State/Inital Gain Ratio (from ' gain_measure{k} '): ' num2str(gain_ratio(k))]})
            legend('Original Values',['Linear Fit, R^2=' num2str(rsq_accom_lin(k))],...
                ['Sigmoidal Fit, R^2=' num2str(rsq_accom_sig(k))])
            xlabel('Current [pA]')
            ylabel('Firing Rate [Hz]')
            axis([currents{k}(1) currents{k}(end) 0 150])
        end
    end
end