%Definimos los datos de las diferentes posiciones
x=[0 1.5 3 4 6 7 9 10];
y=[20 100 60 120 20 40 100 0];
%x=1971:10:2011;
%y=[33.956 37.743 39.434 40.847 46.816 ];

%%%%Ejercicio 4
%Splines naturales cúbicos s(x)
n=length(x);
A=zeros(n); A(1,1)=1; A(n,n)=1;D1(1,1)=1,D1(n,1)=1
k=zeros(n,1)
cont=1;
for i=2:(n-1)
    A(i,cont)=x(i)-x(i-1);
    A(i,cont+1)=2*(x(i)-x(i-1)+x(i+1)-x(i));
    A(i,cont+2)=x(i+1)-x(i);
    k(i,1)=3*((y(i+1)-y(i))/(x(i+1)-x(i))-(y(i)-y(i-1))/(x(i)-x(i-1)))
    cont=cont+1;
end
a=y';
c=A\k;
syms z
for i=1:(n-1)
    h=0; h=x(i+1)-x(i);
    b(i,1)=(a(i+1,1)-a(i,1))/h-h/3*(2*c(i,1)+c(i+1,1));
    d(i,1)=(c(i+1,1)-c(i,1))/(3*(x(i+1)-x(i)));
    s(i,1)=a(i,1)+b(i,1)*(z-x(i))+c(i,1)*(z-x(i))*(z-x(i))+d(i,1)*(z-x(i))*(z-x(i))*(z-x(i));
end
l=[]; x4=[]; y4=[];
for i =1:(length(x)-1)
    x_a=0;
    x_a=linspace(x(i),x(i+1));
    l(:,i)=a;
    y4=[y4 subs(s(i),z,x_a)];
    x4=[x4 x_a];
end

figure
plot(x,y, '.k','MarkerSize',15)
grid on
hold on
plot(x4,y4,'g')
xlabel('x')
ylabel('y')
hold off

for i=1:n-1
    S(i,1)=a(i,1);
    S(i,2)=b(i,1);
    S(i,3)=c(i,1);
    S(i,4)=d(i,1);
end
S
