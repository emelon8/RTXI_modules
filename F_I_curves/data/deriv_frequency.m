function [rate,ISI,imp,pulse_duration,pause_duration,delay,increments,currents,deriv_rate]=...
    deriv_frequency(module,recdate,cellnum,trials,sample_rate)
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
spiketimes=cell(1,howmany); thresholdspikes=cell(1,howmany);
pulse_finish=cell(1,howmany); pulse_start=cell(1,howmany); increment_spikes=cell(1,howmany);
spikes=cell(1,howmany); maxderiv_spikes=cell(1,howmany);
ISI=cell(1,howmany); rate=cell(1,howmany); imp=NaN(1,howmany);

% How much time (in tenths of ms) before and after the spike to average
beforespike=9;
afterspike=60;

color=rand(1,3);

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
    
    % Preallocate vectors for ISI and meanderiv
    ISI{k}=cell(1,increments(k));
    
    % Evaluate spike times using a rate of rise threshold (voltage
    % threshold method is commented out)
    spiketimes{k}=zeros(numel(trialdata(:,1)),1);
    thresholdspikes{k}(trialdata(:,1)>=-0.005)=1;
%     thresholdspikes{k}(diff(trialdata(:,1))>0.003)=1;
    spiketimes{k}(find(diff(thresholdspikes{k})>0)+1)=1;
    
%     figure(k*2-1)
%     title('Maximum Derivative of Spikes for Each Pulse (Lighter=Higher Input Current)')
%     xlabel('Spike Number')
%     ylabel('Maximum Derivative of Spikes [mV/ms]')
%     axis([1 15 0 300])
    
    for h=1:increments(k);
        % Define these three so I don't have to use them over and over
        % again
        pulse_finish{k}(h)=(delay(k)+pulse_duration(k))*sample_rate+(h-1)*((pulse_duration(k)+pause_duration(k))*sample_rate);
        pulse_start{k}(h)=pulse_finish{k}(h)-(pulse_duration(k)*sample_rate-1);
        
        % Finds the total number of spikes during each pulse
        numberspikes{k}(h)=sum(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)));
        rate{k}(h)=numberspikes{k}(h)/pulse_duration(k);
        
        increment_spikes{k}{h}=find(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)));
        
        for p=1:numel(increment_spikes{k}{h})
            spikes{k}{h}(p,:)=trialdata(pulse_start{k}(h)-1+increment_spikes{k}{h}(p)-beforespike:...
                pulse_start{k}(h)-1+increment_spikes{k}{h}(p)+afterspike);
        end
        
        if numel(increment_spikes{k}{h})>=1% && numel(increment_spikes{k}{h})<=3
            maxderiv_spikes{k}{h}=max(diff(spikes{k}{h}'))';
%             figure(k*2-1);hold on;plot(1:numel(increment_spikes{k}{h}),...
%                 maxderiv_spikes{k}{h}*10000,'Color',[0 h/increments(k) 0])
        else
            maxderiv_spikes{k}{h}=0;
        end
    end
    
    for q=1:max(rate{k})
        eval(['meanderiv' num2str(q) '=NaN(howmany,increments(k));'])
    end
    
    for h=1:increments(k);
        for q=1:max(rate{k})
            if numel(maxderiv_spikes{k}{h})==q
                eval(['meanderiv' num2str(q) '(k,h)=mean(maxderiv_spikes{k}{h}(1:q));'])
            end
        end
    end
    
    for q=1:max(rate{k})
        eval(['deriv_rate(k,q)=mean(meanderiv' num2str(q) '(k,meanderiv' num2str(q) '(k,:)>0));'])
    end
    
    % Initial membrane potential
    imp(k)=mean(trialdata(1:delay(k)*sample_rate,1))*1000;
    
    if ~isequal(currents{k},0)
        figure(k*2);hold on;plot(1:max(rate{k}),deriv_rate(k,:)*10000,'Color',color)
        title('Average Maximum Derivative of Spikes for Each Frequency')
        xlabel('Frequency [Hz]')
        ylabel('Maximum Derivative of Spikes [mV/ms]')
        axis([1 15 0 300])
    end
end

% close all