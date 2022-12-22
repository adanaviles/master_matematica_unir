function [X,Y,iter,incr]=Difnolin(f,fy,fz,a,b,alfa,beta,N,maxiter,tol) 
% f = f(x,y,z) es la ecuacion diferencial 
% fy = fy(x,y,z) es la parcial de f respecto a y 
% fz = fz(x,y,z) es la parcial de f respecto a y'=z 

% Ejemplo: para resolver el problema de contorno 
%       y"=(32+2x^3-yy')/8
%           1<=x<=3 
%       y(1)=17,    y(3)=43/3 
% Difnolin('(32+2*x.^3-y.*z)/8','(-1)*z/8','(-1)*y/8',1,3,17,43/3,20,20,1e-8)

h=(b-a)/(N+1); k=(beta-alfa)/(N+1); 
X=a:h:b; Y=alfa:k:beta; 
x=X(2:N+1); y=Y(2:N+1); 

incr=tol+1; % Inicializar parametros
iter=0;

while incr>tol && iter<maxiter
    z=(Y(3:N+2)-Y(1:N))/(2*h); % Estimacion de la derivada por diferencias
    % centrales
    
    fe=feval(f,x,y,z); 
    fye=feval(fy,x,y,z); 
    fze=feval(fz,x,y,z); 
    
    dp=2+h^2*fye; 
    ds=-1+h/2*fze(1:end-1); 
    di=-1-h/2*fze(2:end); 
    d=diff(Y,2)-h^2*fe; 
    
    v=Crout(dp,ds,di,d); 
    y=y+v'; 
    Y=[alfa y beta]; 
    incr=max(abs(v)); 
    iter=iter+1; 
end 
X=X(:); 
Y=Y(:); 
end