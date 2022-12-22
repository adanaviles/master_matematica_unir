function [x,y] = rungekutta_sistemas(funcion, a, b, y0, N)
%RK4_N uso: rk4_n(funcion, a, b, y0, N)
%   Metodo RK-4 o Runge-Kutta de cuatro etapas
%   sistemas de ecuaciones de PVI de primer orden
%   
%   y0 :  vector columna de valores iniciales
%

    % Calular el paso de integracion
    h = (b-a)/N ;
    
    % Obtener el vector nodos
    x = a:h:b;
    
    % Crear el vector solucion e inicializarlo
    y = zeros(length(x),length(y0));
    y(1,:)= y0;
    
    % Evaluar algoritmo RK-4 para cada nodo
    for k = 1:N
       k1 = feval(funcion, x(k), y(k,:))';
       k2 = feval(funcion, x(k)+h/2, y(k,:)+h/2*k1)';
       k3 = feval(funcion, x(k)+h/2, y(k,:)+h/2*k2)';
       k4 = feval(funcion, x(k+1), y(k,:)+h*k3)';
       y(k+1,:) = y(k,:) + h/6 * (k1 + 2*k2 + 2*k3 + k4);
    end  
    x = x';      
end