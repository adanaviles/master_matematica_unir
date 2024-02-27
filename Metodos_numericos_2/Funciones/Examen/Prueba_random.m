alpha=1/3;
CI1=@(x) 3*sin(3*x); CI2=@(x) 0*x;
CC1=@(t) 0*t; CC2=@(t) 0*t;
a=0; b=pi; nx=10;
Tmax=3*pi;  
hold on

for i=10:100
    nt=i;
    [U,x,t] = implicitoOndas(CC1,CC2,CI1,CI2,a,b,nx,nt,Tmax,alpha);
    plot(x,U(:,end))
end
xlabel('x')
ylabel('y(x)')
hold off
