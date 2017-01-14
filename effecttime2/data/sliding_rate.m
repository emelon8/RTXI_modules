function [rate_all,numberspikes,imp,coeff,rsqr]=...
    sliding_rate(module,recdate,cellnum,trials,sample_rate,delay,pulse_length,pause,windowsize,slidesize)
% MODULE is the name of the rtxi module used (e.g. 'fi_curves'); RECDATE is
% the date of recording (i.e. 'Jul_19_11'); CELLNUM is the letter of the
% cell number (e.g. 'A'); TRIAL is the number of trials for the cell (e.g.
% 9); SAMPLE_RATE is the sample rate in Hz;
% 
% The current must return to the starting value after the last pulse for
% some amount of time for this to work.
% 
% What if the first current pulse is 0 pA? It doesn't find it, but the size
% of the increments remains the same.

warning off all

load([module '_' recdate '_' cellnum])

eval(['trialdata=' module '_' recdate '_' cellnum num2str(trials) ';'])
% Evaluate spike times using a voltage threshold (rate of rise
% threshold method is commented out)
spiketimes=zeros(numel(trialdata(:,1)),1);
thresholdspikes(trialdata(:,1)>=-0.005)=1;
%     thresholdspikes(diff(trialdata(:,1))>0.003)=1;
spiketimes(find(diff(thresholdspikes)>0)+1)=1;

pulse_finish(1)=(delay+pulse_length)*sample_rate;
pulse_start(1)=pulse_finish(1)-pulse_length*sample_rate+1;
pulse_finish(2)=pulse_finish(1)+(pause+pulse_length)*sample_rate;
pulse_start(2)=pulse_finish(2)-(pulse_length*sample_rate-1);

% Finds the total number of spikes during each pulse
for h=1:2
    for g=1:(pulse_length-windowsize)/slidesize
        numberspikes(h,g)=sum(spiketimes(pulse_start(h)+(g-1)*slidesize*sample_rate:...
            pulse_start(h)+((g-1)*slidesize+windowsize)*sample_rate));
        rate_all(h,g)=numberspikes(h,g)/windowsize;
    end
end

% Initial membrane potential
imp=mean(trialdata(1:delay*sample_rate,1))*1000;

if isempty(find(rate_all(2,:)==0,1,'last'))
    firstnonzero=1;
else
    firstnonzero=find(rate_all(2,:)==0,1,'last');
end

[coeff,r]=nlinfit(slidesize*firstnonzero:slidesize:(pulse_length-windowsize),...
    rate_all(2,firstnonzero:end),@expdatafit,[5 -5 0]);

rsqr=1-sum(r.^2)/sum((rate_all(2,:)-mean(rate_all(2,:))).^2);

figure;plot(1/sample_rate:1/sample_rate:numel(trialdata(:,1))/sample_rate,trialdata(:,1))

figure;plot(slidesize:slidesize:(pulse_length-windowsize),rate_all','LineWidth',2); hold on; %%figure(k*3)
% title({['Initial Rate for Cell ' recdate '_' cellnum '_' num2str(trials)];...
%     ['Held at ' num2str(imp) ' mV; Delay: ' num2str(delay) ' sec; Pulse Duration: '...
%     num2str(pulse_duration) ' sec; Pause Duration: ' num2str(pause_duration) ' sec']},'interpreter','none')
xlabel('Time [sec]')
ylabel('Firing Rate [Hz]')

hold on;plot(slidesize*firstnonzero:slidesize:(pulse_length-windowsize),...
    expdatafit(coeff,slidesize*firstnonzero:slidesize:(pulse_length-windowsize)),'r','LineWidth',2)
legend('Depolarized',[num2str(pause) ' sec hyperpolarization'],['Exponential fit, R^2=' num2str(rsqr)])