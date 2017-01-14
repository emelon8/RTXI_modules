clear;clc;close all
tic


recdate='Feb_10_15';
cellnum='B';
trial=1;
module='activation_inactivation';
load([module '_' recdate '_' cellnum])
activation_step_starting_V=-90; % Voltages are in millivolts
activation_step_finishing_V=10;
increments=21;
activation_step_t=20; % Times are in seconds
inactivation_step_V=-30;
inactivation_step_t=5;
pause_t=20;
EK=-82.2833;
activation_begintimes=0.005*ones(1,increments); %[0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01 0.01];
sample_rate=10000;   % Sample rate in Hz
leaksteps=0; % number of steps to where the V-I curve is linear
expf_activation_parameters=[-4607.05510648876,6296.63754908715,-0.00718979419040350,9.33593662681046];%[-4090.57207005425,7256.14810882010,-0.109697872919710,0.141792366218903]
expf_inactivation_parameters=[-612.494368596627,1514.02059267331,1.39812452046320,76.2552186855494];%[122.234694599944,1314.09811874337,1.16091768851032,16.6292529699171;]
dexpf_inactivation_parameters=[-461.877787498269,1329.67201336534,-7.75875370110768,5.94025929879121,1012.98088735004,-6.50978668817920,55.4942432894855];
saveit=0;

parameters=[activation_step_starting_V activation_step_finishing_V increments...
    activation_step_t inactivation_step_V inactivation_step_t pause_t leaksteps];

[mean_starting,meanactivation,mean_max_current_activation,mean_max_activation,...
    mean_max_current_inactivation,mean_max_inactivation,normalized_activation_temp,normalized_inactivation_temp,...
    activation_voltages,baselinecurrent,conductancedata,expf_activation,expf_inactivation,...
    rsq_activation_sig,rsq_inactivation_sig,...
    sigslope_normalized_activation,sigslope_normalized_inactivation,rsq_normalized_activation_sig,rsq_normalized_inactivation_sig...
    nlf_normalized_activation,nlf_normalized_inactivation]=... %,tau_activation,dexpf_inactivation
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
        'rsq_normalized_inactivation_sig','nlf_normalized_activation','nlf_normalized_inactivation') %,'tau_activation','dexpf_inactivation'
end

% close all

toc

% P85
% run script again. then see whether double exponential consistently has
% the slow variable first or second. The ratio of the A values of the exponential will
% hopefully be consistent among the fast or slow terms.
% fit exponential to initial steps of current clamp to find membrane time constant (RC) and use that and input resistance in model