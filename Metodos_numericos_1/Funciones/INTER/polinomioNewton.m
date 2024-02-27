function [b,p]=polinomioNewton(xi,fi)
n=length(xi);
syms x
xi=xi(:); fi=fi(:);
col=2;
p=fi(1);
vx=1;

while col<=n
    fi(1:n-col+1,col)=(fi(2:n-col+2,col-1)-fi(1:n-col+1,col-1))./...
        (xi(col:n)-xi(1:n-col+1));
    vx=vx*(x-xi(col-1));
    p=p+fi(1,col)*vx;
    col=col+1;
end
b=fi(1,:);
end