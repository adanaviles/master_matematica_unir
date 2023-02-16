ni = 0;
n= 100;
Xplot = zeros(1,n);
Yplot = zeros(1,n);
Zplot = zeros(1,n);
for i=1:n
    x = rand([1,3]);
    x(1) = x(1)+1; % r va de 1 a 2
    x(2) = x(2)*2*pi; % theta va de 0 a 2pi
    x(3) = -1+x(3)*13; % f(r,theta) va de 0 a 12 (realmente de  -1 a 12)
    Xplot(i) = x(1)*cos(x(2));
    Yplot(i) = x(1)*sin(x(2));
    Zplot(i) = x(3);
    fx = 3*(x(1)*cos(x(2)))^2 -sin(x(1)*sin(x(2)));
    % Tener en cuenta que puede irpor arriba o por debajo por z=0
    % diferenciamos esos casos
    if (x(3)<=0) %si esta por debajo de cero, queremos que este por encima de fx
        if(x(3) > fx)
            ni=ni +1;
        end
    else 
        if(x(3) < fx)
            ni=ni +1;
        end
    end
end
%Sabemos que V(s) = SxI donde S es el area del anillo e I la medida entre 
% -1 y 12 => v(S) = (pi*r_1^2 -pi*r_2^2)*(12--1) = pi(2^2-1^2)*13
vol = pi*(3)*(13)*ni/n; 

fun_polar = @(r,theta) (3*(r.*cos(theta)).^2-sin(r.*sin(theta))).*r; %recordemos que dxdy =rdrdtheta
r1=1; r2=2;
theta1=0; theta2=2*pi;
I = integral2(fun_polar,r1, r2,theta1, theta2);



[X,Y] = meshgrid(-10:0.05:10,-10:0.05:10);
curva = X.^2+Y.^2;
Z = 3*X.^2 -sin(Y);
Z(curva<1 | curva > 4)=nan;
surf(X,Y,Z)
hold on 
plot3(Xplot,Yplot,Zplot, 'o')