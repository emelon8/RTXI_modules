function outv = open_binary(path,rt,nr,sr)
% path is the full path of the file you want to open
% rt is the recording time in seconds.
% nr is the number of rows recorded (num of variables).
% sr is the sampling rate

nc = rt * sr;
myfid = fopen(path,'r');
in1 = fread(myfid,[nr nc], 'double');
outv = in1';
fclose(myfid);

end
