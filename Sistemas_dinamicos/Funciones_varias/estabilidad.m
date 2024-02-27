close all;
syms x mu %declaro variables simbólicas para resolver el mapa no lineal
xdot=solve(mu-x^2-x==0,x)
%% Valores
mu=linspace(0,2,100);
fx1=@(mu) abs(sqrt(4*mu+1)+1);
fx2=@(mu) abs(-sqrt(4*mu+1)+1);
%% Grafica
figure
plot(mu,fx1(mu),'--r');hold on;grid on
plot(mu,fx2(mu),'-b')
legend('x^*_1','x^*_2')
ax = gca;
chart = ax.Children(1);
datatip(chart,0.7475,0.9975);

%plotear la función para mu=0 y mu=1


N=1000;                                  % numero de iteraciones
x=linspace(-2,2,N);                     % defino el intervalo 
%--------------------
figure()
%--------------------
mu=0.75;
f =@(x) mu-x.^2;
fd=@(x) -2*x;
xdot_a=subs(xdot);
hold on
plot(x,x,'--k');           

plot(x,f(x));                                                   %dibujo el mapa y=f(x)
plot(xdot_a,xdot_a,'o','MarkerSize',12,'MarkerFaceColor','r')  %dibujo puntos en los cuales corta la gráfica
xlabel('x_n')
ylabel('x_{n+1}')

x0=-1;
x(1)=x0; % plot orbit starting at x0
hold on
for i=1:N
    x(i+1)=f(x(i));
    line([x(i),x(i)],[x(i),x(i+1)],'Color','m');
    line([x(i),x(i+1)],[x(i+1),x(i+1)],'Color','m');
end
title(strcat('\mu=',num2str(mu),' and x_0=',num2str(x0)))

% x(n+1)=f(x(n))
n_perm=1000;

%--------------
figure()
%---------------
x=zeros(n_perm,1);
%Iterar el mapa en regimen permanente

mu=0.75;
y=-1;
for n=1:50
    y=mu-y.^2;
end 
x(1)=y;
for n=1:n_perm-1
    x(n+1)=mu-x(n).^2;
end 
plot(x(1:end-1),x(2:end),'o','MarkerSize',12);hold on           %phase space
plot(xdot_a,xdot_a,'o','MarkerSize',12,'MarkerFaceColor','m') %puntos fijos

xlabel('x_n')
ylabel('x_{n+1}')

xlim([-1.61 0.67])
ylim([-1.62 0.65])




