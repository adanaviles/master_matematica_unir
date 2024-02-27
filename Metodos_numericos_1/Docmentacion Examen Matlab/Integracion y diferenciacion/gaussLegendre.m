function I = gausslegendre(f, n, a, b)
    % xi, ci = gausslegendre(n) obtiene los
    % coeficientes ci y nodos xi de la cuadratura de
    % Gauss-Legendre para un n dado
    syms x %Creo una variable simbolica para los polinomios
    p{1} = 1; %Creo p_0, p_1. 
    p{2} = x; 
    for k = 1:n-1
        p{k+2} = (1/(k+1))*((2*k+1)*x*p{k+1}-k*p{k}); %Calculo de forma recursiva los pols legendre
    end
    xi = double(solve(p{n+1}==0,x)); %resuelvo la eq 
    derpn = diff(p{n+1});
    ci = double(2./((1-xi.^2).*(subs(derpn,x,xi)).^2));
    valores_funcion = f(xi*(b-a)/2 + (b+a)/2);
    I = ((b-a)/2)*sum(ci.*valores_funcion);
end 
