function I = trapecios(f,a,b,n)
    % I = trapecios(f,a,b,n) devuelve la integral de f(x)
    % con la fórmula de trapecios compuesta.
    h = (b-a)/n; %calculo paso h
    x = a:h:b; % calculo los pasos de a b 
    pesos = [1 2*ones(1, n-1) 1]; %Tal y como aparece en la formula, los pesos son 1,2,...,2,1
    I = (h/2)*sum(pesos.*f(x)); %añado el . para multiplicar vectores
end