function [t,y]=AB4(fun,a,b,N,ya)
    h = (b-a)/N;
    t = a:h:b;
    t = t(:); %Discretizamos t con el paso correcto
    n = length(ya); %Damos el número de columnas en función de las variables
    y= zeros(N+1 ,1); 
    y(1) = ya; %Inicializamos la matriz y 
    
    for k = 1:3 %Empleamos el método de Runge-Kutta para obtener los 4 primeros puntos
        k1 = feval(fun,t(k),y(k,:))';
        k2 = feval(fun,t(k)+(h/2),y(k,:)+(h/2)*k1)';
        k3 = feval(fun,t(k)+(h/2),y(k,:)+(h/2)*k2)';
        k4 = feval(fun,t(k+1),y(k,:)+h*k3)';
        y(k+1,:) = y(k,:)+(h/6)*(k1+2*k2+2*k3+k4);
    end
    
    for k = 4:N %Empleamos el algoritmo de AB4 para los demás puntos
        y(k+1,:) = y(k,:)+(h/24)*(55*feval(fun,t(k),y(k,:))' - 59*feval(fun,t(k-1),y(k-1,:))'+  37*feval(fun,t(k-2),y(k-2,:))' - 9*feval(fun,t(k-3),y(k-3,:))');
    end
    
end