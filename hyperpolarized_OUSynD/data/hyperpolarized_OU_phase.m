function [phases,rate,spikeform,length_meanvector,frequency,mean_voltage]=...
    hyperpolarized_OU_phase(module,recdate,cellnum,outime,pauset,reps,trials,sample_rate)
% MODULE is the name of the rtxi module used (e.g. 'fi_curves'); RECDATE is
% the date of recording (i.e. 'Jul_19_11'); CELLNUM is the letter of the
% cell number (e.g. 'A'); TRIALS is the number of trials for the cell (e.g.
% 9); SAMPLE_RATE is the sample rate in Hz; PHASES is the output vector of
% the different phases of the spikes, from 0 to 2*pi.

warning off all

load([module '_' recdate '_' cellnum])

howmany=numel(trials);

% Preallocate vectors associated with currents
half_wavelength=NaN(1,howmany); wavelength=NaN(1,howmany); amplitude=NaN(1,howmany);

% Preallocate vectors associated with rates
spikemarks=cell(1,howmany); thresholdspikes=cell(1,howmany); spiketimes=cell(1,howmany);
phases=cell(1,howmany); spikes=cell(1,howmany); spikeform=cell(1,howmany);
ISI=cell(1,howmany); rate=NaN(1,howmany); CV=NaN(1,howmany); unitvectors=cell(1,howmany);
meanphases=NaN(1,howmany); meanvectors=NaN(howmany,2); length_meanvector=NaN(1,howmany);
mean_voltage=NaN(1,howmany); allISI=cell(1,howmany); allphases=cell(1,howmany);
allunitvectors=cell(1,howmany); allspikes=cell(1,howmany);

% How much time (in tenths of ms) before and after the spike to average
beforespike=1000;
afterspike=60;

