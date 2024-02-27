format longG 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Metodo de Heun orden 2 para resolver el PVI en 02
a = 0; b = 2; N = 40; Ya = [0;0];
[time, YH] = Heun_sistemas('PVI1', a, b, Ya, N);

% Hacemos la gráfica
plot(time, YH(:,1), '-')
ylabel('t')
xlabel('x(t)')
title('Heun')
grid on

% Hacemos la tabla resumen
t = zeros(9,1);
for i = 1:length(t)
    t(i)=(i-1)*0.25;
end
T1 = tabla(time,t,YH)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Metodo de Runge Kutta
% a = 0; b = 2; N = 40; Ya = [0;0];
[time, YR] = Runge_sistemas('PVI1', a, b, Ya, N);


% Hacemos la gráfica
plot(time,YR(:,1),'-')
ylabel('t')
xlabel('x(t)')
title('Runge-Kutta')
grid on

% Hacemos la tabla resumen
t = zeros(2/0.25+1,1);
for i = 1:length(t)
    t(i) = (i-1)*0.25;
end

T2 = tabla(time,t, YR);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ejercicio 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = 5;
N = ones(1,n);
for i = 1:n
    N(i) = (2^(i-1))*10;
end
% Se va a aproximar del orden sin conocer la solución analítica
[e_H,orden_e_H] = eval_fun_N_aprox(@Heun_sistemas, @PVI1, a, b, Ya, N);
[e_R,orden_e_R] = eval_fun_N_aprox(@Runge_sistemas, @PVI1, a, b, Ya, N);

N = N(:);
T = table(N, e_H, orden_e_H, e_R, orden_e_R)



% Funciones 
function F= PVI1(t,X)
    X1 = X(1);
    X2 = X(2);
    F = [X2;4*sin(5*t)-25*X1];
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

function [t,Y]=Heun_sistemas(f,a,b,Ya,N)
    h=(b-a)/N;
    t=a:h:b;
    t=t(:);
    Y=zeros(N+1,length(Ya));
    Y(1,:)=Ya;
    for k=1:N
        k1=h*feval(f,t(k),Y(k,:))';
        k2=h*feval(f,t(k+1),Y(k,:)+k1)';
        Y(k+1,:)=Y(k,:)+k1/2+k2/2;
    end
end

function [t,Y]=Runge_sistemas(f,a,b,Ya,N)
    h=(b-a)/N;
    t=a:h:b;
    t=t(:);
    Y=zeros(N+1,length(Ya));
    Y(1,:)=Ya;
    for k=1:N
        k1=feval(f,t(k),Y(k,:))';
        k2=feval(f,t(k)+h/2,Y(k,:)+(h/2)*k1)';
        k3=feval(f,t(k)+h/2,Y(k,:)+(h/2)*k2)';
        k4=feval(f,t(k+1),Y(k,:)+h*k3)';
        Y(k+1,:)=Y(k,:)+(h/6)*(k1+2*k2+2*k3+k4);
    end
end
    