clear;%clc;%close all

tic

recdate='Feb_03_15';
cellnum='C';
module='FI_OU';
% trials=1:numel(whos)-3; % if you want to analyze all the trials, use this
trials=[1]; % ...otherwise, specify the trials here
points=[3 4]; % first and last points to include in the linear fit (2 per trial)
sample_rate=10000;   % Sample rate in Hz
shouldplotFI=1; % Should the function plot the F-I curves? 1 for yes, 0 for no.
% saveit=0;

[rate_all,peakrate,nofailrate,mean_holdingvoltage,mean_r_m,std_r_m,mean_time_constant,std_time_constant,mean_c_m,std_c_m,...
    numberspikes,imp,pulse_duration,pause_duration,delay,increments,currents,pf_all]=...
    fi_rate(module,recdate,cellnum,trials,points,sample_rate,shouldplotFI);

% if saveit~=0
%     save([pwd '\..\..\FI_OU\data\fi_analysis\' module '_' recdate '_' cellnum '_fi'],'rate_all','imp','pulse_duration',...
%         'pause_duration','delay','increments','currents','pf_all')
% end

% close all

toc