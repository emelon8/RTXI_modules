function [rate_all,ISI,rate_init,spike1avg,spike2avg,spike3avg,spikelastavg,spikelastriseavg,pulse_duration,pause_duration,delay,...
    increments,currents]=first_three_spikes_noise(module,recdate,cellnum,trials,sample_rate)
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
spikes=cell(1,howmany); spikeform=cell(1,howmany); ISI=cell(1,howmany);
rate_all=cell(1,howmany); rate_init=cell(1,howmany);
spike1=cell(1,howmany);
spike2=cell(1,howmany);
spike3=cell(1,howmany);
spikelast=cell(1,howmany);
spikelastrise=cell(1,howmany);

% How much time (in tenths of ms) before and after the spike to average
beforespike=19;
afterspike=280;

spike1avg=NaN(howmany,beforespike+afterspike+1);
spike2avg=NaN(howmany,beforespike+afterspike+1);
spike3avg=NaN(howmany,beforespike+afterspike+1);
spikelastavg=NaN(howmany,beforespike+afterspike+1);
spikelastriseavg=NaN(howmany,1);

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
    
    % Preallocate vectors for ISI and ISI_accom
    ISI{k}=cell(1,increments(k));
    
    step3=0;
    step2=0;
    step1=0;
    steplast=0;
    
    % Evaluate spike times using a rate of rise threshold (voltage
    % threshold method is commented out)
    spiketimes{k}=zeros(numel(trialdata(:,1)),1);
%     thresholdspikes{k}(trialdata(:,1)>=-0.02)=1;
    thresholdspikes{k}(diff(trialdata(:,1)*1e-3)>0.005)=1;
    spiketimes{k}(find(diff(thresholdspikes{k})>0)+1)=1;
    for h=1:increments(k);
        % Define these three so I don't have to use them over and over
        % again
        pulse_finish{k}(h)=(delay(k)+pulse_duration(k))*sample_rate+(h-1)*((pulse_duration(k)+pause_duration(k))*sample_rate);
        pulse_start{k}(h)=pulse_finish{k}(h)-(pulse_duration(k)*sample_rate-1);
        
        % Find rates based on the interspike intervals
        ISI{k}{h}=diff(find(diff(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)))>0)+1)/sample_rate; % Finds the ISI in seconds
        if numel(ISI{k}{h})>0
            rate_all{k}(h)=1./mean(ISI{k}{h});
        else
            rate_all{k}(h)=0;
        end
        if numel(ISI{k}{h})>3
            rate_init{k}(h)=1./mean(ISI{k}{h}(1:3));
        elseif numel(ISI{k}{h})>0 && numel(ISI{k}{h})<4
            rate_init{k}(h)=1./mean(ISI{k}{h}(1:end));
        else
            rate_init{k}(h)=0;
        end
        
        % Find the spike times for each of the current pulses
        increment_spikes{k}{h}=find(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)));
        
        if numel(increment_spikes{k}{h})>=3
            step3=step3+1;
            for p=1:3
                three_spikes{k}{step3}(p,:)=trialdata(pulse_start{k}(h)+increment_spikes{k}{h}(p)-beforespike-1:...
                    pulse_start{k}(h)+increment_spikes{k}{h}(p)+afterspike-1);
            end
        elseif numel(increment_spikes{k}{h})==2
            step2=step2+1;
            for p=1:2
                two_spikes{k}{step2}(p,:)=trialdata(pulse_start{k}(h)+increment_spikes{k}{h}(p)-beforespike-1:...
                    pulse_start{k}(h)+increment_spikes{k}{h}(p)+afterspike-1);
            end
        elseif numel(increment_spikes{k}{h})==1
            step1=step1+1;
            one_spike{k}{step1}(1,:)=trialdata(pulse_start{k}(h)+increment_spikes{k}{h}(1)-beforespike-1:...
                pulse_start{k}(h)+increment_spikes{k}{h}(1)+afterspike-1);
        end
        
        % find the rate of rise for the last spike in pulses containing 2
        % or more spikes
        if numel(increment_spikes{k}{h})>1
            steplast=steplast+1;
            numberofspikes=numel(increment_spikes{k}{h});
            last_spike{k}{steplast}=trialdata(pulse_start{k}(h)+increment_spikes{k}{h}(numberofspikes)-beforespike-1:...
                pulse_start{k}(h)+increment_spikes{k}{h}(numberofspikes)+afterspike-1);
            max_rise_rate{k}{steplast}=max(diff(last_spike{k}{steplast}));
        end
    end
    
    if exist('three_spikes','var') && numel(three_spikes)==k
        no3spikes=numel(three_spikes{k});
        for y=1:no3spikes
            spike1{k}(y,:)=three_spikes{k}{y}(1,:);
            spike2{k}(y,:)=three_spikes{k}{y}(2,:);
            spike3{k}(y,:)=three_spikes{k}{y}(3,:);
        end
    else
        no3spikes=0;
    end
    if exist('two_spikes','var') && numel(two_spikes)==k
        no2spikes=numel(two_spikes{k});
        for y=no3spikes+1:no3spikes+no2spikes
            spike1{k}(y,:)=two_spikes{k}{y-no3spikes}(1,:);
            spike2{k}(y,:)=two_spikes{k}{y-no3spikes}(2,:);
        end
    else
        no2spikes=0;
    end
    if exist('one_spike','var') && numel(one_spike)==k
        for y=no3spikes+no2spikes+1:no3spikes+no2spikes+numel(one_spike{k})
            spike1{k}(y,:)=one_spike{k}{y-(no3spikes+no2spikes)}(1,:);
        end
    end
    if exist('last_spike','var') && numel(last_spike)==k
        numberlastspikes=numel(last_spike{k});
        for y=1:numberlastspikes
            spikelast{k}(y,:)=last_spike{k}{y};
            spikelastrise{k}(y)=max_rise_rate{k}{y};
        end
    end
    
    spike1avg(k,:)=mean(spike1{k});
    spike2avg(k,:)=mean(spike2{k});
    spike3avg(k,:)=mean(spike3{k});
    spikelastavg(k,:)=mean(spikelast{k});
    spikelastriseavg(k)=mean(spikelastrise{k});
end