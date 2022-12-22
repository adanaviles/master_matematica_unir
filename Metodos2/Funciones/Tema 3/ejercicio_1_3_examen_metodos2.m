

f=@(x,y,z) -y.*cos(x)+2*y.*z+sin(x);
fy=@(x,y,z) cos(x)+2*z;
fz=@(x,y,z) 2*y;
a=0;
b=pi/4;
alfa=-1;
beta=3;
N=18;
maxiter=50;
tol=1e-5;

[X,Y,iter,incr]=Difnolin_NoDirich(f,fy,fz,a,b,alfa,beta,N,maxiter,tol)


plot(X,Y, 'r')
grid on
legend('Difnolin')

function [X,Y,iter,incr]=Difnolin_NoDirich(f,fy,fz,a,b,alfa,beta,N,maxiter,tol) 
% f = f(x,y,z) es la ecuacion diferencial 
% fy = fy(x,y,z) es la parcial de f respecto a y 
% fz = fz(x,y,z) es la parcial de f respecto a y'=z 

h=(b-a)/(N+1);
k=(beta-alfa)/(N+1); 
X=a:h:b;
Y=alfa:k:beta; 
x=X(1:N+2);
y=Y(1:N+2); 
incr=tol+1; % Inicializar parametros
iter=0;

while incr>tol && iter<maxiter
    % como y'(0)=2y(0)+1
    % y'(n+1)=3-y(n+1)
    z=[alfa+2*Y(1) (Y(3:N+2)-Y(1:N))/(2*h) beta-Y(N+2)]; % Estimacion de la derivada por diferencias
    % centrales
    
    fe=feval(f,x,y,z); 
    fye=feval(fy,x,y,z); 
    fze=feval(fz,x,y,z); 
    
    dp=2+h^2*fye; 
    dp(1)=2*(1+2*h)+h^2*fye(1)+2*h^2*fze(1);
    dp(N+2)=2*(1+h)+h^2*fye(N+2)-h^2*fze(N+2);

    ds=-1+h/2*fze(1:end-1); 
    ds(1)=-2;

    di=-1-h/2*fze(2:end); 
    di(end)=-2;

    d(1)=-2*(1+h)*y(1)+2*y(2)-h^2*fe(1)-2*h*alfa;
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

function sol=Crout(a,b,c,d) 
% a diagonal principal, b superdiagonal, c ...
% subdiagonal, d terminos independiante 
n=length(a); 
% Obtencion de las matrices L y U tales que A = LU 
l(1)=a(1); 
u(1)=b(1)/l(1); 
for i=2:n-1 
    l(i)=a(i)-c(i-1)*u(i-1); 
    u(i)=b(i)/l(i); 
end 
l(n)=a(n)-c(n-1)*u(n-1);
%Solucion del sistema Lz=d 
z(1)=d(1)/l(1); 
for i=2:n 
    z(i)=(1/l(i))*(d(i)-c(i-1)*z(i-1)); 
end 
%Solucion del sistema Ux=z
x(n)=z(n); 
for i=n-1:-1:1 
    x(i)=z(i)-u(i)*x(i+1); 
end 
sol=x(:);
end
