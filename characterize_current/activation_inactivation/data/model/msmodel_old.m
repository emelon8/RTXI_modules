% this model was before I integrated all of the experimental measurments
% (except for the current) and changed it to not be units/area
clear;clc;%close all
warning off all;
totaltime=1000;
dt=0.05;
t=0:dt:totaltime;
%all units for conductance in mS/cm2
gNamax=7;
gKmax=3;
gAmax=4; %5
gBmax=5;
gleak=.1;
ENa=50;
EK=-90;
Eleak =-75;
tauh=20;%ms
taun=2;
taua=16;
tauah=40;
taub=10;
taubh=100;
v=NaN(1,length(t));
Iapp=NaN(1,length(t));
n=NaN(1,length(t));
h=NaN(1,length(t));
a=NaN(1,length(t));
ah=NaN(1,length(t));
b=NaN(1,length(t));
bh=NaN(1,length(t));
initv=-65;
v(1,1)=initv;
cm=1.5;%mF/cm2
h=1/(1+exp((initv+85)/1));
n=1/(1+exp((initv+65)/-3));
a=1/(1+exp((initv+65)/-3));
ah=1/(1+exp((initv+85)/1));
b=1.1456+(-1.1261./(1+exp((initv+24.6122)/8.6676)));
bh=0.1617+(0.7418./(1+exp((initv+58.9997)/4.7303)));
Iapp(1:end)=17;%pA
Iapp(1:10000)=-2;
acurrent(1)=0;
bcurrent(1)=0;

for i=1:length(t)-1;
    minf(i)=1/(1+exp((v(i)+30)/-4));
    hinf(i)=1/(1+exp((v(i)+66)/4));
    ninf(i)=1/(1+exp((v(i)+35)/-4));
    ainf(i)=1/(1+exp((v(i)+65)/-3));
    ahinf(i)=1/(1+exp((v(i)+85)/3));
    binf(i)=1.1456+(-1.1261./(1+exp((v(i)+24.6122)/8.6676)));
    bhinf(i)=0.1617+(0.7418./(1+exp((v(i)+58.9997)/4.7303)));
    
    hdt=((hinf(i)-h(i))./tauh).*dt;
    ndt=((ninf(i)-n(i))./taun).*dt;
    adt=((ainf(i)-a(i))./taua).*dt;
    ahdt=((ahinf(i)-ah(i))./tauah).*dt;
    bdt=((binf(i)-b(i))./taub).*dt;
    bhdt=((bhinf(i)-bh(i))./taubh).*dt;
    
    h(i+1)=h(i)+hdt;
    n(i+1)=n(i)+ndt;
    a(i+1)=a(i)+adt;
    ah(i+1)=ah(i)+ahdt;
    b(i+1)=b(i)+bdt;
    bh(i+1)=bh(i)+bhdt;
    
    dia=a(i)*ah(i)*gAmax*(v(i)-EK)*dt;
    dib=b(i)*bh(i)*gBmax*(v(i)-EK)*dt;
    acurrent(i+1)=dia+acurrent(i);
    bcurrent(i+1)=dib+bcurrent(i);
    
    dv=-(minf(i)*(1*(1-n(i))+0*h(i))*gNamax*(v(i)-ENa)+n(i)*gKmax*(v(i)-EK)+...
        a(i)*ah(i)*gAmax*(v(i)-EK)+b(i)*bh(i)*gBmax*(v(i)-EK)+...
        gleak.*(v(i)-Eleak)-Iapp(i))/cm*dt;
    v(i+1)=dv+v(i);
end

plot(t,v,'Color',[rand rand rand]);hold on;
% plot(t,acurrent,'Color',[rand rand rand]);hold on;
% plot(t,bcurrent,'Color',[rand rand rand])
% plot(t,b,'Color',[rand rand rand])
% plot(t,bh,'Color',[rand rand rand])
xlabel('Time [ms]')
ylabel('Membrane Voltage [mV]')
hold on;

