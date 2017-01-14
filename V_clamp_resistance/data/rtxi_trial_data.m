% clear;clc

recdate = 'Dec_19_13';
celltrial = 'D4';
t_sec = 350; % time of recording in seconds
module = 'v_clamp';
sample_rate = 10000;
recnum = 3; % number of recorded variables

trial_file=[pwd '\' module '_' recdate '_' celltrial '.dat'];
in1 = open_binary(trial_file,t_sec,recnum,sample_rate);
eval([module '_' recdate '_' celltrial '=in1;'])
eval([module '_' recdate '_' celltrial '=' module '_' recdate '_' celltrial '(:,2:' num2str(recnum) ');'])