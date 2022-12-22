function I = gausslegendre_varias(f, n, a, b, c, d)
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
    %%% Comienzo la parte de varias variables
    C = ci*ci'; u=xi; v=xi'; %trasponemos v
    U = repmat(u,1,n);
    V = repmat(v,n,1);
    valor_nuevo_U = U*(b-a)/2 + (b+a)/2;
    valor_nuevo_V = V*(d-c)/2 + (d+c)/2;
    parametro_U = (b-a)/2;
    parametro_V = (d-c)/2;
    valores_funcion = f(valor_nuevo_U,valor_nuevo_V);
    I = parametro_U*parametro_V*sum(sum(C.*valores_funcion));
end 