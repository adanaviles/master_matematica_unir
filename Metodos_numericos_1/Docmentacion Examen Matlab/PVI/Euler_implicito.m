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
        while iter < maxiter && dif > tol
            [fx0, dfx0] = feval(f, t(k+1), x0);
            g = x0-y(k)-h*fx0;
            dg = 1-h*dfx0;
            x1 = x0-g/dg;
            dif = abs(x1-x0);
            iter = iter+1;
            x0 = x1;
        end
        y(k+1) = y(k)+h*fx0;
    end
end