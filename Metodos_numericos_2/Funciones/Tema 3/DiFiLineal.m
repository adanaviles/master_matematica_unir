function [x,y] = DiFiLineal(p,q,r,a,b,alfa,beta,N) 
%Diferencias finitas, 
%Problema lineal de segundo orden con... 
% condiciones Dirichlet 
% N es el numero de incognitas 
h=(b-a)/(N+1); 
x=a:h:b; 
x=x(:); 
X=x(2:end-1); 
px=feval(p,X); 
qx=feval(q,X); 
rx=feval(r,X); 
dp=2+h^2*qx; % diagonal principal
ds=-1+h/2*px(1:end-1); % diagonal superior 
di=-1-h/2*px(2:end); % diagonal inferior 
d=-h^2*rx; % terminos independientes 
d(1)=d(1)+(1+h/2*px(1))*alfa; 
d(end)=d(end)+(1-h/2*px(end))*beta; 

y=Crout(dp,ds,di,d); 
y=[alfa;y;beta]; 
end 