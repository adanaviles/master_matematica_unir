function dY = PenduloPVI(t, theta )
g=9.8; L =1;
Y1= theta(1) ; Y2= theta(2) ;
dY =[ Y2; (g/L)* sin(Y1)];
end
