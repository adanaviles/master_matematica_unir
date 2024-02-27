function [b,p]=polinomioHermite(xi,fi,dfi)
n=length(xi)*2;
xi=xi(:); fi=fi(:); dfi=dfi(:);
col=2;
p=fi(1);
vx=1;
Z=repmat(xi',2,1); Z=Z(:);
F=repmat(fi',2,1); F=F(:);
syms x

while col<=n
        F(1:n-col+1,col)=(F(2:n-col+2,col-1)-F(1:n-col+1,col-1))./...
        (Z(col:n)-Z(1:n-col+1));
        if col==2
            F(1:2:n-1,col)=dfi;
        end
        vx=vx*(x-Z(col-1));
        p=p+F(1,col)*vx;
        col=col+1;
end
b=F(1,:);
end