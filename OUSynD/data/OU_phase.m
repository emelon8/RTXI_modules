function [phases,rate,spikeform,length_meanvector,frequency,mean_voltage]=OU_phase(module,recdate,cellnum,trials,sample_rate)
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
mean_voltage=NaN(1,howmany);

% How much time (in tenths of ms) before and after the spike to average
beforespike=9;
afterspike=60;

for k=1:howmany
    eval(['trialdata=' module '_' recdate '_' cellnum num2str(trials(k)) ';'])
    
    % Find out the currents used in each individual trial. If the entire
    % trial has an input current of 0 pA, then skip this step.
    if ~isequal(trialdata(:,3),zeros(size(trialdata(:,3))))
        % Find the time in 100s of microseconds (assuming the sample_rate
        % is 10000 Hz) from the beginning until the first crossing of zero.
        half_wavelength(k)=find(trialdata(:,3)<0,1);
        
        % Find the time from the first crossing of zero to the end of the
        % first wavelength and add it to find the total wavelength time.
        wavelength(k)=half_wavelength(k)-1+find(trialdata(half_wavelength(k):end,3)>0,1)-1;
        
        % Find the amplitude of the sine wave.
        amplitude(k)=max(trialdata(:,3));
        
    else
        wavelength(k)=numel(trialdata(:,3));
        amplitude(k)=0;
    end
    
    % Evaluate spike times using a voltage threshold (rate of rise
    % threshold method is commented out)
    spikemarks{k}=zeros(numel(trialdata(:,1)),1);
        thresholdspikes{k}(trialdata(:,1)>=-0.02)=1;
%     thresholdspikes{k}(diff(trialdata(:,1))>1)=1;
    spikemarks{k}(find(diff(thresholdspikes{k})>0)+1)=1;
    
    if sum(spikemarks{k})~=0
        % Find rates based on the interspike intervals
        ISI{k}=diff(find(diff(spikemarks{k})>0)+1)/sample_rate; % Finds the ISI in seconds
        
        if numel(ISI{k})>0
            rate(k)=1./mean(ISI{k});
            CV(k)=std(ISI{k})/mean(ISI{k});
        else
            rate(k)=0;
        end
        
        % This method uses the last half of the pulse time as SS
        spiketimes{k}=find(spikemarks{k}==1);
        for p=1:numel(spiketimes{k})
            if spiketimes{k}(p)-beforespike>0 && spiketimes{k}(p)+afterspike<=numel(trialdata(:,1))
                spikes{k}(p,:)=trialdata(spiketimes{k}(p)-beforespike:spiketimes{k}(p)+afterspike);
            end
            
            phases{k}(p)=mod(spiketimes{k}(p),wavelength(k))*2*pi/wavelength(k);
            
            unitvectors{k}(p,:)=[cos(phases{k}(p)) sin(phases{k}(p))];
        end
        
        meanvectors(k,:)=mean(unitvectors{k});
        meanphases(k)=atan2(meanvectors(k,2),meanvectors(k,1)); % Alternative method to find the mean phase
        if sign(meanphases(k))==-1
            meanphases(k)=2*pi+meanphases(k);
        end
        length_meanvector(k)=sqrt(meanvectors(k,1)^2+meanvectors(k,2)^2);
        
        if numel(spiketimes{k})==1
            spikeform{k}=spikes{k};
        elseif numel(spiketimes{k})>1
            spikeform{k}=mean(spikes{k});
        else
            spikeform{k}=NaN;
        end
        
%         figure;hist(phases{k}*360/(2*pi),20);%linspace(0,360,100) or 2*pi instead of 360
%         title(['Input Frequency: ' num2str(sample_rate/wavelength(k)) ' Hz; Input Amplitude: '...
%             num2str(amplitude(k)*1e12) ' pA; Spike Rate: ' num2str(rate(k)) ' Hz'])
%         xlabel('Phase (degrees)')
%         ylabel('Spike Count')
%         axis tight
        
        if round(1/(wavelength(k)/sample_rate))>=1
            frequency(k)=round(1/(wavelength(k)/sample_rate));
        else
            frequency(k)=round(10/(wavelength(k)/sample_rate))/10;
        end
        
        mean_voltage(k)=mean(trialdata(:,1));
        
        figure;rose(phases{k},20) %circ_plot(phases{k}','hist',[],100,true,true);
%         figure;compass(unitvectors{k}(:,1),unitvectors{k}(:,2))
%         hold on;compass(meanvectors(k,1),meanvectors(k,2),'r')
        title({['Mean Voltage: ' num2str(mean_voltage(k)) ' mV; Input Frequency: ' num2str(frequency(k)) '; Spike Rate: ' num2str(rate(k)) ' Hz; ISI CV: ' num2str(CV(k))];...
            ['Mean Vector: Phase=' num2str(meanphases(k)/pi) ' \pi; Length=' num2str(length_meanvector(k))]})
    else
        mean_voltage(k)=mean(trialdata(:,1));
        [c_ww,lags] = xcorr(trialdata(:,1)-mean(trialdata(:,1)),10000,'coeff');
        figure;plot(c_ww)
        title(['Voltage Autocorrelation; Mean Voltage: ' num2str(mean_voltage(k)) ' mV ; STD = ' num2str(std(trialdata(:,1)))])
    end
end

frequencies=[];

for j=1:numel(frequency)-3%%%%%%%%%%%
    if frequency(j)==0.1
        mean_vectors(1)=length_meanvector(j);
        frequencies=[frequencies(frequencies<0.1) 0.1 frequencies(frequencies>0.1)];
    elseif frequency(j)==1
        mean_vectors(2)=length_meanvector(j);
        frequencies=[frequencies(frequencies<1) 1 frequencies(frequencies>1)];
    elseif frequency(j)==5
        mean_vectors(3)=length_meanvector(j);
        frequencies=[frequencies(frequencies<5) 5 frequencies(frequencies>5)];
    elseif frequency(j)==10
        mean_vectors(4)=length_meanvector(j);
        frequencies=[frequencies(frequencies<10) 10 frequencies(frequencies>10)];
    elseif frequency(j)==20
        mean_vectors(5)=length_meanvector(j);
        frequencies=[frequencies(frequencies<20) 20 frequencies(frequencies>20)];
    elseif frequency(j)==30
        mean_vectors(6)=length_meanvector(j);
        frequencies=[frequencies(frequencies<30) 30 frequencies(frequencies>30)];
    elseif frequency(j)==50
        mean_vectors(7)=length_meanvector(j);
        frequencies=[frequencies(frequencies<50) 50 frequencies(frequencies>50)];
    end
end

figure;plot(frequencies,mean_vectors)