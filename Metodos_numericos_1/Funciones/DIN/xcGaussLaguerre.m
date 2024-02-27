function [xi, ci] = xcGaussLaguerre(n)
% function [xi, ci] = xcGaussLaguerre(n)
%Obtiene los coeficientes ci y los nodos xi de la cuadratura
%de  Gauss-Laguerre para un valor de n dado como parámetro de entrada
syms x
p{1}=1; %p0(x)
p{2}=1-x; %p1(x)
for k=1:n
    p{k+2}=(2*(k-1)+3-x)*p{k+1}-((k)^2*p{k});
end
coeffs(p{n+1})
xi=double(solve(p{n+1}==0, x));
num=(factorial(n))^2.*xi;
den=(double(subs(p{n+2},x,xi))).^2;
ci=num./den;

end