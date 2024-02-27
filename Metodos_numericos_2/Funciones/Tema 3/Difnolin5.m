function [X,Y,iter,incr]=Difnolin5(f,fy,fz,fw,a,b,alfa,beta,gamma,N,maxiter,tol) 
% f = f(x,y,z,w) es la ecuacion diferencial 
% fy = fy(x,y,z,w) es la parcial de f respecto a y 
% fz = fz(x,y,z,w) es la parcial de f respecto a y'=z 
% fw = fw(x,y,z,w) es la parcial de f respecto a y''=w

h=(b-a)/(N+1); k=(beta-alfa)/(N+1); 
X=a:h:b; Y=alfa:k:beta; 
x=X(1:N+2); y=Y(1:N+2);  

incr=tol+1; % Inicializar parametros
iter=0;

while incr>tol && iter<maxiter
    % Estimacion de la derivada por diferencias centrales
    z=(Y(3:N+2)-Y(1:N))/(2* h); 
    z=[1 z 1];
    w=(Y(3:N+2)-2*Y(2:N+1)+Y(1:N))/(h^2);
    w=[1 w 1];

    fe=feval(f,x,y,z,w);
    fye=feval(fy,x,y,z,w); 
    fze=feval(fz,x,y,z,w); 
    fwe=feval(fz,x,y,z,w);

    dp=2*h^3*fye-4*h*fwe;
    dp(1)=0;
    dp(2)=-1+h^3*fye(2)-2*h*fwe(2);
    dp(N+1)=1+2*h^3*fye(N+1)+4*h*fwe(N+1);
    dp(N+2)=0;
    ds=-2+h^2*fze(1:end-1)+2*h*fwe(1:end-1);
    ds(1)=0;
    ds(2)=3+h^2/2*fze(2)+h*fwe(2);
    ds(N+1)=-2+h^2*fze(N+1)+h*fwe(N+1);
    dss=ones(1,N);
    dss(1)=0;
    dss(2)=-3;
    dsss=zeros(1,N-1);
    dsss(2)=1;
    di=2-h^2*fze(2:end)+2*h*fwe(2:end);
    di(1)=-h^2/2*fze(2)+h*fwe(2);
    di(N+1)=0;
    dii=-1*ones(1,N);
    dii(N)=0;
    A=diag(dp)+diag(ds,1)+diag(dss,2)+diag(dsss,3)+diag(di,-1)+diag(dii,-2);

    d(1)=alfa;
    d(2)=Y(5)-3*Y(4)+3*Y(3)-Y(2)+h^3*fe(2);
    d(3:N)=Y(5:N+2)-2*Y(4:N+1)+2*Y(2:N-1)-Y(1:N-2)+2*h^3*fe(3:N);
    d(N+1)=2*h*gamma-2*Y(N+2)+Y(N+1)+2*Y(N)-Y(N-1)+2*h^3*fe(N+1);
    d(N+2)=beta;

    v=A(2:N+1,1:N+2)\-d(2:N+1)';
    y=y+v'; 
    Y=y;
    incr=max(abs(v));
    iter=iter+1; 
end 
X=x(:); 
Y=y(:); 
end