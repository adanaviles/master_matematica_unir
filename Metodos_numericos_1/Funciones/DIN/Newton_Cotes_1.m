function I= Newton_Cotes_1(f,a,b,n)
% I=Newton_Cotes_1(f,a,b,n) obtiene la integral de f(x)
% con la fórmula de Newton-Cotes con n=1.
h = (b-a)/(n +2);
x = a+h:h:b-h;
I =3*h* sum (f(x(1:3:end)));
end