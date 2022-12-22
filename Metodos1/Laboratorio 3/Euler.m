function [t,y]=Euler(f,a,b,N,ya)
%Codigo para resolver un PVI con el método de Euler
h=(b-a)/N;
t=a:h:b;
t=t(:);
y=zeros(N+1,1);
y(1)=ya;
for k=1:N
    y(k+1)=y(k)+h*feval(f,t(k),y(k));
end
end