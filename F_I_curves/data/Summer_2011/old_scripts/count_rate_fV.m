function count_rate_fV(recdate,varargin)
% recdate is the date of recording (i.e. 'Jul_19_11'); cellnum is the
% letter of the cell number (i.e. 'A');
if nargin>1
    cellnum=varargin{1};
else
    cellnum='A'; % Cell number
end
if nargin>2
    trials_control=varargin{2};
else
    trials_control=3;
end
if nargin>3
    trials_propofol=varargin{3};
else
    trials_propofol=3;
end
if nargin>4
    conc_propofol=varargin{4};
else
    conc_propofol='100'; % Concentration of propofol in uM
end
if nargin>5
    delay=varargin{5};
else
    delay=12;            % Delay in seconds
end
if nargin>6
    pulse_duration=varargin{6};
else
    pulse_duration=5;
end
if nargin>7
    pause_duration=varargin{7};
else
    pause_duration=10;
end
if nargin>8
    sample_rate=varargin{8};
else
    sample_rate=10000;   % Sample rate in Hz.
end
if nargin>9
    increments=varargin{9};
else
    increments=15;
end
if nargin>10
    start_current=varargin{10};
else
    start_current=10;    % Starting current in pA
end
if nargin>11
    finish_current=varargin{11};
else
    finish_current=150;  % Finishing current in pA
end
if nargin>12
    init_time=varargin{12};
else
    init_time=.3;  % Pulse time before accomodation in seconds
end
if nargin>13
    accom_time=varargin{13};
else
    accom_time=round((pulse_duration/3)*sample_rate)/sample_rate; % as opposed to pulse_duration-init_time;
end

% Protocol: Hold resting membrane potential at about -60 mV. 12 sec delay,
% then 5 second pulses, followed by 10 second pauses, totalling 235
% seconds. Pulses start at 10 pA and go to 150 pA over 15 increments.

if trials_control>0
    eval(['load fi_curves_' recdate '_' cellnum '_control.mat'])
end
if trials_propofol>0
    eval(['load fi_curves_' recdate '_' cellnum '_' conc_propofol 'uMpropofol.mat'])
end

dataname=cell(1,trials_control+trials_propofol);
eval(['W_control=zeros(numel(fi_curves_' recdate '_' cellnum '1(:,1)),trials_control+trials_propofol);'])
eval(['X_control=zeros(numel(fi_curves_' recdate '_' cellnum '1(:,1)),trials_control+trials_propofol);'])
rate_all=zeros(increments,trials_control+trials_propofol);
rate_init=zeros(increments,trials_control+trials_propofol);
rate_accom=zeros(increments,trials_control+trials_propofol);

for k=1:trials_control+trials_propofol
    dataname{k}=['fi_curves_' recdate '_' cellnum num2str(k)];
    eval(['W_control(find(' dataname{k} '(:,1)>=-0.02),k)=1;'])
    for h=1:increments
        X_control(find(diff(W_control((delay+pulse_duration)*...
            sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-...
            (pulse_duration*sample_rate-1):(delay+pulse_duration)*...
            sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate,k))>0)+...
            1+(delay+pulse_duration)*sample_rate+(h-1)*(pulse_duration+pause_duration)*...
            sample_rate-(pulse_duration*sample_rate-1),k)=1;
        rate_all(h,k)=sum(X_control((delay+pulse_duration)*...
            sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-...
            (pulse_duration*sample_rate-1):(delay+pulse_duration)*...
            sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate,k));
        rate_init(h,k)=sum(X_control((delay+pulse_duration)*...
            sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-...
            (pulse_duration*sample_rate-1):(delay+pulse_duration)*...
            sample_rate+((h-1)*(pulse_duration+pause_duration)-(pulse_duration-init_time))*...
            sample_rate,k));
        rate_accom(h,k)=sum(X_control((delay+pulse_duration)*...
            sample_rate+((h-1)*(pulse_duration+pause_duration)-accom_time)*...
            sample_rate+1:(delay+pulse_duration)*sample_rate+(h-1)*...
            (pulse_duration+pause_duration)*sample_rate,k));
    end
end

c_v_avg_all=zeros(increments,trials_control+trials_propofol);
c_v_avg_init=zeros(increments,trials_control+trials_propofol);
c_v_avg_accom=zeros(increments,trials_control+trials_propofol);
control_voltage_avg_all=zeros(increments,1);
control_voltage_avg_init=zeros(increments,1);
control_voltage_avg_accom=zeros(increments,1);
p_v_avg_all=zeros(increments,trials_control+trials_propofol);
p_v_avg_init=zeros(increments,trials_control+trials_propofol);
p_v_avg_accom=zeros(increments,trials_control+trials_propofol);
propofol_voltage_avg_all=zeros(increments,1);
propofol_voltage_avg_init=zeros(increments,1);
propofol_voltage_avg_accom=zeros(increments,1);

