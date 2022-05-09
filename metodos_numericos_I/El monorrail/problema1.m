% Definimos primero x e y
x = [0 1.5 3 4 6 7 9 10];
y = [20 100 60 120 20 40 100 0];
% Calculamos los polinomios lineales para cada "trozo"
% Con x([1,2]) obtenemos los valores con la posicion 1 y 2 de x
p_lineal_1 = polyfit(x([1,2]),y([1,2]),1);
p_lineal_2 = polyfit(x([2,3]),y([2,3]),1);
p_lineal_3 = polyfit(x([3,4]),y([3,4]),1);
p_lineal_4 = polyfit(x([4,5]),y([4,5]),1);
p_lineal_5 = polyfit(x([5,6]),y([5,6]),1);
p_lineal_6 = polyfit(x([6,7]),y([6,7]),1);
p_lineal_7 = polyfit(x([7,8]),y([7,8]),1);
% Definimos los y1,y2... para graficar. Usamos polyval para
% tener el valor del polinomio p_lineal en la coordenada.
y1 = polyval(p_lineal_1,x([1,2]));y2 = polyval(p_lineal_2,x([2,3]));
y3 = polyval(p_lineal_3,x([3,4]));y4 = polyval(p_lineal_4,x([4,5]));
y5 = polyval(p_lineal_5,x([5,6]));y6 = polyval(p_lineal_6,x([6,7]));
y7 = polyval(p_lineal_7,x([7,8]));
figure;
plot(x,y,'.');
hold on;
plot(x([1,2]),y1); plot(x([2,3]),y2); plot(x([3,4]),y3);
plot(x([4,5]),y4); plot(x([5,6]),y5); plot(x([6,7]),y6);
plot(x([7,8]),y7);
hold off;