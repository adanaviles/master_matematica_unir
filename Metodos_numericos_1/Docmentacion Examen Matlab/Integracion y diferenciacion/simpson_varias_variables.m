function I = simpson_varias_variables(f, a, b, c, d, n, m)
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
