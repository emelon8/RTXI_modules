clear

recdate='Nov_25_11';
cellnum='A';
trials_control=7;
trials_propofol=0;
conc_propofol=100;

resting_potential_data(recdate,cellnum,trials_control,trials_propofol,conc_propofol)

if trials_control>0
    save(['resting_potential_' recdate '_' cellnum '_control'],['resting_potential_' recdate '_' cellnum '1'])
    if trials_control>1
        for k=1:trials_control
            save(['resting_potential_' recdate '_' cellnum '_control'],['resting_potential_' recdate '_' cellnum num2str(k)],'-append')
        end
    end
end

if trials_propofol>0
    save(['resting_potential_' recdate '_' cellnum '_' num2str(conc_propofol) 'uMpropofol'],['resting_potential_' recdate '_' cellnum num2str(trials_control+1)])
    if trials_propofol>1
        for k=trials_control+1:trials_control+trials_propofol
            save(['resting_potential_' recdate '_' cellnum '_' num2str(conc_propofol) 'uMpropofol'],['resting_potential_' recdate '_' cellnum num2str(k)],'-append')
        end
    end
end