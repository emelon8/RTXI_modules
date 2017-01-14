function [rate_all,peakrate,nofailrate,mean_holdingvoltage,... mean_r_m,std_r_m,mean_time_constant,std_time_constant,mean_c_m,std_c_m,
    numberspikes,thresholds,imp,pulse_duration,pause_duration,delay,increments,currents,...
    pf_all,std_noise,noise_V,mean_spikeform,frequencyforms,ISIs_all,ISIs,ISIratio,firstISI,lastISI,...
    std_noise_all,mean_freq0_spikeforms_increment,mean_freq1_spikeforms_increment,...
    mean_freq2_spikeforms_increment,mean_freq3_spikeforms_increment,mean_freq4_spikeforms_increment,...
    mean_freq5_spikeforms_increment,mean_freq6_spikeforms_increment,mean_freq7_spikeforms_increment,...
    mean_freq8_spikeforms_increment,mean_freq9_spikeforms_increment,mean_freq10_spikeforms_increment,...
    mean_freq0_outputforms_increment,mean_freq1_outputforms_increment,...
    mean_freq2_outputforms_increment,mean_freq3_outputforms_increment,mean_freq4_outputforms_increment,...
    mean_freq5_outputforms_increment,mean_freq6_outputforms_increment,mean_freq7_outputforms_increment,...
    mean_freq8_outputforms_increment,mean_freq9_outputforms_increment,mean_freq10_outputforms_increment,...
    mean_lastspikeforms_increment,mean_lastoutputforms_increment,ahp_depth,ahp_duration,...
    first_spike_delay,interspike_voltage,resistance_voltage2,resistance_voltage1,r_m,c_m,mean_r_m,mean_time_constant,mean_c_m,ahp_depth_increment,ahp_duration_increment]=...
    fi_rate_leak_and_subtraction(module,recdate,cellnum,trials,parameters_up,parameters_down,points,sample_rate,shouldplotFI,noise)
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

