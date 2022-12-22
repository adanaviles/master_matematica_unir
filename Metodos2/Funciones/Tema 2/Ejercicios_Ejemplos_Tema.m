% Ejemplo 6
[x,y]=disparo_lineal('pvi1','pvi2',1,2,1,2,10)

% Ejemplo 7
[nodos, solAprox,t, iter]=disparo_secante('ejemplo1_7',1,3,17,43/3,19,1e-5,50)

% Ejemplo 8
[nodos, solAprox,t, iter]=disparo_secanteP1('ejemplo1_8',1,3,log(1/3)-1,0.5*(log(3)-7),20,1e-7,100)

% Ejemplo 9
[nodos, solAprox,t, iter]=disparo_Newton('ejemplo1_9',1,3,17,43/3,19,1e-5,50)

% Ejemplo 10
[nodos, solAprox,t, iter]=disparo_NewtonP1('ejemplo1_10',1,3,1-1/(2*log(3)), 0.5-1/(6*log(3)),9, 1e-7,100)

% Ejercicio 1
% (a)
[x,y]=disparo_lineal('pvi1_p1','pvi2_p1',1,2,0,log(2),20);
solAprox=y(:,1);
solExacta=log(x);
[x, solAprox solExacta abs(solAprox-solExacta)]

% (b)
[x,y]=disparo_lineal('pvi1_p1_b','pvi1_p1_b',1,2,1/2,1/3,20);
solAprox=y(:,1);
solExacta=1./(x+1);
[x, solAprox solExacta abs(solAprox-solExacta)]

% (c)
[x,y]=disparo_lineal('pvi1_p1_c','pvi2_p1_c',1,2,2,5/2,20);
solAprox=y(:,1);
solExacta=x+(1./x);
[x, solAprox solExacta abs(solAprox-solExacta)]


% Ejericio 2
[nodos, solAprox,t, iter]=disparo_NewtonP2('ejercicio_2',0,pi,1,2,9,1e-8,100)
SolAprox=solAprox(:,1);
solExacta=sin(nodos);
[nodos, SolAprox solExacta abs(SolAprox-solExacta)]
Nodos=linspace(0,pi)
plot(nodos,SolAprox,'o')
hold on
grid on
plot(Nodos,sin(Nodos))

% Ejercicio 4
[nodos, solAprox,t, iter]=disparo_secanteP4('ejercicio_4',0,1,1,1/exp(1),10,1e-8,100)
[nodos solAprox]



% Ejericio 5
% (a) Hemos hecho cambio de variable z=-x, mirar libreta
[nodos, solAprox,t, iter]=disparo_NewtonP5('ejercicio_5',0,1,1/3,1/2,-1/9,9,1e-8,100)
%deshacemos cambio de variable:
nodos=fliplr(-nodos')';
SolAprox=fliplr(solAprox(:,1)')';
solExacta=1./(nodos+3);
[nodos, SolAprox solExacta abs(SolAprox-solExacta)]

% Ejercicio 6
[nodos, solAprox,t,q, iter]=disparo_secanteP6('ejercicio_6',0,10,0,0,40,1e-8,100)
solAprox=solAprox(21,1);
Nodos = nodos(21);
[Nodos solAprox]

% Ejericio 7
[nodos, solAprox,t, iter]=disparo_NewtonP7('ejercicio_7',0,1,0,3*exp(1),3,20,1e-16,100)
SolAprox=solAprox(:,1);
solExacta=nodos.*exp(nodos);
[nodos, SolAprox solExacta abs(SolAprox-solExacta)]

% Ejericio 8
[nodos, solAprox,t, iter]=disparo_NewtonP8('ejercicio_8',1,4,17,-6,34,60,1e-8,100)
SolAprox=solAprox(1:10:end,1);
Nodos=nodos(1:10:end)
solExacta=Nodos.^2+16./Nodos;
[Nodos SolAprox solExacta abs(SolAprox-solExacta)]
