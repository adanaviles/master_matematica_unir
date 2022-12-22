function dY = VanderPolAmort(t,y)
mu=1;
Y1=y(1); Y2=y(2);
dY=[Y2; mu*(1-Y1.^2)*Y2-Y1];
end
