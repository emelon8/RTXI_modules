mean_max_conductance_activation(21)
ste_max_conductance_activation(21)
mean_vhalf_activation
ste_vhalf_activation
mean_sigslope_normalized_activation_all
ste_sigslope_normalized_activation_all
mean_vhalf_inactivation
ste_vhalf_inactivation
mean_sigslope_normalized_inactivation_all
ste_sigslope_normalized_inactivation_all
% nanmean(reshape(expf_activation_all(1:5,9:end),1,[]))
% nanstd(reshape(expf_activation_all(1:5,9:end),1,[]))/sqrt(sum(~isnan(reshape(expf_activation_all(1:5,9:end),1,[]))))
% nanmean(reshape(expf_inactivation_all(1:4,9:end),1,[]))
% nanstd(reshape(expf_inactivation_all(1:4,9:end),1,[]))/sqrt(sum(~isnan(reshape(expf_activation_all(1:4,9:end),1,[]))))
mean_activation_time=nanmean(reshape(expf_activation_all(1:5,9:21),1,[]))
ste_activation_time=nanstd(reshape(expf_activation_all(1:5,9:21),1,[]))/sqrt(sum(~isnan(reshape(expf_activation_all(1:5,9:21),1,[]))))
mean_inactivation_time=nanmean(reshape(expf_inactivation_all(1:4,9:21),1,[]))
ste_inactivation_time=nanstd(reshape(expf_inactivation_all(1:4,9:21),1,[]))/sqrt(sum(~isnan(reshape(expf_activation_all(1:4,9:21),1,[]))))