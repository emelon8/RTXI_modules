% Used to reduce the size of text files that weren't reduced already

clear;clc

recdate='Sep_02_11';
cellnum='B';
conc_propofol='100uMpropofol';
module='fi_curves';

s=whos('-file',[module '_' recdate '_' cellnum '_' conc_propofol]);

load([module '_' recdate '_' cellnum '_' conc_propofol])

for k=1:numel(s)
    eval([s(k).name '=' s(k).name '(:,2:end);'])
end

save([module '_' recdate '_' cellnum '_' conc_propofol],s(1).name)

if numel(s)>1
    for k=2:numel(s)
        save([module '_' recdate '_' cellnum '_' conc_propofol],s(k).name,'-append')
    end
end