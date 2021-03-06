function [imp,pulse_duration,pause_duration,delay,increments,currents,...
    first_spike_diff,pf_hyperpolarized,pf_depolarized]=...
    spike_diff(module,recdate,cellnum,trials,sample_rate)
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
spikes=cell(1,howmany); spikeform=cell(1,howmany); ISI=cell(1,howmany); imp=NaN(1,howmany);

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
        
        if mod(increments(k),2)==0
            if abs(currents{k}(1))<abs(currents{k}(end))
                currents{k}=[0 currents{k}];
                delay(k)=delay(k)-(pulse_duration(k)+pause_duration(k));
            else
                currents{k}=[currents{k} 0];
            end
            increments(k)=increments(k)+1;
        end
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
    
    % Evaluate spike times using a rate of rise threshold (voltage
    % threshold method is commented out)
    spiketimes{k}=zeros(numel(trialdata(:,1)),1);
    thresholdspikes{k}(trialdata(:,1)>=-0.005)=1;
%     thresholdspikes{k}(diff(trialdata(:,1))>0.003)=1;
    spiketimes{k}(find(diff(thresholdspikes{k})>0)+1)=1;
    for h=1:increments(k);
        % Define these three so I don't have to use them over and over
        % again
        pulse_finish{k}(h)=(delay(k)+pulse_duration(k))*sample_rate+(h-1)*((pulse_duration(k)+pause_duration(k))*sample_rate);
        pulse_start{k}(h)=pulse_finish{k}(h)-(pulse_duration(k)*sample_rate-1);
        accom_start{k}(h)=pulse_finish{k}(h)-(accom_time(k)*sample_rate-1);
        
        % Find rates based on the interspike intervals
        if sum(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)))~=0
        first_spike_diff{k}(h)=max(diff(trialdata(pulse_start{k}(h)-1+find(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h))>0)-10:...
            pulse_start{k}(h)-1+find(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h))>0.005)+10)))*1000*10; % Finds the max slope of the first spike in mV/ms
        else
            first_spike_diff{k}(h)=NaN;
        end
        
        % Find the spike times for each of the steady-state portions of the
        % current pulses
        increment_spikes{k}{h}=find(spiketimes{k}(accom_start{k}(h):pulse_finish{k}(h)))+accom_start{k}(h)-1;
    % Initial membrane potential
    imp(k)=mean(trialdata(1:delay(k)*sample_rate,1))*1000;
    end
end

    % Fit a line to the f-I curve
    hyperpolarized_trunc=first_spike_diff{1}(find(isnan(first_spike_diff{1}),1,'last')+1:end);
    currents_hyperpolarized=currents{1}(find(isnan(first_spike_diff{1}),1,'last')+1:end);
    depolarized_trunc=first_spike_diff{2}(find(isnan(first_spike_diff{2}),1,'last')+1:end);
    currents_depolarized=currents{2}(find(isnan(first_spike_diff{2}),1,'last')+1:end);

    pf_hyperpolarized=regstats(hyperpolarized_trunc,currents_hyperpolarized,'linear',{'beta' 'yhat' 'rsquare'});
    pf_depolarized=regstats(depolarized_trunc,currents_depolarized,'linear',{'beta' 'yhat' 'rsquare'});
    
%     pf_hyperpolarized=polyfit(currents_hyperpolarized,hyperpolarized_trunc,1);
%     pf_depolarized=polyfit(currents_depolarized,depolarized_trunc,1);
%     
%     linfit_hyperpolarized=polyval(pf_hyperpolarized,currents_hyperpolarized);
%     linfit_depolarized=polyval(pf_depolarized,currents_depolarized);
%     
%     % Calculate the R^2 value for linear fit
%     resid_hyperpolarized_lin=hyperpolarized_trunc-linfit_hyperpolarized;
%     resid_depolarized_lin=depolarized_trunc-linfit_depolarized;
%     
%     SSresid_hyperpolarized_lin=sum(resid_hyperpolarized_lin.^2);
%     SSresid_depolarized_lin=sum(resid_depolarized_lin.^2);
%     
%     SStotal_hyperpolarized_lin=(length(hyperpolarized_trunc)-1)*var(hyperpolarized_trunc);
%     SStotal_depolarized_lin=(length(depolarized_trunc)-1)*var(depolarized_trunc);
%     
%     rsq_hyperpolarized_lin=1-SSresid_hyperpolarized_lin/SStotal_hyperpolarized_lin;
%     rsq_depolarized_lin=1-SSresid_depolarized_lin/SStotal_depolarized_lin;

figure;plot(currents{1},first_spike_diff{1},'b');hold on;
plot(currents_hyperpolarized,pf_hyperpolarized.yhat,'g');hold on;
plot(currents{2},first_spike_diff{2},'r');hold on;
plot(currents_depolarized,pf_depolarized.yhat,'k')
title({['Slope of First Spikes for ' module '_' recdate '_' cellnum];'Blue=Hyperpolarized, Red=Depolarized'},'interpreter','none')
ylabel('Slope [mV/ms]')
xlabel('Pulse Increment Number')