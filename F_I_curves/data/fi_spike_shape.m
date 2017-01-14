function [lastspikeforms_increment,rate]=fi_spike_shape(module,recdate,cellnum,trials,points,sample_rate)
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
delay=NaN(1,howmany); pulse_duration=NaN(1,howmany); pause_duration=NaN(1,howmany);
start_current=NaN(1,howmany); finish_current=NaN(1,howmany); increments=NaN(1,howmany);
currents=cell(1,howmany);

% Preallocate vectors associated with rates
spiketimes=cell(1,howmany); thresholdspikes=cell(1,howmany); inflections_temp=cell(1,howmany);
inflectiontimes=cell(1,howmany); thresholds=cell(1,howmany);
pulse_finish=cell(1,howmany); pulse_start=cell(1,howmany); numberspikes=cell(1,howmany);
rate_all=cell(1,howmany); imp=NaN(1,howmany);

eval(['trialdata=' module '_' recdate '_' cellnum num2str(trials(2)) ';'])

% Find out the currents used in each individual trial. If the entire
% trial has an input current of 0 pA, then skip this step.
if ~isequal(trialdata(:,2),ones(size(trialdata(:,2)))*trialdata(1,2))
    % Find the time in 100s of microseconds (assuming the sample_rate is 10000)
    % that the first current pulse starts
    first_pulse(2)=find(trialdata(:,2)~=trialdata(1,2),1,'first');
    
    % Find the time in 100s of microseconds that the first pause starts
    first_pause(2)=first_pulse(2)+find(trialdata(first_pulse(2):end,2)~=...
        trialdata(first_pulse(2),2),1,'first');
    
    % Find the time in 100s of microseconds that the second current pulse starts
    second_pulse(2)=first_pause(2)+find(trialdata(first_pause(2):end,2)~=...
        trialdata(first_pause(2),2),1,'first');
    
    % Find the time in 100s of microseconds that the second pause starts
    second_pause(2)=second_pulse(2)+find(trialdata(second_pulse(2):end,2)~=...
        trialdata(second_pulse(2),2),1,'first');
    
    % Find the time in 100s of microseconds that the third current pulse starts
    third_pulse(2)=second_pause(2)+find(trialdata(second_pause(2):end,2)~=...
        trialdata(second_pause(2),2),1,'first');
    
    % Find the time in 100s of microseconds that the last current pulse ends
    last_pause(2)=find(trialdata(:,2)~=trialdata(end,2),1,'last');
    
    %         if ~mod(2,2) % if 2 is even
    %             if last_pause(2)~=last_pause(2-1)
    %                 last_pause(2)=last_pause(2-1);
    %             end
    %         end
    
    %         if 2>1
    %             if last_pause(2)~=last_pause(2-1)
    %                 last_pause(2)=last_pause(2-1);
    %             end
    %         end
    
    % Find the length of time in seconds for the delay
    delay(2)=(first_pulse(2)-1)/sample_rate;
    
    % Find the pulse duration
    pulse_duration(2)=(first_pause(2)-first_pulse(2))/sample_rate;
    
    % Find the pause duration
    % If statement is important in case the first pause is followed by
    % a pulse of 0 pA (or whatever the offset value is).
    if third_pulse(2)-second_pause(2)<second_pulse(2)-first_pause(2)
        pause_duration(2)=(third_pulse(2)-second_pause(2))/sample_rate;
    else
        pause_duration(2)=(second_pulse(2)-first_pause(2))/sample_rate;
    end
    
    % Find the start current in pA
    start_current(2)=trialdata(first_pulse(2),2)*1e12;
    
    % Find the finish current in pA
    finish_current(2)=trialdata(last_pause(2),2)*1e12;
    
    % Find the number of increments
    increments(2)=round((last_pause(2)-(first_pulse(2)-1)+pause_duration(2)*sample_rate)/...
        ((pulse_duration(2)+pause_duration(2))*sample_rate));
    
    currents{2}=linspace(start_current(2),finish_current(2),increments(2));
    
    if mod(increments(2),2)==0
        if abs(currents{2}(1))<abs(currents{2}(end))
            currents{2}=[0 currents{2}];
            delay(2)=delay(2)-(pulse_duration(2)+pause_duration(2));
        else
            currents{2}=[currents{2} 0];
        end
        increments(2)=increments(2)+1;
    end
