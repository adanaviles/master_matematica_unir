function dx=ejercicio_6(x,w)
dx=[w(2);...
    w(3);...
    w(4);...
    100*(1-x./36)/(60e6)-1000*w(1)/(60e6)];
end