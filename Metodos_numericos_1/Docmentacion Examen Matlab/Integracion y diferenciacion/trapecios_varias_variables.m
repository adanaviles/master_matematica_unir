function I = trapecios_varias_variables(f, a, b, c, d, n, m)
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