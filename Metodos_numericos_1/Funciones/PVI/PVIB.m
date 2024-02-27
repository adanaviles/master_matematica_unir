function dY = PVIB(t,y)
Y1=y(1); Y2=y(2); Y3=y(3);
dY=[Y2;Y3;...
    -t.*Y1+18+4.*t.^2.*Y2+t.*exp(t.^2)-33*t.^4];
end