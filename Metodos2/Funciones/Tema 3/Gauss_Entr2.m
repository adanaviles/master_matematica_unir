function [x,y] = Gauss_Entr2(a,b,alfa,beta,N) 
%Diferencias finitas, 
%Problema lineal de segundo orden con... 
% condiciones Dirichlet 
% N es el numero de incognitas 
h=(b-a)/(N-1); 
x=a:h:b; 
X=x(:); 

dp=(h^2-2)*ones(1,length(x)); % diagonal principal
dp(1)=-h^2-2*h-2; dp(end)=-1/3*h^2+4/3*h-2;
ds=(1-h)*ones(1,length(x)-1); % diagonal superior 
ds(1)=2;
di=(1+h)*ones(1,length(x)-1); % diagonal inferior 
di(end)=2;
d=-2*h^2.*cos(X); % terminos independientes 
d(1)=d(1)-2*h*(1+h)*alfa; 
d(end)=d(end)+4/3*h*(1-h)*beta; 

A=diag(dp,0)+diag(ds,1)+diag(di,-1); %Creamos la matriz con las 3 diagonales
y=A\d; %Resolvemos el sistema de ecuaciones por Gauss
x=x';
