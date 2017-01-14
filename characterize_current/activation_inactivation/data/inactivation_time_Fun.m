function y = inactivation_time_Fun(init_coeffs,x)

y=init_coeffs(1)+init_coeffs(2)*exp(-(init_coeffs(3)-x).^2/init_coeffs(4)^2);