%Definimos los datos de las diferentes posiciones
x=[0 1.5 3 4 6 7 9 10];
y=[20 100 60 120 20 40 100 0];

%%%%Ejercicio 2
%Polinormio interpolacion Newton grado 7

n=[]; f1=[]; f2=y; cont=1; y2=0; gaux=1; Gaux=1; p=0;
syms z
n(1)=y(1);
y2=y2+n(1);
p=n(1)
x2=linspace(min(x),max(x));
while cont< length(x)
    for i=1:(length(x)-cont)
        f1(i)=(f2(i+1)-f2(i))/(x(i+cont)-x(i));
    end
    gaux=gaux.*(x2-x(cont));
    Gaux=Gaux.*(z-x(cont));
    cont=cont+1;
    n(cont)=f1(1);
    f2=f1;
    f1=[];
    y2=y2+n(cont)*gaux;
    p=p+n(cont)*Gaux
end

figure
plot(x,y, '.k','MarkerSize',15)
grid on
hold on
plot(x2,y2,'g')
xlabel('x')
ylabel('y')
hold off

format bank %para que salgan dos decimales unicamente
%hn=fliplr(n)
n=round(coeffs(p, 'All'),2)

