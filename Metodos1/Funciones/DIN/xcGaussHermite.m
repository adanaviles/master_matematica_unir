function [xi, ci] = xcGaussHermite(n)
% function [xi, ci] = xcGaussHermite(n)
%Obtiene los coeficientes ci y los nodos xi de la cuadratura
%de  Gauss-Hermite para un valor de n dado como parámetro de entrada
syms x
p{1}=1; %p0(x)
p{2}=2*x; %p1(x)
for k=1:n-1
    p{k+2}=(2*x*p{k+1}-2*(k)*p{k});
end
p{n}
xi=double(solve(p{n+1}==0, x));
num=2^(n-1)*factorial(n)*sqrt(pi);
den=n^2*double(subs(p{n},x,xi)).^2;
ci=num./den;

end