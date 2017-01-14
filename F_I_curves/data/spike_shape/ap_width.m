function ap_width(recdate,varargin)
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

time_after=30; %Time after spike to finish averaging (in tenths of ms)

if trials_control>0
    eval(['load spikeform_' recdate '_' cellnum '_control.mat'])
end
if trials_propofol>0
    eval(['load spikeform_' recdate '_' cellnum '_' conc_propofol 'uMpropofol.mat'])
end

dataname=cell(1,trials_control+trials_propofol);
spiketimes=cell(increments,trials_control+trials_propofol);
spikeawesome=cell(increments,trials_control+trials_propofol);
ap_wid=cell(increments,trials_control+trials_propofol);
ap_wid_avg=zeros(increments,trials_control+trials_propofol);
ap_wid_ste=zeros(increments,trials_control+trials_propofol);

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
                    eval(['halfheight=' dataname{k} '((delay+pulse_duration)*sample_rate+((j-1)*'...
                        '(pulse_duration+pause_duration)-accom_time)*sample_rate+spikeawesome{j,k}(p),2)+'...
                        '(max(' dataname{k} '((delay+pulse_duration)*sample_rate+((j-1)*'...
                        '(pulse_duration+pause_duration)-accom_time)*sample_rate+spikeawesome{j,k}(p):'...
                        '(delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*'...
                        'sample_rate+spikeawesome{j,k}(p)+time_after,2))-' dataname{k}...
                        '((delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*'...
                        'sample_rate+spikeawesome{j,k}(p),2))/2;'])
                    
                    eval(['inds=find(' dataname{k} '((delay+pulse_duration)*sample_rate+'...
                        '((j-1)*(pulse_duration+pause_duration)-accom_time)*sample_rate+spikeawesome{j,k}(p):'...
                        '(delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*'...
                        'sample_rate+spikeawesome{j,k}(p)+time_after,2)>halfheight,1);'])
                    
                    eval(['up=polyfit([(delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*'...
                        'sample_rate+spikeawesome{j,k}(p)-1+inds-1 (delay+pulse_duration)*sample_rate+'...
                        '((j-1)*(pulse_duration+pause_duration)-accom_time)*sample_rate+spikeawesome{j,k}(p)-1+inds],'...
                        '[' dataname{k} '((delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*'...
                        'sample_rate+spikeawesome{j,k}(p)-1+inds-1,2) ' dataname{k} '((delay+pulse_duration)*sample_rate+'...
                        '((j-1)*(pulse_duration+pause_duration)-accom_time)*sample_rate+spikeawesome{j,k}(p)-1+inds,2)],1);'])
                    front=(halfheight-up(2))/up(1);
                    
                    eval(['inds2=find(' dataname{k} '((delay+pulse_duration)*sample_rate+'...
                        '((j-1)*(pulse_duration+pause_duration)-accom_time)*sample_rate+spikeawesome{j,k}(p)-1+inds:'...
                        '(delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*'...
                        'sample_rate+spikeawesome{j,k}(p)-1+time_after,2)<halfheight,1);'])
                    
                    eval(['down=polyfit([(delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*'...
                        'sample_rate+spikeawesome{j,k}(p)-1+inds-1+inds2-1 (delay+pulse_duration)*sample_rate+'...
                        '((j-1)*(pulse_duration+pause_duration)-accom_time)*sample_rate+spikeawesome{j,k}(p)-1+inds-1+inds2],'...
                        '[' dataname{k} '((delay+pulse_duration)*sample_rate+((j-1)*(pulse_duration+pause_duration)-accom_time)*'...
                        'sample_rate+spikeawesome{j,k}(p)-1+inds-1+inds2-1,2) ' dataname{k} '((delay+pulse_duration)*sample_rate+'...
                        '((j-1)*(pulse_duration+pause_duration)-accom_time)*sample_rate+spikeawesome{j,k}(p)-1+inds-1+inds2,2)],1);'])
                    back=(halfheight-down(2))/down(1);
                    
                    ap_wid{j,k}(p)=back-front;
                else
                    ap_wid{j,k}(p)=0;
                end
            end
            if numel(ap_wid{j,k})>1
                ap_wid_avg(j,k)=mean(ap_wid{j,k}(find(ap_wid{j,k}~=0)));
                ap_wid_ste(j,k)=std(ap_wid{j,k}(find(ap_wid{j,k}~=0)))/...
                    sqrt(numel(ap_wid{j,k}(find(ap_wid{j,k}~=0))));
            else
                ap_wid_avg(j,k)=ap_wid{j,k};
                ap_wid_ste(j,k)=0;
            end
        end
    end
end

rate=sf_count_rate(recdate,cellnum,conc_propofol,delay,pulse_duration,...
    pause_duration,sample_rate,increments);

bargraph=[ap_wid_avg(1,1) ap_wid_ste(1,1); ap_wid_avg(1,2) ap_wid_ste(1,2);...
    ap_wid_avg(2,1) ap_wid_ste(2,1); ap_wid_avg(2,2) ap_wid_ste(2,2)];

save(['ap_width_' recdate '_' cellnum],'rate','bargraph')

figure;bar(ap_wid_avg/10)%,0.5)
set(gca,'XTickLabel',{[num2str(rate(1,1)) ' Hz and ' num2str(rate(2,1)) ' Hz'],...
    [num2str(rate(1,2)) ' Hz and ' num2str(rate(2,2)) ' Hz']},'FontSize',14)
title(['Action Potential Width for Control and ' conc_propofol ' \muM Propofol'],'fontsize',14)
legend('Control','Propofol')
ylabel('Action Potential Width [ms]','fontsize',12)
hold on
errorbar([0.855 1.145 1.855 2.145],bargraph(:,1)/10,bargraph(:,2)/10,'.','LineWidth',2.5)