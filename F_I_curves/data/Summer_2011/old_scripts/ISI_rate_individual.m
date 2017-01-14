function ISI_rate_individual(vtrace,varargin)
% recdate is the date of recording (i.e. 'Jul_19_11'); cellnum is the
% letter of the cell number (i.e. 'A');
if nargin>1; delay=varargin{1}; else delay=2; end % Delay in seconds
if nargin>2; pulse_duration=varargin{2}; else pulse_duration=5; end
if nargin>3; pause_duration=varargin{3}; else pause_duration=10; end
if nargin>4; sample_rate=varargin{4}; else sample_rate=10000; end % Sample rate in Hz.
if nargin>5; increments=varargin{5}; else increments=15; end
if nargin>6; start_current=varargin{6}; else start_current=10; end % Starting current in pA
if nargin>7; finish_current=varargin{7}; else finish_current=150; end % Finishing current in pA
if nargin>8; accom_time=varargin{8}; else accom_time=round((pulse_duration/3)*sample_rate)/sample_rate; end % as opposed to pulse_duration-init_time;

currents=linspace(start_current,finish_current,increments)';

W_control=zeros(numel(vtrace(:,1)),1);
ISI=cell(increments,1);
ISI_accom=cell(increments,1);
rate_all=zeros(increments,1);
rate_init=zeros(increments,1);
rate_accom=zeros(increments,1);

for h=1:increments;
    W_control(find(vtrace(:,1)>=-0.02))=1;
    ISI{h}=diff(find(diff(W_control((delay+pulse_duration)*...
        sample_rate+(h-1)*((pulse_duration+pause_duration)*sample_rate)-...
        (pulse_duration*sample_rate-1):(delay+pulse_duration)*...
        sample_rate+(h-1)*((pulse_duration+pause_duration)*sample_rate)))>0)+1)/...
        (sample_rate); % Finds the ISI in seconds
    ISI_accom{h}=diff(find(diff(W_control((delay+pulse_duration)*...
        sample_rate+(h-1)*((pulse_duration+pause_duration)*sample_rate)-...
        (accom_time*sample_rate-1):(delay+pulse_duration)*...
        sample_rate+(h-1)*((pulse_duration+pause_duration)*sample_rate)))>0)+1)/...
        (sample_rate); % Finds the ISI in seconds
    if numel(ISI{h})>0
        rate_all(h)=mean(ISI{h});
    else
        rate_all(h)=0;
    end
    if numel(ISI{h})>=4
        rate_init(h)=mean(ISI{h}(1:3));
        if numel(ISI_accom{h})>=1
            rate_accom(h)=mean(ISI_accom{h}); % rate_accom(h)=mean(ISI{h}(4:end));
        else
            rate_accom(h)=0;
        end
    elseif numel(ISI{h})>=1 && numel(ISI{h})<4
        rate_init(h)=mean(ISI{h}(1:end));
        rate_accom(h)=0;
    else
        rate_init(h)=0;
        rate_accom(h)=0;
    end
end

rate_all_hz=1./rate_all;
rate_init_hz=1./rate_init;
rate_accom_hz=1./rate_accom;

rate_all_hz(find(rate_all_hz==Inf))=0;
rate_init_hz(find(rate_init_hz==Inf))=0;
rate_accom_hz(find(rate_accom_hz==Inf))=0;

c_all=rate_all_hz(find(rate_all_hz>0):end);
c_x_all=currents(find(rate_all_hz>0):end);
c_init=rate_init_hz(find(rate_init_hz>0):end);
c_x_init=currents(find(rate_init_hz>0):end);
c_accom=rate_accom_hz(find(rate_accom_hz>0):end);
c_x_accom=currents(find(rate_accom_hz>0):end);

control_pf_all_ISIrate=polyfit(c_x_all,c_all,1);
control_pf_init_ISIrate=polyfit(c_x_init,c_init,1);
control_pf_accom_ISIrate=polyfit(c_x_accom,c_accom,1);


figure;plot(currents,rate_all_hz,currents,control_pf_all_ISIrate(1)*currents+control_pf_all_ISIrate(2),...
    currents,rate_init_hz,currents,control_pf_init_ISIrate(1)*currents+control_pf_init_ISIrate(2),...
    currents,rate_accom_hz,currents,control_pf_accom_ISIrate(1)*currents+control_pf_accom_ISIrate(2))
title('f-I Curve of Overall, Initial, and Accommodated Firing Rates (ISI)','fontsize',14)
legend('Overall','Fitted Overall','Initial','Fitted Initial','Accommodated','Fitted Accommodated','Location','Best')
xlabel('Current [pA]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)