for h=1:increments
    for k=1:trials_control
        eval(['c_v_avg_all(h,k)=mean(' dataname{k}...
            '((delay+pulse_duration)*sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-(pulse_duration*sample_rate-1):(delay+pulse_duration)*sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate,2));'])
        eval(['c_v_avg_init(h,k)=mean(' dataname{k}...
            '((delay+pulse_duration)*sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-(pulse_duration*sample_rate-1):(delay+pulse_duration)*sample_rate+((h-1)*(pulse_duration+pause_duration)-(pulse_duration-init_time))*sample_rate,2));'])
        eval(['c_v_avg_accom(h,k)=mean(' dataname{k}...
            '((delay+pulse_duration)*sample_rate+((h-1)*(pulse_duration+pause_duration)-accom_time)*sample_rate+1:(delay+pulse_duration)*sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate,2));'])
    end
    
    control_voltage_avg_all(h)=mean(c_v_avg_all(h,:));
    control_voltage_avg_init(h)=mean(c_v_avg_init(h,:));
    control_voltage_avg_accom(h)=mean(c_v_avg_accom(h,:));
    
    for testing=trials_control+1:trials_control+trials_propofol
        eval(['p_v_avg_all(h,k)=mean(' dataname{testing}...
            '((delay+pulse_duration)*sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-(pulse_duration*sample_rate-1):(delay+pulse_duration)*sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate,2));'])
        eval(['p_v_avg_init(h,k)=mean(' dataname{testing}...
            '((delay+pulse_duration)*sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-(pulse_duration*sample_rate-1):(delay+pulse_duration)*sample_rate+((h-1)*(pulse_duration+pause_duration)-(pulse_duration-init_time))*sample_rate,2));'])
        eval(['p_v_avg_accom(h,k)=mean(' dataname{testing}...
            '((delay+pulse_duration)*sample_rate+((h-1)*(pulse_duration+pause_duration)-accom_time)*sample_rate+1:(delay+pulse_duration)*sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate,2));'])
    end
    
    propofol_voltage_avg_all(h)=mean(p_v_avg_all(h,:));
    propofol_voltage_avg_init(h)=mean(p_v_avg_init(h,:));
    propofol_voltage_avg_accom(h)=mean(p_v_avg_accom(h,:));
end

if trials_control>0
    eval(['control_all_' recdate '_' cellnum '=zeros(increments,1);'])
    eval(['control_init_' recdate '_' cellnum '=zeros(increments,1);'])
    eval(['control_accom_' recdate '_' cellnum '=zeros(increments,1);'])
    
    for h=1:increments
        eval(['control_all_' recdate '_' cellnum '(h)=mean(rate_all(h,1:trials_control))/pulse_duration;'])
        eval(['control_init_' recdate '_' cellnum '(h)=mean(rate_init(h,1:trials_control))/init_time;'])
        eval(['control_accom_' recdate '_' cellnum '(h)=mean(rate_accom(h,1:trials_control))/accom_time;'])
    end
    
    eval(['c_all=control_all_' recdate '_' cellnum '(find(control_all_' recdate '_' cellnum '>0,1):end);'])
    eval(['c_x_all=control_voltage_avg_all(find(control_all_' recdate '_' cellnum '>0,1):end);'])
    eval(['c_init=control_init_' recdate '_' cellnum '(find(control_init_' recdate '_' cellnum '>0,1):end);'])
    eval(['c_x_init=control_voltage_avg_init(find(control_init_' recdate '_' cellnum '>0,1):end);'])
    eval(['c_accom=control_accom_' recdate '_' cellnum '(find(control_accom_' recdate '_' cellnum '>0,1):end);'])
    eval(['c_x_accom=control_voltage_avg_accom(find(control_accom_' recdate '_' cellnum '>0,1):end);'])
    
    eval(['control_pf_all_' recdate '_' cellnum '_countrate=polyfit(c_x_all,c_all,1);'])
    eval(['control_pf_init_' recdate '_' cellnum '_countrate=polyfit(c_x_init,c_init,1);'])
    eval(['control_pf_accom_' recdate '_' cellnum '_countrate=polyfit(c_x_accom,c_accom,1);'])
    
    save(['fV_curves_' recdate '_' cellnum '_countrate_control'],'control_*')
end

