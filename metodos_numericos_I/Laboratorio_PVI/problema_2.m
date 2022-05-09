format longG
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculo con Euler explicito
a = 0; b = 2*pi; ya = 0; N = 32;
[t1,y1] = Euler('PVI2_explicito', 0, 2*pi, 0, 32);
solex = (50/(1+50^2))*(exp(-50.*t1) + 50*sin(t1)-cos(t1));
error_max_euler = max(abs(y1-solex));

% Plot
plot(t1,y1,'o-')
hold on
plot(t1,solex,'*-')
xlabel('x'); ylabel('y')
legend('Aproximacion por Euler', 'Valores Exactos')
title('Euler explícito')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculo con Euler implícito
[t2,y2] = Euler_implicito('PVI2_implicito', 0,2*pi,0,32,1e-6,30);
error_max_euler_imp = max(abs(y2-solex));
% Plot
plot(t2,y2,'o-')
hold on
plot(t2,solex,'*-')
xlabel('x');ylabel('y')
legend('Aproximacion por Euler implicito', 'Valores Exactos')
title('Euler implícito')
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Intervalos para una buena aproximación
% Podemos hacerlo mediante un bucle while, viendo cuantos intervalos son ncesarios para un error dado
iter = 32
error = 1
while  error > 0.02
    [t1,y1] = Euler('PVI2_explicito', 0,2*pi,0,iter);
    solex = (50/(1+50^2))*(exp(-50.*t1) + 50*sin(t1)-cos(t1));
    error  = max(abs(y1-solex))
    iter = iter+1;
end

% O cogiendo N de 0 a 200
N = linspace(1,200,200)'; %Traspuesta
s = @(x) ((50./(1+50^2)).*(exp(-50.*x)+50*sin(x)-cos(x)));
[E,orden_E] = eval_fun_N_ana(@Euler, s, @PVI2_explicito, a, b, ya, N);
T3 = table(N,E,orden_E);
T3(155:160,:)

% Distintos plots
% N = 158
[x,y] = Euler('PVI2_explicito', a, b, ya, 158);
solex = (50/(1+50^2))*(exp(-50*x)+50*sin(x)-cos(x));
hold on
plot(x,y,'-')
plot(x,solex,'-')
ylabel('y')
xlabel('x')
legend('n = 158','y(x)')
grid on
hold off

% N = 155
[x,y] = Euler('PVI2_explicito', a, b, ya, 155);
solex = (50/(1+50^2))*(exp(-50*x)+50*sin(x)-cos(x));
hold on
plot(x,y,'-')
plot(x,solex,'-')
ylabel('y')
xlabel('x')
legend('n = 155','y(x)')
grid on
hold off

% N = 156
[x,y] = Euler('PVI2_explicito', a, b, ya, 156);
solex = (50/(1+50^2))*(exp(-50*x)+50*sin(x)-cos(x));
hold on
plot(x,y,'-')
plot(x,solex,'-')
ylabel('y')
xlabel('x')
legend('n = 151568','y(x)')
grid on
hold off

% N = 157
[x,y] = Euler('PVI2_explicito', a, b, ya, 157);
solex = (50/(1+50^2))*(exp(-50*x)+50*sin(x)-cos(x));
hold on
plot(x,y,'-')
plot(x,solex,'-')
ylabel('y')
xlabel('x')
legend('n = 157','y(x)')
grid on
hold off


function  f = PVI2_explicito(x, y)
    f = 50*(-y+sin(x));
end


function  [f,df] = PVI2_implicito(x, y)
    f = 50*(-y+sin(x));
    df = -50;
end

% Definimos las funcionees
function [t, y] = Euler(f,a,b,ya,N)
    h = (b-a)/N;
    t = a:h:b;
    t = t(:);
    y = zeros(N+1,1);
    y(1) = ya;
    for k = 1:N
        fx = feval(f, t(k), y(k));
        y(k+1) = y(k)+h*fx;
    end
end

function [t,y] = Euler_implicito(f,a,b,ya,N,tol,maxiter)
    h = (b-a)/N;
    t = a:h:b;
    t = t(:);
    y = zeros(N+1, 1);
    y(1) = ya;
    for k = 1:N
        x0 = y(k);
        iter = 1;
        dif = tol+1;
        while iter < maxiter && dif > tol
            [fx0, dfx0] = feval(f, t(k+1), x0);
            g = x0-y(k)-h*fx0;
            dg = 1-h*dfx0;
            x1 = x0-g/dg;
            dif = abs(x1-x0);
            iter = iter+1;
            x0 = x1;
        end
        y(k+1) = y(k)+h*fx0;
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
    