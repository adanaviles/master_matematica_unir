[nodos_secante, solAprox_secante,t_secante, iter_secante]=disparo_secante_NoDirich_monse('pvi_examen_monse_Secante',0,1,1,2,19,1e-5,50)
plot(nodos_secante,solAprox_secante(:,1),'x')
hold on
grid on
xlabel('x')
ylabel('y(x)')
hold off
Nodos=vpa(nodos_secante,6);
SolY=vpa(solAprox_secante(:,1),7);
SolYprima=vpa(solAprox_secante(:,2),7);
t=t_secante
iter=iter_secante
table(Nodos, SolY, SolYprima)