if trials_propofol>0
    eval(['propofol_all_' recdate '_' cellnum '=zeros(increments,1);'])
    eval(['propofol_init_' recdate '_' cellnum '=zeros(increments,1);'])
    eval(['propofol_accom_' recdate '_' cellnum '=zeros(increments,1);'])
    
    for h=1:increments
        eval(['propofol_all_' recdate '_' cellnum '(h)=mean(rate_all(h,trials_control+1:end))/pulse_duration;'])
        eval(['propofol_init_' recdate '_' cellnum '(h)=mean(rate_init(h,trials_control+1:end))/init_time;'])
        eval(['propofol_accom_' recdate '_' cellnum '(h)=mean(rate_accom(h,trials_control+1:end))/accom_time;'])
    end
    
    eval(['p_all=propofol_all_' recdate '_' cellnum '(find(propofol_all_' recdate '_' cellnum '>0,1):end);'])
    eval(['p_x_all=propofol_voltage_avg_all(find(propofol_all_' recdate '_' cellnum '>0,1):end);'])
    eval(['p_init=propofol_init_' recdate '_' cellnum '(find(propofol_init_' recdate '_' cellnum '>0,1):end);'])
    eval(['p_x_init=propofol_voltage_avg_init(find(propofol_init_' recdate '_' cellnum '>0,1):end);'])
    eval(['p_accom=propofol_accom_' recdate '_' cellnum '(find(propofol_accom_' recdate '_' cellnum '>0,1):end);'])
    eval(['p_x_accom=propofol_voltage_avg_accom(find(propofol_accom_' recdate '_' cellnum '>0,1):end);'])
    
    eval(['propofol_pf_all_' recdate '_' cellnum '_countrate=polyfit(p_x_all,p_all,1);'])
    eval(['propofol_pf_init_' recdate '_' cellnum '_countrate=polyfit(p_x_init,p_init,1);'])
    eval(['propofol_pf_accom_' recdate '_' cellnum '_countrate=polyfit(p_x_accom,p_accom,1);'])
    
    save(['fV_curves_' recdate '_' cellnum '_countrate_propofol'],'propofol_*')
end

figure;eval(['plot(control_voltage_avg_all,control_all_' recdate '_' cellnum...
    ',control_voltage_avg_all,control_pf_all_' recdate '_' cellnum...
    '_countrate(1)*control_voltage_avg_all+control_pf_all_' recdate '_' cellnum...
    '_countrate(2),propofol_voltage_avg_all,propofol_all_' recdate '_' cellnum...
    ',propofol_voltage_avg_all,propofol_pf_all_' recdate '_' cellnum...
    '_countrate(1)*propofol_voltage_avg_all+propofol_pf_all_' recdate '_' cellnum '_countrate(2))'])
title('f-V Curve of Overall Firing Rate','fontsize',14)
legend('Control','Fitted Control',[conc_propofol '\muM Propofol'],'Fitted Propofol','Location','Best')
xlabel('Voltage [mV]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)
figure;eval(['plot(control_voltage_avg_init,control_init_' recdate '_' cellnum...
    ',control_voltage_avg_init,control_pf_init_' recdate '_' cellnum...
    '_countrate(1)*control_voltage_avg_init+control_pf_init_' recdate '_' cellnum...
    '_countrate(2),propofol_voltage_avg_init,propofol_init_' recdate '_' cellnum...
    ',propofol_voltage_avg_init,propofol_pf_init_' recdate '_' cellnum...
    '_countrate(1)*propofol_voltage_avg_init+propofol_pf_init_' recdate '_' cellnum '_countrate(2))'])
title('f-V Curve of Initial Firing Rate','fontsize',14)
legend('Control','Fitted Control',[conc_propofol '\muM Propofol'],'Fitted Propofol','Location','Best')
xlabel('Voltage [mV]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)
figure;eval(['plot(control_voltage_avg_accom,control_accom_' recdate '_' cellnum...
    ',control_voltage_avg_accom,control_pf_accom_' recdate '_' cellnum...
    '_countrate(1)*control_voltage_avg_accom+control_pf_accom_' recdate '_' cellnum...
    '_countrate(2),propofol_voltage_avg_accom,propofol_accom_' recdate '_' cellnum...
    ',propofol_voltage_avg_accom,propofol_pf_accom_' recdate '_' cellnum...
    '_countrate(1)*propofol_voltage_avg_accom+propofol_pf_accom_' recdate '_' cellnum '_countrate(2))'])
title('f-V Curve of Accommodated Firing Rate','fontsize',14)
legend('Control','Fitted Control',[conc_propofol '\muM Propofol'],'Fitted Propofol','Location','Best')
xlabel('Voltage [mV]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)