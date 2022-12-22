function dY = MuellePVI(t,y)
Y1=y(1); Y2=y(2);
dY=[Y2; 4*sin(5*t)-25*Y1];
end
