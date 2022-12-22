%1.b
[nodos, solAprox,t, iter]=disparo_Newton('pvi_examen_Newton',1,2,3/2,9/2,19,1e-5,50)

plot(nodos,solAprox(:,1),'x')
hold on
grid on
xlabel('x')
ylabel('y(x)')
hold off
Nodos=vpa(nodos,6);
SolY=vpa(solAprox(:,1),7);
SolYprima=vpa(solAprox(:,2),7);
t=t
iter=iter
table(Nodos, SolY, SolYprima)


%1.c
[X_df,Y_df,iter_df,incr_df]= Difnolin_NoDirich_examen(@(x,y,z) -y.*z+2+2*x.*y, @(x,y,z) -z+2*x, @(x,y,z) -y, 1,2,1,17/2,19,50,1e-5)
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




%2.b
alpha=2;
CI1=@(x) cos(x)-x.^2; CI2=@(x) -2*sin(x);
CC1=@(t) cos(2*t); CC2=@(t) cos(2*t+1)-1;
a=0; b=1; nx=10;
Tmax=2; nt=40;
[U,x,t] = explicitoOndas_examen(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha);
plot(x,U(:,2))
hold on
plot(x,U(:,21))
plot(x,U(:,end))
xlabel('x')
ylabel('y(x)')
legend('x=k','x=1','x=2')
hold off
SolU=vpa(U(:,end),6);