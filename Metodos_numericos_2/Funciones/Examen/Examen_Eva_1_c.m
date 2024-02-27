%(1.b)
[nodos_secante, solAprox_secante,t_secante, iter_secante]=disparo_secante_NoDirich('pvi_examen_eva_Secante',1,2,1/2,17/2,19,1e-5,50)
[nodos_newton, solAprox_newton,t_newton, iter_newton]=disparo_Newton_NoDirich('pvi_examen_eva_Newton',1,2,1/2,17/2,19,1e-5,50)
[X_df,Y_df,iter_df,incr_df]= Difnolin_NoDirich(@(x,y,z) -y.*z+2+2*x.*y, @(x,y,z) -z+2*x, @(x,y,z) -y, 1,2,1/2,17/2,19,50,1e-5)
plot(nodos_secante,solAprox_secante(:,1),'x')
hold on
grid on
plot(nodos_newton,solAprox_newton(:,1),'o')
plot(X_df, Y_df, '+')
xlabel('x')
ylabel('y(x)')
legend('Secante','Newton', 'Diferencias finitas')
hold off
Nodos=vpa(X_df,6);
SolY=vpa(Y_df,6);
iter=iter_df
incr_df
table(Nodos, SolY)