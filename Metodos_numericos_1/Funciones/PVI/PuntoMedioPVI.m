function [t,y]=PuntoMedioPVI(f,a,b,N,ya)
%Codigo para resolver un PVI con el Punto Medio
h=(b-a)/N;
t=a:h:b;
t=t(:);
y=zeros(N+1,1);
y(1)=ya;
for k=1:N
    k1=feval(f,t(k),y(k));
    ym=y(k)+h*k1/2;
    k2=feval(f,t(k)+h/2,ym);
    y(k+1)=y(k)+h*k2;
end
end