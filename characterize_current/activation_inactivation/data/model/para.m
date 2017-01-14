
v = -100:.5:50;

p1=1./(1+exp((v+25.4)/-10.48));
p2=1./(1+exp((v+59.1)/4.66));
tau=7.37+142.29.*exp(-(-6.17-v).^2/11.54^2);
plot(v,p1);hold on;
plot(v,p2)
figure(2)
plot (v,tau)