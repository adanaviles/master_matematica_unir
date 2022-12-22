
a=0;
b=2*pi;
Ya=[0:1];
h=pi/8;
N=(b-a)/h;

[x,Y] = Runge_sistemas('PVI',a,b,Ya,N);

% convergencia

[x,Y2] = Runge_sistemas('PVI',a,b,Ya,2*N);
[x,Y3] = Runge_sistemas('PVI',a,b,Ya,4*N);
[x,Y4] = Runge_sistemas('PVI',a,b,Ya,8*N);
[x,Y5] = Runge_sistemas('PVI',a,b,Ya,16*N);

function dY = PVI(x,Y)
    Y1=Y(1);
    Y2=Y(2);
    dY=[Y2; -Y1-2*sin(x)];
end


function [t,Y]=Runge_sistemas(f,a,b,Ya,N)
    h=(b-a)/N;
    t=a:h:b;
    t=t(:);
    Y=zeros(N+1,length(Ya));
    Y(1,:)=Ya;
    for k=1:N
        k1=feval(f,t(k),Y(k,:))';
        k2=feval(f,t(k)+h/2,Y(k,:)+(h/2)*k1)';
        k3=feval(f,t(k)+h/2,Y(k,:)+(h/2)*k2)';
        k4=feval(f,t(k+1),Y(k,:)+h*k3)';
        Y(k+1,:)=Y(k,:)+(h/6)*(k1+2*k2+2*k3+k4);
    end
end