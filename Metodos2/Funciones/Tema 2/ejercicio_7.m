function dx=ejercicio_7(x,y)
dx=[y(2);...
    y(3);...
    (3+x).*(-y(2).*y(1)-exp(-x).*y(3)+exp(x)+x+exp(2*x).*(x+x.^2)+2);...
    y(5);...
    y(6);...
    (3+x)*(-y(2).*y(4)-y(1).*y(5)-exp(-x).*y(6))];
end