
a=0;b=10;N=10;
Ya=[100;32;5];

[t,YE] = Euler_Sistemas('ModeloSIR',a,b,N,Ya);
[t,YH] = Heun_sistemas('ModeloSIR',a,b,N,Ya);
[t,YR] = RK_Sistemas('ModeloSIR',a,b,N,Ya);

figure
hold on
grid on
plot(t,YE(:,1),'r') %Pintamos S(x)
plot(t,YE(:,2),'c') %Pintamos I(x)
plot(t,YE(:,3),'g') %Pintamos R(x)
legend('S(x)','I(x)', 'R(x)')
xlabel('x')
ylabel('y')
hold off
function dY=ModeloSIR(t,Y)
    S=Y(1);
    I=Y(2);
    R=Y(3);
    beta=0.01; nu=0.5;
    dY=[-beta*S.*I; beta*S.*I-nu*I; nu*I];
end


function [t,Y] = Euler_Sistemas(f,a,b,N,Ya)
    % Código para resolver un PVI basado en un sistema
    % de EDOs con el metodo de Euler
    h=(b-a)/N;
    t=a:h:b;
    t=t(:);
    Y=zeros(N+1,length(Ya));
    Y(1,:)=Ya;
    for k=1:N
    Y(k+1,:)=Y(k,:)+h*feval(f,t(k),Y(k,:))';
    end
end

function [t,Y]=Heun_sistemas(f,a,b,N,Ya)
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

function [t,Y]=RK_Sistemas(f,a,b,N,Ya)
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
