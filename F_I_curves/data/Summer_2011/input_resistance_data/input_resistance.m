function input_resistance(recdate,varargin)
if nargin>1
    cellnum=varargin{1};
else
    cellnum='A'; % Cell number
end
if nargin>2
    trials_control=varargin{2};
else
    trials_control=1;
end
if nargin>3
    trials_propofol=varargin{3};
else
    trials_propofol=1;
end
if nargin>4
    conc_propofol=varargin{4};
else
    conc_propofol='100'; % Concentration of propofol in uM
end
if nargin>5
    delay=varargin{5};
else
    delay=1;            % Delay in seconds
end
if nargin>6
    pulse_duration=varargin{6};
else
    pulse_duration=0.5;
end
if nargin>7
    pause_duration=varargin{7};
else
    pause_duration=0.5;
end
if nargin>8
    sample_rate=varargin{8};
else
    sample_rate=10000;   % Sample rate in Hz.
end
if nargin>9
    increments=varargin{9};
else
    increments=75;
end
if nargin>10
    start_current=varargin{10};
else
    start_current=-55;    % Starting current in pA
end
if nargin>11
    finish_current=varargin{11};
else
    finish_current=20;  % Finishing current in pA
end
if nargin>12
    accom_time=varargin{12};
else
    accom_time=round((pulse_duration*3/5)*sample_rate)/sample_rate; % as opposed to pulse_duration-init_time;
end

% Protocol: Hold resting membrane potential at about -65 mV. 2 sec delay,
% then 1 second pulses, followed by 1 second pauses, totalling 44 seconds.
% Pulses start at -55 pA and go to 20 pA over 20 increments.

currents=linspace(start_current,finish_current,increments)';

if trials_control>0
    eval(['load input_resistance_' recdate '_' cellnum '_control.mat'])
end
if trials_propofol>0
    eval(['load input_resistance_' recdate '_' cellnum '_' conc_propofol 'uMpropofol.mat'])
end

dataname=cell(1,trials_control+trials_propofol);
voltage_steady=zeros(increments,trials_control+trials_propofol);

for k=1:trials_control+trials_propofol
    dataname{k}=['input_resistance_' recdate '_' cellnum num2str(k)];
    for h=1:increments
        eval(['voltage_steady(h,k)=mean(' dataname{k}...
            '((delay+pulse_duration)*sample_rate+((h-1)*(pulse_duration+pause_duration)'...
            '-accom_time)*sample_rate+1:(delay+pulse_duration)*sample_rate+(h-1)*'...
            '(pulse_duration+pause_duration)*sample_rate,2));'])
    end
end

voltage_control=zeros(1,increments);
voltage_propofol=zeros(1,increments);

for h=1:increments
    voltage_control(h)=mean(voltage_steady(h,1:trials_control))*1000;
    voltage_propofol(h)=mean(voltage_steady(h,trials_control+1:trials_control+trials_propofol))*1000;
end

resistance_control=polyfit(currents/1000,voltage_control',1);
resistance_propofol=polyfit(currents/1000,voltage_propofol',1);

save(['input_resistance_' recdate '_' cellnum],'resistance_control',...
    'resistance_propofol')

figure;plot(currents,voltage_control,currents,voltage_propofol)
title('I-V Curve and Input Resistance','fontsize',14)
legend(['Control (R = ' num2str(resistance_control(1)) ' M\Omega)'],...
    [conc_propofol '\muM Propofol (R = ' num2str(resistance_propofol(1)) ' M\Omega)'],'Location','Best')
xlabel('Input Current [pA]','fontsize',12)
ylabel('Membrane Voltage [mV]','fontsize',12)