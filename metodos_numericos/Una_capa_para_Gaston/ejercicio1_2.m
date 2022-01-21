%% Ejercicio 1
% Sabiendo que R = 56
L = @(x) 1./(sqrt(1-(x/56).^2))
f = @(x) (sqrt(56^2-x^2))
a = (-56)/2
b = (9*56)/10

% Podemos comprobar el codigo optimizado con tic y toc
tic;
I = simpson_varias_variables(f, a, b, c, d, 500, 500)
toc;
tic;
I = simpson_varias_variables_optimizadas(f, a, b, c, d, 500, 500)
toc;



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


function I = trapecios_varias_variables(f, a, b, c, d, n, m)
    % Devuelve la integral de la funcion F
    % [a,b] = limites para x
    % [c,d] = limites para y
    % n = intervalos para x
    % n = intervalos para y
    h = (b-a)/n; %calculo paso h
    k = (d-c)/m; %calculo paso h
    x = a:h:b; % calculo los pasos de a b 
    y = c:k:d; % calculo los pasos de c d 
    % Crearé la matriz de pesos
    pesos_x = [1 2*ones(1, n-1) 1]; %Matriz fila
    pesos_y = [1 2*ones(1, m-1) 1]'; %Matriz columna
    pesos = pesos_y*pesos_x; %Matriz de pesos
    %Pre allocation
    matriz_valores = zeros(m+1,n+1);
    % Creo una matriz con f(x0,ym) ..... f(xn,ym)
    %                     ...
    %                     f(x0,y0) ..... f(xn, y0)
    % i son las filas, j las columnas
    for j = 1:n+1
        for i = 1:m+1
            matriz_valores(i,j) = f(x(j),y(m+2-i));
        end
    end

    % Hago el producto elemento a elemento de pesos y matriz y calculo su determinante
    % Tendré 1f(x0,ym) 2f(x2,ym)....1f(xn,ym)
    % ....   2f(x0,ym-1) 4(x1,ym-2)....
    % Para finalmente sumar todos los valores
    I = ((h*k)/4)*sum(sum(pesos.*matriz_valores)); 
    %I = ((h*k)/4)*sum(pesos.*matriz_valores, 'all'); %añado el . para multiplicar vectores
end

function I = trapecios_varias_variables_optimizada(f, a, b, c, d, n, m)
    % Devuelve la integral de la funcion F
    % [a,b] = limites para x
    % [c,d] = limites para y
    % n = intervalos para x
    % n = intervalos para y
    h = (b-a)/n; %calculo paso h
    k = (d-c)/m; %calculo paso h
    x = a:h:b; % calculo los pasos de a b 
    y = d:-k:c; % calculo los pasos de c d 
    % Crearé la matriz de pesos
    pesos_x = [1 2*ones(1, n-1) 1]; %Matriz fila
    pesos_y = [1 2*ones(1, m-1) 1]'; %Matriz columna
    pesos = pesos_y*pesos_x; %Matriz de pesos
    matriz_valores = f(x,y');
    % Hago el producto elemento a elemento de pesos y matriz y calculo su determinante
    % Tendré 1f(x0,ym) 2f(x2,ym)....1f(xn,ym)
    % ....   2f(x0,ym-1) 4(x1,ym-2)....
    % Para finalmente sumar todos los valores
    I = ((h*k)/4)*sum(sum(pesos.*matriz_valores)); 
    %I = ((h*k)/4)*sum(pesos.*matriz_valores, 'all'); %añado el . para multiplicar vectores
end


function I = simpson_varias_variables(f, a, b, c, d, n, m)
    % Devuelve la integral de la funcion F
    % [a,b] = limites para x
    % [c,d] = limites para y
    % n = intervalos para x
    % n = intervalos para y
    h = (b-a)/n; %calculo paso h
    k = (d-c)/m; %calculo paso h
    x = a:h:b; % calculo los pasos de a b 
    y = c:k:d; % calculo los pasos de c d 
    % Crearé la matriz de pesos
    pesos_x = ones(1, n+1);   pesos_y = ones(1, n+1)';
    pesos_x(2:2:n) = 4; pesos_y(2:2:n) = 4; 
    pesos_x(3:2:n-1) = 2; pesos_y(3:2:n-1) = 2; 
    pesos = pesos_y*pesos_x; %Matriz de pesos
    %Pre allocation
    matriz_valores = zeros(m+1,n+1);
    % Creo una matriz con f(x0,ym) ..... f(xn,ym)
    %                     ...
    %                     f(x0,y0) ..... f(xn, y0)
    % i son las filas, j las columnas
    for j = 1:n+1
        for i = 1:m+1
            matriz_valores(i,j) = f(x(j),y(m+2-i));
        end
    end
    % Hago el producto elemento a elemento de pesos y matriz y calculo su determinante
    % Tendré 1f(x0,ym) 2f(x2,ym)....1f(xn,ym)
    % ....   2f(x0,ym-1) 4(x1,ym-2)....
    % Para finalmente sumar todos los valores
    I = ((h*k)/9)*sum(sum(pesos.*matriz_valores)); 
    %I = ((h*k)/4)*sum(pesos.*matriz_valores, 'all'); %añado el . para multiplicar vectores
end

function I = simpson_varias_variables_optimizadas(f, a, b, c, d, n, m)
    h = (b-a)/n; 
    k = (d-c)/m; 
    x = a:h:b; % calculo los pasos de a b 
    y = d:-k:c; % calculo los pasos de d a c, para tener y de menos a más 
    % Crearé la matriz de pesos
    pesos_x = ones(1, n+1);   pesos_y = ones(1, n+1)';
    pesos_x(2:2:n) = 4; pesos_y(2:2:n) = 4; 
    pesos_x(3:2:n-1) = 2; pesos_y(3:2:n-1) = 2; 
    pesos = pesos_y*pesos_x; % Matriz de pesos
    % Hace todas las permutaciones f(x_i,y_j)
    matriz_valores = f(x,y');
    I = ((h*k)/9)*sum(sum(pesos.*matriz_valores)); 
end



function I = gausslegendre_varias(f, n, a = -1, b = 1, c = -1, d = 1)
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
