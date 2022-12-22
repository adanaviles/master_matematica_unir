%Ejercicio1
a=0; b=2; N=40; Ya=[0;0];
[t1,x1]=Heun_Sistemas('PVI1',a,b,N,Ya);
plot(t1,x1(:,1),'o-')
grid on
xlabel('t_k')
ylabel('x_k')
title('Muelle con Heun')
[t1 x1(:,1)]


a=0; b=2; N=40; Ya=[0,0];
[t2,x2]=Runge_Kutta_Sistemas('PVI1',a,b,N,Ya);
plot(t2,x2(:,1),'o-')
grid on
xlabel('t_k')
ylabel('x_k')
title('Muelle con RK')
[t2 x2(:,1)]

%Convergencias ejercicio 1
a=0; b=2; N=40; Ya=[0,0];
[t,z1]=Heun_Sistemas('PVI1',a,b,N,Ya);
[t,z2]=Heun_Sistemas('PVI1',a,b,2*N,Ya);
[t,z3]=Heun_Sistemas('PVI1',a,b,4*N,Ya);
[t,z4]=Heun_Sistemas('PVI1',a,b,8*N,Ya);
[t,z5]=Heun_Sistemas('PVI1',a,b,16*N,Ya);
[t,z6]=Heun_Sistemas('PVI1',a,b,32*N,Ya);
[t,z7]=Heun_Sistemas('PVI1',a,b,64*N,Ya);
[t,z8]=Heun_Sistemas('PVI1',a,b,2*64*N,Ya);
E1=max(abs(z1(:,1)-z2(1:2:end,1)));
E2=max(abs(z2(:,1)-z3(1:2:end,1)));
E3=max(abs(z3(:,1)-z4(1:2:end,1)));
E4=max(abs(z4(:,1)-z5(1:2:end,1)));
E5=max(abs(z5(:,1)-z6(1:2:end,1)));
E6=max(abs(z6(:,1)-z7(1:2:end,1)));
E7=max(abs(z7(:,1)-z8(1:2:end,1)));
E=[E1 E2 E3 E4 E5 E6 E7];
orden=log2(E(1:end-1)./E(2:end))

a=0; b=2; N=40; Ya=[0,0];
[t,z1]=Runge_Kutta_Sistemas('PVI1',a,b,N,Ya);
[t,z2]=Runge_Kutta_Sistemas('PVI1',a,b,2*N,Ya);
[t,z3]=Runge_Kutta_Sistemas('PVI1',a,b,4*N,Ya);
[t,z4]=Runge_Kutta_Sistemas('PVI1',a,b,8*N,Ya);
[t,z5]=Runge_Kutta_Sistemas('PVI1',a,b,16*N,Ya);
[t,z6]=Runge_Kutta_Sistemas('PVI1',a,b,32*N,Ya);
[t,z7]=Runge_Kutta_Sistemas('PVI1',a,b,64*N,Ya);
[t,z8]=Runge_Kutta_Sistemas('PVI1',a,b,2*64*N,Ya);
[t,z7_1]=rungekutta_sistemas('PVI1',a,b,Ya,64*N);
[t,z8_1]=rungekutta_sistemas('PVI1',a,b,Ya,2*64*N);
E1=max(abs(z1(:,1)-z2(1:2:end,1)));
E2=max(abs(z2(:,1)-z3(1:2:end,1)));
E3=max(abs(z3(:,1)-z4(1:2:end,1)));
E4=max(abs(z4(:,1)-z5(1:2:end,1)));
E5=max(abs(z5(:,1)-z6(1:2:end,1)));
E6=max(abs(z6(:,1)-z7(1:2:end,1)));
E7=max(abs(z7(:,1)-z8(1:2:end,1)));
E7_1=max(abs(z7_1(:,1)-z8_1(1:2:end,1)));
E=[E1 E2 E3 E4 E5 E6 E7];
orden=log2(E(1:end-1)./E(2:end))





%Ejercicio2
a=0; b=2*pi; N=32;ya=0;
[t3,y3]=Euler('PVI2',a,b,N,ya)
plot(t3,y3(:,1),'o-')
grid on
xlabel('t_k')
ylabel('y_k')
title('Euler explícito')
lambda=50
sol=lambda/(1+lambda^2)*(exp(-lambda*t3)+lambda*sin(t3)-cos(t3))
Error_max=max(abs(sol-y3))


[t4,y4]=Euler_implicito('PVI2_imp',a,b,N,ya,1e-6,30);
plot(t4,y4(:,1),'o-')
grid on
xlabel('t_k')
ylabel('y_k')
title('Euler implícito')
lambda=50
sol=lambda/(1+lambda^2)*(exp(-lambda*t4)+lambda*sin(t4)-cos(t4))
Error_max=max(abs(sol-y4))

