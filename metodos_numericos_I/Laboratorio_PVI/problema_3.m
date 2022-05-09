format longG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot 1
a = 0; b = 20; N = 200; Xa = [2, 0];
[t,x] = AB2sist(@apa, a, b, N, Xa)
plot(t, x(:,1), 'o-')
xlabel('t_k');
ylabel('x_k');
title('Método Adam Bashfort Orden 2')

sol = round([x(21), x(81), x(141), x(161)],7)
T = table([2 8 14 16]', sol')
T.Properties.VariableNames = {'t' 'X_t'}

% Plot 2
[t,x] = AB4sist(@apa, a, b, N, Xa)
plot(t, x(:,1), 'o-')
xlabel('t_k');
ylabel('x_k');
title('Método Adam Bashfort Orden 4')

sol = round([x(21), x(81), x(141), x(161)],7)
T = table([2 8 14 16]', sol')
T.Properties.VariableNames = {'t' 'X_t'}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot 1 / AB2
[t,x] = AB2sist(@apb, a, b, N, Xa)
plot(t, x(:,1), 'o-')
xlabel('t_k');
ylabel('x_k');
title('Método Adam Bashfort Orden 2')
sol = round([x(21), x(81), x(141), x(161)],7)
T = table([2 8 14 16]', sol')
T.Properties.VariableNames = {'t' 'X_t'}

% Plot 2 / AB4
[t,x] = AB4sist(@apb, a, b, N, Xa)
plot(t,x(:,1),'o-')
xlabel('t_k');
ylabel('x_k');
title('Método Adam Bashfort Orden 4')
sol = round([x(21), x(81), x(141), x(161)],7)
T = table([2 8 14 16]', sol')
T.Properties.VariableNames = {'t' 'X_t'}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Para AB2
solex200 = 2*cos(t);
[t,y] = AB2sist(@apa, a, b, N, Xa)
E200 = max(abs(solex200-y));
% Error
E200(1)
% Orden de convergencia
N = 400;
[t400,y400] = AB2sist('am',a,b,N,ya)
solex400 = 2*cos(t400);
E400 = max(abs(solex400-y400))
%Error
E400(1)
convergencia = log2(E200(1)/E400(1))

% Para AB4
solex200 = 2*cos(t);
[t,y] = AB4sist(@apa, a, b, N, Xa)
E200 = max(abs(solex200-y));
% Error
E200(1)
% Orden de convergencia
N = 400;
[t400,y400] = AB4sist('am',a,b,N,ya)
solex400 = 2*cos(t400);
E400 = max(abs(solex400-y400))
%Error
E400(1)
convergencia = log2(E200(1)/E400(1))



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Funciones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function f = apa(t,x)
    x1 = x(1);
    x2 = x(2);
    f = [x2;-x1];
end

function f=apb(t,x)
    x1 = x(1);
    x2 = x(2);
    f = [x2;((1-x1.^2).*x2)-x1];
end
    

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

function [t,y]=AB4sist(fun,a,b,N,Ya)
    h = (b-a)/N;
    t = a:h:b;
    t = t(:); %Discretizamos t con el paso correcto
    n = length(Ya); %Damos el número de columnas en función de las variables
    y = zeros(N+1,n); %Creamos la matriz solución
    y(1,:) = Ya; %Inicializamos la matriz y 
    
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
    
    

function [T]=tabla(time,t,f)
    f = f(:);
    n = length(t);
    x_t=zeros(n,1);
    j = 1;
    for i = 1:length(time)
        if t(j,1) == time(i,1)
            x_t(j,1)=f(i);
            j=j+1;
        end
    end
    x_t = round(x_t,6);
    T = table(t,x_t);
end

function [E,orden_E] = eval_fun_N_ana(f,solex,PVI,a,b,ya,N)
    n = length(N);
    E = zeros(1,n);
    for i = 1:n
        [t,y] = f(PVI,a,b,ya,N(i));
        E(i) = max(abs(solex(t)-y));
    end
    orden_E = log2(E(1:end-1)./E(2:end));
    E = round(E,6);
    E = E(:);
    orden_E = [missing orden_E]';
    orden_E = round(orden_E,6);
end

function [e,orden_e]=eval_fun_N_aprox(f,PVI,a,b,Ya,N)
    n = length(N);
    e = zeros(1,n-1);
    for i = 1:n
        [~,Y] = f(PVI,a,b,Ya,N(i));
        if i < n
            [~,Y2] = f(PVI,a,b,Ya,N(i+1));
            e(i) = norm(Y(:,1)-Y2(1:2:end,1));
        end
    end
    orden_e = log2(e(1:end-1)./e(2:end));
    e = round(e,6);
    orden_e = round(orden_e,6);
    e = [missing e]';
    orden_e = [missing missing orden_e]';
end