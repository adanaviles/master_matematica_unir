x=0:0.1:1;
fx=4*x*(1-exp(-2));
b=zeros(5,1);
A=zeros(5,5);

for i=1:5
    b(i)=trapz(x,fx.*sin(i*pi*x));
    for j=1:5
        A(i,j)=trapz(x,i*j*pi^2*cos(i*pi*x).*cos(j*pi*x)+4*sin(i*pi*x).*sin(j*pi*x));
    end
end
c=A\b
phi=zeros(size(x));
for k=1:5
    phikx=sin(k*pi*x);
    phi=phi+c(k)*phikx;
end
m=1/(1+exp(2));
solex=m*exp(-2*x)-m*exp(2*x)+(1-exp(-2))*x;
error=abs(solex-phi)';
table(x',phi',solex',error)