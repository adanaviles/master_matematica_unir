function [f,df,ddf] = ejemplo4(x)
f=( cos(x)).^2-x;
df =2*cos(x).*(-sin(x))-1;
ddf=2*sin(x).^2-2*cos(x).^2;
end