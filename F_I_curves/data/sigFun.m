function y = sigFun(init_coeffs,x)

y = init_coeffs(1)./(1+exp((init_coeffs(2)-x)/init_coeffs(3)));