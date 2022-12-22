%Definimos los datos de las diferentes posiciones
x=[0 1.5 3 4 6 7 9 10];
y=[20 100 60 120 20 40 100 0];

%%%%Ejercicio 1
%Interpolación lienal enttre cada pareja de puntos usando polyfit con dos
%decimales
l=[]; x1=[]; y1=[];
for i =1:(length(x)-1)
    a=0; x_a=0;
    a=polyfit(x(:,i:i+1), y(:,i:i+1),1);
    x_a=linspace(x(i),x(i+1));
    l(:,i)=a;
    y1=[y1 polyval(a,x_a)];
    x1=[x1 x_a];
end

figure
plot(x,y, '.k','MarkerSize',15)
grid on
hold on
plot(x1,y1,'g')
xlabel('x')
ylabel('y')
hold off

format bank %para que salgan dos decimales unicamente
l