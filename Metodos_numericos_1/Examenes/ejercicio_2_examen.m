%Establecemos las condiciones iniciales

a=0;
b=2*pi;
Ya=[0;1;0];
N=20;

% Resolvemos para Heunn
[x,Yrk]=RK_Sistemas('PVI',a,b,Ya,N);

% orden de convergencia
[x,Yrk1]=RK_Sistemas('PVI',a,b,Ya,N)
Yrk1=Yrk1(:,1);
[x,Yrk2]=RK_Sistemas('PVI',a,b,Ya,2*N)
Yrk2=Yrk2(1:2:end,:);
[x,Yrk3]=RK_Sistemas('PVI',a,b,Ya,4*N)
Yrk3=Yrk3(1:4:end,:);
[x,Yrk4]=RK_Sistemas('PVI',a,b,Ya,8*N)
Yrk4=Yrk4(1:8:end,:);
[x,Yrk5]=RK_Sistemas('PVI',a,b,Ya,16*N)
Yrk5=Yrk5(1:16:end,:);
[x,Yrk6]=RK_Sistemas('PVI',a,b,Ya,32*N)
Yrk6=Yrk6(1:32:end,:);
erk1=norm(Yrk2-Yrk1);
erk2=norm(Yrk3-Yrk2);
erk3=norm(Yrk4-Yrk3);
erk4=norm(Yrk5-Yrk4);
erk5=norm(Yrk6-Yrk5);
eri=[erk1 erk2 erk3 erk4 erk5];
eR=log2(eri(1:end-1)./eri(2:end));

[x,Yrk1]=Heun_sistemas('PVI',a,b,Ya,N)
Yrk1=Yrk1(:,1);
[x,Yrk2]=Heun_sistemas('PVI',a,b,Ya,2*N)
Yrk2=Yrk2(1:2:end,:);
[x,Yrk3]=Heun_sistemas('PVI',a,b,Ya,4*N)
Yrk3=Yrk3(1:4:end,:);
[x,Yrk4]=Heun_sistemas('PVI',a,b,Ya,8*N)
Yrk4=Yrk4(1:8:end,:);
[x,Yrk5]=Heun_sistemas('PVI',a,b,Ya,16*N)
Yrk5=Yrk5(1:16:end,:);
[x,Yrk6]=Heun_sistemas('PVI',a,b,Ya,32*N)
Yrk6=Yrk6(1:32:end,:);
erk1=norm(Yrk2-Yrk1);
erk2=norm(Yrk3-Yrk2);
erk3=norm(Yrk4-Yrk3);
erk4=norm(Yrk5-Yrk4);
erk5=norm(Yrk6-Yrk5);
eri=[erk1 erk2 erk3 erk4 erk5];
eRh=log2(eri(1:end-1)./eri(2:end));



%Por abuso de notacino cambiaremos el par (x,t) por (y,x)
function dY = PVI(x,Y)
    Y1=Y(1);
    Y2=Y(2);
    Y3=Y(3);
    dY=[Y2;  Y3; -Y1+sin(x)+12-Y2+2*(x+3).*x.^2];
end



function [t,Y]=Heun_sistemas(f,a,b,Ya,N)
    h=(b-a)/N;
    t=a:h:b;
    t=t(:);
    Y=zeros(N+1,length(Ya));
    Y(1,:)=Ya;
    for k=1:N
        k1=h*feval(f,t(k),Y(k,:))';
        k2=h*feval(f,t(k+1),Y(k,:)+k1)';
        Y(k+1,:)=Y(k,:)+k1/2+k2/2;
    end
end

function [t,Y]=RK_Sistemas(f,a,b,Ya,N)
%Codigo para resolver un PVI con el método de Runge-Kuta de orden 4
h=(b-a)/N;
t=a:h:b;
t=t(:);
Y=zeros(N+1,length(Ya));
Y(1,:)=Ya;
for k=1:N
    k1=feval(f,t(k),Y(k,:))';
    k2=feval(f,t(k)+h/2,Y(k,:)+h*k1/2)';
    k3=feval(f,t(k)+h/2,Y(k,:)+h*k2/2)';
    k4=feval(f,t(k+1),Y(k,:)+h*k3)';

    Y(k+1,:)=Y(k,:)+h*(k1+2*k2+2*k3+k4)/6;
end
end