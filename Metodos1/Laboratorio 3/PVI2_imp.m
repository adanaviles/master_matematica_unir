function [Y,dY]= PVI2_imp(t,y)
lambda=50;
Y=lambda*(-y+sin(t));
dY=-lambda;
end
