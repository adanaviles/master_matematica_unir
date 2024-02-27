for i = 1:10
    tic
    [x,y] = DiFiLinealPractica2(0,pi/2,-1,1,101);
    toc
end
%  no necesitamos establecer p,q,r pues ya hemos hecho los calculos
function [x,y] = DiFiLinealPractica(a, b, alfa, beta, N)
    % Diferencias finitas ,
    % Problema lineal de segundo orden con
    %condiciones Dirichlet
    % N es el numero de incognitas
    h = (b-a)/(N-1) ;
    x = a:h:b;
    X = x(:) ;
    % Definimos la diagonal principal
    dp = (h^2-2)*ones(1,length(x));
    dp(1) = -h^2* - 2*h - 2; 
    dp(end) = (-1/3)*h^2 + (4/3)*h - 2;
    % Definimos la diagonal superior
    ds = (1-h)*ones(1,length(x)-1);  
    ds(1) = 2;
    % Definimos la diagonal inferior
    di = (1+h)*ones(1,length(x)-1);  
    di(end) = 2;
    % Definimos los terminos independientes, en este caso usamos el coseno
    % ya estamos evaluando, pues X tiene valores
    d = -2*h^2.*cos(X);
    d(1) = d(1) - 2*h*(1 + h)*alfa;
    d(end) = d(end) +(4/3)*h*(1 - h)*beta;
    % Resolvemos mediante Crout
    y = Crout(dp , ds, di, d);
end

% Este no usa crout
function [x,y] = DiFiLinealPractica2(a, b, alfa, beta, N)
    % Diferencias finitas ,
    % Problema lineal de segundo orden con
    %condiciones Dirichlet
    % N es el numero de incognitas
    h = (b-a)/(N-1) ;
    x = a:h:b;
    X = x(:) ;
    % Definimos la diagonal principal
    dp = (h^2-2)*ones(1,length(x));
    dp(1) = -h^2* - 2*h - 2; 
    dp(end) = (-1/3)*h^2 + (4/3)*h - 2;
    % Definimos la diagonal superior
    ds = (1-h)*ones(1,length(x)-1);  
    ds(1) = 2;
    % Definimos la diagonal inferior
    di = (1+h)*ones(1,length(x)-1);  
    di(end) = 2;
    % Definimos los terminos independientes, en este caso usamos el coseno
    % ya estamos evaluando, pues X tiene valores
    d = -2*h^2.*cos(X);
    d(1) = d(1) - 2*h*(1 + h)*alfa;
    d(end) = d(end) +(4/3)*h*(1 - h)*beta;
    % Creamos la matriz con las 3 diagonales
    A = diag(dp,0)+diag(ds,1)+diag(di,-1); 
    y=A\d; %Resolvemos el sistema de ecuaciones por Gauss
end



function [x,y] = DiFiLineal(p, q, r, a, b, alfa, beta, N)
    % Diferencias finitas ,
    % Problema lineal de segundo orden con
    %condiciones Dirichlet
    % N es el numero de incognitas
    h =(b-a)/(N+1) ;
    x = a:h:b;
    x = x (:) ;
    X = x(2:end-1);
    px = feval(p,X);
    qx = feval(q,X);
    rx = feval(r,X);
    dp = 2 + h^2*qx; %diagonal principal
    ds = -1 + h/2*px(1:end-1); %diagonal superior
    di = -1 - h/2*px(2:end); %diagonal inferior
    d = -h^2*rx; %terminos independientes
    d(1) = d(1) + (1 + h/2*px(1))*alfa ;
    d(end) = d(end) + (1 - h/2*px(end))* beta ;
    y = Crout(dp , ds, di, d);
    y = [ alfa; y; beta];

end
    

function sol = Crout(a, b, c, d)
    % a diagonal principal
    % b superdiagonal
    % c subdiagonal
    % d terminos independiante
    n = length(a);
    % Obtencion de las matrices L y U tales que A = LU
    l(1) = a(1) ;
    u(1) = b(1)/l(1);
    for i = 2:n-1
        l(i) = a(i) - c(i-1)*u(i -1) ;
        u(i) = b(i)/l(i);
    end
    l(n) = a(n)-c(n-1)*u(n -1) ;
    % Solucion del sistema Lz = d
    z(1) =d(1)/l (1) ;
    for i = 2:n
        z(i) =(1/l(i))*(d(i) - c(i - 1)*z(i - 1));
    end
    % Solucion del sistema Ux = z
    x(n) = z(n);
    for i = n-1:-1:1
        x(i)=z(i) - u(i)*x(i + 1) ;
    end
    sol = x(:) ;
end
