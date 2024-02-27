function dY = PVIA(t,y)
Y1=y(1); Y2=y(2); Y3=y(3);
dY=[Y2;Y3;...
    t.*Y1+11.*t.*sin(t.^2)-4.*t.^2.*Y2+(4.*t.^2+t+1).*exp(t)];
end