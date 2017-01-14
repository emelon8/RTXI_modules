function y = sigFun(init_coeffs,x)

y=init_coeffs(1)+init_coeffs(2)./(1+exp((init_coeffs(3)-x)/init_coeffs(4)));