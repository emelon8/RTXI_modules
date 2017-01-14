function [rate_all,peakrate,nofailrate,mean_holdingvoltage,... mean_r_m,std_r_m,mean_time_constant,std_time_constant,mean_c_m,std_c_m,
    numberspikes,thresholds,imp,pulse_duration,pause_duration,delay,increments,currents,...
    pf_all,std_noise,mean_spikeform,frequencyforms,ISIs_all,ISIs,ISIratio,firstISI,lastISI,...
    std_noise_all,mean_freq0_spikeforms_increment,mean_freq1_spikeforms_increment,...
    mean_freq2_spikeforms_increment,mean_freq3_spikeforms_increment,mean_freq4_spikeforms_increment,...
    mean_freq5_spikeforms_increment,mean_freq6_spikeforms_increment,mean_freq7_spikeforms_increment,...
    mean_freq8_spikeforms_increment,mean_freq9_spikeforms_increment,mean_freq10_spikeforms_increment,...
    mean_freq0_Isynforms_increment,mean_freq1_Isynforms_increment,...
    mean_freq2_Isynforms_increment,mean_freq3_Isynforms_increment,mean_freq4_Isynforms_increment,...
    mean_freq5_Isynforms_increment,mean_freq6_Isynforms_increment,mean_freq7_Isynforms_increment,...
    mean_freq8_Isynforms_increment,mean_freq9_Isynforms_increment,mean_freq10_Isynforms_increment,...
    mean_lastspikeforms_increment,mean_lastistepforms_increment,mean_lastIsynforms_increment,mean_lastoutputforms_increment]=...
    fi_rate(module,recdate,cellnum,trials,points,sample_rate,shouldplotFI)
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
spiketimes=cell(1,howmany); thresholdspikes=cell(1,howmany); inflections_temp=cell(1,howmany);
inflectiontimes=cell(1,howmany); thresholds=cell(1,howmany);
pulse_finish=cell(1,howmany); pulse_start=cell(1,howmany); numberspikes=cell(1,howmany);
rate_all=cell(1,howmany); peakrate=NaN(1,howmany); nofailrate=NaN(1,howmany); all_trunc=cell(1,howmany); currents_all=cell(1,howmany);
pf_all=cell(1,howmany); imp=NaN(1,howmany); std_noise=NaN(1,howmany);
% pf_all=NaN(howmany,2); linfit_all=cell(1,howmany); resid_all_lin=cell(1,howmany); SSresid_all_lin=NaN(1,howmany);
% SStotal_all_lin=NaN(1,howmany); rsq_all_lin=NaN(1,howmany); 

for k=1:howmany
    eval(['trialdata=' module '_' recdate '_' cellnum num2str(trials(k)) ';'])
    trialdata(:,1)=trialdata(:,1)*1e-3;
    frequencyforms{k}=NaN;
    
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
        pulse_finish{k}(h)=(delay(k)+pulse_duration(k))*sample_rate+(h-1)*((pulse_duration(k)+pause_duration(k))*sample_rate);
        pulse_start{k}(h)=pulse_finish{k}(h)-(pulse_duration(k)*sample_rate-1);
        
        % make the pulse duration 1 sec and the pulse finish after 1 sec
        skip=pulse_duration;
