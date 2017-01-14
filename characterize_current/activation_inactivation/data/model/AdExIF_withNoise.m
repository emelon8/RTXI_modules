function  [FI,IDC,Ri,VRi]=AdExIF_withNoise();
% %% Touboul and Brette notation 
dt = 0.01; %in ms
SR=(1/dt)*1000;
Ttot=.7;
t = 0:dt:Ttot*1000;
gnoise=0;% slp= 15 90//140; slp 2 = 140 slp 5 135; slp 10 122 ///  for slp 2 control=140 and leak 185
C = 170;
gL= 25;%25 under all other conditions
gLL =0;%%0/15 --- 15 nS base for LIF
EL=-75;
slp=15;   
Vr=-65;%%-65 default; -95 for slp = 1; -90 slp = 2; -90 slp = 5; -72 slp = 10
Vt=-60;

for jj = 1;
Istep=[];
spikefrequency=[];
 
IDC=0:25:150;%%slp = 
% IDC=55;%% 282-252//343-326.5  
countC=1;
voltage=zeros(1,length(IDC));

for j = 1:length(IDC);
    
v = ones(1,length(t));
v(:,:)=-75;

count = 1;
spidx = []; 

filterfrequency = 100;
dt_ins = dt/1000;

df = 1/(Ttot+dt_ins);% freq resolution
fidx = 1:length(t)/2;% it has to be N/2 pts, where N = length(t)
faxis = (fidx-1)*df;
%make the phases
Rr = randn(size(fidx));% ~N(0,1) over [-1,1]
distribphases = exp(1i*pi*Rr);% on the unit circle
%make the amplitudes - filtered
filterf = 1./(1+faxis/filterfrequency); % see the PSD of an OU process,
% note: missing a 2pi and a square!!! PSD(f) = 2D/((1/tau)^2+(2pif)^2)
fourierA = distribphases.*filterf; % representation in fourier domain
% make it conj-symmetric so the ifft is real
fourierB = fliplr(conj(fourierA));
nss = [0,fourierA,fourierB];
signal = ifft(nss);
if ~isreal(signal)
    disp('trouble');
end
Inoise = signal;
scaling = std(Inoise);
Inoise = Inoise/scaling;
% trsf = fft(Inoise);
% PS = trsf.*conj(trsf);
% loglog(faxis,PS(1:length(faxis)));

Inoise = Inoise*gnoise; %

Itrace = Inoise(1:1:end);%in time as the variables

% Itrace = zeros(size(t));
%Inoise = zeros(size(0:dt/2:Ttot*1000));


for i = 1:length(t)-1;
%             if t(i) > 800 || t(i)< 200;
            if t(i)<500;
            I(j)=-205;
            else
                I(j)=IDC(j);
            end

        fv_i =(-gL*(v(i)-EL)+gL*slp*exp((v(i)-Vt)/slp)+I(j)+Itrace(i)-gLL*(v(i)-EL))/C;
    
        k1v = dt*fv_i;
        
        v(i+1) = v(i)+k1v;

        
        
    if  v(i)>0 %%% -55 mV
        v(i+1) = Vr;
 
        spidx(count) = i/SR;
        count = count+1;
    end
         
            
end

v(v>0) = 50;
vv(j)=v(1,end)';

% vm=v;
% t=t;
figure(1);
plot (t,v,'b');hold on
% stdV=std(v)
% figure(2);
% % plot (v(1:end-1),diff(v),'b');
% % hold on;

if length(spidx)>1;
spikefrequency(countC)=mean(1./(diff(spidx)));
Istep(countC)=IDC(j);
Vstep(countC)=mean(v(600/dt:end));
countC=countC+1;

end
end
current=IDC;

Ri=diff(vv)./diff(IDC);
Ri=(Ri/1e-9);
Ri=Ri/1e6;
VRi=vv(2:end)';
FI{jj}=[Vstep',Istep',spikefrequency'];
end
figure(22);
plot(FI{1}(:,1),FI{1}(:,3)); hold on;
figure(23);
plot(FI{1}(:,2),FI{1}(:,3)); hold on;

return