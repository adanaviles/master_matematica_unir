function dx=ejercicio_5(x,y)
dx=[y(2);...
    y(3);...
    6*y(2).^2-y(3)-2*y(1).^3;...
    y(5);...
    y(6);...
    -6*y(1).^2.*y(4)+12*y(5)-y(6)];
end