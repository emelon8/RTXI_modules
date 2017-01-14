function ISI_rate(recdate,varargin)
% recdate is the date of recording (i.e. 'Jul_19_11'); cellnum is the
% letter of the cell number (i.e. 'A');
if nargin>1
    cellnum=varargin{1};
else
    cellnum='A';
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
    accom_time=varargin{12};
else
    accom_time=round((pulse_duration/3)*sample_rate)/sample_rate; % as opposed to pulse_duration-init_time;
end

currents=linspace(start_current,finish_current,increments)';

if trials_control>0
    eval(['load fi_curves_' recdate '_' cellnum '_control.mat'])
end
if trials_propofol>0
    eval(['load fi_curves_' recdate '_' cellnum '_' conc_propofol 'uMpropofol.mat'])
end

dataname=cell(1,trials_control+trials_propofol);
eval(['W_control=zeros(numel(fi_curves_' recdate '_' cellnum '1(:,1)),trials_control+trials_propofol);'])
ISI=cell(increments,trials_control+trials_propofol);
ISI_accom=cell(increments,trials_control+trials_propofol);
rate_all=zeros(increments,trials_control+trials_propofol);
rate_init=zeros(increments,trials_control+trials_propofol);
rate_accom=zeros(increments,trials_control+trials_propofol);

for k=1:trials_control+trials_propofol
    for h=1:increments;
        dataname{k}=['fi_curves_' recdate '_' cellnum num2str(k)];
        eval(['W_control(find(' dataname{k} '(:,1)>=-0.02),k)=1;'])
        ISI{h,k}=diff(find(diff(W_control((delay+pulse_duration)*...
            sample_rate+(h-1)*((pulse_duration+pause_duration)*sample_rate)-...
            (pulse_duration*sample_rate-1):(delay+pulse_duration)*...
            sample_rate+(h-1)*((pulse_duration+pause_duration)*sample_rate),k))>0)+1)/...
            (sample_rate); % Finds the ISI in seconds
        ISI_accom{h,k}=diff(find(diff(W_control((delay+pulse_duration)*...
            sample_rate+(h-1)*((pulse_duration+pause_duration)*sample_rate)-...
            (accom_time*sample_rate-1):(delay+pulse_duration)*...
            sample_rate+(h-1)*((pulse_duration+pause_duration)*sample_rate),k))>0)+1)/...
            (sample_rate); % Finds the ISI in seconds
        if numel(ISI{h,k})>0
            rate_all(h,k)=mean(ISI{h,k});
        else
            rate_all(h,k)=0;
        end
        if numel(ISI{h,k})>=4
            rate_init(h,k)=mean(ISI{h,k}(1:3));
            if numel(ISI_accom{h,k})>=1
                rate_accom(h,k)=mean(ISI_accom{h,k}); % rate_accom(h,k)=mean(ISI{h,k}(4:end));
            else
                rate_accom(h,k)=0;
            end
        elseif numel(ISI{h,k})>=1 && numel(ISI{h,k})<4
            rate_init(h,k)=mean(ISI{h,k}(1:end));
            rate_accom(h,k)=0;
        else
            rate_init(h,k)=0;
            rate_accom(h,k)=0;
        end
    end
end

if trials_control>0
    eval(['control_all_' recdate '_' cellnum '=zeros(increments,1);'])
    eval(['control_init_' recdate '_' cellnum '=zeros(increments,1);'])
    eval(['control_accom_' recdate '_' cellnum '=zeros(increments,1);'])
    
    for h=1:increments
        eval(['control_all_' recdate '_' cellnum '(h)=1./mean(rate_all(h,1:trials_control));'])
        eval(['control_init_' recdate '_' cellnum '(h)=1./mean(rate_init(h,1:trials_control));'])
        eval(['control_accom_' recdate '_' cellnum '(h)=1./mean(rate_accom(h,1:trials_control));'])
    end
    
    eval(['control_all_' recdate '_' cellnum '(find(control_all_' recdate '_' cellnum '==Inf))=0;'])
    eval(['control_init_' recdate '_' cellnum '(find(control_init_' recdate '_' cellnum '==Inf))=0;'])
    eval(['control_accom_' recdate '_' cellnum '(find(control_accom_' recdate '_' cellnum '==Inf))=0;'])
    
    eval(['c_all=control_all_' recdate '_' cellnum '(find(control_all_' recdate '_' cellnum '>0,1):end);'])
    eval(['c_x_all=currents(find(control_all_' recdate '_' cellnum '>0,1):end);'])
    eval(['c_init=control_init_' recdate '_' cellnum '(find(control_init_' recdate '_' cellnum '>0,1):end);'])
    eval(['c_x_init=currents(find(control_init_' recdate '_' cellnum '>0,1):end);'])
    eval(['c_accom=control_accom_' recdate '_' cellnum '(find(control_accom_' recdate '_' cellnum '>0,1):end);'])
    eval(['c_x_accom=currents(find(control_accom_' recdate '_' cellnum '>0,1):end);'])
    
    eval(['control_pf_all_' recdate '_' cellnum '_ISIrate=polyfit(c_x_all,c_all,1);'])
    eval(['control_pf_init_' recdate '_' cellnum '_ISIrate=polyfit(c_x_init,c_init,1);'])
    eval(['control_pf_accom_' recdate '_' cellnum '_ISIrate=polyfit(c_x_accom,c_accom,1);'])
    
    save(['fi_curves_' recdate '_' cellnum '_ISIrate_control'],'control_*')
