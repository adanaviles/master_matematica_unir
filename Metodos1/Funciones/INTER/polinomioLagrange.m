function [p]=polinomioLagrange(xi,fi)
n=length(xi);
syms x
xi=xi(:); fi=fi(:);
col=1; p=0;
while col<=n
    L=1;
    for i=1:length(xi)
        if i~=col
            L=L.*(x-xi(i))/(xi(col)-xi(i));
        end
    end
    p=p+L.*fi(col);
    col=col+1;
end
end