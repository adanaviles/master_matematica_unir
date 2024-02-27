function [X,Y,iter,incr]=Difnolin_NoDirich_examen(f,fy,fz,a,b,alfa,beta,N,maxiter,tol) 
% f = f(x,y,z) es la ecuacion diferencial 
% fy = fy(x,y,z) es la parcial de f respecto a y 
% fz = fz(x,y,z) es la parcial de f respecto a y'=z 

h=(b-a)/(N+1); k=(beta-alfa)/(N+1); 
X=a:h:b; Y=alfa:k:beta; 
x=X(1:N+2); y=Y(1:N+2); 

incr=tol+1; % Inicializar parametros
iter=0;

while incr>tol && iter<maxiter
    z=[2*Y(1)-alfa (Y(3:N+2)-Y(1:N))/(2*h) beta-Y(N+2)]; % Estimacion de la derivada por diferencias
    % centrales
    
    fe=feval(f,x,y,z); 
    fye=feval(fy,x,y,z); 
    fze=feval(fz,x,y,z); 
    
    dp=2+h^2*fye; 
    dp(1)=2*(1+2*h)+h^2*fye(1)-2*h^2*fze(1);
    dp(N+2)=2*(1+h)+h^2*fye(N+2)-h^2*fze(N+2);

    ds=-1+h/2*fze(1:end-1); 
    ds(1)=-2;

    di=-1-h/2*fze(2:end); 
    di(end)=-2;

    d(1)=-2*(1+2*h)*y(1)+2*y(2)-h^2*fe(1)+2*h*alfa;
    d(2:N+1)=diff(Y,2)-h^2*fe(2:N+1);
    d(N+2)= 2*y(N+1)-2*(1+h)*y(N+2)-h^2*fe(N+2)+2*beta*h;
    
    v=Crout(dp,ds,di,d); 
    y=y+v'; 
    Y=y;
    incr=max(abs(v));
    iter=iter+1; 
end 
X=x(:); 
Y=y(:); 
end