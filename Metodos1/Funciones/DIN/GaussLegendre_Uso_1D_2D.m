R=56; a=-R/2; b=9*R/10; nTrap=8; nSimps=8; nGL=3;
f=@(x) 1./sqrt(1-(x/R).^2);
[xi, ci] = xcGaussLegendre(nGL);
%Como Gauss-Legendre tiene que ser de 1 a -1, aplicamos cambio de variable:
xPrima=(b-a)*xi/2+(b+a)/2;
cPrima=(b-a)/2*ci';
IGL=cPrima*f(xPrima)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R=56; a=0; b=R; c=0; d=2*pi; nTrap=8; nSimps=8; nGL=3;
f=@(x,y) x.*sqrt(R^2-x.^2).* (1+0.*y)'
[xi, ci] = xcGaussLegendre(nGL);
%Como Gauss-Legendre tiene que ser de 1 a -1, aplicamos cambio de variable:
C=ci*ci';
U= repmat(xi,1,3);
V= repmat(xi',3 ,1);
UPrima=(b-a)/2*U+(b+a)/2;
VPrima=(d-c)/2*V+(c+d)/2;
IGL=(b-a)/2*(d-c)/2*sum(sum(C.*UPrima.*sqrt(R^2-UPrima.^2)))

