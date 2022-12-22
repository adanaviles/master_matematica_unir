function [t,Y]=Heun_Sistemas(f,a,b,N,Ya)
%Codigo para resolver un PVI con el método de Euler
h=(b-a)/N;
t=a:h:b;
t=t(:);
Y=zeros(N+1,length(Ya));
Y(1,:)=Ya;
for k=1:N
    k1=h*feval(f,t(k),Y(k,:))';
    k2=h*feval(f,t(k+1),Y(k,:)+k1)';
    Y(k+1,:)=Y(k,:)+k1/2+k2/2;
end
end