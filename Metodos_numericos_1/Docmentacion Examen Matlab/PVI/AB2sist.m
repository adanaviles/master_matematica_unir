function [t,y]=AB2sist(fun,a,b,N,Ya)
    h = (b-a)/N;
    t = a:h:b;
    t = t(:); %Discretizamos t con el paso correcto
    n = length(Ya); %Damos el número de columnas en función de las variables
    y = zeros(N+1,n); %Creamos la matriz solución
    y(1,:) = Ya; %Inicializamos la matriz y 
    
    k1 = h*feval(fun,t(1),y(1,:))'; %Empleamos el método de Heun para sacar el primer punto de todas las variables
    k2 = h*feval(fun,t(2),y(1,:)+k1)';
    y(2,:) = y(1,:)+k1/2+k2/2;
    
    for k = 2:N
        k1 = (h/2)*feval(fun,t(k),y(k,:))'; %Empleamos el algoritmo de AB2 para los demás puntos
        k2 = (h/2)*feval(fun,t(k-1,:),y(k-1,:))';
        y(k+1,:) = y(k,:)+3*k1-k2;
    end
end