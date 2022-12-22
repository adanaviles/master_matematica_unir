function [t,y]=Heun(f,a,b,N,ya)
%Codigo para resolver un PVI con el método de Euler
h=(b-a)/N;
t=a:h:b;
t=t(:);
y=zeros(N+1,1);
y(1)=ya;
for k=1:N
    k1=h*feval(f,t(k),y(k));
    k2=h*feval(f,t(k+1),y(k)+k1);
    y(k+1)=y(k)+k1/2+k2/2;
end
end