clear;clc

recdate = 'Apr_23_12';
cellnum = 'C';
trials = 2;
t_sec = 45; % time of recording in seconds
module = 'v_step';
sample_rate = 10000;
recnum = 3; % number of recorded variables

trial_file=[pwd '\' module '_' recdate '_' cellnum num2str(1) '.dat'];
in1 = open_binary(trial_file,t_sec,recnum,sample_rate);
eval([module '_' recdate '_' cellnum '1=in1;'])
eval([module '_' recdate '_' cellnum '1=' module '_' recdate '_' cellnum '1(:,2:' num2str(recnum) ');'])
save([module '_' recdate '_' cellnum],[module '_' recdate '_' cellnum '1'])

if trials>1
    for k=2:trials
        trial_file=[pwd '\' module '_' recdate '_' cellnum num2str(k) '.dat'];
        in1 = open_binary(trial_file,t_sec,recnum,sample_rate);
        eval([module '_' recdate '_' cellnum num2str(k) '=in1;'])
        eval([module '_' recdate '_' cellnum num2str(k) '=' module '_' recdate '_' cellnum num2str(k) '(:,2:' num2str(recnum) ');'])
        save([module '_' recdate '_' cellnum],[module '_' recdate '_' cellnum num2str(k)],'-append')
    end
end