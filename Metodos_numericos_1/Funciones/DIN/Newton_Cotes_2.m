function I= Newton_Cotes_2(f,a,b,n)
% I=Newton_Cotes_2(f,a,b,n) obtiene la integral de f(x)
% con la fórmula de Newton-Cotes con n=2.
h = (b-a)/(n +2);
x = a+h:h:b-h;
I =4*h* sum (f(x(1:4:end)));
end