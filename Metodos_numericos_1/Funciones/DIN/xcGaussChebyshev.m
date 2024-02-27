function [xi, ci] = xcGaussChebyshev(n)
% function [xi, ci] = xcGaussChebyshev(n)
%Obtiene los coeficientes ci y los nodos xi de la cuadratura
%de  Gauss-Chebyshev para un valor de n dado como parámetro de entrada
syms x
p{1}=1; %p0(x)
p{2}=x; %p1(x)
for k=2:n
    p{k+1}=(2*x*p{k}-p{k-1});
end
xi=double(solve(p{n+1}==0, x));
ci=ones(n,1)*pi/n;

end