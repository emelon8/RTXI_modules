clear

load controls.mat

controls_slopes_all=control_slopes_all;
clear control_slopes_all
controls_slopes_init=control_slopes_init;
clear control_slopes_init
controls_slopes_accom=control_slopes_accom;
clear control_slopes_accom

load propofols.mat

% [ttests_slope_all(1),ttests_slope_all(2)]=ttest2(control_slopes_all,...
%     controls_slopes_all);
% [ttests_slope_init(1),ttests_slope_init(2)]=ttest2(control_slopes_init,...
%     controls_slopes_init);
% [ttests_slope_accom(1),ttests_slope_accom(2)]=ttest2(control_slopes_accom,...
%     controls_slopes_accom);

[ttest_slope_all(1),ttest_slope_all(2)]=ttest2(control2_slopes_all,...
    propofol_slopes_all);
[ttest_slope_init(1),ttest_slope_init(2)]=ttest2(control2_slopes_init,...
    propofol_slopes_init);
[ttest_slope_accom(1),ttest_slope_accom(2)]=ttest2(control2_slopes_accom,...
    propofol_slopes_accom);

% Bargraph

bargraph=[mean(control2_slopes_accom) std(control2_slopes_accom)/sqrt(numel(control2_slopes_accom));...
    mean(propofol_slopes_accom) std(propofol_slopes_accom)/sqrt(numel(propofol_slopes_accom))];

bar(bargraph(:,1),0.5,'b')
set(gca,'XTickLabel',{'Delayed Control', 'Propofol'},'FontSize',14)
title('Effects on Gain of Delayed Control and 100 \muM Propofol')
ylabel('Gain [Hz/pA]')
axis([0.6 2.4 0 0.15])
hold on
errorbar(bargraph(:,1),bargraph(:,2),'.b','LineWidth',2.5)
