function [Fa] = fun_alpha(alpha,x0, Dfx)
     y = x0-alpha*Dfx;
     [Fa, ~] = fun(y);
end