function [f,df,ddf] = ejemploE(x)
f=exp(-x)-x.^3+2.*x;
df =-exp(-x)-3*x.^2+2;
ddf=exp(-x)-6*x;
end