end

if trials_propofol>0
    eval(['propofol_all_' recdate '_' cellnum '=zeros(increments,1);'])
    eval(['propofol_init_' recdate '_' cellnum '=zeros(increments,1);'])
    eval(['propofol_accom_' recdate '_' cellnum '=zeros(increments,1);'])
    
    for h=1:increments
        eval(['propofol_all_' recdate '_' cellnum '(h)=1./mean(rate_all(h,trials_control+1:end));'])
        eval(['propofol_init_' recdate '_' cellnum '(h)=1./mean(rate_init(h,trials_control+1:end));'])
        eval(['propofol_accom_' recdate '_' cellnum '(h)=1./mean(rate_accom(h,trials_control+1:end));'])
    end
    
    eval(['propofol_all_' recdate '_' cellnum '(find(propofol_all_' recdate '_' cellnum '==Inf))=0;'])
    eval(['propofol_init_' recdate '_' cellnum '(find(propofol_init_' recdate '_' cellnum '==Inf))=0;'])
    eval(['propofol_accom_' recdate '_' cellnum '(find(propofol_accom_' recdate '_' cellnum '==Inf))=0;'])
    
    eval(['p_all=propofol_all_' recdate '_' cellnum '(find(propofol_all_' recdate '_' cellnum '>0,1):end);'])
    eval(['p_x_all=currents(find(propofol_all_' recdate '_' cellnum '>0,1):end);'])
    eval(['p_init=propofol_init_' recdate '_' cellnum '(find(propofol_init_' recdate '_' cellnum '>0,1):end);'])
    eval(['p_x_init=currents(find(propofol_init_' recdate '_' cellnum '>0,1):end);'])
    eval(['p_accom=propofol_accom_' recdate '_' cellnum '(find(propofol_accom_' recdate '_' cellnum '>0,1):end);'])
    eval(['p_x_accom=currents(find(propofol_accom_' recdate '_' cellnum '>0,1):end);'])
    
    eval(['propofol_pf_all_' recdate '_' cellnum '_ISIrate=polyfit(p_x_all,p_all,1);'])
    eval(['propofol_pf_init_' recdate '_' cellnum '_ISIrate=polyfit(p_x_init,p_init,1);'])
    eval(['propofol_pf_accom_' recdate '_' cellnum '_ISIrate=polyfit(p_x_accom,p_accom,1);'])
    
    save(['fi_curves_' recdate '_' cellnum '_ISIrate_propofol'],'propofol_*')
end

figure;eval(['plot(currents,control_all_' recdate '_' cellnum ',currents,control_pf_all_'...
    recdate '_' cellnum '_ISIrate(1)*currents+control_pf_all_' recdate '_' cellnum...
    '_ISIrate(2),currents,propofol_all_' recdate '_' cellnum ',currents,propofol_pf_all_'...
    recdate '_' cellnum '_ISIrate(1)*currents+propofol_pf_all_' recdate '_' cellnum '_ISIrate(2))'])
title('f-I Curve of Overall Firing Rate','fontsize',14)
legend('Control','Fitted Control',[conc_propofol '\muM Propofol'],'Fitted Propofol','Location','Best')
xlabel('Current [pA]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)
figure;eval(['plot(currents,control_init_' recdate '_' cellnum ',currents,control_pf_init_'...
    recdate '_' cellnum '_ISIrate(1)*currents+control_pf_init_' recdate '_' cellnum...
    '_ISIrate(2),currents,propofol_init_' recdate '_' cellnum ',currents,propofol_pf_init_'...
    recdate '_' cellnum '_ISIrate(1)*currents+propofol_pf_init_' recdate '_' cellnum '_ISIrate(2))'])
title('f-I Curve of Initial Firing Rate','fontsize',14)
legend('Control','Fitted Control',[conc_propofol '\muM Propofol'],'Fitted Propofol','Location','Best')
xlabel('Current [pA]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)
figure;eval(['plot(currents,control_accom_' recdate '_' cellnum ',currents,control_pf_accom_'...
    recdate '_' cellnum '_ISIrate(1)*currents+control_pf_accom_' recdate '_' cellnum...
    '_ISIrate(2),currents,propofol_accom_' recdate '_' cellnum ',currents,propofol_pf_accom_'...
    recdate '_' cellnum '_ISIrate(1)*currents+propofol_pf_accom_' recdate '_' cellnum '_ISIrate(2))'])
title('f-I Curve of Accommodated Firing Rate','fontsize',14)
legend('Control','Fitted Control',[conc_propofol '\muM Propofol'],'Fitted Propofol','Location','Best')
xlabel('Current [pA]','fontsize',12)
ylabel('Firing Rate [Hz]','fontsize',12)