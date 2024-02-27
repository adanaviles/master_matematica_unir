function I= puntoMedio (f,a,b,n)
% I=puntoMedio(f,a,b,n) obtiene la integral de f(x)
% con la fórmula de punto medio compuesta.
h = (b-a)/(n +2) ;
x = a+h:h:b-h;
I =2* h* sum (f(x (1:2 :end)));
end
