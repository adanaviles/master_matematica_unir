% Ejemplo 13
%(a)
a=5; L=2; 
cc1=@(t) exp(-25.*(t.^2));
cc2=@(t) exp(-1*(2-5.*t).^2);
ci=@(x) exp(-1*(x.^2));
Tmax=2;
nx=10; nt=200;
h=0.2;k=0.1;
[U,x,t]=Lax_Fri(cc1,cc2,ci,a,L,nx,Tmax,nt);
[x' U(:,end)]

%(a)
a=5; L=2; 
cc1=@(t) exp(-25.*(t.^2));
cc2=@(t) exp(-1*(2-5.*t).^2);
ci=@(x) exp(-1*(x.^2));
Tmax=2;
nx=10; nt=20;
h=0.2;k=0.1;
[U2,x2,t2]=Lax_Fri(cc1,cc2,ci,a,L,nx,Tmax,nt);
[x2' U2(:,end)]