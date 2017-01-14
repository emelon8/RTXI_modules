function rate_accom=sf_count_rate(recdate,varargin)
% recdate is the date of recording (i.e. 'Jul_19_11'); cellnum is the
% letter of the cell number (i.e. 'A');
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
    accom_time=round((pulse_duration/3)*sample_rate)/sample_rate; % as opposed to pulse_duration-init_time;
end

eval(['load spikeform_' recdate '_' cellnum '_control.mat'])
eval(['load spikeform_' recdate '_' cellnum '_' conc_propofol 'uMpropofol.mat'])

dataname=cell(1,2);
eval(['W_control=zeros(numel(spikeform_' recdate '_' cellnum...
    '1(:,2)),2);'])
eval(['X_control=zeros(numel(spikeform_' recdate '_' cellnum...
    '1(:,2)),2);'])
rate_accom=zeros(increments,2);

for k=1:2
    dataname{k}=['spikeform_' recdate '_' cellnum num2str(k)];
    eval(['W_control(find(diff(' dataname{k} '(:,2))>0.005),k)=1;'])
    for h=1:increments;
        X_control(find(diff(W_control((delay+pulse_duration)*...
            sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-...
            (pulse_duration*sample_rate-1):(delay+pulse_duration)*...
            sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate,k))>0)+1+...
            (delay+pulse_duration)*sample_rate+(h-1)*(pulse_duration+pause_duration)*...
            sample_rate-(pulse_duration*sample_rate-1),k)=1;
        rate_accom(k,h)=sum(X_control((delay+pulse_duration)*...
            sample_rate+((h-1)*(pulse_duration+pause_duration)-accom_time)*...
            sample_rate+1:(delay+pulse_duration)*sample_rate+(h-1)*...
            (pulse_duration+pause_duration)*sample_rate,k))/accom_time;
    end
end

% save(['spikeform_' recdate '_' cellnum '_rate_accom'],'rate_accom')