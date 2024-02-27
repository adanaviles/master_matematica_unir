%(1.b)
[nodos_secante, solAprox_secante,t_secante, iter_secante]=disparo_secante('pvi_examen_eva_Secante',1,2,3/2,9/2,19,1e-5,50)
[nodos_newton, solAprox_newton,t_newton, iter_newton]=disparo_Newton('pvi_examen_eva_Newton',1,2,3/2,9/2,19,1e-5,50)
[X_df,Y_df,iter_df,incr_df]= Difnolin(@(x,y,z) -y.*z+2+2*x.*y, @(x,y,z) -z+2*x, @(x,y,z) -y, 1,2,3/2,9/2,19,50,1e-5)
plot(nodos_secante,solAprox_secante(:,1),'x')
hold on
grid on
plot(nodos_newton,solAprox_newton(:,1),'o')
plot(X_df, Y_df, '+')
xlabel('x')
ylabel('y(x)')
legend('Secante','Newton', 'Diferencias finitas')
hold off
Nodos=vpa(nodos_secante,6);
SolY=vpa(solAprox_secante(:,1),7);
SolYprima=vpa(solAprox_secante(:,2),7);
t=t_secante
iter=iter_secante
table(Nodos, SolY, SolYprima)