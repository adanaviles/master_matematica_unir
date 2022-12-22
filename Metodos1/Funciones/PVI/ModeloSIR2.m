function [dY,JY]=ModeloSIR2(t,Y)
S=Y(1); I=Y(2); R=Y(3);
beta=0.01; nu=0.5;
dY=[-beta*S.*I;beta*S.*I-nu*I;nu*I];

JY=[-beta*I beta.*I 0; -beta*S beta*S-nu nu; 0 0 0 ]'
end