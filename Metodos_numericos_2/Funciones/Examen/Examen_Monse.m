[nodos_secante, solAprox_secante,t_secante, iter_secante]=disparo_secante('pvi_examen_monse_Secante',0,1,1,2,19,1e-5,50)

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



[X_df,Y_df,iter_df,incr_df]= Difnolin_NoDirich_monse(@(x,y,z) 8/6*exp(-x).*y.*z+exp(x)/6, @(x,y,z) 8/6*exp(-x).*z, @(x,y,z) 8/6*exp(-x).*y, 0,1,1,2,19,5000,1e-5)
plot(X_df, Y_df, '+')
hold on
grid on
xlabel('x')
ylabel('y(x)')
hold off
Nodos=vpa(X_df,6);
SolY=vpa(Y_df,7);
iter=iter_df
incr_df
table(Nodos, SolY)


alpha=2;
CI1=@(x) cos(x)-x; CI2=@(x) -2*sin(x);
CC1=@(t) cos(2*t); CC2=@(t) cos(2*t+1)-1;
a=0; b=1; nx=10;
Tmax=2; nt=40;
[U,x,t] = explicitoOndas(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha);
plot(x,U(:,2))
hold on
plot(x,U(:,21))
plot(x,U(:,end))
xlabel('x')
ylabel('y(x)')
legend('x=k','x=1','x=2')
hold off
SolU=vpa(U(:,end),6);