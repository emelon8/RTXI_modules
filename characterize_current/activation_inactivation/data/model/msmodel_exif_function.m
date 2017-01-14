function [t,v,currentstep,firate,fifit]=msmodel_exif_function(Ttot,current,subtractionsize,stepsizei,gLL,slp,gBmax)
warning off all;

%parameters
dt = 0.01; %in ms
SR=(1/dt)*1000;
% Ttot=25; %in seconds
t = 0:dt:Ttot*1000;
gnoise=0;% slp= 15 90//140; slp 2 = 140 slp 5 135; slp 10 122 ///  for slp 2 control=140 and leak 185
C = 170;
gL= 25;%25 under all other conditions
% gLL =0;%#%%0/15 --- 15 nS base for LIF
EL=-75;
% slp=15;%# %2-5
Vr=-65;%%-65 default; -95 for slp = 1; -90 slp = 2; -90 slp = 5; -72 slp = 10
Vt=-60; %threshold voltage

count = 1;
spidx = []; 

% all units for conductance in mS

% gAmax=245; % 4-AP sensitive current
% gBmax=50;%# % slow, potassium current
ENa=50; % mV
EK=-90;
% taua=0.016*1000;
% tauah=0.040*1000;
taub=0.1340*1000;
v=NaN(1,length(t));
% a=NaN(1,length(t));
% ah=NaN(1,length(t));
b=NaN(1,length(t));
bh=NaN(1,length(t));
initv=-65;
v(1)=initv;
cm=91.9; %pF
% a=1/(1+exp((initv+65)/-3));
% ah=1/(1+exp((initv+85)/1));
b=1.18221743736166-1.26759729935242./(1+exp((initv+25.3959613425674)/10.4754896808280)); % extracted from experiments
bh=0.134304322321950+0.779228763105139./(1+exp((initv+59.0650955113259)/4.65810384224100)); % extracted from experiments
taubh=7.36508751804256+142.286674746436*exp(-(-6.17390760853182-initv).^2/11.5357877928097^2);
% acurrent(1)=0;
bcurrent(1)=0;

% current for f-i curves
pulse_time=1*1000; % in ms
pause_time=1*1000;
steps=10;

I=current*ones(size(t)); % pause current; -220 for hyperpolarized, -20 for depolarized
for k=1:steps
    currentstep(k)=subtractionsize+stepsizei*k;
    I((k*(pause_time+pulse_time)-pause_time)/dt+1:k*(pause_time+pulse_time)/dt)=currentstep(k); % pulse current
end

for i=1:length(t)-1;
%     ainf=1/(1+exp((v(i)+65)/-3));
%     ahinf=1/(1+exp((v(i)+85)/3));
    binf=1.18221743736166-1.26759729935242./(1+exp((v(i)+25.3959613425674)/10.4754896808280));
    bhinf=0.134304322321950+0.779228763105139./(1+exp((v(i)+59.0650955113259)/4.65810384224100));
    taubh=7.36508751804256+142.286674746436*exp(-(-6.17390760853182-v(i)).^2/11.5357877928097^2);
    
%     adt=((ainf(i)-a(i))./taua).*dt;
%     ahdt=((ahinf(i)-ah(i))./tauah).*dt;
    bdt=((binf-b)./taub).*dt;
    bhdt=((bhinf-bh)./taubh).*dt;
    
%     a(i+1)=a(i)+adt;
%     ah(i+1)=ah(i)+ahdt;
    b=b+bdt;
    bh=bh+bhdt;
    
%     Ia(i)=a(i)*ah(i)*gAmax*(v(i)-EK);
    Ib(i)=b*bh*gBmax*(v(i)-(-82.2833));
    
%     if t(i)<500;
%         I(i)=-205;
%     else
%         I(i)=-20;
%     end
    
    fv_i =(-gL*(v(i)-EL)+gL*slp*exp((v(i)-Vt)/slp)+I(i)-gLL*(v(i)-EL)-Ib(i))/C;
    
    k1v = dt*fv_i;
    
    v(i+1) = v(i)+k1v;
    
    if v(i)>0 %%% -55 mV
        v(i+1) = Vr;
        
        spidx(count) = i/SR;
        count = count+1;
    end
end

% color=[rand rand rand];

% figure;plot(t,v,'Color',color);
% plot(t,acurrent,'Color',[rand rand rand]);hold on;
% plot(t,bcurrent,'Color',[rand rand rand])
% plot(t,b,'Color',[rand rand rand])
% plot(t,bh1,'Color',[rand rand rand])
% xlabel('Time [ms]')
% ylabel('Membrane Voltage [mV]')
% hold on;

% f-i curve
for k=1:steps
    firate(k)=numel(find((spidx*1000/dt>(k*(pause_time+pulse_time)-pause_time)/dt+1)-(spidx*1000/dt<(k*(pause_time+pulse_time)/dt))==0))/(pulse_time/1000);
end

fifit=polyfit(currentstep,firate,1);

% figure;plot(currentstep,firate,'Color',color)
% title('f-I Curve')
% xlabel('Current [pA]')
% ylabel('Firing Rate [Hz]')

% %sliding rate
% window_size=1000; %in ms
% step_size=500; %in ms
% for k=window_size/dt:step_size/dt:length(t)
%     rates((k*dt-window_size)/step_size+1)=numel(find(((spidx*1000)/dt>k-window_size/dt+1)-((spidx*1000)/dt<k)==0));
% end
% 
% figure;plot(window_size:step_size:length(t)*dt,rates)