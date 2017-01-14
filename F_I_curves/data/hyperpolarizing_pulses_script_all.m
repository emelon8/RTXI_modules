clear;clc;close all

tic

% Apr_06_15_B1 is a good example of a cholinergic neuron firing fastly

% dates_all={'Apr_03_15' 'Apr_03_15' 'Apr_03_15' 'Apr_06_15' 'Apr_06_15' 'Apr_06_15'...
%     'Apr_06_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15'...
%     'Apr_08_15' 'Apr_08_15' 'Apr_08_15' 'Apr_08_15' 'Apr_08_15'}; % End of no hyperpolarizing pulses
% dates_all={'Apr_03_15' 'Apr_03_15' 'Apr_06_15' 'Apr_06_15' 'Apr_06_15' 'Apr_07_15'...
%     'Apr_07_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15' 'Apr_07_15'...
%     'Apr_08_15' 'Apr_08_15' 'Apr_08_15' 'Apr_08_15' 'Apr_08_15' 'Apr_08_15'...
%     'Apr_08_15' 'Apr_08_15'}; % End of hyperpolarizing pulses
% dates_all={'Apr_10_15' 'Apr_10_15' 'Apr_10_15' 'Apr_10_15' 'Apr_17_15' 'Apr_17_15'...
%     'Apr_28_15' 'Apr_28_15' 'Apr_28_15' 'Apr_28_15' 'Apr_28_15' 'Apr_29_15' ...
%     'Apr_29_15' 'Apr_29_15' 'Apr_29_15' 'Apr_29_15' 'Apr_29_15' 'Apr_29_15'...
%     'May_01_15' 'May_01_15' 'May_01_15' 'May_01_15' 'May_01_15' 'May_01_15'...
%     'May_01_15' 'May_01_15' 'May_01_15' 'May_04_15' 'May_04_15' 'May_04_15'...
%     'May_04_15' 'May_04_15' 'May_04_15' 'May_04_15' 'May_04_15' 'May_05_15'...
%     'May_05_15' 'May_05_15' 'May_05_15' 'May_05_15' 'May_05_15'}; % End of no hyperpolarizing pulses non-cholinergic
dates_all={'Apr_10_15' 'Apr_10_15' 'Apr_10_15' 'Apr_10_15' 'Apr_17_15' 'Apr_28_15'...
    'Apr_28_15' 'Apr_28_15' 'Apr_28_15' 'Apr_28_15' 'Apr_29_15' 'Apr_29_15'...
    'Apr_29_15' 'Apr_29_15' 'Apr_29_15' 'Apr_29_15' 'Apr_29_15' 'Apr_29_15'...
    'Apr_29_15' 'May_01_15' 'May_01_15' 'May_01_15' 'May_01_15' 'May_01_15'...
    'May_01_15' 'May_01_15' 'May_01_15' 'May_04_15' 'May_04_15' 'May_04_15'...
    'May_04_15' 'May_04_15' 'May_04_15' 'May_04_15' 'May_04_15' 'May_05_15'...
    'May_05_15' 'May_05_15' 'May_05_15' 'May_05_15'}; % End of hyperpolarizing pulses non-cholinergic

