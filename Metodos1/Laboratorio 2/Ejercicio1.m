R=56; a=-R/2; b=9*R/10; nTrap=8; nSimps=8; nGL=3;
f=@(x) 1./sqrt(1-(x/R).^2);
ITrap=trapecios(f,a,b,nTrap)
ISimps=simpson(f,a,b,nSimps)
[xi, ci] = xcGaussLegendre(nGL);
%Como Gauss-Legendre tiene que ser de 1 a -1, aplicamos cambio de variable:
xPrima=(b-a)*xi/2+(b+a)/2;
cPrima=(b-a)/2*ci';
IGL=cPrima*f(xPrima)
Ianalitico=integral(f,a,b)
Error=abs([ITrap ISimps IGL]-Ianalitico)/Ianalitico*100