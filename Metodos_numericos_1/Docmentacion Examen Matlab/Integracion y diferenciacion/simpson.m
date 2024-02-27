function I = simpson(f,a,b,n)
    % I=simpson(f,a,b,n) obtiene la integral de f(x)
    % con la fórmula de Simpson compuesta.
    h = (b-a)/n; %calculo paso h
    x = a:h:b; % calculo los pasos de a b 
    pesos = ones(1, n+1); % Devuelve un array de n+1 unos
    pesos(2:2:n) = 4; % Hago que los pares sean 4
    pesos (3:2:n-1) = 2; %Hago que los impares sean 2
    I = (h/3)*sum(pesos.*f(x)); %añado el . para multiplicar vectores
end