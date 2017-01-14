load v_clamp_Jan_08_14_B

figure(1);plot(0.0001:0.0001:350,v_clamp_Jan_08_14_B1(1:3.5e6,1))
figure(2);hold on;plot(0.0001:0.0001:350,v_clamp_Jan_08_14_B2(1:3.5e6,1),'r')
figure(1);hold on;plot(0.0001:0.0001:350,v_clamp_Jan_08_14_B3(1:3.5e6,1),'g')
figure(2);hold on;plot(0.0001:0.0001:350,v_clamp_Jan_08_14_B4(1:3.5e6,1),'m')
% axis([0 110 ])
% figure;plot(v_clamp_Nov_02_13_A5(:,1))
% hold on;plot(v_clamp_Nov_02_13_A6(:,1),'r')
