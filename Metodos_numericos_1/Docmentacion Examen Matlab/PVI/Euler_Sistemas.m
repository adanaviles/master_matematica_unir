function [t,Y] = Euler_Sistemas (f,a,b,N,Ya)
% Código para resolver un PVI basado en un sistema
% de EDOs con el metodo de Euler
    h = (b-a)/N;
    t = a:h:b;
    t = t(:);
    Y= zeros(N+1, length(Ya));
    Y(1,:) =Ya;
    for k = 1:N
        Y(k+1,:) = Y(k,:)+h*feval(f,t(k),Y(k ,:))';
    end
end
