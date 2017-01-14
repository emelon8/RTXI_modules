function [rate_all,numberspikes,thresholds,imp,pulse_duration,pause_duration,increments,currents,hyperpolarization_pulse_voltages,depolarization_pulse_voltages]=...
    hyperpolarizing_pulses_rate(module,recdate,cellnum,trials,delay,sample_rate,shouldplotFI)
% MODULE is the name of the rtxi module used (e.g. 'fi_curves'); RECDATE is
% the date of recording (i.e. 'Jul_19_11'); CELLNUM is the letter of the
% cell number (e.g. 'A'); TRIALS is the number of trials for the cell (e.g.
% 9); SAMPLE_RATE is the sample rate in Hz; SHOULDPLOTFI, denotes whether
% or not each of those things should be plotted, with a 0 meaning no and a
% 1 meaning yes.
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
pulse_duration=NaN(1,howmany); pause_duration=NaN(1,howmany);
start_current=NaN(1,howmany); finish_current=NaN(1,howmany); increments=NaN(1,howmany);
currents=cell(1,howmany);

% Preallocate vectors associated with rates
spiketimes=cell(1,howmany); thresholdspikes=cell(1,howmany); inflections_temp=cell(1,howmany);
inflectiontimes=cell(1,howmany); thresholds=cell(1,howmany);
pulse_finish=cell(1,howmany); pulse_start=cell(1,howmany); numberspikes=cell(1,howmany);
rate_all=cell(1,howmany); imp=NaN(1,howmany);

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
        pulse_duration(k)=0.5;
        pause_duration(k)=4.5;
        increments(k)=24;
        currents{k}=zeros(1,24);
    end
    
%     figure;plot(1/sample_rate:1/sample_rate:numel(trialdata(:,1))/sample_rate,trialdata(:,1)*1e3)
    
    % Evaluate spike times using a voltage threshold (rate of rise
    % threshold method is commented out)
    spiketimes{k}=zeros(numel(trialdata(:,1)),1);
    inflections_temp{k}=zeros(numel(trialdata(:,1)),1);
    thresholdspikes{k}(trialdata(:,1)>=-0.005)=1;
    inflections_temp{k}(find(diff(diff(trialdata(:,1)))>=0.005)+1)=1; % find the inflection points to find threshold
    inflectiontimes_temp{k}=find(diff(inflections_temp{k})>0)+1;
    markfalse{k}=[0; diff(inflectiontimes_temp{k})<10];
    if sum(inflections_temp{1})>0
        inflectiontimes{k}=inflectiontimes_temp{k}(~markfalse{k});
        for p=1:numel(inflectiontimes{k})
            inflectionvoltage{k}(p)=trialdata(inflectiontimes{k}(p)-10+...
                find(max(diff(diff(trialdata(inflectiontimes{k}(p)-10:inflectiontimes{k}(p)+10,1)))))+1-1,1);
        end
    end
%     thresholdspikes{k}(diff(trialdata(:,1))>0.003)=1;
    spiketimes{k}(find(diff(thresholdspikes{k})>0)+1)=1;
    for h=1:increments(k);
        % Define these three so I don't have to use them over and over
        % again
        pulse_start{k}(h)=(delay(k)+pulse_duration(k))*sample_rate+(h-1)*((pulse_duration(k)+pause_duration(k))*sample_rate)+1;
        pulse_finish{k}(h)=pulse_start{k}(h)+pause_duration(k)*sample_rate-1;
        
        % make the pulse duration 1 sec and the pulse finish after 1 sec
        skip=pause_duration;
%         pulse_duration(k)=1;
%         pulse_finish{k}(h)=pulse_start{k}(h)+pulse_duration(k)*sample_rate-1;
        
        % Finds the total number of spikes during each pulse
        numberspikes{k}(h)=sum(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)));
        rate_all{k}(h)=numberspikes{k}(h)/pause_duration(k);
        
        pause_duration=skip;
        
        hyperpolarization_pulse_voltages{k}(h)=mean(trialdata(pulse_start{k}(h)-4500:pulse_start{k}(h)-1,1))*1e3;
        depolarization_pulse_voltages{k}(h)=mean(trialdata(pulse_start{k}(h):pulse_finish{k}(h),1))*1e3;
        
        if sum(inflections_temp{1})>0
            thresholds{k}{h}=inflectionvoltage{k}((pulse_start{k}(h)+200<inflectiontimes{k})==(inflectiontimes{k}<pulse_finish{k}(h)-10));
        end
    end
    
    % Initial membrane potential
    imp(k)=nanmean(trialdata(1:delay(k)*sample_rate,1))*1000;
    
    if shouldplotFI~=0
        figure;plot(1:24,rate_all{k},'*k'); hold on;
        title({['Rate for Cell ' recdate '_' cellnum num2str(trials(k))];...
            ['Held at ' num2str(imp(k)) ' mV; Delay: ' num2str(delay(k)) ' sec; Pulse Duration: '...
            num2str(pulse_duration(k)) ' sec; Pause Duration: ' num2str(pause_duration(k)) ' sec']},'interpreter','none')
        xlabel('Current [pA]')
        ylabel('Firing Rate [Hz]')
        %             axis([currents{k}(1) currents{k}(end) 0 40])
    end
end