%Secante
[nodos, solAprox,t, iter]=disparo_secanteP2('ejercicio_2_secante',0,pi,1,2,10,1e-8,100);
SolAprox=solAprox(:,1);
solExacta=sin(nodos);
[nodos SolAprox solExacta abs(SolAprox-solExacta)];

%Newton
[nodos2, solAprox,t, iter]=disparo_NewtonP2('ejercicio_2',0,pi,1,2,10,1e-8,100);
SolAprox2=solAprox(:,1);
solExacta=sin(nodos2);
[nodos SolAprox SolAprox2 solExacta  abs(SolAprox-solExacta) abs(SolAprox2-solExacta)]

Nodos=linspace(0,pi);
tiledlayout(1,2)

nexttile
plot(nodos,SolAprox,'o')
hold on
grid on
plot(Nodos,sin(Nodos))
xlabel('x')
ylabel('y(x)')
title('Secante')
legend('Aproximacion','Exacta')
xlim([0,pi])

nexttile
plot(nodos2,SolAprox2,'o')
hold on
grid on
plot(Nodos,sin(Nodos))
xlabel('x')
ylabel('y(x)')
title('Newton')
legend('Aproximacion','Exacta')
xlim([0,pi])

plot(nodos,SolAprox, 'o')
hold on 
grid on
plot(nodos2,SolAprox2,'x')
xlabel('x')
ylabel('y(x)')
title('Newton')
legend('Secante','Newton')
xlim([0,pi])