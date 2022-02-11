function dy = problema2(x, y)
    lambda = 50;
    dy = lambda*(-y+sin(x))
end
% Para lambda = 50
yexacta = @(x) (50/((1+50^2))*(exp(-50*x) + 50*sin(x)-cos(x))
a = 0; b = 2*pi; N = 32;
h = (b-a)/n
td = a:h:b;
ya = 0;



% Definimos las funcionees
function [t, y] = Euler(f,a,b,N,ya)
    h = (b-a)/N;
    t = a:h:b;
    t = t(:);
    y = zeros(N+1,1);
    y(1) = ya;
    for k = 1:N
        y(k+1) = y(k)+h*feval(f, t(k), y(k))
    end
end

function [t,y] = Euler_implicito(f,a,b,ya,N,tol,maxiter)
    h = (b-a)/N;
    t = a:h:b;
    t = t(:);
    y = zeros(N+1, 1);
    y(1) = ya;
    for k = 1:N
        x0 = y(k);
        iter = 1;
        dif = tol+1;
        while iter<maxiter && dif > tol
            [fx0, dfx0] = feval(f,t(k+1), x0);
            g = x0-y(k)-h*fx0;
            dg = 1-h*dfx0;
            x1 = x0-g/dg;
            dif = abs(x1-x0);
            iter = iter+1;
            x0 = x1;
        end
        y(k+1) = y(k)+h*feval(f, t(k+1), x0);
    end
end