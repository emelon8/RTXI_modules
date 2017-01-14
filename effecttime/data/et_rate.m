function [rate_all,numberspikes,imp]=...
    et_rate(module,recdate,cellnum,trials,sample_rate,delay,pulse_length,first_pause,second_pause,increments)
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

howmany=numel(trials);

firstpauses=first_pause*logspace(0,(increments/2-1),increments/2);
secondpauses=second_pause*logspace(0,(increments/2-1),increments/2);
pauses(1:2:increments)=firstpauses;
pauses(2:2:increments)=secondpauses;

eval(['trialdata=' module '_' recdate '_' cellnum num2str(trials) ';'])
% Evaluate spike times using a voltage threshold (rate of rise
% threshold method is commented out)
spiketimes=zeros(numel(trialdata(:,1)),1);
thresholdspikes(trialdata(:,1)>=-0.005)=1;
%     thresholdspikes(diff(trialdata(:,1))>0.003)=1;
spiketimes(find(diff(thresholdspikes)>0)+1)=1;

totalpause=0;

for h=1:increments+1;
    if mod(h,2)~=0
        thispause=first_pause*10^((h-1)/2)*sample_rate;
    else
        thispause=second_pause*10^(h/2-1)*sample_rate;
    end
    totalpause=totalpause+thispause;
    % Define these three so I don't have to use them over and over
    % again
    pulse_finish(h)=(delay+h*pulse_length)*sample_rate+totalpause-thispause;
    pulse_start(h)=pulse_finish(h)-(pulse_length*sample_rate-1);
    
    % Finds the total number of spikes during each pulse
    for g=1:4
        numberspikes(h,g)=sum(spiketimes(pulse_start(h)+(g-1)*pulse_length*sample_rate/4:...
            pulse_start(h)+g*pulse_length*sample_rate/4));
        rate_all(h,g)=numberspikes(h,g)/(pulse_length/4);
    end
end

% Initial membrane potential
imp=mean(trialdata(1:delay*sample_rate,1))*1000;

figure;plot(rate_all,'LineWidth',2); hold on; %%figure(k*3)
% title({['Initial Rate for Cell ' recdate '_' cellnum '_' num2str(trials)];...
%     ['Held at ' num2str(imp) ' mV; Delay: ' num2str(delay) ' sec; Pulse Duration: '...
%     num2str(pulse_duration) ' sec; Pause Duration: ' num2str(pause_duration) ' sec']},'interpreter','none')
legend('0-5 sec','5-10 sec','10-15 sec','15-20 sec')
ylabel('Firing Rate [Hz]')

figure;plot(rate_all','LineWidth',2); hold on; %%figure(k*3)
% title({['Initial Rate for Cell ' recdate '_' cellnum '_' num2str(trials)];...
%     ['Held at ' num2str(imp) ' mV; Delay: ' num2str(delay) ' sec; Pulse Duration: '...
%     num2str(pulse_duration) ' sec; Pause Duration: ' num2str(pause_duration) ' sec']},'interpreter','none')
legend('Depolarized','5 sec','1 sec','0.5 sec','0.1 sec','0.05 sec','0.01 sec')
ylabel('Firing Rate [Hz]')