% Definimos primero xi e fi y x como variable simbolica.
xi = [0 1.5 3 4 6 7 9 10];
fi = [20 100 60 120 20 40 100 0];
dfi = zeros(size(xi));
syms x
% Calculamos b y el polinomio p 
[b,p] = polinomioHermite(xi,fi,dfi);
digits(2)

% Tomamos 100 puntos para representar el polinomio
xaxis = linspace(0,10);

% Obtenemos los coeficientes redondeados
hcoeffs = round(double(coeffs(p)));
% Con t obtenemos x^15, x^14...
[C,T] = coeffs(p);
% Creamos el nuevo polinomio con los valores redondeados
polinomio_redondeado = dot(hcoeffs,flip(T))
%%
yaxis = double(subs(p,x,xaxis));
% Representamos el polinomio en rojo, los puntos como estrellas
% Y la interpolación lineal automática que hace matlab en azul.
plot(xaxis,yaxis,'red'), hold on, grid, xlabel('x'), ylabel('y'),
plot(xi,fi, 'o:black'), plot(xi,fi, 'blue'),
legend('Polinomio de Hermite','Puntos por los que pasa', ...
    'Interpolación lineal a trozos');
% Definimos la funcion polinomioHermite
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