else
    delay(2)=0;
    pulse_duration(2)=numel(trialdata(:,2))/sample_rate;
    pause_duration(2)=0;
    increments(2)=1;
    currents{2}=0;
end

% Evaluate spike times using a voltage threshold (rate of rise
% threshold method is commented out)
spiketimes{2}=zeros(numel(trialdata(:,1)),1);
thresholdspikes{2}(trialdata(:,1)>=-0.005)=1;
%     thresholdspikes{2}(diff(trialdata(:,1))>0.003)=1;
spiketimes{2}(find(diff(thresholdspikes{2})>0)+1)=1;
for h=1:increments(2);
    % Define these three so I don't have to use them over and over
    % again
    pulse_finish{2}(h)=(delay(2)+pulse_duration(2))*sample_rate+(h-1)*((pulse_duration(2)+pause_duration(2))*sample_rate);
    pulse_start{2}(h)=pulse_finish{2}(h)-(pulse_duration(2)*sample_rate-1);
    
    % Finds the total number of spikes during each pulse
    numberspikes{2}(h)=sum(spiketimes{2}(pulse_start{2}(h):pulse_finish{2}(h)));
    rate_all{2}(h)=numberspikes{2}(h)/pulse_duration(2);
end

% Fit a line to the f-I curve
if sum(rate_all{2}>0)>2 % keep this if statement if you want the points for the linear regression automatically chosen
    if find(rate_all{2}==max(rate_all{2}),1) - find(rate_all{2}>0,1) > 1
        points(2*2-1)=find(rate_all{2}>0,1);
        points(2*2)=find(rate_all{2}==max(rate_all{2}),1);%numel(rate_all{2});
    elseif find(rate_all{2}==max(rate_all{2}),1) - find(rate_all{2}>0,1) <= 1
        points(2*2-1)=find(rate_all{2}>0,1);
        points(2*2)=numel(rate_all{2});
    end
end

%% Find the last spike in the hyperpolarized pulse that corresponds to the depolarized pulse at the top of the fit
eval(['trialdata=' module '_' recdate '_' cellnum num2str(trials(1)) ';'])

if ~isequal(trialdata(:,2),ones(size(trialdata(:,2)))*trialdata(1,2))
    % Find the time in 100s of microseconds (assuming the sample_rate is 10000)
    % that the first current pulse starts
    first_pulse(1)=find(trialdata(:,2)~=trialdata(1,2),1,'first');
    
    % Find the time in 100s of microseconds that the first pause starts
    first_pause(1)=first_pulse(1)+find(trialdata(first_pulse(1):end,2)~=...
        trialdata(first_pulse(1),2),1,'first');
    
    % Find the time in 100s of microseconds that the second current pulse starts
    second_pulse(1)=first_pause(1)+find(trialdata(first_pause(1):end,2)~=...
        trialdata(first_pause(1),2),1,'first');
    
    % Find the time in 100s of microseconds that the second pause starts
    second_pause(1)=second_pulse(1)+find(trialdata(second_pulse(1):end,2)~=...
        trialdata(second_pulse(1),2),1,'first');
    
    % Find the time in 100s of microseconds that the third current pulse starts
    third_pulse(1)=second_pause(1)+find(trialdata(second_pause(1):end,2)~=...
        trialdata(second_pause(1),2),1,'first');
    
    % Find the time in 100s of microseconds that the last current pulse ends
    last_pause(1)=find(trialdata(:,2)~=trialdata(end,2),1,'last');
    
    %         if ~mod(1,2) % if 1 is even
    %             if last_pause(1)~=last_pause(1-1)
    %                 last_pause(1)=last_pause(1-1);
    %             end
    %         end
    
    %         if 1>1
    %             if last_pause(1)~=last_pause(1-1)
    %                 last_pause(1)=last_pause(1-1);
    %             end
    %         end
    
    % Find the length of time in seconds for the delay
    delay(1)=(first_pulse(1)-1)/sample_rate;
    
    % Find the pulse duration
    pulse_duration(1)=(first_pause(1)-first_pulse(1))/sample_rate;
    
    % Find the pause duration
    % If statement is important in case the first pause is followed by
    % a pulse of 0 pA (or whatever the offset value is).
    if third_pulse(1)-second_pause(1)<second_pulse(1)-first_pause(1)
        pause_duration(1)=(third_pulse(1)-second_pause(1))/sample_rate;
    else
        pause_duration(1)=(second_pulse(1)-first_pause(1))/sample_rate;
    end
    
    % Find the start current in pA
    start_current(1)=trialdata(first_pulse(1),2)*1e12;
    
    % Find the finish current in pA
    finish_current(1)=trialdata(last_pause(1),2)*1e12;
    
    % Find the number of increments
    increments(1)=round((last_pause(1)-(first_pulse(1)-1)+pause_duration(1)*sample_rate)/...
        ((pulse_duration(1)+pause_duration(1))*sample_rate));
    
    currents{1}=linspace(start_current(1),finish_current(1),increments(1));
    
    if mod(increments(1),2)==0
        if abs(currents{1}(1))<abs(currents{1}(end))
            currents{1}=[0 currents{1}];
            delay(1)=delay(1)-(pulse_duration(1)+pause_duration(1));
        else
            currents{1}=[currents{1} 0];
        end
        increments(1)=increments(1)+1;
    end
