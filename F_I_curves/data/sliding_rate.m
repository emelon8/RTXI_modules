function [rate_all,numberspikes,mean_v,imp]=...
    sliding_rate(module,recdate,cellnum,trials,sample_rate,delay,pulse_length,...
    pause_length,increments,windowsize,slidesize)

load([module '_' recdate '_' cellnum])

eval(['trialdata=' module '_' recdate '_' cellnum num2str(trials) ';'])
% Evaluate spike times using a voltage threshold (rate of rise
% threshold method is commented out)
spiketimes=zeros(numel(trialdata(:,1)),1);
thresholdspikes(trialdata(:,1)>=0)=1;
%     thresholdspikes(diff(trialdata(:,1))>0.003)=1;
spiketimes(find(diff(thresholdspikes)>0)+1)=1;

for k=1:increments
    pulse_finish(k)=(delay+k*(pause_length+pulse_length))*sample_rate;
    pulse_start(k)=(delay+k*(pause_length+pulse_length)-pulse_length)*sample_rate+1;
    
    % Find the prestep voltages
    mean_v(k)=mean(trialdata(pulse_start(k)-pause_length*sample_rate:pulse_start(k)-1,1))*1000;
    
    % Find the total number of spikes during each pulse
    for g=1:(pulse_length-windowsize)/slidesize
        numberspikes(k,g)=sum(spiketimes(pulse_start(k)+(g-1)*slidesize*sample_rate:...
            pulse_start(k)+((g-1)*slidesize+windowsize)*sample_rate));
        rate_all(k,g)=numberspikes(k,g)/windowsize;
    end
end

% Initial membrane potential
imp=mean(trialdata(1:delay*sample_rate,1))*1000;

% [coeff,r]=nlinfit(slidesize:slidesize:(pulse_length-windowsize),rate_all(2,:),@expdatafit,[5 -5 0]);
% 
% rsqr=1-sum(r.^2)/sum((rate_all(2,:)-mean(rate_all(2,:))).^2);

figure;plot(slidesize:slidesize:(pulse_length-windowsize),rate_all','LineWidth',2); hold on; %%figure(k*3)
% title({['Initial Rate for Cell ' recdate '_' cellnum '_' num2str(trials)];...
%     ['Held at ' num2str(imp) ' mV; Delay: ' num2str(delay) ' sec; Pulse Duration: '...
%     num2str(pulse_duration) ' sec; Pause Duration: ' num2str(pause_duration) ' sec']},'interpreter','none')
legend(num2str(mean_v(1)),num2str(mean_v(2)),num2str(mean_v(3)),num2str(mean_v(4)),num2str(mean_v(5)),num2str(mean_v(6)),num2str(mean_v(7)),num2str(mean_v(8)),num2str(mean_v(9)),num2str(mean_v(10)),num2str(mean_v(11)))%,num2str(mean_v(12)),num2str(mean_v(13)),num2str(mean_v(14)))
xlabel('Time [sec]')
ylabel('Firing Rate [Hz]')