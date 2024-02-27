function [t, y] = Euler(f,a,b,ya,N)
    h = (b-a)/N;
    t = a:h:b;
    t = t(:);
    y = zeros(N+1,1);
    y(1) = ya;
    for k = 1:N
        fx = feval(f, t(k), y(k));
        y(k+1) = y(k)+h*fx;
    end
end
