function [r,u] = DiFiLineal_Ej2() 
%Diferencias finitas, 
%Problema lineal de segundo orden con... 
% condiciones Dirichlet 
% N es el numero de incognitas 
alfa=1-1/(2*log(3));
beta=0.5-1/(6*log(3));
h=2/10;
r=1:h:3;
ds=r(1:10)+h/2; ds(1)=2*r(1); %superdiagonal de A, 
di=r(2:11)-h/2; di(10)=2*r(11); %subdiagonal de A 
dp=-2*r(1:11); %diagonal principal de A 
dp(1)=2*h*r(1)-h^2-2*r(1); 
dp(11)=-h^2-2*h*r(11)-2*r(11); 
d=zeros(11,1); % terminos independientes 
d(1)=2*h*alfa*(r(1)-h/2); 
d(11)=-2*h*beta*(r(11)+h/2);

u=Crout(dp,ds,di,d);  
end 