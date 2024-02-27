function dY=ModeloSIR(t,Y)
S=Y(1); I=Y(2); R=Y(3);
beta=0.01; nu=0.5;
dY=[-beta*S.*I;beta*S.*I-nu*I;nu*I];
end