function [x,y]=disparo_lineal(pvi1,pvi2,a,b,alfa,beta,N)
h=(b-a)/(N+1);
x=a:h:b;
%primer disparo
[x,y1]=ode45(pvi1,x,[alfa,0]);
%segundo dosparo
[x,y2]=ode45(pvi2,x,[0,1]);
y=y1+(beta-y1(end,1))/y2(end,1)*y2;
end