function count_time_rate(recdate,varargin)
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
    delay=varargin{3};
else
    delay=12;            % Delay in seconds
end
if nargin>4
    pulse_duration=varargin{4};
else
    pulse_duration=5;
end
if nargin>5
    pause_duration=varargin{5};
else
    pause_duration=10;
end
if nargin>6
    sample_rate=varargin{6};
else
    sample_rate=10000;   % Sample rate in Hz.
end
if nargin>7
    increments=varargin{7};
else
    increments=15;
end
if nargin>8
    start_current=varargin{8};
else
    start_current=10;    % Starting current in pA
end
if nargin>9
    finish_current=varargin{9};
else
    finish_current=150;  % Finishing current in pA
end
if nargin>10
    init_time=varargin{10};
else
    init_time=0.3;  % Pulse time before accomodation in seconds
end
if nargin>11
    accom_time=varargin{11};
else
    accom_time=round((pulse_duration/3)*sample_rate)/sample_rate; % as opposed to pulse_duration-init_time;
end

currents=linspace(start_current,finish_current,increments)';

eval(['load fi_curves_' recdate '_' cellnum '_control.mat'])

dataname=cell(1,trials_control);
eval(['W_control=zeros(numel(fi_curves_' recdate '_' cellnum '1(:,1)),trials_control);'])
eval(['X_control=zeros(numel(fi_curves_' recdate '_' cellnum '1(:,1)),trials_control);'])
rate_all=zeros(increments,trials_control);
rate_init=zeros(increments,trials_control);
rate_accom=zeros(increments,trials_control);

for k=1:trials_control
    dataname{k}=['fi_curves_' recdate '_' cellnum num2str(k)];
    eval(['W_control(find(' dataname{k} '(:,1)>=-0.02),k)=1;'])
    for h=1:increments;
        X_control(find(diff(W_control((delay+pulse_duration)*...
            sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-...
            (pulse_duration*sample_rate-1):(delay+pulse_duration)*...
            sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate,k))>0)+...
            1+(delay+pulse_duration)*sample_rate+(h-1)*(pulse_duration+pause_duration)*...
            sample_rate-(pulse_duration*sample_rate-1),k)=1;
        rate_all(h,k)=sum(X_control((delay+pulse_duration)*...
            sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-...
            (pulse_duration*sample_rate-1):(delay+pulse_duration)*...
            sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate,k))/pulse_duration;
        rate_init(h,k)=sum(X_control((delay+pulse_duration)*...
            sample_rate+(h-1)*(pulse_duration+pause_duration)*sample_rate-...
            (pulse_duration*sample_rate-1):(delay+pulse_duration)*...
            sample_rate+((h-1)*(pulse_duration+pause_duration)-(pulse_duration-init_time))*...
            sample_rate,k))/init_time;
        rate_accom(h,k)=sum(X_control((delay+pulse_duration)*...
            sample_rate+((h-1)*(pulse_duration+pause_duration)-accom_time)*...
            sample_rate+1:(delay+pulse_duration)*sample_rate+(h-1)*...
            (pulse_duration+pause_duration)*sample_rate,k))/accom_time;
    end
end

c_all=cell(1,7);
c_x_all=cell(1,7);
c_init=cell(1,7);
c_x_init=cell(1,7);
c_accom=cell(1,7);
c_x_accom=cell(1,7);

