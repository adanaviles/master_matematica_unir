function [xi, ci] = xcGaussLegendre(n)
% funcion [xi, ci] = xcGaussLegendre(n)
%Obtiene los coeficientes ci y los nodos xi de la cuadratura
%de  Gauss-Legendre para un valor de n dado como parámetro de entrada
syms x %utilizamos una variable simbolica
p{1}=1; %creamos el primer polinomio p0(x)
p{2}=x; % creamos el segundo polinomio p1(x)
%Creamos el resto de polinomios de manera recursiva conociendo los dos
%anteriores implementando la ecuacion de los apuntes
for k=1:n-1
    p{k+2}=1/(k+1)*((2*k+1)*x*p{k+1}-k*p{k});
end
%Resolviendo el ultimo polinomio obtenido podemos sacar las raices que
%buscabamos
xi=double(solve(p{n+1}==0, x));
dpn=diff(p{n+1}); %derivamos el ultimo polinomio
%sacamos los coeficientes implementando al ecuacion de clase
ci=double(2./(1-xi.^2)./subs(dpn,x,xi).^2); 
end