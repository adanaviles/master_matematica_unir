R=56; a=-R/2; b=9*R/10; nTrap=8; nSimps=8; nGL=3;
f=@(x) 1./sqrt(1-(x/R).^2);
ITrap=trapecios(f,a,b,nTrap)
ISimps=simpson(f,a,b,nSimps)
ISimps38=simpson3_8(f,a,b,nSimps)
IMilne=Milne(f,a,b,nSimps)
PM=puntoMedio(f,a,b,nSimps)
INC1=Newton_Cotes_1(f,a,b,nSimps)
INC2=Newton_Cotes_2(f,a,b,nSimps)
[xi, ci] = xcGaussChebyshev(nGL);
[xi, ci] = xcGaussLegendre(nGL);
%Como Gauss-Legendre tiene que ser de 1 a -1, aplicamos cambio de variable:
xPrima=(b-a)*xi/2+(b+a)/2;
cPrima=(b-a)/2*ci';
IGL=cPrima*f(xPrima)
Ianalitico=integral(f,a,b)
Error=abs([ITrap ISimps IGL]-Ianalitico)/Ianalitico*100