clear;clc

recdate = 'Sep_12_14';
cellnum = 'A';
trials = 4;
t_sec = 455; % time of recording in seconds
module = 'hyperpolarized_OUSynD';
sample_rate = 10000;
recnum = 5; % number of recorded variables

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