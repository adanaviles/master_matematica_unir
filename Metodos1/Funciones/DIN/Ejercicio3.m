R=56; a=0; b=R; c=0; d=2*pi; nTrap=8; nSimps=8; nGL=3;
f=@(x,y) x.*sqrt(R^2-x.^2).* (1+0.*y)'
g=@(x) x.*sqrt(R^2-x.^2); 
h=@(x) 1+0.*x;

ITrap=trapecios2D(f,a,b,nTrap,c,d,nTrap)
ISimps=simpson2D(f,a,b,nSimps,c,d,nSimps)
ISimpson38= simpson3_8_2D(f,a,b,nSimps,c,d,nSimps)
IMilne=Milne_2D(f,a,b,nSimps,c,d,nSimps)
[xi, ci] = xcGaussLegendre(nGL);
%Como Gauss-Legendre tiene que ser de 1 a -1, aplicamos cambio de variable:
C=ci*ci';
U= repmat(xi,1,3);
V= repmat(xi',3 ,1);
UPrima=(b-a)/2*U+(b+a)/2;
VPrima=(d-c)/2*V+(c+d)/2;
IGL=(b-a)/2*(d-c)/2*sum(sum(C.*UPrima.*sqrt(R^2-UPrima.^2)))
Ianalitico=integral(h,c,d)*integral(g,a,b)
Error=abs([ITrap ISimps IGL]-Ianalitico)/Ianalitico*100