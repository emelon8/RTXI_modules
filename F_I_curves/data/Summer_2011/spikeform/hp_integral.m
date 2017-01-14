function hp_integral(recdate,varargin)
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
    delay=10;            % Delay in seconds
end
if nargin>6
    pulse_duration=varargin{6};
else
    pulse_duration=50;
end
if nargin>7
    pause_duration=varargin{7};
else
    pause_duration=20;
end
if nargin>8
    sample_rate=varargin{8};
else
    sample_rate=10000;   % Sample rate in Hz.
end
if nargin>9
    increments=varargin{9};
else
    increments=20;
end
if nargin>10
    accom_time=varargin{10};
else
    accom_time=round((pulse_duration*3/5)*sample_rate)/sample_rate; % as opposed to pulse_duration-init_time;
end

time_after=700; %Time after spike to finish averaging (in tenths of ms)

if trials_control>0
    eval(['load spikeform_' recdate '_' cellnum '_control.mat'])
end
if trials_propofol>0
    eval(['load spikeform_' recdate '_' cellnum '_' conc_propofol 'uMpropofol.mat'])
end

dataname=cell(1,trials_control+trials_propofol);
spiketimes=cell(increments,trials_control+trials_propofol);
spikeawesome=cell(increments,trials_control+trials_propofol);
hp_int=cell(increments,trials_control+trials_propofol);
hp_int_avg=zeros(increments,trials_control+trials_propofol);
hp_int_ste=zeros(increments,trials_control+trials_propofol);

for k=1:trials_control+trials_propofol
    dataname{k}=['spikeform_' recdate '_' cellnum num2str(k)];
    for j=1:increments
        eval(['spiketimes{j,k}=find(diff(' dataname{k}...
            '((delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*sample_rate+1:'...
            '(delay+pulse_duration)*sample_rate+(j-1)*(pulse_duration+pause_duration)*sample_rate,2))>0.005);'])
        if ~isempty(spiketimes{j,k})
            spikeawesome{j,k}=[spiketimes{j,k}(1) ; spiketimes{j,k}(find(diff(spiketimes{j,k})~=1)+1)];
            for p=1:length(spikeawesome{j,k})
                if (delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*...
                        sample_rate+spikeawesome{j,k}(p)+time_after<(delay+pulse_duration)*sample_rate+...
                        ((j-1)*(pulse_duration+pause_duration))*sample_rate
                    eval(['inds=find(' dataname{k} '((delay+pulse_duration)*sample_rate+((j-1)*'...
                        '(pulse_duration+pause_duration)-accom_time)*sample_rate+spikeawesome{j,k}(p):'...
                        '(delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*'...
                        'sample_rate+spikeawesome{j,k}(p)+time_after,2)<' dataname{k}...
                        '((delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*'...
                        'sample_rate+spikeawesome{j,k}(p),2),1);'])
                    eval(['hp_int{j,k}(p)=' dataname{k} '((delay+pulse_duration)*sample_rate+((j-1)*'...
                        '(pulse_duration+pause_duration)-accom_time)*sample_rate+spikeawesome{j,k}(p),2)*'...
                        '(time_after-inds+1)-sum(' dataname{k} '((delay+pulse_duration)*sample_rate+((j-1)*'...
                        '(pulse_duration+pause_duration)-accom_time)*sample_rate+spikeawesome{j,k}(p)+inds:'...
                        '(delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)'...
                        '-accom_time)*sample_rate+spikeawesome{j,k}(p)+time_after,2));'])
                else
                    hp_int{j,k}(p)=0;
                end
            end
            if numel(hp_int{j,k})>1
                hp_int_avg(j,k)=mean(hp_int{j,k}(find(hp_int{j,k}~=0)));
                hp_int_ste(j,k)=std(hp_int{j,k}(find(hp_int{j,k}~=0)))/...
                    sqrt(numel(hp_int{j,k}(find(hp_int{j,k}~=0))));
            else
                hp_int_avg(j,k)=hp_int{j,k};
                hp_int_ste(j,k)=0;
            end
        end
    end
end

rate=sf_count_rate(recdate,cellnum,conc_propofol,delay,pulse_duration,...
    pause_duration,sample_rate,increments);

bargraph=[hp_int_avg(1,1) hp_int_ste(1,1); hp_int_avg(1,2) hp_int_ste(1,2);...
    hp_int_avg(2,1) hp_int_ste(2,1); hp_int_avg(2,2) hp_int_ste(2,2)];

save(['hp_integral_' recdate '_' cellnum],'rate','bargraph')

figure;bar(hp_int_avg*1000/10)%,0.5)
set(gca,'XTickLabel',{[num2str(rate(1,1)) ' Hz and ' num2str(rate(2,1)) ' Hz'],...
    [num2str(rate(1,2)) ' Hz and ' num2str(rate(2,2)) ' Hz']},'FontSize',14)
title(['Hyperpolarization Integral for Control and ' conc_propofol ' \muM Propofol'],'fontsize',14)
legend('Control','Propofol')
ylabel('Hyperpolarization Integral [mV ms]','fontsize',12)
hold on
errorbar([0.855 1.145 1.855 2.145],bargraph(:,1)*1000/10,bargraph(:,2)*1000/10,'.','LineWidth',2.5)