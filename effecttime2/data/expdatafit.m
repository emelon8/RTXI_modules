function fittedexp=expdatafit(b,x)
fittedexp=b(1)+b(2)*exp(-b(3)*x);