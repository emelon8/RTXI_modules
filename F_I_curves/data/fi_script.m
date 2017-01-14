clear;%clc;%close all

tic

recdate='Mar_11_15';
cellnum='B';
module='fi_curves';
% trials=1:numel(whos)-3; % if you want to analyze all the trials, use this
trials=[1 2]; % ...otherwise, specify the trials here
points=[3 4 3 4]; % first and last points to include in the linear fit (2 per trial)
sample_rate=10000;   % Sample rate in Hz
shouldplotFI=1; % Should the function plot the F-I curves? 1 for yes, 0 for no.
shouldplotsegmenter =0;
% saveit=0;

[rate_all,peakrate,nofailrate,mean_holdingvoltage,mean_r_m,std_r_m,mean_time_constant,std_time_constant,mean_c_m,std_c_m,...
    numberspikes,thresholds,imp,pulse_duration,pause_duration,delay,increments,currents,pf_all,std_noise]=...
    fi_rate(module,recdate,cellnum,trials,points,sample_rate,shouldplotFI);

segmented_trials=segmenter(module,recdate,cellnum,trials,delay,pulse_duration,pause_duration,increments,sample_rate,shouldplotsegmenter);

% if saveit~=0
%     save([pwd '\..\..\F_I_curves\data\fi_analysis\' module '_' recdate '_' cellnum '_fi'],'rate_all','imp','pulse_duration',...
%         'pause_duration','delay','increments','currents','pf_all')
% end

% close all

toc