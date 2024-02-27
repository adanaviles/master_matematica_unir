function c=RRlin(p,q,f,t,m) 
% t: particion del intervalo (incluidos los extremos) 
% m: numero de pasos para la cuadratura (2*m) 
n=length(t)-1; 
for i=1:n 
    %Amplitud intervalos 
    l=t(i); r=t(i+1); h=r-l; 
    %Paso y Nodos de integracion 
    k=h/(2*m); x=l:k:r; 

    px=feval(p,x); 
    ph(i)=trapz(x,px)/h^2; 

    qx=feval(q,x); 
    ql(i)=trapz(x,qx.*(x-l).^2)/h^2; 
    qr(i)=trapz(x,qx.*(r-x).^2)/h^2; 
    qh(i)=trapz(x,qx.*(x-l).*(r-x))/h^2; 
    
    fx=feval(f,x); 
    fl(i)=trapz(x,fx.*(x-l))/h; 
    fr(i)=trapz(x,fx.*(r-x))/h; 
end
L=1:n-1; C=2:n-1; R=2:n; 
% Matriz de coeficientes: 
% Diagonal principal
a=ph(L)+ph(R)+ql(L)+qr(R);
% Subdiagonal y superdiagonal
b=qh-ph; b=b(C);
% Termino independiente 
d=fl(L)+fr(R); 
c=Crout(a,b,b,d); 
end