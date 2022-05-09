% Definimos primero xi e fi y x como variable simbolica.
xi = [0 1.5 3 4 6 7 9 10];
fi = [20 100 60 120 20 40 100 0];
syms x
% Calculamos b y el polinomio p 
[b,p] = polinomioNewton(xi,fi);

% Tomamos 100 puntos para representar el polinomio
xaxis = linspace(0,10);
yaxis = double(subs(p,x,xaxis));

% Representamos el polinomio en rojo, los puntos como estrellas
% Y la interpolación lineal automática que hace matlab en azul.
plot(xaxis,yaxis,'red')
hold on 
plot(xi,fi, '.:black');
plot(xi,fi, 'blue')
legend('Polinomio de newton','Puntos por los que pasa', ...
    'Interpolación lineal a trozos');

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