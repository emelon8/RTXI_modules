function segmented_trials=segmenter(module,recdate,cellnum,trials,delay,pulse_duration,pause_duration,increments,sample_rate,shouldplotsegmenter,noise)

if noise==1
    cd([pwd '\..\..\FI_OU\data\'])
end

load([module '_' recdate '_' cellnum])

beginning=NaN(1,numel(trials));
finish=NaN(1,numel(trials));
segmented_trials=cell(2,numel(trials));

for k=1:numel(trials)
    eval([' trialdata=' module '_' recdate '_' cellnum num2str(trials(k)) ''';'])
    if pulse_duration(k)*sample_rate==numel(trialdata(1,:))
        segmented_trials{1,k}=trialdata(1,:);
        segmented_trials{2,k}=trialdata(2,:);
    else
        beginning(k)=round((delay(k)+(increments(k)-1)*(pulse_duration(k)+pause_duration(k))-pause_duration(k)/2)*sample_rate);
        finish(k)=round((delay(k)+(increments(k)-1)*(pulse_duration(k)+pause_duration(k))+(pulse_duration(k)+pause_duration(k)/2))*sample_rate);
        if pause_duration(k)/2>=delay(k)
            segmented_trials{1,k}(1,:)=[NaN(1,round((pause_duration(k)/2-delay(k))*sample_rate))...
                trialdata(1,1:round((delay(k)+(pulse_duration(k)+pause_duration(k)/2))*sample_rate))];
            segmented_trials{2,k}(1,:)=[NaN(1,round((pause_duration(k)/2-delay(k))*sample_rate))...
                trialdata(2,1:round((delay(k)+(pulse_duration(k)+pause_duration(k)/2))*sample_rate))];
            for h=2:increments(k)-1
                segmented_trials{1,k}(h,:)=trialdata(1,round((delay(k)+(h-1)*...
                    (pulse_duration(k)+pause_duration(k))-pause_duration(k)/2)*sample_rate):...
                    round((delay(k)+(h-1)*(pulse_duration(k)+pause_duration(k))-...
                    pause_duration(k)/2)*sample_rate+numel(segmented_trials{1,k}(1,:))-1));
                segmented_trials{2,k}(h,:)=trialdata(2,round((delay(k)+(h-1)*...
                    (pulse_duration(k)+pause_duration(k))-pause_duration(k)/2)*sample_rate):...
                    round((delay(k)+(h-1)*(pulse_duration(k)+pause_duration(k))-...
                    pause_duration(k)/2)*sample_rate+numel(segmented_trials{2,k}(1,:))-1));
            end
            if numel(trialdata(1,:))<=round((delay(k)+increments(k)*(pulse_duration(k)+pause_duration(k))-pause_duration(k)/2)*sample_rate)
                segmented_trials{1,k}(increments(k),:)=NaN(size(segmented_trials{k}(1,1,:)));
                segmented_trials{1,k}(increments(k),1:numel(trialdata(1,:))-beginning(k))=trialdata(1,beginning(k):end);
                segmented_trials{2,k}(increments(k),:)=NaN(size(segmented_trials{k}(2,1,:)));
                segmented_trials{2,k}(increments(k),1:numel(trialdata(2,:))-beginning(k))=trialdata(2,beginning(k):end);
            elseif numel(trialdata(1,beginning(k)+1:finish(k)))==numel(segmented_trials{1,k}(1,:))
                segmented_trials{1,k}(increments(k),:)=trialdata(1,beginning(k)+1:finish(k));
                segmented_trials{2,k}(increments(k),:)=trialdata(2,beginning(k)+1:finish(k));
            else
                segmented_trials{1,k}(increments(k),:)=trialdata(1,beginning(k):finish(k));
                segmented_trials{2,k}(increments(k),:)=trialdata(2,beginning(k):finish(k));
            end
        else
            segmented_trials{1,k}(1,:)=trialdata(1,(delay(k)-pause_duration(k)/2)*sample_rate:...
                round((delay(k)+pulse_duration(k)+pause_duration(k)/2)*sample_rate));
            segmented_trials{2,k}(1,:)=trialdata(2,(delay(k)-pause_duration(k)/2)*sample_rate:...
                round((delay(k)+pulse_duration(k)+pause_duration(k)/2)*sample_rate));
            for h=2:increments(k)-1
                if noise~=1
                    segmented_trials{1,k}(h,:)=trialdata(1,round((delay(k)+(h-1)*...
                        (pulse_duration(k)+pause_duration(k))-pause_duration(k)/2)*sample_rate):...
                        round((delay(k)+(h-1)*(pulse_duration(k)+pause_duration(k))+...
                        (pulse_duration(k)+pause_duration(k)/2))*sample_rate));
                    segmented_trials{2,k}(h,:)=trialdata(2,round((delay(k)+(h-1)*...
                        (pulse_duration(k)+pause_duration(k))-pause_duration(k)/2)*sample_rate):...
                        round((delay(k)+(h-1)*(pulse_duration(k)+pause_duration(k))+...
                        (pulse_duration(k)+pause_duration(k)/2))*sample_rate));
                else
                    cool=trialdata(1,round((delay(k)+(h-1)*...
                        (pulse_duration(k)+pause_duration(k))-pause_duration(k)/2)*sample_rate):...
                        round((delay(k)+(h-1)*(pulse_duration(k)+pause_duration(k))+...
                        (pulse_duration(k)+pause_duration(k)/2))*sample_rate));
                    segmented_trials{1,k}(h,:)=cool(1:60003); %60003 FOR HYPERPOLARIZED; 60002 FOR DEPOLARIZED
                    cool2=trialdata(2,round((delay(k)+(h-1)*...
                        (pulse_duration(k)+pause_duration(k))-pause_duration(k)/2)*sample_rate):...
                        round((delay(k)+(h-1)*(pulse_duration(k)+pause_duration(k))+...
                        (pulse_duration(k)+pause_duration(k)/2))*sample_rate));
                    segmented_trials{2,k}(h,:)=cool2(1:60003); %60003 FOR HYPERPOLARIZED; 60002 FOR DEPOLARIZED
                end
            end
            if numel(trialdata(1,:))<=round((delay(k)+increments(k)*(pulse_duration(k)+pause_duration(k))-pause_duration(k)/2)*sample_rate)
                segmented_trials{1,k}(increments(k),:)=NaN(size(segmented_trials{k}(1,1,:)));
                segmented_trials{1,k}(increments(k),1:numel(trialdata(1,:))-beginning(k))=trialdata(1,beginning(k):end);
                segmented_trials{2,k}(increments(k),:)=NaN(size(segmented_trials{k}(2,1,:)));
                segmented_trials{2,k}(increments(k),1:numel(trialdata(2,:))-beginning(k))=trialdata(2,beginning(k):end);
            else
                cool3=trialdata(1,beginning(k):finish(k));
                segmented_trials{1,k}(increments(k),:)=cool3(1:60003); %60003 FOR HYPERPOLARIZED; 60002 FOR DEPOLARIZED
                cool4=trialdata(2,beginning(k):finish(k));
                segmented_trials{2,k}(increments(k),:)=cool4(1:60003); %60003 FOR HYPERPOLARIZED; 60002 FOR DEPOLARIZED
            end
        end
    end
end

if shouldplotsegmenter~=0
    for k=1:numel(trials)
        figure
        plot((1:numel(segmented_trials{1,k}(1,:)))/10,segmented_trials{1,k}(1:2:20,:)','k')%*1000  32000:34000
%         title({[module '_' recdate '_' cellnum num2str(trials(k))];...
%             ['Increments: ' num2str(increments(k)) '; Delay: ' num2str(delay(k))...
%             '; Pulse Duration: ' num2str(pulse_duration(k)) '; Pause Duration: '...
%             num2str(pause_duration(k))]},'interpreter','none')
        xlabel('time [ms]')
        ylabel('membrane voltage [mV]')
        axis([1 numel(segmented_trials{1,k}(1,:))/10 -100 40])
    end
end