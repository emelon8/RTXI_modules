clear

recdate='May_14_14';
cellnum='C';
trials=3;
module='recovery_time';

cell_txt_data(recdate,cellnum,module,trials)

for k=1:trials
    eval([module '_' recdate '_' cellnum num2str(k)...
        '=' module '_' recdate '_' cellnum num2str(k) '(:,2:end);'])
end

save([module '_' recdate '_' cellnum],[module '_' recdate '_' cellnum '1'])

if trials>1
    for k=2:trials
        save([module '_' recdate '_' cellnum],[module '_' recdate '_' cellnum num2str(k)],'-append')
    end
end