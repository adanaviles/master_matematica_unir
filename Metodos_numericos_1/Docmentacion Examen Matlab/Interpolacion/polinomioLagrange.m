function p = polinomioLagrange(xi,fi)
   syms x 
   n = length(xi);
   % Prealoco las L en un vector
   L = sym(zeros(1,n));
   % Col es mi i.
   col = 1;
   while col <= n 
      % Creo un vector auxiliar al que le ire quitando los elementos que
      % necesiet quitar
      aux = xi;
      aux(col)=[];
      L(col) = prod(x-aux)/prod(xi(col)-aux);
      col = col+1;
   end
   p = sum(L.*fi)
end