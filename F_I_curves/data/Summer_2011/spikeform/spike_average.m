function spike_average(recdate,varargin)
if nargin>1
    cellnum=varargin{1};
else
    cellnum='A'; % Cell number
end
if nargin>2
    conc_propofol=varargin{2};
else
    conc_propofol='100'; % Concentration of propofol in uM
end
if nargin>3
    delay=varargin{3};
else
    delay=10;            % Delay in seconds
end
if nargin>4
    pulse_duration=varargin{4};
else
    pulse_duration=50;
end
if nargin>5
    pause_duration=varargin{5};
else
    pause_duration=20;
end
if nargin>6
    sample_rate=varargin{6};
else
    sample_rate=10000;   % Sample rate in Hz.
end
if nargin>7
    increments=varargin{7};
else
    increments=2;
end
if nargin>8
    accom_time=varargin{8};
else
    accom_time=round((pulse_duration*3/5)*sample_rate)/sample_rate; % as opposed to pulse_duration-init_time;
end

time_before=9; %Time before spike to start averaging (in tenths of ms)
time_after=60; %Time after spike to finish averaging (in tenths of ms)

eval(['load spikeform_' recdate '_' cellnum '_control.mat'])
eval(['load spikeform_' recdate '_' cellnum '_' conc_propofol 'uMpropofol.mat'])

dataname=cell(1,2);
spiketimes=cell(increments,2);
spikeawesome=cell(increments,2);
spikes=cell(increments,2);
spikeform=zeros(increments,2,time_before+time_after+1);

for k=1:2
    dataname{k}=['spikeform_' recdate '_' cellnum num2str(k)];
    for j=1:increments
        eval(['spiketimes{j,k}=find(diff(' dataname{k}...
            '((delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*sample_rate+1:'...
            '(delay+pulse_duration)*sample_rate+(j-1)*(pulse_duration+pause_duration)*sample_rate,2))>0.005);'])
        if ~isempty(spiketimes{j,k})
            spikeawesome{j,k}=[spiketimes{j,k}(1) ; spiketimes{j,k}(find(diff(spiketimes{j,k})~=1)+1)];
            for p=1:length(spikeawesome{j,k})
                eval(['spikes{j,k}(p,:)=' dataname{k} '((delay+pulse_duration)*sample_rate+((j-1)*'...
                    '(pulse_duration+pause_duration)-accom_time)*sample_rate+spikeawesome{j,k}(p)-time_before:'...
                    '(delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-'...
                    'accom_time)*sample_rate+spikeawesome{j,k}(p)+time_after,2);'])
            end
            if numel(spikes{j,k})>time_before+time_after+1
                spikeform(j,k,:)=mean(spikes{j,k});
            else
                spikeform(j,k,:)=spikes{j,k};
            end
        end
    end
end

control_spike=zeros(increments,time_before+time_after+1);
propofol_spike=zeros(increments,time_before+time_after+1);

for c_w=1:increments
    control_spike(c_w,:)=reshape(spikeform(c_w,1,:),1,[]);
end

for p_w=1:increments
    propofol_spike(p_w,:)=reshape(spikeform(p_w,2,:),1,[]);
end

rate=sf_count_rate(recdate,cellnum,conc_propofol,delay,pulse_duration,...
    pause_duration,sample_rate,increments);

save(['spikeform_' recdate '_' cellnum],'rate','control_spike','propofol_spike')

for k=1:increments
    figure;plot(0.1:0.1:7,control_spike(k,:),0.1:0.1:7,propofol_spike(k,:))
    title(['Averaged Spikeform for Control and ' conc_propofol ' \muM Propofol at '...
        num2str(rate(1,k)) ' and ' num2str(rate(2,k)) 'Hz'],'fontsize',14)
    legend('Control Spikeform','Propofol Spikeform','Location','Best')
    xlabel('Time [ms]','fontsize',12)
    ylabel('Membrane Voltage [mV]','fontsize',12)
end