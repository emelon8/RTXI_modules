trialdata=hyperpolarized_OUSynD_Jul_16_14_A2;

mean_voltage(k)=mean(trialdata(50000:150000,1));
[c_ww,lags] = xcorr(trialdata(50000:150000,1)-mean(trialdata(50000:150000,1)),10000,'coeff');
figure;plot(c_ww)
title(['Voltage Autocorrelation; Mean Voltage: ' num2str(mean_voltage(k)) ' mV ; STD = ' num2str(std(trialdata(50000:150000,1)))])