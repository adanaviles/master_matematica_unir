function [S,p]=splinesCubicoNatural(xi,fi)
xi=xi(:);
h=xi(2:end)-xi(1:end-1); h=h(:);
a=fi(:);
dPA=[1; 2*(h(1:end-1)+h(2:end)); 1];
dSA=[0; h(2:end)];
dIA=[h(1:end-1);0];
B=3*[0; (a(3:end)-a(2:end-1))./h(2:end)-(a(2:end-1)-a(1:end-2))./h(1:end-1); 0];
c=Crout(dPA, dSA, dIA, B);
b=(a(2:end)-a(1:end-1))./h-h/3.*(2*c(1:end-1)+c(2:end));
d=(c(2:end)-c(1:end-1))./(3*h);
S=[a(1:end-1) b c(1:end-1) d]
syms x
p=a(1:end-1)+b.*(x-xi(1:end-1))+c(1:end-1).*((x-xi(1:end-1)).^2)+d.*((x-xi(1:end-1)).^3);
end