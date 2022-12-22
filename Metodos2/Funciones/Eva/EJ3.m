Tmax=1.5;
a=0;
b=1;
nx=10;
nt=1000;
CC1=@(t)0*t;
CC2=@(t)0*t;
CI1=@(x)sin(pi*x);
CI2=@(x)0*x;
alfa=1;
[x,U] = EJ3explicito(CC1 ,CC2 ,CI1 ,a,b,Tmax , nx ,nt)
[UJ,xJ,t] = EJ3explicito_JOAN(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alfa) 
%%
[xi, Ui] = EJ3implicito(CC1 ,CC2 ,CI1 ,a,b,Tmax , nx ,nt)
[UJi,xJi,t]=EJ3implicito_JOAN(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alfa) 
%%
hold on
%plot(x,U(:,1001),'r')
plot(xi,Ui(:,1001),'g')
plot(xJi,UJi(:,1001),'m')