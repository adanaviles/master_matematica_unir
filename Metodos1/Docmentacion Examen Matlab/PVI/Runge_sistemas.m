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