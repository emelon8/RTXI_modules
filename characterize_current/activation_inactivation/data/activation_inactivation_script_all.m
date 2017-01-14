clear;clc;close all
tic

dates_all={'Mar_14_14' 'Mar_25_14' 'Mar_31_14' 'Apr_03_14' 'Apr_08_14'};
cellnum_all={'A' 'A' 'A' 'A' 'A'};
trials_all=[2 1 1 1 1];
activation_step_starting_V_all=[-100 -100 -100 -100 -100];
activation_step_finishing_V_all=[0 0 0 20 20];
increments_all=[21 21 21 25 25];
activation_step_t_all=[20 20 20 20 20];
inactivation_step_V_all=[-30 -30 -30 -30 -30];
inactivation_step_t_all=[5 5 5 5 5];
pause_t_all=[20 20 20 20 20];
expf_activation_parameters_to_use=[1 1 2 1 1];
expf_inactivation_parameters_to_use=[1 1 2 1 2];
dexpf_inactivation_parameters_to_use=[1 1 1 1 1];

expf_activation_parameters_all=[-4090.57207005425,7256.14810882010,-0.109697872919710,0.141792366218903;...
    -4607.05510648876,6296.63754908715,-0.00718979419040350,9.33593662681046];
expf_inactivation_parameters_all=[122.234694599944,1314.09811874337,1.16091768851032,16.6292529699171;...
    -612.494368596627,1514.02059267331,1.39812452046320,76.2552186855494];
dexpf_inactivation_parameters_all=[-461.877787498269,1329.67201336534,-7.75875370110768,5.94025929879121,1012.98088735004,-6.50978668817920,55.4942432894855];


for k=1:numel(dates_all)
    recdate=dates_all{k};
    cellnum=cellnum_all{k};
    trial=trials_all(k);
    module='activation_inactivation';
    activation_step_starting_V=activation_step_starting_V_all(k); % Voltages are in millivolts
    activation_step_finishing_V=activation_step_finishing_V_all(k);
    increments=increments_all(k);
    activation_step_t=activation_step_t_all(k); % Times are in seconds
    inactivation_step_V=inactivation_step_V_all(k);
    inactivation_step_t=inactivation_step_t_all(k);
    pause_t=pause_t_all(k);
    EK=-93.0802; % -82.2833;
    activation_begintimes=0.005*ones(1,increments); %[0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01];
    sample_rate=10000;   % Sample rate in Hz
    leaksteps=0; % number of steps to where the V-I curve is linear
    expf_activation_parameters=expf_activation_parameters_all(expf_activation_parameters_to_use(k),:);
    expf_inactivation_parameters=expf_inactivation_parameters_all(expf_inactivation_parameters_to_use(k),:);
    dexpf_inactivation_parameters=dexpf_inactivation_parameters_all(dexpf_inactivation_parameters_to_use(k),:);
    saveit=1;
    
    parameters=[activation_step_starting_V activation_step_finishing_V increments...
        activation_step_t inactivation_step_V inactivation_step_t pause_t leaksteps];
    
    [mean_starting,meanactivation,mean_max_current_activation,mean_max_activation,...
        mean_max_current_inactivation,mean_max_inactivation,normalized_activation_temp,normalized_inactivation_temp,...
        activation_voltages,baselinecurrent,conductancedata,expf_activation,expf_inactivation,...
        rsq_activation_sig,rsq_inactivation_sig,...
        sigslope_normalized_activation,sigslope_normalized_inactivation,rsq_normalized_activation_sig,rsq_normalized_inactivation_sig...
        nlf_normalized_activation,nlf_normalized_inactivation,min_snippet_activation,max_snippet_activation,min_snippet_inactivation,max_snippet_inactivation]=... %,tau_activation,dexpf_inactivation
        activation_inactivation(module,recdate,cellnum,trial,activation_step_starting_V,...
        activation_step_finishing_V,increments,activation_step_t,inactivation_step_V,...
        inactivation_step_t,pause_t,EK,activation_begintimes,sample_rate,leaksteps,...
        expf_activation_parameters,expf_inactivation_parameters,dexpf_inactivation_parameters);
    
    if saveit~=0
        save([module '_' recdate '_' cellnum num2str(trial) '_activation_inactivation'],...
            'parameters','mean_starting','mean_max_current_activation','mean_max_activation','mean_max_current_inactivation','mean_max_inactivation',...
            'normalized_activation_temp','normalized_inactivation_temp','activation_voltages',...
            'baselinecurrent','expf_activation','expf_inactivation','rsq_activation_sig','rsq_inactivation_sig',...
            'sigslope_normalized_activation','sigslope_normalized_inactivation','rsq_normalized_activation_sig',...
            'rsq_normalized_inactivation_sig','nlf_normalized_activation','nlf_normalized_inactivation','min_snippet_activation','max_snippet_activation','min_snippet_inactivation','max_snippet_inactivation') %,'tau_activation','dexpf_inactivation'
    end
end

% close all

toc

% P85
% run script again. then see whether double exponential consistently has
% the slow variable first or second. The ratio of the A values of the exponential will
% hopefully be consistent among the fast or slow terms.
% fit exponential to initial steps of current clamp to find membrane time constant (RC) and use that and input resistance in model