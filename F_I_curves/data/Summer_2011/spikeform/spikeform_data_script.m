clear

recdate='Oct_13_11';
cellnum='D';
trials_control=1;
trials_propofol=1;
conc_propofol=100;

spikeform_data(recdate,cellnum,trials_control,trials_propofol,conc_propofol)

if trials_control>0
    save(['spikeform_' recdate '_' cellnum '_control'],['spikeform_' recdate '_' cellnum '1'])
    if trials_control>1
        for k=2:trials_control
            save(['spikeform_' recdate '_' cellnum '_control'],['spikeform_' recdate '_' cellnum num2str(k)],'-append')
        end
    end
end

if trials_propofol>0
    save(['spikeform_' recdate '_' cellnum '_' num2str(conc_propofol) 'uMpropofol'],['spikeform_' recdate '_' cellnum num2str(trials_control+1)])
    if trials_propofol>1
        for k=trials_control+2:trials_control+trials_propofol
            save(['spikeform_' recdate '_' cellnum '_' num2str(conc_propofol) 'uMpropofol'],['spikeform_' recdate '_' cellnum num2str(k)],'-append')
        end
    end
end