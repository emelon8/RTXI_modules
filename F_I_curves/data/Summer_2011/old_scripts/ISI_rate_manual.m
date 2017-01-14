clear

recdate='Jul_22_11'; % Recording date
cellnum='A';         % Cell number
trials_control=3;
trials_propofol=3;
conc_propofol='100'; % Concentration of propofol in uM
start_current=10;    % Starting current in pA
finish_current=150;  % Finishing current in pA
increments=15;
delay=12;            % Delay in seconds
pulse_duration=5;
pause_duration=10;
sample_rate=10000;   % Sample rate in Hz.
accom_time=round((pulse_duration/3)*sample_rate)/sample_rate; % Time (from the end) to measure the accommodated firing rate

% Protocol: Hold resting membrane potential at about -50 mV. 10 sec delay,
% then 1 second pulses, followed by 10 second pauses, totalling 175
% seconds. Pulses start at 10 pA and go to 150 pA over 15 increments.

if trials_control>0
    eval(['load fi_curves_' recdate '_' cellnum '_control.mat'])
end
if trials_propofol>0
    eval(['load fi_curves_' recdate '_' cellnum '_' conc_propofol 'uMpropofol.mat'])
end

dataname=cell(1,trials_control+trials_propofol);
eval(['W_control=zeros(numel(' sprintf(['fi_curves_' recdate '_' cellnum '1'])...
    '(:,2)),trials_control+trials_propofol);'])
ISI=cell(increments,trials_control+trials_propofol);
ISI_accom=cell(increments,trials_control+trials_propofol);
rate_all=zeros(increments,trials_control+trials_propofol);
rate_init=zeros(increments,trials_control+trials_propofol);
rate_accom=zeros(increments,trials_control+trials_propofol);

for k=1:trials_control+trials_propofol
    for h=1:increments;
        dataname{k}=['fi_curves_' recdate '_' cellnum num2str(k)];
        eval(['W_control(find(' sprintf(dataname{k}) '(:,2)>=-0.02),k)=1;'])
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
    
    save(['fi_curves_' recdate '_' cellnum '_ISIrate_propofol'],'propofol_*')
end

figure;eval(['plot(linspace(start_current,finish_current,increments),control_all_'...
    recdate '_' cellnum ',linspace(start_current,finish_current,increments),propofol_all_'...
    recdate '_' cellnum ')'])
title('f-I Curve of Overall Firing Rate','fontsize',14)
legend('Control',[conc_propofol '\muM Propofol'])
xlabel('Current (pA)','fontsize',12)
ylabel('Firing Rate (Hz)','fontsize',12)
figure;eval(['plot(linspace(start_current,finish_current,increments),control_init_'...
    recdate '_' cellnum ',linspace(start_current,finish_current,increments),propofol_init_'...
    recdate '_' cellnum ')'])
title('f-I Curve of Initial Firing Rate','fontsize',14)
legend('Control',[conc_propofol '\muM Propofol'])
xlabel('Current (pA)','fontsize',12)
ylabel('Firing Rate (Hz)','fontsize',12)
figure;eval(['plot(linspace(start_current,finish_current,increments),control_accom_'...
    recdate '_' cellnum ',linspace(start_current,finish_current,increments),propofol_accom_'...
    recdate '_' cellnum ')'])
title('f-I Curve of Accommodated Firing Rate','fontsize',14)
legend('Control',[conc_propofol '\muM Propofol'])
xlabel('Current (pA)','fontsize',12)
ylabel('Firing Rate (Hz)','fontsize',12)