for k=1:howmany
    eval(['trialdata=' module '_' recdate '_' cellnum num2str(trials(k)) ';'])
    
    % Find out the currents used in each individual trial. If the entire
    % trial has an input current of 0 pA, then skip this step.
    if ~isequal(trialdata(pauset*sample_rate+1:(pauset+outime)*sample_rate,2),...
            zeros(size(trialdata(pauset*sample_rate+1:(pauset+outime)*sample_rate,2))))
        % Find the time in 100s of microseconds (assuming the sample_rate
        % is 10000 Hz) from the beginning until the first crossing of zero.
        half_wavelength(k)=find(trialdata(pauset*sample_rate+1:(pauset+outime)*sample_rate,2)<0,1);
        
        % Find the time from the first crossing of zero to the end of the
        % first wavelength and add it to find the total wavelength time.
        wavelength(k)=(find(trialdata(pauset*sample_rate+half_wavelength(k):(pauset+outime)*sample_rate,2)>0,1)-1)*2;
        
        % Find the amplitude of the sine wave.
        amplitude(k)=max(trialdata(pauset*sample_rate+1:(pauset+outime)*sample_rate,2));
        
    else
        wavelength(k)=numel(trialdata(pauset*sample_rate+1:(pauset+outime)*sample_rate,2));
        amplitude(k)=0;
    end
    
    if round(1/(wavelength(k)/sample_rate))>=1
        frequency(k)=round(1/(wavelength(k)/sample_rate));
    else
        frequency(k)=round(10/(wavelength(k)/sample_rate))/10;
    end
    
    
    if reps>1
        for o=1:reps
            repstart=(o*(pauset+outime)-outime)*sample_rate+1;
            repfinish=o*(pauset+outime)*sample_rate;
            % Evaluate spike times using a voltage threshold (rate of rise
            % threshold method is commented out)
            spikemarks{k}{o}=zeros(numel(trialdata(repstart:repfinish,1)),1);
            thresholdspikes{k}{o}(trialdata(repstart:repfinish,1)>=-0.02)=1;
            %     thresholdspikes{k}(diff(trialdata(:,1))>1)=1;
            spikemarks{k}{o}(find(diff(thresholdspikes{k}{o})>0)+1)=1;
            
            % Find rates based on the interspike intervals
            ISI{k}{o}=diff(find(diff(spikemarks{k}{o})>0)+1)/sample_rate; % Finds the ISI in seconds
            
            allISI{k}=[allISI{k} ; ISI{k}{o}];
            raterep(k,o)=1./mean(ISI{k}{o});
            
            % find the phases and average spike shape
            spiketimes{k}{o}=find(spikemarks{k}{o}==1);
            for p=1:numel(spiketimes{k}{o})
                if spiketimes{k}{o}(p)-beforespike>0.05*sample_rate && spiketimes{k}{o}(p)+afterspike<=numel(trialdata(repstart:repfinish,1))
                    spikes{k}{o}(p,:)=trialdata(repstart+spiketimes{k}{o}(p)-beforespike:repstart+spiketimes{k}{o}(p)+afterspike);
                end
                
                % this assumes each pulse starts the sine wave at the same
                % phase and that phase is zero radians.
                phases{k}{o}(p)=mod(spiketimes{k}{o}(p),wavelength(k))*2*pi/wavelength(k);
                
                unitvectors{k}{o}(p,:)=[cos(phases{k}{o}(p)) sin(phases{k}{o}(p))];
            end
            
            numberofspikes=size(spiketimes{k}{o});
            
            if numberofspikes(1)~=0
                allphases{k}=[allphases{k} ; phases{k}{o}'];
                allunitvectors{k}=[allunitvectors{k} ; unitvectors{k}{o}];
                allspikes{k}=[allspikes{k} ; spikes{k}{o}];
            end
        end
        
        rate(k)=1./mean(allISI{k});
        CV(k)=std(allISI{k})/mean(allISI{k});
        
        meanvectors(k,:)=mean(allunitvectors{k});
        meanphases(k)=atan2(meanvectors(k,2),meanvectors(k,1)); % Alternative method to find the mean phase
        if sign(meanphases(k))==-1
            meanphases(k)=2*pi+meanphases(k);
        end
        length_meanvector(k)=sqrt(meanvectors(k,1)^2+meanvectors(k,2)^2);
        
        spikeform{k}=mean(allspikes{k});
        
%             figure;hist(phases{k}*360/(2*pi),20);%linspace(0,360,100) or 2*pi instead of 360
%             title(['Input Frequency: ' num2str(sample_rate/wavelength(k)) ' Hz; Input Amplitude: '...
%                 num2str(amplitude(k)*1e12) ' pA; Spike Rate: ' num2str(rate(k,o)) ' Hz'])
%             xlabel('Phase (degrees)')
%             ylabel('Spike Count')
%             axis tight
            
        mean_voltage(k)=mean(trialdata(repstart:repfinish,1));
        
        color=[rand rand rand];
        
        figure(k);roseplot=rose(allphases{k},20); %circ_plot(phases{k}','hist',[],100,true,true);
        set(roseplot,'Color',color)
%         figure;compass(unitvectors{k}(:,1),unitvectors{k}(:,2))
%         hold on;compass(meanvectors(k,1),meanvectors(k,2),'r')
        title({['Mean Voltage: ' num2str(mean_voltage(k)) ' mV; Input Frequency: ' num2str(frequency(k)) '; Spike Rate: ' num2str(rate(k)) ' Hz; ISI CV: ' num2str(CV(k))];...
            ['Mean Vector: Phase=' num2str(meanphases(k)/pi) ' \pi; Length=' num2str(length_meanvector(k))]})
        figure(3);hold on;plot(1/sample_rate:1/sample_rate:numel(spikeform{1})/sample_rate,...
            spikeform{k},'Color',color)
    else
        mean_voltage(k)=mean(trialdata(pauset*sample_rate+1:(pauset+outime)*sample_rate,1));
        [c_ww,lags] = xcorr(trialdata(pauset*sample_rate+1:(pauset+outime)*sample_rate,1)-...
            mean(trialdata(pauset*sample_rate+1:(pauset+outime)*sample_rate,1)),10000,'coeff');
        figure;plot(c_ww)
        title(['Voltage Autocorrelation; Mean Voltage: ' num2str(mean_voltage(k)) ' mV ; STD = ' num2str(std(trialdata(pauset*sample_rate+1:(pauset+outime)*sample_rate,1)))])
    end
end

% frequencies=[];
% 
% for j=1:numel(frequency)-3%%%%%%%%%%%
%     if frequency(j)==0.1
%         mean_vectors(1)=length_meanvector(j);
%         frequencies=[frequencies(frequencies<0.1) 0.1 frequencies(frequencies>0.1)];
%     elseif frequency(j)==1
%         mean_vectors(2)=length_meanvector(j);
%         frequencies=[frequencies(frequencies<1) 1 frequencies(frequencies>1)];
%     elseif frequency(j)==5
%         mean_vectors(3)=length_meanvector(j);
%         frequencies=[frequencies(frequencies<5) 5 frequencies(frequencies>5)];
%     elseif frequency(j)==10
%         mean_vectors(4)=length_meanvector(j);
%         frequencies=[frequencies(frequencies<10) 10 frequencies(frequencies>10)];
%     elseif frequency(j)==20
%         mean_vectors(5)=length_meanvector(j);
%         frequencies=[frequencies(frequencies<20) 20 frequencies(frequencies>20)];
%     elseif frequency(j)==30
%         mean_vectors(6)=length_meanvector(j);
%         frequencies=[frequencies(frequencies<30) 30 frequencies(frequencies>30)];
%     elseif frequency(j)==50
%         mean_vectors(7)=length_meanvector(j);
%         frequencies=[frequencies(frequencies<50) 50 frequencies(frequencies>50)];
%     end
% end
% 
% figure;plot(frequencies,mean_vectors)