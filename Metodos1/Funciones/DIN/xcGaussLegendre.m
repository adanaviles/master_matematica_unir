function [xi, ci] = xcGaussLegendre(n)
% function [xi, ci] = xcGaussLegendre(n)
%Obtiene los coeficientes ci y los nodos xi de la cuadratura
%de  Gauss-Legendre para un valor de n dado como parámetro de entrada
syms x
p{1}=1; %p0(x)
p{2}=x; %p1(x)
for k=1:n-1
    p{k+2}=1/(k+1)*((2*k+1)*x*p{k+1}-k*p{k});
end
xi=double(solve(p{n+1}==0, x));
dpn=diff(p{n+1});
ci=double(2./(1-xi.^2)./subs(dpn,x,xi).^2);

end