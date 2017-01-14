function count_rate_individual(vtrace,varargin)
% recdate is the date of recording (i.e. 'Jul_19_11'); cellnum is the
% letter of the cell number (i.e. 'A');
if nargin>1
    delay=varargin{1};
else
    delay=2;            % Delay in seconds
end
if nargin>2
    pulse_duration=varargin{2};
else
    pulse_duration=5;
end
if nargin>3
    pause_duration=varargin{3};
else
    pause_duration=10;
end
if nargin>4
    sample_rate=varargin{4};
else
    sample_rate=10000;   % Sample rate in Hz.
end
if nargin>5
    increments=varargin{5};
else
    increments=15;
end
if nargin>6
    start_current=varargin{6};
else
    start_current=10;    % Starting current in pA
end
if nargin>7
    finish_current=varargin{7};
else
    finish_current=150;  % Finishing current in pA
end
if nargin>8
    accom_time=varargin{8};
else
    accom_time=round((pulse_duration/3)*sample_rate)/sample_rate; % as opposed to pulse_duration-init_time;
end

init_time=pulse_duration*2/5;
currents=linspace(start_current,finish_current,increments)';

W_control=zeros(numel(vtrace(:,1)),1);
X_control=zeros(numel(vtrace(:,1)),1);
rate_all=zeros(increments,1);
rate_init=zeros(increments,1);
rate_accom=zeros(increments,1);

W_control(find(vtrace(:,1)>=-0.02))=1;
for h=1:increments;
    X_control(find(diff(W_control((delay+pulse_duration)*...
        sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-...
        (pulse_duration*sample_rate-1):(delay+pulse_duration)*...
        sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate))>0)+...
        1+(delay+pulse_duration)*sample_rate+(h-1)*(pulse_duration+pause_duration)*...
        sample_rate-(pulse_duration*sample_rate-1))=1;
    rate_all(h)=sum(X_control((delay+pulse_duration)*...
        sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-...
        (pulse_duration*sample_rate-1):(delay+pulse_duration)*...
        sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate));
    rate_init(h)=sum(X_control((delay+pulse_duration)*...
        sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-...
        (pulse_duration*sample_rate-1):(delay+pulse_duration)*...
        sample_rate+((h-1)*(pulse_duration+pause_duration)-(pulse_duration-init_time))*...
        sample_rate));
    rate_accom(h)=sum(X_control((delay+pulse_duration)*...
        sample_rate+((h-1)*(pulse_duration+pause_duration)-accom_time)*...
        sample_rate+1:(delay+pulse_duration)*sample_rate+(h-1)*...
        (pulse_duration+pause_duration)*sample_rate));
end

rate_all_hz=rate_all/pulse_duration;
rate_init_hz=rate_init/init_time;
rate_accom_hz=rate_accom/accom_time;

c_all=rate_all_hz(find(rate_all_hz>0):end);
c_x_all=currents(find(rate_all_hz>0):end);
c_init=rate_init_hz(find(rate_init_hz>0):end);
c_x_init=currents(find(rate_init_hz>0):end);
c_accom=rate_accom_hz(find(rate_accom_hz>0):end);
c_x_accom=currents(find(rate_accom_hz>0):end);

control_pf_all_countrate=polyfit(c_x_all,c_all,1);
control_pf_init_countrate=polyfit(c_x_init,c_init,1);
control_pf_accom_countrate=polyfit(c_x_accom,c_accom,1);

figure;plot(currents,rate_all_hz,currents,control_pf_all_countrate(1)*currents+control_pf_all_countrate(2),...
    currents,rate_init_hz,currents,control_pf_init_countrate(1)*currents+control_pf_init_countrate(2),...
    currents,rate_accom_hz,currents,control_pf_accom_countrate(1)*currents+control_pf_accom_countrate(2))
title('f-I Curve of Overall, Initial, and Accommodated Firing Rates','fontsize',14)
legend('Overall','Fitted Overall','Initial','Fitted Initial','Accommodated','Fitted Accommodated','Location','Best')
xlabel('Current [pA]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)