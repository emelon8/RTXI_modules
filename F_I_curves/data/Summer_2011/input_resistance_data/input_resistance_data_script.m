clear

recdate='Nov_25_11';
cellnum='A';
trials_control=7;
trials_propofol=0;
conc_propofol=100;

input_resistance_data(recdate,cellnum,trials_control,trials_propofol,conc_propofol)

if trials_control>0
    save(['input_resistance_' recdate '_' cellnum '_control'],['input_resistance_' recdate '_' cellnum '1'])
    if trials_control>1
        for k=1:trials_control
            save(['input_resistance_' recdate '_' cellnum '_control'],['input_resistance_' recdate '_' cellnum num2str(k)],'-append')
        end
    end
end

if trials_propofol>0
    save(['input_resistance_' recdate '_' cellnum '_' num2str(conc_propofol) 'uMpropofol'],['input_resistance_' recdate '_' cellnum num2str(trials_control+1)])
    if trials_propofol>1
        for k=trials_control+1:trials_control+trials_propofol
            save(['input_resistance_' recdate '_' cellnum '_' num2str(conc_propofol) 'uMpropofol'],['input_resistance_' recdate '_' cellnum num2str(k)],'-append')
        end
    end
end