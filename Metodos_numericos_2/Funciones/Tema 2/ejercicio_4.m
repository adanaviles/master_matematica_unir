function dx=ejercicio_4(x,y)
dx=[y(2);...
   -(x+1).*y(2)+2*y(1)+(1-x.^2).*exp(-x)];
end