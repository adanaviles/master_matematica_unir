Monorail_Ej1 %ejecutamos el ejercicio 1 para sacar valores
Monorail_Ej2 %ejecutamos el ejercicio 2 para sacar valores
Monorail_Ej3 %ejecutamos el ejercicio 3 para sacar valores
Monorail_Ej4 %ejecutamos el ejercicio 4 para sacar valores

figure
axis([0 10 0 140])
hold on
plot(x,y, '.k','MarkerSize',15) %Pintamos los puntos
grid on
plot(x1,y1,'r') %Pintamos l(x)
plot(x2,y2,'c') %Pintamos n(x)
plot(x3,y3,'g') %Pintamos h(x)
plot(x4,y4,'m') %Pintamos h(x)
legend('Paradas', 'l(x)','n(x)', 'h(x)', 's(x)', 'Location','south','Orientation','horizontal')
xlabel('x')
ylabel('y')
hold off