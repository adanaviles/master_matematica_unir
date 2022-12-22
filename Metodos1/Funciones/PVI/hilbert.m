%numero de condicion

for n=2:14
    H=hilb(n);
    K(n-1)=cond(H,inf)
end

plot([2:14],log(K), 'o-')
grid on
xlabel('n')
ylabel('log(K(H))')

%ejemplo 2
for n=2:14
    H=hilb(n);
    b=H*ones(n,1);
    x=ones(n,1);
    x1=H\b;
    dif=norm(x1-x,inf);
    error(n-1)=dif/norm(x,inf);
end

plot([2:14],error, 'o-')
grid on
xlabel('n')
ylabel('Error relativo')