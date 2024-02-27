function dx=ejercicio_2_secante(x,y)
dx=[y(2);...
    x.*y(1).*y(2)-x.*cos(x).*y(1)-sin(x)];
end