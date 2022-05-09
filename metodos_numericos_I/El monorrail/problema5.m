% Definimos primero x e y
xi = [0 1.5 3 4 6 7 9 10];
fi = [20 100 60 120 20 40 100 0];
dfi = zeros(size(xi));
syms x
% Tomamos 100 puntos para representar el polinomio
xaxis = linspace(0,10);

%Newton
[b,p_newton] = polinomioNewton(xi,fi);
yaxis_newton = double(subs(p_newton,x,xaxis));

%Hermite
[b,p_hermite] = polinomioHermite(xi,fi,dfi);
yaxis_hermite = double(subs(p_hermite,x,xaxis));
%Calculo de splines
[ai,bi,ci,di,p] = splineCubicoNatural(xi,fi);
xaxis_1 = linspace(xi(1),xi(2));xaxis_2 = linspace(xi(2),xi(3));
xaxis_3 = linspace(xi(3),xi(4));xaxis_4 = linspace(xi(4),xi(5));
xaxis_5 = linspace(xi(5),xi(6));xaxis_6 = linspace(xi(6),xi(7));
xaxis_7 = linspace(xi(7),xi(8));yaxis_1 = double(subs(p(1), x, xaxis_1));
yaxis_2 = double(subs(p(2), x, xaxis_2));yaxis_3 = double(subs(p(3), x, xaxis_3));
yaxis_4 = double(subs(p(4), x, xaxis_4));yaxis_5 = double(subs(p(5), x, xaxis_5));
yaxis_6 = double(subs(p(6), x, xaxis_6));yaxis_7 = double(subs(p(7), x, xaxis_7));

% Representamos el polinomio en rojo, los puntos como circulos
% Y la interpolación lineal automática que hace matlab en rojo.
plot(xi,fi,'o');
hold on 
%Interpolacion lineal
plot(xi,fi,'red');

%Interpolacion Newton azul
plot(xaxis,yaxis_newton, 'blue')

%Interpolacion Hermite verde
plot(xaxis,yaxis_hermite, 'green')

%Interpolacion por splines naranja
plot(xaxis_1,yaxis_1, 'black');
plot(xaxis_2,yaxis_2, 'black');
plot(xaxis_3,yaxis_3, 'black');
plot(xaxis_4,yaxis_4, 'black');
plot(xaxis_5,yaxis_5, 'black');
plot(xaxis_6,yaxis_6, 'black');
plot(xaxis_7,yaxis_7, 'black');

legend('Puntos por los que pasa','Interpolación lineal','Polinomio de Newton', ...
    'Polinomio de Hermite', 'Splines');
xlim([0,10])
ylim([10,140])
% Definimos la funcion polinomioNewton
function [b,p] = polinomioNewton(xi,fi)
   % Siendo n el grado del polinomio
   % Creamos una matriz de ceros (n+1)*(n+1) 
   % Damos a la  primera columna el valor de los f(x)
   syms x 
   n = length(xi);
   F = zeros(n, n);
   F(:, 1) = fi;
   %Inicializo p con b0, vx con 1
   p = F(1,1);
   vx = 1; 
   %Sean j las columnas, i las filas. 
   % Rellenaré de 1 a n-j+1 filas. La primera columna (cuando j = 1)
   % tiene n filas con valores. La segunda columna (cuando j=2) tiene n-1
   % valores ... la última columna (j=n) tiene solo una fila con valores. 
   %
   for j=2:n
        for i=1:n-j+1
            F(i,j) = (F(i+1,j-1)-F(i,j-1))/(xi(i+j-1)-xi(i)); %tener cuidado no confundir xi con x*i
        end
        %En cada iteracion tendré vx = 1, vx=1*(x-x0), vx=(x-x0)*(x-x1)...
        vx = vx*(x-xi(j-1));
        p = p+F(1,j)*vx;
   end
   % Los bs serán la primera fila 
   b = F(1,:);
end

