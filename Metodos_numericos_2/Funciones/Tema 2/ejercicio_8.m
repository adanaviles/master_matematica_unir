function dx=ejercicio_8(x,y)
dx=[y(2);...
    y(3);...
    -y(2).*y(1)/8-y(3)+x.^3/4+32/(x.^3)+6;...
    y(5);...
    y(6);...
    -y(2).*y(4)/8-y(1).*y(5)/8-y(6)];
end