if trials_control>0
    for k=1:trials_control
        c_all{k}=rate_all(find(rate_all(:,k)>0),k);
        c_x_all{k}=currents(find(rate_all(:,k)>0));
        c_init{k}=rate_init(find(rate_init(:,k)>0),k);
        c_x_init{k}=currents(find(rate_init(:,k)>0));
        c_accom{k}=rate_accom(find(rate_accom(:,k)>0),k);
        c_x_accom{k}=currents(find(rate_accom(:,k)>0));
        
        eval(['control_pf_all_' recdate '_' cellnum '_countrate(k,:)=polyfit(c_x_all{k},c_all{k},1);'])
        eval(['control_pf_init_' recdate '_' cellnum '_countrate(k,:)=polyfit(c_x_init{k},c_init{k},1);'])
        eval(['control_pf_accom_' recdate '_' cellnum '_countrate(k,:)=polyfit(c_x_accom{k},c_accom{k},1);'])
    end
    
    eval(['rate_all_' recdate '_' cellnum '=rate_all;'])
    clear rate_all
    eval(['rate_init_' recdate '_' cellnum '=rate_init;'])
    clear rate_init
    eval(['rate_accom_' recdate '_' cellnum '=rate_accom;'])
    clear rate_accom
    
    save(['fi_curves_' recdate '_' cellnum '_countrate_control'],'control_*','rate_*')
end

figure(1);eval(['plot(0:10:60,control_pf_all_' recdate '_' cellnum...
    '_countrate(:,1),0:10:60,control_pf_init_' recdate '_' cellnum...
    '_countrate(:,1),0:10:60,control_pf_accom_' recdate '_' cellnum '_countrate(:,1));'])
title('Change in Gain of f-I Curves Over Time','FontSize',16)
legend('Overall Gain','Initial Gain','Steady-State Gain')
ylabel('Gain [Hz/pA]','FontSize',14)
xlabel('Time [min]','FontSize',14)

% for k=1:trials_control
%     figure(2);hold on;eval(['plot(currents,rate_all_' recdate '_' cellnum '(:,k),currents,control_pf_all_'...
%         recdate '_' cellnum '_countrate(k,1)*currents+control_pf_all_' recdate '_' cellnum...
%         '_countrate(k,2))'])
%     title('f-I Curve of Overall Firing Rate','fontsize',14)
%     xlabel('Current [pA]','fontsize',12)
%     ylabel('Firing Rate [Hz]','fontsize',12)
%     figure(3);hold on;eval(['plot(currents,rate_init_' recdate '_' cellnum '(:,k),currents,control_pf_init_'...
%         recdate '_' cellnum '_countrate(k,1)*currents+control_pf_init_' recdate '_' cellnum...
%         '_countrate(k,2))'])
%     title('f-I Curve of Initial Firing Rate','fontsize',14)
%     xlabel('Current [pA]','fontsize',12)
%     ylabel('Firing Rate [Hz]','fontsize',12)
%     figure(4);hold on;eval(['plot(currents,rate_accom_' recdate '_' cellnum '(:,k),currents,control_pf_accom_'...
%         recdate '_' cellnum '_countrate(k,1)*currents+control_pf_accom_' recdate '_' cellnum...
%         '_countrate(k,2))'])
%     title('f-I Curve of Accommodated Firing Rate','fontsize',14)
%     xlabel('Current [pA]','fontsize',12)
%     ylabel('Firing Rate [Hz]','fontsize',12)
% end
% 
% figure(2);legend('T=0 min','T=0 min fitted','T=10 min','T=10 min fitted','T=20 min',...
%     'T=20 min fitted','T=30 min','T=30 min fitted','T=40 min','T=40 min fitted',...
%     'T=50 min','T=50 min fitted','T=60 min','T=60 min fitted','Location','Best')
% figure(3);legend('T=0 min','T=0 min fitted','T=10 min','T=10 min fitted','T=20 min',...
%     'T=20 min fitted','T=30 min','T=30 min fitted','T=40 min','T=40 min fitted',...
%     'T=50 min','T=50 min fitted','T=60 min','T=60 min fitted','Location','Best')
% figure(4);legend('T=0 min','T=0 min fitted','T=10 min','T=10 min fitted','T=20 min',...
%     'T=20 min fitted','T=30 min','T=30 min fitted','T=40 min','T=40 min fitted',...
%     'T=50 min','T=50 min fitted','T=60 min','T=60 min fitted','Location','Best')