function [b,p] = polinomioHermite(xi,fi,dfi)
    % Siendo n el grado del polinomio
    % Creamos una matriz de ceros (n+1)*(n+1) 
    % Damos a la  primera columna el valor de los f(x)
    format shortg;
    syms x;

    %Creamos el vector z 
    n = length(xi);
    z = zeros(1,2*n);
    z(1:2:end) = xi;
    z(2:2:end) = xi;
    
    %Creamos la matriz F
    F = zeros(2*n, 2*n);
    % Meto en las columnas pares e impares fi, pues z2i = z2i+1 = xi
    F(1:2:end, 1) = fi;
    F(2:2:end, 1) = fi;
    %Inicializo p con b0, vx con 1
    p = F(1,1);
    vx = 1; 
    %Sean j las columnas, i las filas. 
    % Rellenaré de 1 a n-j+1 filas. La primera columna (cuando j = 1)
    % tiene n filas con valores. La segunda columna (cuando j=2) tiene n-1
    % valores ... la última columna (j=n) tiene solo una fila con valores. 
    for j=2:2*n
        for i=1:2*n-j+1
            F(i,j) = (F(i+1,j-1)-F(i,j-1))/(z(i+j-1)-z(i)); 
        end
        % Para j=2, cambio las impares por dfi
        if j == 2
            F(1:2:end, 2) = dfi;
        end
        %Redondeamos los coeficientes F al entero más proximo como se nos
        %pide
        vx = vx*(x-z(j-1));
        p = p+F(1,j)*vx;
    end
    % Los bs serán la primera fila 
    b = F(1,:);
end

function [ai,bi,ci,di,p] = splineCubicoNatural(xi,fi)
    format shortg
    n = length(xi);
    h = zeros(1,n-1);
    for i = 1:n-1
        h(i) = xi(i+1)-xi(i);
    end
    ai  = fi;
    %Relleno la diagonal inferior, superior y principal
    %Relleno también b
    dI = zeros(n-1,1);
    dS = zeros(n-1,1);
    dP = ones(n,1);
    b = zeros(n,1);
    for i = 2:n-1
        dI(i-1) = h(i-1);
        dS(i) = h(i);
        dP(i) = 2*(h(i)+h(i-1));
        b(i) = 3*((ai(i+1)-ai(i))/h(i) - (ai(i)-ai(i-1))/h(i-1));
    end
    % Aplico crout para sacar ci
    ci  = Crout(dP ,dS ,dI ,b);
    bi = zeros(n-1,1);
    di = zeros(n-1,1);
    % Obtengo bi y di
    for i=1:n-1
        bi(i) = (ai(i+1)-ai(i))/h(i) - h(i)*(2*ci(i)+ci(i+1))/3;
        di(i) = (ci(i+1)-ci(i))/(3*h(i));
    end
    
    syms x;
    % En p tendré una lista con cada spline 
    p = zeros(1,n);
    syms p;
    for i = 1:n-1
        p(i) = ai(i)+bi(i)*(x-xi(i))+ci(i)*(x-xi(i))^2+di(i)*(x-xi(i))^3;
    end
end

function x = Crout(dP ,dS ,dI ,b)
    % La función x=Crout(dP,dS,dI,b) obtiene la ...
    % solución del sistema Ax=b utilizando el ...
    % algoritmo de Crout. dP, dS y dI son las ...
    % diagonales principal , superior e inferior de A.
    n = length(dP);
    % 1. Obtención de las matrices L y U tales que A = LU
    l(1) = dP(1);
    u(1) = dS(1)/l(1);
    for i =2:n-1
        l(i) = dP(i)-dI(i-1)*u(i -1) ;
        u(i) = dS(i)/l(i);
    end
    l(n) = dP(n)-dI(n-1)*u(n-1);
    % 2. Solución del sistema Lz = b
   
    z(1) = b(1)/l(1) ;
    for i = 2:n
        z(i) = (1/l(i))*(b(i)-dI(i-1)*z(i-1));
    end
    % 3. Solución del sistema Ux = z
    x(n) = z(n);
    for i = n-1:-1:1
        x(i) = z(i)-u(i)*x(i+1);
    end
    x=x(:);
end
