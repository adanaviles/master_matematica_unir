%% Ejercicio 1
% Sabiendo que R = 56
L = @(x) 1./(sqrt(1-(x/56).^2))
f = @(x) (sqrt(56^2-x^2))
a = (-56)/2
b = (9*56)/10




function I = trapecios(f,a,b,n)
    % I = trapecios(f,a,b,n) devuelve la integral de f(x)
    % con la fórmula de trapecios compuesta.
    h = (b-a)/n; %calculo paso h
    x = a:h:b; % calculo los pasos de a b 
    pesos = [1 2*ones(1, n-1) 1]; %Tal y como aparece en la formula, los pesos son 1,2,...,2,1
    I = (h/2)*sum(pesos.*f(x)); %añado el . para multiplicar vectores
end

function I = simpson(f,a,b,n)
    % I=simpson(f,a,b,n) obtiene la integral de f(x)
    % con la fórmula de Simpson compuesta.
    h = (b-a)/n; %calculo paso h
    x = a:h:b; % calculo los pasos de a b 
    pesos = ones(1, n+1) ; % Devuelve un array de n+1 unos
    pesos(2:2:n) = 4; % Hago que los pares sean 4
    pesos (3:2:n-1) = 2; %Hago que los impares sean 2
    I = (h/3)*sum(pesos.*f(x)); %añado el . para multiplicar vectores
end
    

function [xi ci I] = gausslegendre(f, n, a = -1, b = 1)
    % xi, ci = gausslegendre(n) obtiene los
    % coeficientes ci y nodos xi de la cuadratura de
    % Gauss-Legendre para un n dado
    x = sym('x') %Creo una variable simbolica para los polinomios
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


function I = trapecios_varias_variables(f, g, a, b, c, d, n, m)
    % I = trapecios(f,a,b,n) devuelve la integral de f(x)
    % con la fórmula de trapecios compuesta.
    % Siendo f,g las funciones
    % [a,b] para f // [c,d] para k
    % n intervalos para f y m intervalos para k
    h = (b-a)/n; %calculo paso h
    k = (d-c)/m; %calculo paso h
    x = a:h:b; % calculo los pasos de a b 
    pesos = [1 2*ones(1, n-1) 1]; %Tal y como aparece en la formula, los pesos son 1,2,...,2,1
    I = (h/2)*sum(pesos.*f(x)); %añado el . para multiplicar vectores
end
