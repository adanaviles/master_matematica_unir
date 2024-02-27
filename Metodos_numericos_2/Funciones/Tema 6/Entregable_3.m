% Entregable 3
alpha=1;
ci=@(x) sin(x)+cos(x); h2=@(t) t.^2/2;
L=1; nx=10;
Tmax=0.5; nt=1000;
[u,x,t] = CalorExpl_Ent3_1(alpha,ci,h2,L,nx,Tmax,nt); 
[u2,x2,t2] = CalorImpl_Entr3_2(alpha,ci,h2,L,nx,Tmax,nt);
Tmax=1; nt=1/0.0005;
[u3,x3,t3] = CalorCN_Entr3_3(alpha,ci,h2,L,nx,Tmax,nt); 
[x' u(:,end) u2(:,end) u3(:,end)]
plot(x,u(:,end),'o')
hold on
plot(x2,u2(:,end),'*')
plot(x3,u3(:,end))
grid on
title('Comparativa')
xlabel('x')
ylabel('u(x,t)')
legend('Expl','Impl','C-N')
hold off

Tmax=1; nt=1/0.0005;
[u4,x4,t4] = CalorCN_Entr3_3(alpha,ci,h2,L,nx,Tmax,nt);
plot(x4,u4(:,end),'o-')
hold on
grid on
title('C-N en t=1')
xlabel('x')
ylabel('u(x,t)')
hold off