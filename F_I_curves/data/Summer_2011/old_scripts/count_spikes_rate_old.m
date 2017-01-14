trials_control=5;
trials_100uMpropofol=5;
increments=15;

% Protocol: 10 sec delay, then 1 second pulses, followed by 10 second
% pauses, totalling 175 seconds. Pulses start at 10 pA and go to 150 pA
% over 15 increments.
V_control=[fi_curves_Jul_15_11_B1(:,2) fi_curves_Jul_15_11_B2(:,2) fi_curves_Jul_15_11_B3(:,2) fi_curves_Jul_15_11_B4(:,2) fi_curves_Jul_15_11_B5(:,2)];
V_100uMpropofol=[fi_curves_Jul_15_11_B6(:,2) fi_curves_Jul_15_11_B7(:,2) fi_curves_Jul_15_11_B8(:,2) fi_curves_Jul_15_11_B9(:,2) fi_curves_Jul_15_11_B10(:,2)];

% Set all steps equal to 0 in a new vector X except those where the voltage
% was greater than or equal to 0. Set those steps equal to 1.
X_control=zeros(numel(V_control(:,1)),trials_control);
X_100uMpropofol=zeros(numel(V_100uMpropofol(:,1)),trials_100uMpropofol);

for w=1:trials_control
    if V_control(1,w)>=-0.02
        X_control(1,w)=1;
    else
        X_control(1,w)=0;
    end
    for k=2:numel(V_control(:,w))
        if V_control(k,w)>=-0.02 && V_control(k-1,w)<-0.02
            X_control(k,w)=1;
        else
            X_control(k,w)=0;
        end
    end
end

for w=1:trials_100uMpropofol
    if V_100uMpropofol(1,w)>=-0.02
        X_100uMpropofol(1,w)=1;
    else
        X_100uMpropofol(1,w)=0;
    end
    for k=2:numel(V_100uMpropofol(:,w))
        if V_100uMpropofol(k,w)>=-0.02 && V_100uMpropofol(k-1,w)<-0.02
            X_100uMpropofol(k,w)=1;
        else
            X_100uMpropofol(k,w)=0;
        end
    end
end

% Finding the overall rate for each of the current pulses
rate_control=zeros(increments,trials_control);
rate_100uMpropofol=zeros(increments,trials_100uMpropofol);

for s=1:trials_control
    for q=1:increments
        rate_control(q,s)=sum(X_control(q*110000-9999:q*110000,s));
    end
end

for s=1:trials_100uMpropofol
    for q=1:increments
        rate_100uMpropofol(q,s)=sum(X_100uMpropofol(q*110000-9999:q*110000,s));
    end
end

%subplot(2,1,1)
figure;plot(rate_control)
%axis([1 15 0 20])
%subplot(2,1,2)
figure;plot(rate_100uMpropofol)
%axis([1 15 0 20])

rate_average=zeros(increments,2);

for k=1:increments
    rate_average(k,1)=mean(rate_control(k,:));
end

for k=1:increments
    rate_average(k,2)=mean(rate_100uMpropofol(k,:));
end

figure;plot(rate_average)
%axis([1 15 0 20])

% Finding the firing rate before and after adaptation
rate_control_initial=zeros(increments,trials_control);
rate_100uMpropofol_initial=zeros(increments,trials_100uMpropofol);

for s=1:trials_control
    for q=1:increments
        rate_control_initial(q,s)=sum(X_control(q*110000-9999:q*110000-7000,s))*(10000/3000);
    end
end

for s=1:trials_100uMpropofol
    for q=1:increments
        rate_100uMpropofol_initial(q,s)=sum(X_100uMpropofol(q*110000-9999:q*110000-7000,s))*(10000/3000);
    end
end

rate_control_adapted=zeros(increments,trials_control);
rate_100uMpropofol_adapted=zeros(increments,trials_100uMpropofol);

for s=1:trials_control
    for q=1:increments
        rate_control_adapted(q,s)=sum(X_control(q*110000-6999:q*110000,s))*(10000/7000);
    end
end

for s=1:trials_100uMpropofol
    for q=1:increments
        rate_100uMpropofol_adapted(q,s)=sum(X_100uMpropofol(q*110000-6999:q*110000,s))*(10000/7000);
    end
end

rate_initial_average=zeros(increments,2);

for k=1:increments
    rate_initial_average(k,1)=mean(rate_control_initial(k,:));
end

for k=1:increments
    rate_initial_average(k,2)=mean(rate_100uMpropofol_initial(k,:));
end

rate_adapted_average=zeros(increments,2);

for k=1:increments
    rate_adapted_average(k,1)=mean(rate_control_adapted(k,:));
end

for k=1:increments
    rate_adapted_average(k,2)=mean(rate_100uMpropofol_adapted(k,:));
end


figure;plot(rate_control_initial)
%axis([1 15 0 30])
figure;plot(rate_100uMpropofol_initial)
%axis([1 15 0 30])
figure;plot(rate_initial_average)
%axis([1 15 0 30])
figure;plot(rate_control_adapted)
%axis([1 15 0 30])
figure;plot(rate_100uMpropofol_adapted)
%axis([1 15 0 30])
figure;plot(rate_adapted_average)
%axis([1 15 0 30])