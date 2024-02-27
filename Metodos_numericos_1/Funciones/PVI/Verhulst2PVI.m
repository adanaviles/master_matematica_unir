function [fun, dfun] =Verhulst2PVI(t,y)
k=3;
p=0.1;
fun=(k-p*y).*y;
dfun=k-2*p*y;
end