% cellnum_all={'A' 'B' 'B' 'A' 'A' 'B'...
%     'B' 'A' 'A' 'B' 'C' 'D'...
%     'B' 'C' 'D' 'E' 'E'}; % End of no hyperpolarizing pulses
% cellnum_all={'A' 'B' 'A' 'B' 'B' 'A'...
%     'A' 'B' 'C' 'C' 'C' 'D'...
%     'A' 'B' 'C' 'D' 'D' 'D'...
%     'D' 'E'}; % End of hyperpolarizing pulses
% cellnum_all={'A' 'B' 'C' 'C' 'A' 'A'...
%     'A' 'A' 'B' 'B' 'B' 'A'...
%     'B' 'B' 'B' 'C' 'C' 'D'...
%     'A' 'A' 'A' 'A' 'B' 'B'...
%     'B' 'B' 'B' 'A' 'A' 'A'...
%     'A' 'B' 'B' 'B' 'B' 'A'...
%     'A' 'A' 'B' 'B' 'C'}; % End of no hyperpolarizing pulses non-cholinergic
cellnum_all={'A' 'B' 'B' 'C' 'A' 'A'...
    'B' 'B' 'B' 'B' 'A' 'B'...
    'B' 'B' 'C' 'C' 'C' 'C'...
    'D' 'A' 'A' 'A' 'A' 'B'...
    'B' 'B' 'B' 'A' 'A' 'A'...
    'A' 'B' 'B' 'B' 'B' 'A'...
    'A' 'B' 'B' 'C'}; % End of hyperpolarizing pulses non-cholinergic

% trials_all=[1 1 3 1 3 2 ...
%     4 1 8 1 1 1 ...
%     1 1 1 1 3]'; % End of no hyperpolarizing pulses
% trials_all=[2 2 2 1 3 2 ...
%     9 2 2 3 4 2 ...
%     1 2 2 2 3 4 ...
%     5 2]'; % End of hyperpolarizing pulses
% trials_all=[1 1 1 3 1 2 ...
%     1 3 2 4 6 2 ...
%     3 4 5 4 5 2 ...
%     2 4 5 7 2 3 ...
%     4 7 8 2 3 4 ...
%     6 2 4 5 7 4 ...
%     5 6 3 5 6]'; % End of no hyperpolarizing pulses non-cholinergic
trials_all=[2 2 3 2 3 2 ...
    1 3 5 7 1 1 ...
    2 6 1 2 3 6 ...
    1 1 3 6 8 1 ...
    5 6 9 1 5 7 ...
    8 1 3 6 8 3 ...
    7 4 6 5]'; % End of hyperpolarizing pulses non-cholinergic

% delay_all=[0 0 0 2 2 2 ...
%     2 2 2 2 2 2 ...
%     2 2 2 2 2]'; % End of no hyperpolarizing pulses
% delay_all=[0 0 2 2 2 2 ...
%     2 2 2 2 2 2 ...
%     2 2 2 2 2 2 ...
%     2 2]'; % End of hyperpolarizing pulses
% delay_all=[2 2 2 2 2 2 ...
%     2 2 2 2 2 2 ...
%     2 2 2 2 2 2 ...
%     2 2 2 2 2 2 ...
%     2 2 2 2 2 2 ...
%     2 2 2 2 2 2 ...
%     2 2 2 2 2]'; % End of no hyperpolarizing pulses non-cholinergic
delay_all=[2 2 2 2 2 2 ...
    2 2 2 2 2 2 ...
    2 2 2 2 2 2 ...
    2 2 2 2 2 2 ...
    2 2 2 2 2 2 ...
    2 2 2 2 2 2 ...
    2 2 2 2]'; % End of hyperpolarizing pulses non-cholinergic

for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    module='fi_curves';
    % trials=1:numel(whos)-3;
    trials=trials_all(k,:);
    delay=delay_all(k,:);
    sample_rate=10000;   % Sample rate in Hz
    shouldplotFI=0; % Should the function plot the F-I curves? 1 for yes, 0 for no.
    saveit=1;
    
    [rate_all,numberspikes,thresholds,imp,pulse_duration,pause_duration,increments,currents,hyperpolarization_pulse_voltages,depolarization_pulse_voltages]=...
        hyperpolarizing_pulses_rate(module,recdate,cellnum,trials,delay,sample_rate,shouldplotFI);
    
    if saveit~=0
        save([pwd '\..\..\F_I_curves\data\hyperpolarizing_pulses_analysis\' module '_' recdate '_' cellnum num2str(trials) '_hp'],...
            'rate_all','thresholds','imp','pulse_duration','pause_duration','increments','currents','hyperpolarization_pulse_voltages','depolarization_pulse_voltages')
    end
end

toc