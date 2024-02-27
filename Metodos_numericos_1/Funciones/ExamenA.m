%Ejercicio 1: DIN
%a)
a=0; b=1;
f=@(x) 1./(x.^2+1);
Ianalitico=integral(f,a,b)
%b)
nTrap=12
ITrap=trapecios(f,a,b,nTrap)
Error=abs(Ianalitico-ITrap)
%c) Funcion en carpeta
%d)
nSimps=12
ISimps38=simpson3_8(f,a,b,nSimps)
Error2=abs(Ianalitico-ISimps38)


%Ejercicio 2 PVI
%a) Word
%b)
a=0;b=3;N=30; Ya=[1;1;1];
[t,Y]=Heun_Sistemas('PVIA',a,b,N,Ya)

plot(t,Y(:,1))
grid on
xlabel('t')
ylabel('y(t)')

[t Y(:,1)]

%c)
a=0;b=3;N=30; Ya=[1;1;1];
[t2,Y2]=AB4Sist('PVIA',a,b,N,Ya)

plot(t2,Y2(:,1))
grid on
xlabel('t')
ylabel('y(t)')

[t2 Y2(:,1)]

%d)
[t,z1]=Heun_Sistemas('PVIA',a,b,N,Ya);
[t,z2]=Heun_Sistemas('PVIA',a,b,2*N,Ya);
[t,z3]=Heun_Sistemas('PVIA',a,b,4*N,Ya);
[t,z4]=Heun_Sistemas('PVIA',a,b,8*N,Ya);
[t,z5]=Heun_Sistemas('PVIA',a,b,16*N,Ya);
[t,z6]=Heun_Sistemas('PVIA',a,b,32*N,Ya);
[t,z7]=Heun_Sistemas('PVIA',a,b,64*N,Ya);
[t,z8]=Heun_Sistemas('PVIA',a,b,2*64*N,Ya);
E1=max(abs(z1(:,1)-z2(1:2:end,1)));
E2=max(abs(z2(:,1)-z3(1:2:end,1)));
E3=max(abs(z3(:,1)-z4(1:2:end,1)));
E4=max(abs(z4(:,1)-z5(1:2:end,1)));
E5=max(abs(z5(:,1)-z6(1:2:end,1)));
E6=max(abs(z6(:,1)-z7(1:2:end,1)));
E7=max(abs(z7(:,1)-z8(1:2:end,1)));
E=[E1 E2 E3 E4 E5 E6 E7];
orden=log2(E(1:end-1)./E(2:end))

[t,z1]=AB4Sist('PVIA',a,b,N,Ya);
[t,z2]=AB4Sist('PVIA',a,b,2*N,Ya);
[t,z3]=AB4Sist('PVIA',a,b,4*N,Ya);
[t,z4]=AB4Sist('PVIA',a,b,8*N,Ya);
[t,z5]=AB4Sist('PVIA',a,b,16*N,Ya);
[t,z6]=AB4Sist('PVIA',a,b,32*N,Ya);
[t,z7]=AB4Sist('PVIA',a,b,64*N,Ya);
[t,z8]=AB4Sist('PVIA',a,b,2*64*N,Ya);
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
plot(x,f1,'o')
hold on
grid on
plot(x,f2,'o')
xlabel('x')
ylabel('f(x)')
hold off
%Se cortan en (1.46465,0.212651)
%b)
[sol ,iter, incre, f_eval, dif , ACOC ]  =NewtonNL('ejemploE',vpa(1.1) ,1e-10 ,50)

%c) seria copiar codigo
%d)
[sol ,iter, incre, f_eval, dif , ACOC ]  =K2NL('ejemploE',vpa(1.1) ,1e-10 ,50)

%e) Word