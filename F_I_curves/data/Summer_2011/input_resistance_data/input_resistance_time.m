function input_resistance_time(recdate,varargin)
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
    delay=varargin{3};
else
    delay=1;            % Delay in seconds
end
if nargin>4
    pulse_duration=varargin{4};
else
    pulse_duration=0.5;
end
if nargin>5
    pause_duration=varargin{5};
else
    pause_duration=0.5;
end
if nargin>6
    sample_rate=varargin{6};
else
    sample_rate=10000;   % Sample rate in Hz.
end
if nargin>7
    increments=varargin{7};
else
    increments=75;
end
if nargin>8
    start_current=varargin{8};
else
    start_current=-55;    % Starting current in pA
end
if nargin>9
    finish_current=varargin{9};
else
    finish_current=20;  % Finishing current in pA
end

% Protocol: Hold resting membrane potential at about -65 mV. 2 sec delay,
% then 1 second pulses, followed by 1 second pauses, totalling 44 seconds.
% Pulses start at -55 pA and go to 20 pA over 20 increments.

accom_time=pulse_duration-0.1;
currents=linspace(start_current,finish_current,increments)';

eval(['load input_resistance_' recdate '_' cellnum '_control.mat'])

dataname=cell(1,trials_control);
voltage_steady=zeros(increments,trials_control);

for k=1:trials_control
    dataname{k}=['input_resistance_' recdate '_' cellnum num2str(k)];
    for h=1:increments
        eval(['voltage_steady(h,k)=mean(' dataname{k}...
            '((delay+pulse_duration)*sample_rate+((h-1)*(pulse_duration+pause_duration)'...
            '-accom_time)*sample_rate+1+1000:(delay+pulse_duration)*sample_rate+(h-1)*'...
            '(pulse_duration+pause_duration)*sample_rate,2))*1000;'])
    end
end

resistance_control=zeros(7,2);

for j=1:7
    resistance_control(j,:)=polyfit(currents/1000,voltage_steady(:,j),1);
end

save(['input_resistance_' recdate '_' cellnum],'resistance_control')

figure;plot([currents currents currents currents currents currents currents],voltage_steady)
title('I-V Curve and Input Resistance','fontsize',14)
legend(['T = 0 min, R = ' num2str(resistance_control(1,1)) ' M\Omega)'],...
    ['T = 10 min, R = ' num2str(resistance_control(2,1)) ' M\Omega)'],...
    ['T = 20 min, R = ' num2str(resistance_control(3,1)) ' M\Omega)'],...
    ['T = 30 min, R = ' num2str(resistance_control(4,1)) ' M\Omega)'],...
    ['T = 40 min, R = ' num2str(resistance_control(5,1)) ' M\Omega)'],...
    ['T = 50 min, R = ' num2str(resistance_control(6,1)) ' M\Omega)'],...
    ['T = 60 min, R = ' num2str(resistance_control(7,1)) ' M\Omega)'],'Location','Best')
xlabel('Input Current [pA]','fontsize',12)
ylabel('Membrane Voltage [mV]','fontsize',12)