if noise==1
    cd([pwd '\..\..\FI_OU\data\'])
end

load([module '_' recdate '_' cellnum])

l=0;
a=0;
b=0;
c=0;
d=0;
e=0;
f=0;
g=0;
m=0;
n=0;
o=0;
q=0;

howmany=numel(trials);
tau_m=0.25*sample_rate; %time in seconds*sample_rate of the membrane charging
risetime=1/sample_rate:1/sample_rate:tau_m/sample_rate;

% Preallocate vectors associated with currents
first_pulse=NaN(1,howmany); first_pause=NaN(1,howmany); second_pulse=NaN(1,howmany);
second_pause=NaN(1,howmany); third_pulse=NaN(1,howmany); last_pause=NaN(1,howmany);
delay=NaN(1,howmany); pulse_duration=NaN(1,howmany); pause_duration=NaN(1,howmany);
start_current=NaN(1,howmany); finish_current=NaN(1,howmany); increments=NaN(1,howmany);
currents=cell(1,howmany);

% Preallocate vectors associated with rates
spiketimes=cell(1,howmany); thresholdspikes=cell(1,howmany); thresholds=cell(1,howmany);
pulse_finish=cell(1,howmany); pulse_start=cell(1,howmany); numberspikes=cell(1,howmany);
rate_all=cell(1,howmany); peakrate=NaN(1,howmany); nofailrate=NaN(1,howmany); all_trunc=cell(1,howmany); currents_all=cell(1,howmany);
pf_all=cell(1,howmany); imp=NaN(1,howmany); std_noise=NaN(1,howmany); noise_V=NaN(1,howmany);

for k=1:howmany
    eval(['trialdata=' module '_' recdate '_' cellnum num2str(trials(k)) ';'])
    frequencyforms{k}=NaN;
%     figure;plot(0.0001:0.0001:length(trialdata(:,1))/sample_rate,trialdata(:,1)*1e3)
    
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
        
%         if ~mod(k,2) % if k is even
%             if last_pause(k)~=last_pause(k-1)
%                 last_pause(k)=last_pause(k-1);
%             end
%         end
        
%         if k>1
%             if last_pause(k)~=last_pause(k-1)
%                 last_pause(k)=last_pause(k-1);
%             end
%         end
        
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
    
%     figure;plot(1/sample_rate:1/sample_rate:numel(trialdata(:,1))/sample_rate,trialdata(:,1)*1e3)
    
    holdingvoltage{k}=NaN(1,increments(k));
    
    if k==1
        r_m=NaN(1,increments(k));
        c_m=NaN(1,increments(k));
        expf_membrane=NaN(increments(k),3);
    end
    
    % Evaluate spike times using a voltage threshold (rate of rise
    % threshold method is commented out)
    spiketimes{k}=zeros(size(trialdata(:,1)));
% %     inflections_temp{k}=zeros(size(trialdata(:,1))); % Can delete this double commented stuff
    thresholdspikes{k}(trialdata(:,1)>=-0.005)=1;
% %     inflections_temp{k}(find(diff(diff(trialdata(:,1)))>=0.005)+1)=1; % find the inflection points to find threshold
% %     inflectiontimes_temp{k}=find(diff(inflections_temp{k})>0)+1;
% %     markfalse{k}=[0; diff(inflectiontimes_temp{k})<10];
% %     if sum(inflections_temp{1})>0
% %         inflectiontimes{k}=inflectiontimes_temp{k}(~markfalse{k});
% %         for p=1:numel(inflectiontimes{k})
% %             inflectionvoltage{k}(p)=trialdata(inflectiontimes{k}(p)-10+...
% %                 find(max(diff(diff(trialdata(inflectiontimes{k}(p)-10:inflectiontimes{k}(p)+10,1)))))+1-1,1);
% %         end
% %     end
%     thresholdspikes{k}(diff(trialdata(:,1))>0.003)=1; % finds spikes based on a thresholded first derivative
    spiketimes{k}(find(diff(thresholdspikes{k})>0)+1)=1;
    spiketimes_indices{k}=find(spiketimes{k}==1);
    if numel(spiketimes_indices{k})>0
        for p=1:numel(spiketimes_indices{k})
            inflection_points{k}(p)=spiketimes_indices{k}(p)+...
                find(diff(diff(trialdata(spiketimes_indices{k}(p)-20:spiketimes_indices{k}(p),1)))==...
                max(diff(diff(trialdata(spiketimes_indices{k}(p)-20:spiketimes_indices{k}(p),1)))),1,'first')-...
                21;
            inflectionvoltage{k}(p)=trialdata(inflection_points{k}(p),1);
        end
    else
        inflection_points{k}=NaN;
        inflectionvoltage{k}=NaN;
    end
    
    for h=1:increments(k);
        % Define these three so I don't have to use them over and over
        % again
        pulse_finish{k}(h)=(delay(k)+pulse_duration(k))*sample_rate+(h-1)*((pulse_duration(k)+pause_duration(k))*sample_rate);
        pulse_finish{k}(h)=round(pulse_finish{k}(h)/sample_rate)*sample_rate;
        pulse_start{k}(h)=pulse_finish{k}(h)-(pulse_duration(k)*sample_rate-1);
        pulse_start{k}(h)=round(pulse_start{k}(h)/sample_rate)*sample_rate;
        
        % make the pulse duration 1 sec and the pulse finish after 1 sec
        skip=pulse_duration;
%         pulse_duration(k)=1;
%         pulse_finish{k}(h)=pulse_start{k}(h)+pulse_duration(k)*sample_rate-1;
        
        % Finds the total number of spikes during each pulse
        numberspikes{k}(h)=sum(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)));
        ISIs_all{k}{h}=diff(find(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h))>0))/sample_rate;
        ISIs{k}{h}=diff(find(spiketimes{k}(pulse_start{k}(h)+5000:pulse_finish{k}(h)-5000)>0))/sample_rate;
        rate_all{k}(h)=numberspikes{k}(h)/pulse_duration(k);
        
