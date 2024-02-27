%Ejercicio 1: DIN
%a)
a=2; b=3;
f=@(x) 1./sqrt(x-1);
Ianalitico=integral(f,a,b)
%b)
npm=12
Ipm=puntoMedio(f,a,b,npm)
Error=abs(Ianalitico-Ipm)
%c) Funcion en carpeta
%d)
nSimps=12
ISimps38=simpson3_8(f,a,b,nSimps)
Error2=abs(Ianalitico-ISimps38)

%Ejercicio 2 PVI
%a) Word
%b)
a=1;b=2;N=20; Ya=[exp(1)+3;2*exp(1)+9;4*exp(1)+18];
[t,Y]=RK_Sistemas('PVIA',a,b,N,Ya)

plot(t,Y(:,1))
grid on
xlabel('t')
ylabel('y(t)')

[t Y(:,1) Y(:,2)]

%c)
a=1;b=2;N=20; Ya=[exp(1)+3;2*exp(1)+9;4*exp(1)+18];
[t2,Y2]=AB2Sist('PVIB',a,b,N,Ya)

plot(t2,Y2(:,1))
grid on
xlabel('t')
ylabel('y(t)')

[t2(1:5:end) Y2(1:5:end,1) Y2(1:5:end,2)]

%d)
[t,z1]=RK_Sistemas('PVIB',a,b,N,Ya);
[t,z2]=RK_Sistemas('PVIB',a,b,2*N,Ya);
[t,z3]=RK_Sistemas('PVIB',a,b,4*N,Ya);
[t,z4]=RK_Sistemas('PVIB',a,b,8*N,Ya);
[t,z5]=RK_Sistemas('PVIB',a,b,16*N,Ya);
[t,z6]=RK_Sistemas('PVIB',a,b,32*N,Ya);
[t,z7]=RK_Sistemas('PVIB',a,b,64*N,Ya);
[t,z8]=RK_Sistemas('PVIB',a,b,2*64*N,Ya);
E1=max(abs(z1(:,1)-z2(1:2:end,1)));
E2=max(abs(z2(:,1)-z3(1:2:end,1)));
E3=max(abs(z3(:,1)-z4(1:2:end,1)));
E4=max(abs(z4(:,1)-z5(1:2:end,1)));
E5=max(abs(z5(:,1)-z6(1:2:end,1)));
E6=max(abs(z6(:,1)-z7(1:2:end,1)));
E7=max(abs(z7(:,1)-z8(1:2:end,1)));
E=[E1 E2 E3 E4 E5 E6 E7];
orden=log2(E(1:end-1)./E(2:end))

[t,z1]=AB2Sist('PVIB',a,b,N,Ya);
[t,z2]=AB2Sist('PVIB',a,b,2*N,Ya);
[t,z3]=AB2Sist('PVIB',a,b,4*N,Ya);
[t,z4]=AB2Sist('PVIB',a,b,8*N,Ya);
[t,z5]=AB2Sist('PVIB',a,b,16*N,Ya);
[t,z6]=AB2Sist('PVIB',a,b,32*N,Ya);
[t,z7]=AB2Sist('PVIB',a,b,64*N,Ya);
[t,z8]=AB2Sist('PVIB',a,b,2*64*N,Ya);
E1=max(abs(z1(:,1)-z2(1:2:end,1)));
E2=max(abs(z2(:,1)-z3(1:2:end,1)));
E3=max(abs(z3(:,1)-z4(1:2:end,1)));
E4=max(abs(z4(:,1)-z5(1:2:end,1)));
E5=max(abs(z5(:,1)-z6(1:2:end,1)));
E6=max(abs(z6(:,1)-z7(1:2:end,1)));
E7=max(abs(z7(:,1)-z8(1:2:end,1)));
E=[E1 E2 E3 E4 E5 E6 E7];
orden=log2(E(1:end-1)./E(2:end))

%Ejercicio 3 ESLN
%a)
x=linspace(-1,3);
f1=exp(-x);
f2=x.^3-2.*x;
plot(x,f1)
hold on
grid on
plot(x,f2)
xlabel('x')
ylabel('f(x)')
hold off
%Se cortan en (1.46465,0.212651)
%b)
[sol ,iter, incre, f_eval, dif , ACOC ]  =TraubNL('ejemploE',vpa(1.1) ,1e-10 ,50)

%c) seria copiar codigo
%d)
[sol ,iter, incre, f_eval, dif , ACOC ]  =OstrowskiNL('ejemploE',vpa(1.1) ,1e-10 ,50)

%e) Word
[sol ,iter, incre, f_eval, dif , ACOC ]  =NewtonNL('ejemploE',vpa(1.1) ,1e-10 ,50)