%Calculo N
a=0; b=2*pi; N=round(50*pi)+1;ya=0;
[t_3,y_3]=Euler('PVI2',a,b,N,ya)
plot(t_3,y_3(:,1),'o-')
grid on
xlabel('t_k')
ylabel('y_k')
title('Euler explícito')
lambda=50
sol=lambda/(1+lambda^2)*(exp(-lambda*t_3)+lambda*sin(t_3)-cos(t_3))
Error_max=max(abs(sol-y_3))



%Ejercicio3
a=0; b=20; h=0.1; N=(b-a)/h; Ya=[2,0];
[t5,y5]=AB2Sist('VanderPolNoAmort',a,b,N,Ya);
[t6,y6]=AB4Sist('VanderPolNoAmort',a,b,N,Ya);
[t5 y5(:,1) y6(:,1)]
plot(t5,y5(:,1),'o-')
hold on
plot(t6,y6(:,1),'o-')
grid on
xlabel('t_k')
ylabel('y_k')
title('Van der Pol No Amortiguado: Adams-Bashforth')
legend('AB2','AB4')
hold off



a=0; b=20; h=0.1; N=(b-a)/h; Ya=[2,0];
[t7,y7]=AB2Sist('VanderPolAmort',a,b,N,Ya);
[t8,y8]=AB4Sist('VanderPolAmort',a,b,N,Ya);
[t7 y7(:,1) y8(:,1)]
plot(t7,y7(:,1),'o-')
hold on
plot(t8,y8(:,1),'o-')
grid on
xlabel('t_k')
ylabel('y_k')
title('Van der Pol Amortiguado: Adams-Bashforth')
legend('AB2','AB4')
hold off




%Convergencias ejercicio 3
a=0; b=20; h=0.1; N=(b-a)/h; Ya=[2,0];
[t,z1]=AB2Sist('VanderPolNoAmort',a,b,N,Ya);
[t,z2]=AB2Sist('VanderPolNoAmort',a,b,2*N,Ya);
[t,z3]=AB2Sist('VanderPolNoAmort',a,b,4*N,Ya);
[t,z4]=AB2Sist('VanderPolNoAmort',a,b,8*N,Ya);
[t,z5]=AB2Sist('VanderPolNoAmort',a,b,16*N,Ya);
[t,z6]=AB2Sist('VanderPolNoAmort',a,b,32*N,Ya);
[t,z7]=AB2Sist('VanderPolNoAmort',a,b,64*N,Ya);
[t,z8]=AB2Sist('VanderPolNoAmort',a,b,2*64*N,Ya);
E1=max(abs(z1(:,1)-z2(1:2:end,1)));
E2=max(abs(z2(:,1)-z3(1:2:end,1)));
E3=max(abs(z3(:,1)-z4(1:2:end,1)));
E4=max(abs(z4(:,1)-z5(1:2:end,1)));
E5=max(abs(z5(:,1)-z6(1:2:end,1)));
E6=max(abs(z6(:,1)-z7(1:2:end,1)));
E7=max(abs(z7(:,1)-z8(1:2:end,1)));
E=[E1 E2 E3 E4 E5 E6 E7];
orden=log2(E(1:end-1)./E(2:end))

a=0; b=20; h=0.1; N=(b-a)/h; Ya=[2,0];
[t,z1]=AB4Sist('VanderPolNoAmort',a,b,N,Ya);
[t,z2]=AB4Sist('VanderPolNoAmort',a,b,2*N,Ya);
[t,z3]=AB4Sist('VanderPolNoAmort',a,b,4*N,Ya);
[t,z4]=AB4Sist('VanderPolNoAmort',a,b,8*N,Ya);
[t,z5]=AB4Sist('VanderPolNoAmort',a,b,16*N,Ya);
[t,z6]=AB4Sist('VanderPolNoAmort',a,b,32*N,Ya);
[t,z7]=AB4Sist('VanderPolNoAmort',a,b,64*N,Ya);
[t,z8]=AB4Sist('VanderPolNoAmort',a,b,2*64*N,Ya);
E1=max(abs(z1(:,1)-z2(1:2:end,1)));
E2=max(abs(z2(:,1)-z3(1:2:end,1)));
E3=max(abs(z3(:,1)-z4(1:2:end,1)));
E4=max(abs(z4(:,1)-z5(1:2:end,1)));
E5=max(abs(z5(:,1)-z6(1:2:end,1)));
E6=max(abs(z6(:,1)-z7(1:2:end,1)));
E7=max(abs(z7(:,1)-z8(1:2:end,1)));
E=[E1 E2 E3 E4 E5 E6 E7];
orden=log2(E(1:end-1)./E(2:end))