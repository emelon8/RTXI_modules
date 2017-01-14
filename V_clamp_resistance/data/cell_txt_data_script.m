clear

recdate='Aug_06_14';
cellnum='A';
trials=1;
module='v_clamp2';

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