else
    delay(1)=0;
    pulse_duration(1)=numel(trialdata(:,2))/sample_rate;
    pause_duration(1)=0;
    increments(1)=1;
    currents{1}=0;
end

% Evaluate spike times using a voltage threshold (rate of rise
% threshold method is commented out)
spiketimes{1}=zeros(numel(trialdata(:,1)),1);
thresholdspikes{1}(trialdata(:,1)>=-0.005)=1;
%     thresholdspikes{1}(diff(trialdata(:,1))>0.003)=1;
spiketimes{1}(find(diff(thresholdspikes{1})>0)+1)=1;

% Define these three so I don't have to use them over and over again
pulse_finish{1}(points(4))=(delay(1)+pulse_duration(1))*sample_rate+(points(4)-1)*((pulse_duration(1)+pause_duration(1))*sample_rate);
pulse_start{1}(points(4))=pulse_finish{1}(points(4))-(pulse_duration(1)*sample_rate-1);

rate(1)=numel(find(spiketimes{1}(pulse_start{1}(points(4)):pulse_finish{1}(points(4)))))/5;
rate(2)=numel(find(spiketimes{2}(pulse_start{2}(points(4)):pulse_finish{2}(points(4)))))/5;

% Find spike times for current pulse
beforelastspike=100;
afterlastspike=125;
increment_spikes_trunc{1}{points(4)}=find(spiketimes{1}(pulse_start{1}(points(4))+beforelastspike:pulse_finish{1}(points(4))-afterlastspike));
%         increment_spikes{1}{points(4)}=find(spiketimes{1}(pulse_start{1}(points(4)):pulse_finish{1}(points(4))));
lastspikeforms_increment=NaN(2,beforelastspike+afterlastspike+1);

% Find spike times for depolarized pulse
increment_spikes_trunc{2}{points(4)}=find(spiketimes{2}(pulse_start{2}(points(4))+beforelastspike:pulse_finish{2}(points(4))-afterlastspike));
%         increment_spikes{2}{points(4)}=find(spiketimes{k}(pulse_start{2}(points(4)):pulse_finish{2}(points(4))));

if numel(increment_spikes_trunc{1}{points(4)})~=0 && numel(increment_spikes_trunc{1}{points(4)})<numel(increment_spikes_trunc{2}{points(4)})
    lastspikeforms_increment(1,:)=trialdata(pulse_start{1}(points(4))+beforelastspike+increment_spikes_trunc{1}{points(4)}(end)-beforelastspike-1:...
        pulse_start{1}(points(4))+beforelastspike+increment_spikes_trunc{1}{points(4)}(end)+afterlastspike-1,1);
end

%% Find the corresponding spike in the depolarized trial
eval(['trialdata=' module '_' recdate '_' cellnum num2str(trials(2)) ';'])

if numel(increment_spikes_trunc{1}{points(4)})~=0 && numel(increment_spikes_trunc{1}{points(4)})<numel(increment_spikes_trunc{2}{points(4)})
    lastspikeforms_increment(2,:)=trialdata(pulse_start{2}(points(4))+beforelastspike+increment_spikes_trunc{2}{points(4)}(numel(increment_spikes_trunc{1}{points(4)}))-beforelastspike-1:...
        pulse_start{2}(points(4))+beforelastspike+increment_spikes_trunc{2}{points(4)}(numel(increment_spikes_trunc{1}{points(4)}))+afterlastspike-1,1);
end