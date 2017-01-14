clear;clc;close all

module_all={'fi_curves' 'fi_curves'};
dates_all={'Dec_22_14' 'Dec_22_14'};
cellnum_all={'C' 'C'};
trials_all=[1 2]';

points_all=repmat([1 21],size(trials_all));

for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    module=module_all{k};
    % trials=1:numel(whos)-3;
    trials=trials_all(k,:);
    points=points_all(k,:);
    sample_rate=10000;   % Sample rate in Hz
    shouldplotFI=0; % Should the function plot the F-I curves? 1 for yes, 0 for no.
    shouldplotFV=0;
    shouldplotsegmenter=1;
    
    if strcmp(module,'fi_curves')
        cd ../../F_I_curves/data/
        
        [rate_all,peakrate,nofailrate,mean_holdingvoltage,...
            numberspikes,thresholds,imp,pulse_duration,pause_duration,delay,increments,currents,pf_all_fi,std_noise]=...
            fi_rate_leak_and_subtraction(module,recdate,cellnum,trials,points,sample_rate,shouldplotFI);
        
        segmenter(module,recdate,cellnum,trials,delay,pulse_duration,pause_duration,increments,sample_rate,shouldplotsegmenter)
        
        [~,~,~,~,~,~,~,~,pf_all_fV,threshold,avg_voltage,avg_voltage_trunc]=...
            fV_rate_leak_and_subtraction(module,recdate,cellnum,trials,points,sample_rate,shouldplotFV);
    else
        cd ../../FI_OU/data/
        
        [rate_all_OU,peakrate_OU,nofailrate_OU,mean_holdingvoltage_OU,...
            numberspikes_OU,thresholds_OU,imp_OU,pulse_duration_OU,pause_duration_OU,delay_OU,increments_OU,currents_OU,pf_all_OU,std_noise_OU]=...
            fi_rate(module,recdate,cellnum,trials,points,sample_rate,shouldplotFI);

        [~,~,~,~,~,~,~,~,pf_all_fV_OU,threshold_OU,avg_voltage_OU,avg_voltage_trunc_OU]=...
            fV_rate(module,recdate,cellnum,trials,points,sample_rate,shouldplotFV);
    end
end