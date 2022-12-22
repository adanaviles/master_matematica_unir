%Definimos los datos de las diferentes posiciones
x=[0 1.5 3 4 6 7 9 10];
y=[20 100 60 120 20 40 100 0];
k=zeros(1,length(x));
%x=[0 0.5 1]
%y=[1 0.9385 0.7652]
%k=[0 -0.2423 -0.4401]

%%%%Ejercicio 3
%Polinormio de Hermite de grado 15. Para ello primero tenemos que definir
%el polinomio de Lagrange de grado 15

x3=linspace(min(x),max(x));
H=0; f1=[]; f2=y; cont=1; gaux1=1;gaux2=1; Hbar=0;
syms z
while cont< length(x)+1
    gaux1=1;gaux2=1; L=0;Lprima=0; Dif=0;
    for i=1:length(x)
        if i~=cont
            gaux1=gaux1.*(z-x(i));
            gaux2=gaux2.*(x(cont)-x(i));
        end
    end
    L=(1/gaux2)*gaux1;
    Lprima=diff(L,z);
    Dif=(1-2*(z-x(cont))*subs(Lprima,z,x(cont)))*L*L;
    Hbar=(z-x(cont))*L*L;
    H=H+y(cont)*Dif+k(cont)*Hbar;
    cont=cont+1;
end
y3=subs(H,z,x3);
figure
plot(x,y, '.k','MarkerSize',15)
grid on
hold on
plot(x3,y3,'g')
xlabel('x')
ylabel('y')
hold off

h=round(sym2poly(H))%para que salgan dos decimales unicamente



