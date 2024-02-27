function dY = PVI(t,y)
Y1=y(1); Y2=y(2);
dY=[Y2;-Y1-2*sin(t)];
end