%         pulse_duration(k)=1;
%         pulse_finish{k}(h)=pulse_start{k}(h)+pulse_duration(k)*sample_rate-1;
        
        % Finds the total number of spikes during each pulse
        numberspikes{k}(h)=sum(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h)));
        ISIs_all{k}{h}=diff(find(spiketimes{k}(pulse_start{k}(h):pulse_finish{k}(h))>0))/sample_rate;
        ISIs{k}{h}=diff(find(spiketimes{k}(pulse_start{k}(h)+5000:pulse_finish{k}(h)-5000)>0))/sample_rate;
        rate_all{k}(h)=numberspikes{k}(h)/pulse_duration(k);
        
        pulse_duration=skip;
        
        if currents{k}(h)==0 && pulse_duration(k)>=.9
            std_noise(k)=std(trialdata(pulse_start{k}(h):pulse_start{k}(h)+1*sample_rate,1)*1e3);
        end
        
        std_noise_all{k}(h)=std(trialdata(pulse_start{k}(h)+5000:pulse_finish{k}(h),1)*1e3);
        
        if numberspikes{k}(h)==0 && pulse_start{k}(h)>pause_duration(k)*sample_rate
            holdingvoltage{k}(h)=mean(trialdata(pulse_start{k}(h)-pause_duration(k)*sample_rate+1:pulse_start{k}(h),1)*1e3);
        end
        
        if sum(inflections_temp{1})>0
            thresholds{k}{h}=inflectionvoltage{k}((pulse_start{k}(h)+200<inflectiontimes{k})==(inflectiontimes{k}<pulse_finish{k}(h)-10));
        end
        
        %find the ratio between the first and last ISIs
        if numel(ISIs_all{k}{h})>1
            firstISI{k}(h)=ISIs_all{k}{h}(1);
            lastISI{k}(h)=ISIs_all{k}{h}(end);
            ISIratio{k}(h)=ISIs_all{k}{h}(end)/ISIs_all{k}{h}(1);
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
        lastistepforms_increment{k}(h,:)=NaN(1,beforelastspike+afterlastspike+1);
        lastIsynforms_increment{k}(h,:)=NaN(1,beforelastspike+afterlastspike+1);
        lastoutputforms_increment{k}(h,:)=NaN(1,beforelastspike+afterlastspike+1);
        
        for p=1:numel(increment_spikes_trunc{k}{h})
            spikeforms_increment_trunc{k}{h}(p,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforespike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterspike-1,1);
            istepforms_increment_trunc{k}{h}(p,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforespike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterspike-1,2);
            Isynforms_increment_trunc{k}{h}(p,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforespike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterspike-1,3);
            outputforms_increment_trunc{k}{h}(p,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforespike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterspike-1,4);
            spikeforms{k}(l+1,:)=spikeforms_increment_trunc{k}{h}(p,:);
            istepforms{k}(l+1,:)=istepforms_increment_trunc{k}{h}(p,:);
            Isynforms{k}(l+1,:)=Isynforms_increment_trunc{k}{h}(p,:);
            outputforms{k}(l+1,:)=outputforms_increment_trunc{k}{h}(p,:);
            frequencyforms{k}(l+1)=numel(increment_spikes_trunc{k}{h});
            l=l+1;
        end
        
        for p=1:numel(increment_spikes_trunc{k}{h})
            spikeforms_increment{k}{h}(p,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforespike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterspike-1,1);
            istepforms_increment{k}{h}(p,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforespike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterspike-1,2);
            Isynforms_increment{k}{h}(p,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforespike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterspike-1,3);
            outputforms_increment{k}{h}(p,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforespike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterspike-1,4);
            
            if p==numel(increment_spikes_trunc{k}{h})
            lastspikeforms_increment{k}(h,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforelastspike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterlastspike-1,1);
            lastistepforms_increment{k}(h,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforelastspike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterlastspike-1,2);
            lastIsynforms_increment{k}(h,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforelastspike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterlastspike-1,3);
            lastoutputforms_increment{k}(h,:)=trialdata(pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)-beforelastspike-1:...
                pulse_start{k}(h)+5000+increment_spikes_trunc{k}{h}(p)+afterlastspike-1,4);
            end
        end
        
        if numel(ISIs{k}{h}>0)
            for p=1:numel(ISIs{k}{h})
                if 1/ISIs{k}{h}(p)<=1 && 1/ISIs{k}{h}(p)>0
                    freq0_spikeforms_increment(a+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq0_istepforms_increment(a+1,:)=istepforms_increment{k}{h}(p+1,:);
                    freq0_Isynforms_increment(a+1,:)=Isynforms_increment{k}{h}(p+1,:);
                    freq0_outputforms_increment(a+1,:)=outputforms_increment{k}{h}(p+1,:);
                    a=a+1;
                elseif 1/ISIs{k}{h}(p)<=2 && 1/ISIs{k}{h}(p)>1
                    freq1_spikeforms_increment(b+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq1_istepforms_increment(b+1,:)=istepforms_increment{k}{h}(p+1,:);
                    freq1_Isynforms_increment(b+1,:)=Isynforms_increment{k}{h}(p+1,:);
                    freq1_outputforms_increment(b+1,:)=outputforms_increment{k}{h}(p+1,:);
                    b=b+1;
                elseif 1/ISIs{k}{h}(p)<=3 && 1/ISIs{k}{h}(p)>2
                    freq2_spikeforms_increment(c+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq2_istepforms_increment(c+1,:)=istepforms_increment{k}{h}(p+1,:);
                    freq2_Isynforms_increment(c+1,:)=Isynforms_increment{k}{h}(p+1,:);
                    freq2_outputforms_increment(c+1,:)=outputforms_increment{k}{h}(p+1,:);
                    c=c+1;
                elseif 1/ISIs{k}{h}(p)<=4 && 1/ISIs{k}{h}(p)>3
                    freq3_spikeforms_increment(d+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq3_istepforms_increment(d+1,:)=istepforms_increment{k}{h}(p+1,:);
                    freq3_Isynforms_increment(d+1,:)=Isynforms_increment{k}{h}(p+1,:);
                    freq3_outputforms_increment(d+1,:)=outputforms_increment{k}{h}(p+1,:);
                    d=d+1;
                elseif 1/ISIs{k}{h}(p)<=5 && 1/ISIs{k}{h}(p)>4
                    freq4_spikeforms_increment(e+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq4_istepforms_increment(e+1,:)=istepforms_increment{k}{h}(p+1,:);
                    freq4_Isynforms_increment(e+1,:)=Isynforms_increment{k}{h}(p+1,:);
                    freq4_outputforms_increment(e+1,:)=outputforms_increment{k}{h}(p+1,:);
                    e=e+1;
                elseif 1/ISIs{k}{h}(p)<=6 && 1/ISIs{k}{h}(p)>5
                    freq5_spikeforms_increment(f+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq5_istepforms_increment(f+1,:)=istepforms_increment{k}{h}(p+1,:);
                    freq5_Isynforms_increment(f+1,:)=Isynforms_increment{k}{h}(p+1,:);
                    freq5_outputforms_increment(f+1,:)=outputforms_increment{k}{h}(p+1,:);
                    f=f+1;
                elseif 1/ISIs{k}{h}(p)<=7 && 1/ISIs{k}{h}(p)>6
                    freq6_spikeforms_increment(g+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq6_istepforms_increment(g+1,:)=istepforms_increment{k}{h}(p+1,:);
                    freq6_Isynforms_increment(g+1,:)=Isynforms_increment{k}{h}(p+1,:);
                    freq6_outputforms_increment(g+1,:)=outputforms_increment{k}{h}(p+1,:);
                    g=g+1;
                elseif 1/ISIs{k}{h}(p)<=8 && 1/ISIs{k}{h}(p)>7
                    freq7_spikeforms_increment(m+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq7_istepforms_increment(m+1,:)=istepforms_increment{k}{h}(p+1,:);
                    freq7_Isynforms_increment(m+1,:)=Isynforms_increment{k}{h}(p+1,:);
                    freq7_outputforms_increment(m+1,:)=outputforms_increment{k}{h}(p+1,:);
                    m=m+1;
                elseif 1/ISIs{k}{h}(p)<=9 && 1/ISIs{k}{h}(p)>8
                    freq8_spikeforms_increment(n+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq8_istepforms_increment(n+1,:)=istepforms_increment{k}{h}(p+1,:);
                    freq8_Isynforms_increment(n+1,:)=Isynforms_increment{k}{h}(p+1,:);
                    freq8_outputforms_increment(n+1,:)=outputforms_increment{k}{h}(p+1,:);
                    n=n+1;
                elseif 1/ISIs{k}{h}(p)<=10 && 1/ISIs{k}{h}(p)>9
                    freq9_spikeforms_increment(o+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq9_istepforms_increment(o+1,:)=istepforms_increment{k}{h}(p+1,:);
                    freq9_Isynforms_increment(o+1,:)=Isynforms_increment{k}{h}(p+1,:);
                    freq9_outputforms_increment(o+1,:)=outputforms_increment{k}{h}(p+1,:);
                    o=o+1;
                else
                    freq10_spikeforms_increment(q+1,:)=spikeforms_increment{k}{h}(p+1,:);
                    freq10_istepforms_increment(q+1,:)=istepforms_increment{k}{h}(p+1,:);
                    freq10_Isynforms_increment(q+1,:)=Isynforms_increment{k}{h}(p+1,:);
                    freq10_outputforms_increment(q+1,:)=outputforms_increment{k}{h}(p+1,:);
                    q=q+1;
                end
            end
        end
        
%         % Fit an exponential to the charging of the membrane for the first
%         % steps with between a 5 and 10 mV change
%         if numberspikes{k}(h)==0 && k==1 && currents{k}(h)~=0 &&...
%                 abs(mean(trialdata(pulse_start{k}(h)+tau_m:pulse_finish{k}(h)+tau_m*2,1))-mean(trialdata(pulse_start{k}(h)-tau_m:pulse_start{k}(h),1)))*1e3>5 &&...
%                 abs(mean(trialdata(pulse_start{k}(h)+tau_m:pulse_finish{k}(h)+tau_m*2,1))-mean(trialdata(pulse_start{k}(h)-tau_m:pulse_start{k}(h),1)))*1e3<10
%             %find the membrane resistance in mV/pA=GOhm
%             r_m(h)=(mean(trialdata(pulse_start{k}(h)+tau_m:pulse_finish{k}(h)+tau_m*2,1))-mean(trialdata(pulse_start{k}(h)-tau_m:pulse_start{k}(h),1)))*1e3/currents{k}(h);
%             if mean(trialdata(pulse_start{k}(h):pulse_finish{k}(h),1))>=mean(trialdata(pulse_start{k}(h)-pause_duration(k)*sample_rate:pulse_start{k}(h),1))
%                 expf_membrane(h,:)=nlinfit(risetime',trialdata(pulse_start{k}(h):pulse_start{k}(h)+tau_m-1,1)*1e3,...
%                     'rising_membrane_expFun',[-67.9685 8.4820 0.0587]);
% %                 hold on;plot(pulse_start{k}(h)/sample_rate+risetime'-1/sample_rate,rising_membrane_expFun(expf_membrane(h,:),risetime),'g','LineWidth',2)
%             else
%                 expf_membrane(h,:)=nlinfit(risetime',trialdata(pulse_start{k}(h):pulse_start{k}(h)+tau_m-1,1)*1e3,...
%                     'falling_membrane_expFun',[-89.0497 20.5893 0.0249]);
% %                 hold on;plot(pulse_start{k}(h)/sample_rate+risetime'-1/sample_rate,falling_membrane_expFun(expf_membrane(h,:),risetime),'g','LineWidth',2)
%             end
%             c_m(h)=expf_membrane(h,3)/r_m(h); %capacitance in seconds/GOhms=nF
%         end
    end
    
    mean_lastspikeforms_increment=nanmean(lastspikeforms_increment{k});
    mean_lastistepforms_increment=nanmean(lastistepforms_increment{k});
    mean_lastIsynforms_increment=nanmean(lastIsynforms_increment{k});
    mean_lastoutputforms_increment=nanmean(lastoutputforms_increment{k});
    
    if l>1
        mean_spikeform=nanmean(spikeforms{k});
        mean_istepform=nanmean(istepforms{k});
        mean_Isynform=nanmean(Isynforms{k});
        mean_outputform=nanmean(outputforms{k});
    elseif l==1
        mean_spikeform=spikeforms{k};
        mean_istepform=istepforms{k};
        mean_Isynform=Isynforms{k};
        mean_outputform=outputforms{k};
    else
        mean_spikeform=NaN(1,beforespike+afterspike+1);
        mean_istepform=NaN(1,beforespike+afterspike+1);
        mean_Isynform=NaN(1,beforespike+afterspike+1);
        mean_outputform=NaN(1,beforespike+afterspike+1);
    end
    if a>1
        mean_freq0_spikeforms_increment=nanmean(freq0_spikeforms_increment);
        mean_freq0_istepforms_increment=nanmean(freq0_istepforms_increment);
        mean_freq0_Isynforms_increment=nanmean(freq0_Isynforms_increment);
        mean_freq0_outputforms_increment=nanmean(freq0_outputforms_increment);
    elseif a==1
        mean_freq0_spikeforms_increment=freq0_spikeforms_increment;
        mean_freq0_istepforms_increment=freq0_istepforms_increment;
        mean_freq0_Isynforms_increment=freq0_Isynforms_increment;
        mean_freq0_outputforms_increment=freq0_outputforms_increment;
    else
        mean_freq0_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq0_istepforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq0_Isynforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq0_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if b>1
        mean_freq1_spikeforms_increment=nanmean(freq1_spikeforms_increment);
        mean_freq1_istepforms_increment=nanmean(freq1_istepforms_increment);
        mean_freq1_Isynforms_increment=nanmean(freq1_Isynforms_increment);
        mean_freq1_outputforms_increment=nanmean(freq1_outputforms_increment);
    elseif b==1
        mean_freq1_spikeforms_increment=freq1_spikeforms_increment;
        mean_freq1_istepforms_increment=freq1_istepforms_increment;
        mean_freq1_Isynforms_increment=freq1_Isynforms_increment;
        mean_freq1_outputforms_increment=freq1_outputforms_increment;
    else
        mean_freq1_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq1_istepforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq1_Isynforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq1_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if c>1
        mean_freq2_spikeforms_increment=nanmean(freq2_spikeforms_increment);
        mean_freq2_istepforms_increment=nanmean(freq2_istepforms_increment);
        mean_freq2_Isynforms_increment=nanmean(freq2_Isynforms_increment);
        mean_freq2_outputforms_increment=nanmean(freq2_outputforms_increment);
    elseif c==1
        mean_freq2_spikeforms_increment=freq2_spikeforms_increment;
        mean_freq2_istepforms_increment=freq2_istepforms_increment;
        mean_freq2_Isynforms_increment=freq2_Isynforms_increment;
        mean_freq2_outputforms_increment=freq2_outputforms_increment;
    else
        mean_freq2_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq2_istepforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq2_Isynforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq2_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if d>1
        mean_freq3_spikeforms_increment=nanmean(freq3_spikeforms_increment);
        mean_freq3_istepforms_increment=nanmean(freq3_istepforms_increment);
        mean_freq3_Isynforms_increment=nanmean(freq3_Isynforms_increment);
        mean_freq3_outputforms_increment=nanmean(freq3_outputforms_increment);
    elseif d==1
        mean_freq3_spikeforms_increment=freq3_spikeforms_increment;
        mean_freq3_istepforms_increment=freq3_istepforms_increment;
        mean_freq3_Isynforms_increment=freq3_Isynforms_increment;
        mean_freq3_outputforms_increment=freq3_outputforms_increment;
    else
        mean_freq3_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq3_istepforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq3_Isynforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq3_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if e>1
        mean_freq4_spikeforms_increment=nanmean(freq4_spikeforms_increment);
        mean_freq4_istepforms_increment=nanmean(freq4_istepforms_increment);
        mean_freq4_Isynforms_increment=nanmean(freq4_Isynforms_increment);
        mean_freq4_outputforms_increment=nanmean(freq4_outputforms_increment);
    elseif e==1
        mean_freq4_spikeforms_increment=freq4_spikeforms_increment;
        mean_freq4_istepforms_increment=freq4_istepforms_increment;
        mean_freq4_Isynforms_increment=freq4_Isynforms_increment;
        mean_freq4_outputforms_increment=freq4_outputforms_increment;
    else
        mean_freq4_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq4_istepforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq4_Isynforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq4_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if f>1
        mean_freq5_spikeforms_increment=nanmean(freq5_spikeforms_increment);
        mean_freq5_istepforms_increment=nanmean(freq5_istepforms_increment);
        mean_freq5_Isynforms_increment=nanmean(freq5_Isynforms_increment);
        mean_freq5_outputforms_increment=nanmean(freq5_outputforms_increment);
    elseif f==1
        mean_freq5_spikeforms_increment=freq5_spikeforms_increment;
        mean_freq5_istepforms_increment=freq5_istepforms_increment;
        mean_freq5_Isynforms_increment=freq5_Isynforms_increment;
        mean_freq5_outputforms_increment=freq5_outputforms_increment;
    else
        mean_freq5_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq5_istepforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq5_Isynforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq5_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if g>1
        mean_freq6_spikeforms_increment=nanmean(freq6_spikeforms_increment);
        mean_freq6_istepforms_increment=nanmean(freq6_istepforms_increment);
        mean_freq6_Isynforms_increment=nanmean(freq6_Isynforms_increment);
        mean_freq6_outputforms_increment=nanmean(freq6_outputforms_increment);
    elseif g==1
        mean_freq6_spikeforms_increment=freq6_spikeforms_increment;
        mean_freq6_istepforms_increment=freq6_istepforms_increment;
        mean_freq6_Isynforms_increment=freq6_Isynforms_increment;
        mean_freq6_outputforms_increment=freq6_outputforms_increment;
    else
        mean_freq6_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq6_istepforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq6_Isynforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq6_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if m>1
        mean_freq7_spikeforms_increment=nanmean(freq7_spikeforms_increment);
        mean_freq7_istepforms_increment=nanmean(freq7_istepforms_increment);
        mean_freq7_Isynforms_increment=nanmean(freq7_Isynforms_increment);
        mean_freq7_outputforms_increment=nanmean(freq7_outputforms_increment);
    elseif m==1
        mean_freq7_spikeforms_increment=freq7_spikeforms_increment;
        mean_freq7_istepforms_increment=freq7_istepforms_increment;
        mean_freq7_Isynforms_increment=freq7_Isynforms_increment;
        mean_freq7_outputforms_increment=freq7_outputforms_increment;
    else
        mean_freq7_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq7_istepforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq7_Isynforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq7_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if n>1
        mean_freq8_spikeforms_increment=nanmean(freq8_spikeforms_increment);
        mean_freq8_istepforms_increment=nanmean(freq8_istepforms_increment);
        mean_freq8_Isynforms_increment=nanmean(freq8_Isynforms_increment);
        mean_freq8_outputforms_increment=nanmean(freq8_outputforms_increment);
    elseif n==1
        mean_freq8_spikeforms_increment=freq8_spikeforms_increment;
        mean_freq8_istepforms_increment=freq8_istepforms_increment;
        mean_freq8_Isynforms_increment=freq8_Isynforms_increment;
        mean_freq8_outputforms_increment=freq8_outputforms_increment;
    else
        mean_freq8_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq8_istepforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq8_Isynforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq8_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if o>1
        mean_freq9_spikeforms_increment=nanmean(freq9_spikeforms_increment);
        mean_freq9_istepforms_increment=nanmean(freq9_istepforms_increment);
        mean_freq9_Isynforms_increment=nanmean(freq9_Isynforms_increment);
        mean_freq9_outputforms_increment=nanmean(freq9_outputforms_increment);
    elseif o==1
        mean_freq9_spikeforms_increment=freq9_spikeforms_increment;
        mean_freq9_istepforms_increment=freq9_istepforms_increment;
        mean_freq9_Isynforms_increment=freq9_Isynforms_increment;
        mean_freq9_outputforms_increment=freq9_outputforms_increment;
    else
        mean_freq9_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq9_istepforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq9_Isynforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq9_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    if q>1
        mean_freq10_spikeforms_increment=nanmean(freq10_spikeforms_increment);
        mean_freq10_istepforms_increment=nanmean(freq10_istepforms_increment);
        mean_freq10_Isynforms_increment=nanmean(freq10_Isynforms_increment);
        mean_freq10_outputforms_increment=nanmean(freq10_outputforms_increment);
    elseif q==1
        mean_freq10_spikeforms_increment=freq10_spikeforms_increment;
        mean_freq10_istepforms_increment=freq10_istepforms_increment;
        mean_freq10_Isynforms_increment=freq10_Isynforms_increment;
        mean_freq10_outputforms_increment=freq10_outputforms_increment;
    else
        mean_freq10_spikeforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq10_istepforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq10_Isynforms_increment=NaN(1,beforespike+afterspike+1);
        mean_freq10_outputforms_increment=NaN(1,beforespike+afterspike+1);
    end
    
    
    mean_holdingvoltage(k)=nanmean(holdingvoltage{k});
    
    mean_r_m=nanmean(r_m);
    std_r_m=nanstd(r_m);
    mean_c_m=nanmean(c_m);
    std_c_m=nanstd(c_m);
    mean_time_constant=nanmean(expf_membrane(:,3));
    std_time_constant=nanstd(expf_membrane(:,3));
    
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
    currents_all{k}=currents{k}(points(2*k-1):points(2*k));
    
    if points(2*k)~=increments(k)
        peakrate(k)=all_trunc{k}(end);
    else
        nofailrate(k)=all_trunc{k}(end);
    end
    
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