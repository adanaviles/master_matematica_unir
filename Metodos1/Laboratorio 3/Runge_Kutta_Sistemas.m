function [t,Y]=Runge_Kutta_Sistemas(f,a,b,N,Ya)
%Codigo para resolver un PVI con el método de Euler
h=(b-a)/N;
t=a:h:b;
t=t(:);
Y=zeros(N+1,length(Ya));
Y(1,:)=Ya;
for k=1:N
    k1=feval(f,t(k),Y(k,:))';
    k2=feval(f,t(k)+h/2,Y(k,:)+h*k1/2)';
    k3=feval(f,t(k)+h/2,Y(k,:)+h*k2/2)';
    k4=feval(f,t(k+1),Y(k,:)+h*k3)';

    Y(k+1,:)=Y(k,:)+h*(k1+2*k2+2*k3+k4)/6;
end
end