%         if strcmp([recdate '_' cellnum num2str(trials)],'Mar_23_15_C1') % use for debugging
%             hi=1;
%         end
        
        % Measure the AHP duration and depth
        AHP_time=500; % amount of time before the end of the pulse to stop measuring the AHP
        increment_spikes_ahp{k}{h}=find(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)-AHP_time));
        inflection_points_ahp{k}{h}=inflection_points{k}(pulse_start{k}(h)<=inflection_points{k} & inflection_points{k}<=(pulse_finish{k}(h)-AHP_time));
        inflection_voltage_ahp{k}{h}=trialdata(inflection_points_ahp{k}{h},1);
        first_spike_delay{k}(h)=NaN;
        for p=1:numel(increment_spikes_ahp{k}{h})
            % find the depth of the ahp, from inflection point to bottom
            ahp_depth_point{k}{h}(p)=pulse_start{k}(h)+increment_spikes_ahp{k}{h}(p)-1-1+...
                find(trialdata(pulse_start{k}(h)+increment_spikes_ahp{k}{h}(p)-1:...
                pulse_start{k}(h)+increment_spikes_ahp{k}{h}(p)+500-1,1)==...
                min(trialdata(pulse_start{k}(h)+increment_spikes_ahp{k}{h}(p)-1:...
                pulse_start{k}(h)+increment_spikes_ahp{k}{h}(p)+500-1,1)),1,'first');
            ahp_depth_increment{k}{h}(p)=inflection_voltage_ahp{k}{h}(p)-trialdata(ahp_depth_point{k}{h}(p),1);
            if ahp_depth_increment{k}{h}(p)<0 %throw out cases where the inflection point is lower than the AHP
                ahp_depth_increment{k}{h}(p)=NaN;
                downstroke_inflection{k}{h}(p)=NaN;
                ahp_duration_point{k}{h}(p)=NaN;
                ahp_duration_increment{k}{h}(p)=NaN;
            else
                % find the next point after the spike crosses the inflection point on the downstroke of the spike
                downstroke_inflection{k}{h}(p)=inflection_points_ahp{k}{h}(p)+find(trialdata(inflection_points_ahp{k}{h}(p):inflection_points_ahp{k}{h}(p)+500,1)<inflection_voltage_ahp{k}{h}(p),1,'first')-1;
                % find the duration of the action potential, from the downstroke inflection point to when it recovers to 40% of the ahp depth
                if numel(find(trialdata(ahp_depth_point{k}{h}(p):end,1)>trialdata(ahp_depth_point{k}{h}(p),1)+0.4*(ahp_depth_increment{k}{h}(p)),1,'first'))>0
                    ahp_duration_point{k}{h}(p)=ahp_depth_point{k}{h}(p)-1+find(trialdata(ahp_depth_point{k}{h}(p):end,1)>...
                        trialdata(ahp_depth_point{k}{h}(p),1)+0.4*(ahp_depth_increment{k}{h}(p)),1,'first');
                    ahp_duration_increment{k}{h}(p)=(ahp_duration_point{k}{h}(p)-downstroke_inflection{k}{h}(p))/sample_rate;
                else
                    ahp_duration_point{k}{h}(p)=NaN;
                    ahp_duration_increment{k}{h}(p)=NaN;
                end
            end
            first_spike_delay{k}(h)=increment_spikes_ahp{k}{h}(1);
        end
        if numel(increment_spikes_ahp{k}{h})>0
            ahp_depth{k}(h)=nanmean(ahp_depth_increment{k}{h});
            ahp_duration{k}(h)=nanmean(ahp_duration_increment{k}{h});
        else
            ahp_depth{k}(h)=NaN;
            ahp_duration{k}(h)=NaN;
        end
        
        % find the interspike voltage
        interspike_voltage_concat{k}{h}=[];
        inflection_points_ISV{k}{h}=inflection_points{k}(pulse_start{k}(h)<=inflection_points{k} & inflection_points{k}<=(pulse_finish{k}(h)));
        interspike_stop{k}{h}=inflection_points_ISV{k}{h}(inflection_points_ISV{k}{h}>pulse_start{k}(h)+0.25*sample_rate); %spike inflection points after 250 ms
        if exist('ahp_duration_point') && numel(inflection_points_ISV{k}{h})>0
            interspike_start{k}{h}=ahp_duration_point{k}{h}(ahp_duration_point{k}{h}>pulse_start{k}(h)+0.25*sample_rate); %spike AHPs after 250 ms
        else
            interspike_start{k}{h}=interspike_stop{k}{h};
        end
        
        if numel(interspike_stop{k}{h})==0 && numel(interspike_start{k}{h})==0
            if numel(inflection_points_ISV{k}{h})>0
                interspike_voltage_concat{k}{h}=NaN;
            else
                interspike_voltage_concat{k}{h}=trialdata(pulse_start{k}(h)+0.25*sample_rate:pulse_finish{k}(h),1)';
            end
        end
        if numel(interspike_stop{k}{h})==0 && numel(interspike_start{k}{h})==1
            interspike_voltage_concat{k}{h}=trialdata(interspike_start{k}{h}:pulse_finish{k}(h),1)';
        elseif numel(interspike_stop{k}{h})==1 && numel(interspike_start{k}{h})==0
            interspike_voltage_concat{k}{h}=trialdata(pulse_start{k}(h)+0.25*sample_rate:interspike_stop{k}{h}-1,1)';
        end
        if numel(interspike_stop{k}{h})==1 && numel(interspike_start{k}{h})==1 && interspike_stop{k}{h}<interspike_start{k}{h}
            interspike_voltage_concat{k}{h}=trialdata(pulse_start{k}(h)+0.25*sample_rate:interspike_stop{k}{h}-1,1)';
            interspike_voltage_concat{k}{h}=[interspike_voltage_concat{k}{h} trialdata(interspike_start{k}{h}:pulse_finish{k}(h),1)'];
        elseif numel(interspike_stop{k}{h})==1 && numel(interspike_start{k}{h})==1 && interspike_stop{k}{h}>interspike_start{k}{h}
            interspike_voltage_concat{k}{h}=trialdata(interspike_start{k}{h}:interspike_stop{k}{h}-1,1)';
        end
        if numel(interspike_stop{k}{h})==1 && numel(interspike_start{k}{h})>1
            interspike_voltage_concat{k}{h}=trialdata(interspike_start{k}{h}(1):interspike_stop{k}{h}-1,1)';
            interspike_voltage_concat{k}{h}=[interspike_voltage_concat{k}{h} trialdata(interspike_start{k}{h}(end):pulse_finish{k}(h),1)'];
        elseif numel(interspike_stop{k}{h})>1 && numel(interspike_start{k}{h})==1
            interspike_voltage_concat{k}{h}=trialdata(pulse_start{k}(h)+0.25*sample_rate:interspike_stop{k}{h}(1)-1,1)';
            interspike_voltage_concat{k}{h}=[interspike_voltage_concat{k}{h} trialdata(interspike_start{k}{h}:interspike_stop{k}{h}(end)-1,1)'];
        end
        if numel(interspike_stop{k}{h})>1 && numel(interspike_start{k}{h})>1
            if numel(interspike_stop{k}{h})==numel(interspike_start{k}{h}) && interspike_stop{k}{h}(1)>interspike_start{k}{h}(1)
                for x=1:numel(interspike_stop{k}{h})
                    interspike_middle_segments{k}{h}{x}=trialdata(interspike_start{k}{h}(x):interspike_stop{k}{h}(x),1)';
                    interspike_voltage_concat{k}{h}=[interspike_voltage_concat{k}{h} interspike_middle_segments{k}{h}{x}];
                end
            elseif numel(interspike_stop{k}{h})==numel(interspike_start{k}{h}) && interspike_stop{k}{h}(1)<interspike_start{k}{h}(1)
                interspike_voltage_concat{k}{h}=trialdata(pulse_start{k}(h)+0.25*sample_rate:interspike_stop{k}{h}(1)-1,1)';
                for x=2:numel(interspike_stop{k}{h})
                    interspike_middle_segments{k}{h}{x}=trialdata(interspike_start{k}{h}(x-1):interspike_stop{k}{h}(x),1)';
                    interspike_voltage_concat{k}{h}=[interspike_voltage_concat{k}{h} interspike_middle_segments{k}{h}{x}];
                end
                interspike_voltage_concat{k}{h}=[interspike_voltage_concat{k}{h} trialdata(interspike_start{k}{h}(end):pulse_finish{k}(h),1)'];
            elseif numel(interspike_stop{k}{h})>numel(interspike_start{k}{h})
                interspike_voltage_concat{k}{h}=trialdata(pulse_start{k}(h)+0.25*sample_rate:interspike_stop{k}{h}(1)-1,1)';
                if numel(interspike_stop{k}{h})-numel(interspike_start{k}{h})>1
                    for x=2:numel(interspike_stop{k}{h})-1
                        interspike_middle_segments{k}{h}{x}=trialdata(interspike_start{k}{h}(x-1):interspike_stop{k}{h}(x),1)';
                        interspike_voltage_concat{k}{h}=[interspike_voltage_concat{k}{h} interspike_middle_segments{k}{h}{x}];
                        %if you want to see the trial with the ISI after
                        %0.05 s, put a stop sign above and run this:
                        %figure;plot(0.0001:0.0001:5.0001,trialdata(pulse_start{k}(h):pulse_finish{k}(h),1)*1e3)
                    end
                else
                    for x=2:numel(interspike_stop{k}{h})
                        interspike_middle_segments{k}{h}{x}=trialdata(interspike_start{k}{h}(x-1):interspike_stop{k}{h}(x),1)';
                        interspike_voltage_concat{k}{h}=[interspike_voltage_concat{k}{h} interspike_middle_segments{k}{h}{x}];
                    end
                end
            elseif numel(interspike_stop{k}{h})<numel(interspike_start{k}{h})
                for x=1:numel(interspike_stop{k}{h})
                    interspike_middle_segments{k}{h}{x}=trialdata(interspike_start{k}{h}(x):interspike_stop{k}{h}(x),1)';
                    interspike_voltage_concat{k}{h}=[interspike_voltage_concat{k}{h} interspike_middle_segments{k}{h}{x}];
                end
                interspike_voltage_concat{k}{h}=[interspike_voltage_concat{k}{h} trialdata(interspike_start{k}{h}(end):pulse_finish{k}(h),1)'];
            end
        end
        interspike_voltage{k}(h)=mean(interspike_voltage_concat{k}{h});
        
        pulse_duration=skip;
        
        if currents{k}(h)==0 && pulse_duration(k)>=.9
            std_noise(k)=std(trialdata(pulse_start{k}(h):pulse_start{k}(h)+1*sample_rate,1)*1e3);
            noise_V(k)=mean(trialdata(pulse_start{k}(h):pulse_start{k}(h)+1*sample_rate,1)*1e3);
        end
        
        std_noise_all{k}(h)=std(trialdata(pulse_start{k}(h)+5000:pulse_finish{k}(h),1)*1e3);
        
        if numberspikes{k}(h)==0 && pulse_start{k}(h)>pause_duration(k)*sample_rate
            holdingvoltage{k}(h)=mean(trialdata(pulse_start{k}(h)-pause_duration(k)*sample_rate+1:pulse_start{k}(h),1)*1e3);
        end
        
        if numel(inflection_points{1})>0
            thresholds{k}{h}=inflectionvoltage{k}((pulse_start{k}(h)+200<inflection_points{k})==(inflection_points{k}<pulse_finish{k}(h)-10));
        end
        
        %find the ratio between the first and last ISIs
        if numel(ISIs_all{k}{h})>1
            firstISI{k}(h)=ISIs_all{k}{h}(1);
            lastISI{k}(h)=ISIs_all{k}{h}(end);
            ISIratio{k}(h)=lastISI{k}(h)/firstISI{k}(h);
        elseif numel(ISIs_all{k}{h})==1
            firstISI{k}(h)=ISIs_all{k}{h}(1);
            lastISI{k}(h)=ISIs_all{k}{h}(end);
            ISIratio{k}(h)=NaN;
        else
            firstISI{k}(h)=NaN;
            lastISI{k}(h)=NaN;
            ISIratio{k}(h)=NaN;
        end

        % Find spike times for current pulse
        increment_spikes_trunc{k}{h}=find(spiketimes{k}(pulse_start{k}(h)+5000:pulse_finish{k}(h)-5000));
%         increment_spikes{k}{h}=find(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)));
        beforespike=7000;
        afterspike=3000;
        beforelastspike=5000;
        afterlastspike=5000;
        lastspikeforms_increment{k}(h,:)=NaN(1,beforelastspike+afterlastspike+1);
        lastoutputforms_increment{k}(h,:)=NaN(1,beforelastspike+afterlastspike+1);
        
        
        for p=1:numel(increment_spikes_trunc{k}{h})
            spikeforms_increment_trunc{k}{h}(p,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforespike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterspike-1,1);
            outputforms_increment_trunc{k}{h}(p,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforespike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterspike-1,2);
            spikeforms{k}(l+1,:)=spikeforms_increment_trunc{k}{h}(p,:);
            outputforms{k}(l+1,:)=outputforms_increment_trunc{k}{h}(p,:);
            frequencyforms{k}(l+1)=numel(increment_spikes_trunc{k}{h});
            l=l+1;
        end
        
        for p=1:numel(increment_spikes_trunc{k}{h})
            spikeforms_increment{k}{h}(p,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforespike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterspike-1,1);
            outputforms_increment{k}{h}(p,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforespike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterspike-1,2);
            
            if p==numel(increment_spikes_trunc{k}{h})
            lastspikeforms_increment{k}(h,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforelastspike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterlastspike-1,1);
            lastoutputforms_increment{k}(h,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforelastspike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterlastspike-1,2);
            end
        end
        
        if numel(ISIs{k}{h}>0)
            for p=1:numel(ISIs{k}{h})
                if 1/ISIs{k}{h}(p)<=1 && 1/ISIs{k}{h}(p)>0
                    freq0_spikeforms_increment(a+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq0_outputforms_increment(a+1,:)=outputforms_increment{k}{h}(p+1,:);
                    a=a+1;
                elseif 1/ISIs{k}{h}(p)<=2 && 1/ISIs{k}{h}(p)>1
                    freq1_spikeforms_increment(b+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq1_outputforms_increment(b+1,:)=outputforms_increment{k}{h}(p+1,:);
                    b=b+1;
                elseif 1/ISIs{k}{h}(p)<=3 && 1/ISIs{k}{h}(p)>2
                    freq2_spikeforms_increment(c+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq2_outputforms_increment(c+1,:)=outputforms_increment{k}{h}(p+1,:);
                    c=c+1;
                elseif 1/ISIs{k}{h}(p)<=4 && 1/ISIs{k}{h}(p)>3
                    freq3_spikeforms_increment(d+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq3_outputforms_increment(d+1,:)=outputforms_increment{k}{h}(p+1,:);
                    d=d+1;
                elseif 1/ISIs{k}{h}(p)<=5 && 1/ISIs{k}{h}(p)>4
                    freq4_spikeforms_increment(e+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq4_outputforms_increment(e+1,:)=outputforms_increment{k}{h}(p+1,:);
                    e=e+1;
                elseif 1/ISIs{k}{h}(p)<=6 && 1/ISIs{k}{h}(p)>5
                    freq5_spikeforms_increment(f+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq5_outputforms_increment(f+1,:)=outputforms_increment{k}{h}(p+1,:);
                    f=f+1;
                elseif 1/ISIs{k}{h}(p)<=7 && 1/ISIs{k}{h}(p)>6
                    freq6_spikeforms_increment(g+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq6_outputforms_increment(g+1,:)=outputforms_increment{k}{h}(p+1,:);
                    g=g+1;
                elseif 1/ISIs{k}{h}(p)<=8 && 1/ISIs{k}{h}(p)>7
                    freq7_spikeforms_increment(m+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq7_outputforms_increment(m+1,:)=outputforms_increment{k}{h}(p+1,:);
                    m=m+1;
                elseif 1/ISIs{k}{h}(p)<=9 && 1/ISIs{k}{h}(p)>8
                    freq8_spikeforms_increment(n+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq8_outputforms_increment(n+1,:)=outputforms_increment{k}{h}(p+1,:);
                    n=n+1;
                elseif 1/ISIs{k}{h}(p)<=10 && 1/ISIs{k}{h}(p)>9
                    freq9_spikeforms_increment(o+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq9_outputforms_increment(o+1,:)=outputforms_increment{k}{h}(p+1,:);
                    o=o+1;
                else
                    freq10_spikeforms_increment(q+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq10_outputforms_increment(q+1,:)=outputforms_increment{k}{h}(p+1,:);
                    q=q+1;
                end
            end
        end
        
        
        resistance_voltage2{k}(h)=mean(trialdata(pulse_start{k}(h)+tau_m:pulse_finish{k}(h)+tau_m*2,1));
        resistance_voltage1{k}(h)=mean(trialdata(pulse_start{k}(h)-tau_m:pulse_start{k}(h),1));
        % Fit an exponential to the charging of the membrane for the first
        % steps with between a 5 and 10 mV change
        if numberspikes{k}(h)==0 && k==1 && currents{k}(h)~=0 &&...
                abs(resistance_voltage2{k}(h)-resistance_voltage1{k}(h))*1e3>5 &&...
                abs(resistance_voltage2{k}(h)-resistance_voltage1{k}(h))*1e3<10
            %find the membrane resistance in mV/pA=GOhm
            r_m(h)=(resistance_voltage2{k}(h)-resistance_voltage1{k}(h))*1e3/currents{k}(h);
            if mean(trialdata(pulse_start{k}(h):pulse_finish{k}(h),1))>=mean(trialdata(pulse_start{k}(h)-pause_duration(k)*sample_rate:pulse_start{k}(h),1))
                disp([recdate '_' cellnum num2str(trials)])
%                 if strcmp([recdate '_' cellnum num2str(trials)],'May_05_15_A1')
%                     keyboard
%                 end
                expf_membrane(h,:)=nlinfit(risetime',trialdata(pulse_start{k}(h):pulse_start{k}(h)+tau_m-1,1)*1e3,...
                    'rising_membrane_expFun',parameters_up);
%                 hold on;plot(pulse_start{k}(h)/sample_rate+risetime'-1/sample_rate,rising_membrane_expFun(expf_membrane(h,:),risetime),'g','LineWidth',2)
            else
                disp([recdate '_' cellnum num2str(trials)])
%                 if strcmp([recdate '_' cellnum num2str(trials)],'May_05_15_A1')
%                     keyboard
%                 end
                expf_membrane(h,:)=nlinfit(risetime',trialdata(pulse_start{k}(h):pulse_start{k}(h)+tau_m-1,1)*1e3,...
                    'falling_membrane_expFun',parameters_down);
%                 hold on;plot(pulse_start{k}(h)/sample_rate+risetime'-1/sample_rate,falling_membrane_expFun(expf_membrane(h,:),risetime),'g','LineWidth',2)
            end
            c_m(h)=expf_membrane(h,3)/r_m(h); %capacitance in seconds/GOhms=nF
        end
    end
    
    if ~exist('ahp_depth_increment') % if there aren't any spikes in a trial, then this is needed so the function doesn't throw an error
        ahp_depth_increment=NaN;
        ahp_duration_increment=NaN;
    end
    
    mean_r_m=nanmean(r_m);
    mean_c_m=nanmean(c_m);
    mean_time_constant=nanmean(expf_membrane(:,3));
    
    mean_lastspikeforms_increment=nanmean(lastspikeforms_increment{k});
    mean_lastoutputforms_increment=nanmean(lastoutputforms_increment{k});
    
    if l>1
        mean_spikeform=nanmean(spikeforms{k});
        mean_outputform=nanmean(outputforms{k});
    elseif l==1
        mean_spikeform=spikeforms{k};
        mean_outputform=outputforms{k};
    else
        mean_spikeform=NaN(1,beforespike+afterspike+1);
        mean_outputform=NaN(1,beforespike+afterspike+1);
    end
    if a>1
        mean_freq0_spikeforms_increment=nanmean(freq0_spikeforms_increment);
        mean_freq0_outputforms_increment=nanmean(freq0_outputforms_increment);
    elseif a==1
        mean_freq0_spikeforms_increment=freq0_spikeforms_increment;
        mean_freq0_outputforms_increment=freq0_outputforms_increment;
    else
        mean_freq0_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq0_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if b>1
        mean_freq1_spikeforms_increment=nanmean(freq1_spikeforms_increment);
        mean_freq1_outputforms_increment=nanmean(freq1_outputforms_increment);
    elseif b==1
        mean_freq1_spikeforms_increment=freq1_spikeforms_increment;
        mean_freq1_outputforms_increment=freq1_outputforms_increment;
    else
        mean_freq1_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq1_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if c>1
        mean_freq2_spikeforms_increment=nanmean(freq2_spikeforms_increment);
        mean_freq2_outputforms_increment=nanmean(freq2_outputforms_increment);
    elseif c==1
        mean_freq2_spikeforms_increment=freq2_spikeforms_increment;
        mean_freq2_outputforms_increment=freq2_outputforms_increment;
    else
        mean_freq2_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq2_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if d>1
        mean_freq3_spikeforms_increment=nanmean(freq3_spikeforms_increment);
        mean_freq3_outputforms_increment=nanmean(freq3_outputforms_increment);
    elseif d==1
        mean_freq3_spikeforms_increment=freq3_spikeforms_increment;
        mean_freq3_outputforms_increment=freq3_outputforms_increment;
    else
        mean_freq3_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq3_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if e>1
        mean_freq4_spikeforms_increment=nanmean(freq4_spikeforms_increment);
        mean_freq4_outputforms_increment=nanmean(freq4_outputforms_increment);
    elseif e==1
        mean_freq4_spikeforms_increment=freq4_spikeforms_increment;
        mean_freq4_outputforms_increment=freq4_outputforms_increment;
    else
        mean_freq4_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq4_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if f>1
        mean_freq5_spikeforms_increment=nanmean(freq5_spikeforms_increment);
        mean_freq5_outputforms_increment=nanmean(freq5_outputforms_increment);
    elseif f==1
        mean_freq5_spikeforms_increment=freq5_spikeforms_increment;
        mean_freq5_outputforms_increment=freq5_outputforms_increment;
    else
        mean_freq5_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq5_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if g>1
        mean_freq6_spikeforms_increment=nanmean(freq6_spikeforms_increment);
        mean_freq6_outputforms_increment=nanmean(freq6_outputforms_increment);
    elseif g==1
        mean_freq6_spikeforms_increment=freq6_spikeforms_increment;
        mean_freq6_outputforms_increment=freq6_outputforms_increment;
    else
        mean_freq6_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq6_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if m>1
        mean_freq7_spikeforms_increment=nanmean(freq7_spikeforms_increment);
        mean_freq7_outputforms_increment=nanmean(freq7_outputforms_increment);
    elseif m==1
        mean_freq7_spikeforms_increment=freq7_spikeforms_increment;
        mean_freq7_outputforms_increment=freq7_outputforms_increment;
    else
        mean_freq7_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq7_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if n>1
        mean_freq8_spikeforms_increment=nanmean(freq8_spikeforms_increment);
        mean_freq8_outputforms_increment=nanmean(freq8_outputforms_increment);
    elseif n==1
        mean_freq8_spikeforms_increment=freq8_spikeforms_increment;
        mean_freq8_outputforms_increment=freq8_outputforms_increment;
    else
        mean_freq8_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq8_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if o>1
        mean_freq9_spikeforms_increment=nanmean(freq9_spikeforms_increment);
        mean_freq9_outputforms_increment=nanmean(freq9_outputforms_increment);
    elseif o==1
        mean_freq9_spikeforms_increment=freq9_spikeforms_increment;
        mean_freq9_outputforms_increment=freq9_outputforms_increment;
    else
        mean_freq9_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq9_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if q>1
        mean_freq10_spikeforms_increment=nanmean(freq10_spikeforms_increment);
        mean_freq10_outputforms_increment=nanmean(freq10_outputforms_increment);
    elseif q==1
        mean_freq10_spikeforms_increment=freq10_spikeforms_increment;
        mean_freq10_outputforms_increment=freq10_outputforms_increment;
    else
        mean_freq10_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq10_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    
    mean_holdingvoltage(k)=nanmean(holdingvoltage{k});
    
%     mean_r_m=nanmean(r_m);
%     std_r_m=nanstd(r_m);
%     mean_c_m=nanmean(c_m);
%     std_c_m=nanstd(c_m);
%     mean_time_constant=nanmean(expf_membrane(:,3));
%     std_time_constant=nanstd(expf_membrane(:,3));
    
    % Fit a line to the f-I curve
    if sum(rate_all{k}>0)>2 % keep this if statement if you want the points for the linear regression automatically chosen
        if find(rate_all{k}==max(rate_all{k}),1) - find(rate_all{k}>0,1) > 1
            points(2*k-1)=find(rate_all{k}>0,1);
            points(2*k)=find(rate_all{k}==max(rate_all{k}),1);%numel(rate_all{k});
        elseif find(rate_all{k}==max(rate_all{k}),1) - find(rate_all{k}>0,1) <= 1
            points(2*k-1)=find(rate_all{k}>0,1);
            points(2*k)=numel(rate_all{k});
        end
    end
    
    all_trunc{k}=rate_all{k}(points(2*k-1):points(2*k));
    currents_all{k}=currents{k}(points(2*k-1):points(2*k));
    
    if points(2*k)~=increments(k)
        peakrate(k)=all_trunc{k}(end);
    else
        nofailrate(k)=all_trunc{k}(end);
    end
    
%     % Fit a line to the f-I curve
%     if howmany==2 && ~mod(k,2)
%         all_trunc{k}=rate_all{k}(points(3):points(4));
%         currents_all{k}=currents{k}(points(3):points(4));
%     elseif howmany==2 && mod(k,2)
%         all_trunc{k}=rate_all{k}(points(1):points(2));
%         currents_all{k}=currents{k}(points(1):points(2));
%     else
%         all_trunc{k}=rate_all{k}(find(rate_all{k}>0,1):end);
%         currents_all{k}=currents{k}(find(rate_all{k}>0,1):end);
%     end
    
    pf_all{k}=regstats(all_trunc{k},currents_all{k},'linear',{'beta' 'yhat' 'rsquare'});
    
    % Initial membrane potential
    imp(k)=mean(trialdata(1:delay(k)*sample_rate,1))*1000;
    
    if shouldplotFI~=0
        if ~isequal(currents{k},0)
            figure;plot(currents{k},rate_all{k},'*k'); hold on; %%figure(k*3)
            plot(currents_all{k},pf_all{k}.yhat,'r'); hold on;
            title({['Rate for Cell ' recdate '_' cellnum num2str(trials(k))];...
                ['Held at ' num2str(imp(k)) ' mV; Delay: ' num2str(delay(k)) ' sec; Pulse Duration: '...
                num2str(pulse_duration(k)) ' sec; Pause Duration: ' num2str(pause_duration(k)) ' sec']},'interpreter','none')
            legend('Original Values',['Linear Fit, R^2=' num2str(pf_all{k}.rsquare)])
            xlabel('Current [pA]')
            ylabel('Firing Rate [Hz]')
            axis([currents{k}(1) currents{k}(end) 0 40])
        end
    end
end