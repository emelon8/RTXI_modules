function y = activation_expFun(init_coeffs,x)

y=init_coeffs(1)+init_coeffs(2)*(1-exp(-(x-init_coeffs(3))/init_coeffs(4)));