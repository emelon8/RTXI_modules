clear;clc;close all
warning off all;
totaltime=10000; %in ms
dt=0.05; %in ms
t=0:dt:totaltime;
% all units for conductance in mS
gNamax=735;
gKmax=220;
% gAmax=245; % 4-AP sensitive current
gBmax=500; % slow, potassium current
gleak=1.8;
ENa=50; % mV
EK=-90;
Eleak =-75;
tauh=0.020*1000; %seconds * 1000 = milliseconds
taun=0.002*1000;
% taua=0.016*1000;
% tauah=0.040*1000;
taub=0.2125*1000;
taubh1=1308.42539035947*1000; %100
taubh2=1774370.83510016*1000; %100
v=NaN(1,length(t));
Iapp=NaN(1,length(t));
n=NaN(1,length(t));
h=NaN(1,length(t));
% a=NaN(1,length(t));
% ah=NaN(1,length(t));
b=NaN(1,length(t));
bh1=NaN(1,length(t));
bh2=NaN(1,length(t));
initv=-65;
v(1,1)=initv;
cm=91.9; %pF
h=1/(1+exp((initv+85)/1));
n=1/(1+exp((initv+65)/-3));
% a=1/(1+exp((initv+65)/-3));
% ah=1/(1+exp((initv+85)/1));
b=1.18221743736166-1.26759729935242./(1+exp((initv+25.3959613425674)/10.4754896808280)); % extracted from experiments
bh1=0.134304322321950+0.779228763105139./(1+exp((initv+59.0650955113259)/4.65810384224100)); % extracted from experiments
bh2=0.134304322321950+0.779228763105139./(1+exp((initv+59.0650955113259)/4.65810384224100)); % extracted from experiments
Iapp(1:end)=10; % pA
Iapp(1:10000)=-30;
% acurrent(1)=0;
bcurrent(1)=0;

for i=1:length(t)-1;
    minf(i)=1/(1+exp((v(i)+30)/-4));
    hinf(i)=1/(1+exp((v(i)+66)/4));
    ninf(i)=1/(1+exp((v(i)+35)/-4));
%     ainf(i)=1/(1+exp((v(i)+65)/-3));
%     ahinf(i)=1/(1+exp((v(i)+85)/3));
    binf(i)=1.18221743736166-1.26759729935242./(1+exp((v(i)+25.3959613425674)/10.4754896808280));
    bh1inf(i)=0.134304322321950+0.779228763105139./(1+exp((v(i)+59.0650955113259)/4.65810384224100));
    bh2inf(i)=0.134304322321950+0.779228763105139./(1+exp((v(i)+59.0650955113259)/4.65810384224100));
    
    hdt=((hinf(i)-h(i))./tauh).*dt;
    ndt=((ninf(i)-n(i))./taun).*dt;
%     adt=((ainf(i)-a(i))./taua).*dt;
%     ahdt=((ahinf(i)-ah(i))./tauah).*dt;
    bdt=((binf(i)-b(i))./taub).*dt;
    bh1dt=((bh1inf(i)-bh1(i))./taubh1).*dt;
    bh2dt=((bh2inf(i)-bh2(i))./taubh2).*dt;
    
    h(i+1)=h(i)+hdt;
    n(i+1)=n(i)+ndt;
%     a(i+1)=a(i)+adt;
%     ah(i+1)=ah(i)+ahdt;
    b(i+1)=b(i)+bdt;
    bh1(i+1)=bh1(i)+bh1dt;
    bh2(i+1)=bh2(i)+bh2dt;
    
%     dia=a(i)*ah(i)*gAmax*(v(i)-EK)*dt;
    dib=b(i)*bh1(i)*bh2(i)*gBmax*(v(i)-(-82.2833))*dt;
%     acurrent(i+1)=dia+acurrent(i);
    bcurrent(i+1)=dib+bcurrent(i);
    
    INa(i)=minf(i)*(1*(1-n(i))+0*h(i))*gNamax*(v(i)-ENa);
    IK(i)=n(i)*gKmax*(v(i)-EK);
%     Ia(i)=a(i)*ah(i)*gAmax*(v(i)-EK);
    Ib(i)=b(i)*bh1(i)*bh2(i)*gBmax*(v(i)-(-82.2833));
    Ileak(i)=gleak.*(v(i)-Eleak);
    
    dv=-(INa(i)+IK(i)+Ib(i)+Ileak(i)-Iapp(i))/cm*dt; %+Ia(i)
    v(i+1)=dv+v(i);
end

plot(t,v,'Color',[rand rand rand]);hold on;
% plot(t,acurrent,'Color',[rand rand rand]);hold on;
% plot(t,bcurrent,'Color',[rand rand rand])
% plot(t,b,'Color',[rand rand rand])
% plot(t,bh1,'Color',[rand rand rand])
xlabel('Time [ms]')
ylabel('Membrane Voltage [mV]')
hold on;

%sliding rate
window_size=1000; %in ms
step_size=500; %in ms
spikes=zeros(1,length(t));
thresholdspikes=zeros(1,length(t));
thresholdspikes(v>=0)=1;
spikes(find(diff(thresholdspikes)>0)+1)=1;
for k=window_size/dt:step_size/dt:length(t)
    rates((k*dt-window_size)/step_size+1)=sum(spikes(k-window_size/dt+1:k));
end

figure;plot(window_size:step_size:length(t)*dt,rates)