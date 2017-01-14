function [rate_all,numberspikes,imp,pulse_duration,pause_duration,delay,increments,currents,pf_all,threshold,avg_voltage,avg_voltage_trunc,pf_supra_iv]=...
    fV_rate_leak_and_subtraction(module,recdate,cellnum,trials,points,sample_rate,shouldplotFV,noise)
% MODULE is the name of the rtxi module used (e.g. 'fi_curves'); RECDATE is
% the date of recording (i.e. 'Jul_19_11'); CELLNUM is the letter of the
% cell number (e.g. 'A'); TRIALS is the number of trials for the cell (e.g.
% 9); SAMPLE_RATE is the sample rate in Hz; SHOULDPLOTFV, denotes whether
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

howmany=numel(trials);

% Preallocate vectors associated with currents
first_pulse=NaN(1,howmany); first_pause=NaN(1,howmany); second_pulse=NaN(1,howmany);
second_pause=NaN(1,howmany); third_pulse=NaN(1,howmany); last_pause=NaN(1,howmany);
delay=NaN(1,howmany); pulse_duration=NaN(1,howmany); pause_duration=NaN(1,howmany);
start_current=NaN(1,howmany); finish_current=NaN(1,howmany); increments=NaN(1,howmany);
currents=cell(1,howmany);avg_voltage=cell(1,howmany);avg_voltage_trunc=cell(1,howmany);

% Preallocate vectors associated with rates
spiketimes=cell(1,howmany); thresholdspikes=cell(1,howmany);
pulse_finish=cell(1,howmany); pulse_start=cell(1,howmany); numberspikes=cell(1,howmany);
rate_all=cell(1,howmany); all_trunc=cell(1,howmany); currents_all=cell(1,howmany);
pf_all=cell(1,howmany); imp=NaN(1,howmany); threshold=NaN(1,howmany);

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
    
    % Evaluate spike times using a voltage threshold (rate of rise
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
        
        % make the pulse duration 1 sec and the pulse finish after 1 sec
        skip=pulse_duration;
%         pulse_duration(k)=1;
%         pulse_finish{k}(h)=pulse_start{k}(h)+pulse_duration(k)*sample_rate-1;
        
        % Finds the total number of spikes during each pulse
        numberspikes{k}(h)=sum(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)));
        rate_all{k}(h)=numberspikes{k}(h)/pulse_duration(k);
        avg_voltage{k}(h)=mean(trialdata(pulse_start{k}(h)+2500:pulse_finish{k}(h)))*1e3;
        skew_noise{k}(h)=skewness(trialdata(pulse_start{k}(h)+2500:pulse_finish{k}(h),1)*1e3);
        
        pulse_duration=skip;
    end
    
    % Fit a line to the f-I curve
    if sum(rate_all{k}>0)>2 % keep this if statement if you want the points for the linear regression automatically chosen
        if find(rate_all{k}==max(rate_all{k}),1) - find(rate_all{k}>0,1) > 1
            points(2*k-1)=find(rate_all{k}>0,1);
            points(2*k)=find(rate_all{k}==max(rate_all{k}),1);
        elseif find(rate_all{k}==max(rate_all{k}),1) - find(rate_all{k}>0,1) <= 1
            points(2*k-1)=find(rate_all{k}>0,1);
            points(2*k)=numel(rate_all{k});
        end
    end
    
    all_trunc{k}=rate_all{k}(points(2*k-1):points(2*k));
    avg_voltage_trunc{k}=avg_voltage{k}(points(2*k-1):points(2*k));
    
    pf_all{k}=regstats(all_trunc{k},avg_voltage_trunc{k},'linear',{'beta' 'yhat' 'rsquare'});
    
    % fit line to suprathreshold I-V curve
    if points(2*k-1)==1
        pf_supra_iv{k}=regstats(avg_voltage{k}(points(2*k-1):end),currents{k}(points(2*k-1):end),...
            'linear',{'beta' 'yhat' 'rsquare'});
        pf_supra_iv{k}.beta=[NaN;NaN];
    else
        pf_supra_iv{k}=regstats(avg_voltage{k}(points(2*k-1):end),currents{k}(points(2*k-1):end),...
            'linear',{'beta' 'yhat' 'rsquare'});
    end
        
    % Initial membrane potential
    imp(k)=mean(trialdata(1:delay(k)*sample_rate,1))*1000;
    
    % Find the voltage threshold
    if sum(rate_all{k}>0)
        threshold(k)=min(avg_voltage{k}(rate_all{k}>0));
    end
    
    if shouldplotFV~=0
        if ~isequal(currents{k},0)
            figure;plot(avg_voltage{k},rate_all{k},'k'); hold on; %%figure(k*3)
            plot(avg_voltage_trunc{k},pf_all{k}.yhat,'r'); hold on;
            title({['Initial Rate for Cell ' recdate '_' cellnum num2str(trials(k))];...
                ['Held at ' num2str(imp(k)) ' mV; Delay: ' num2str(delay(k)) ' sec; Pulse Duration: '...
                num2str(pulse_duration(k)) ' sec; Pause Duration: ' num2str(pause_duration(k)) ' sec']},'interpreter','none')
            legend('Original Values',['Linear Fit, R^2=' num2str(pf_all{k}.rsquare)])
            xlabel('Voltage [mV]')
            ylabel('Firing Rate [Hz]')
            axis([min(avg_voltage{k}) max(avg_voltage{k}) 0 30])
        end
    end
end
