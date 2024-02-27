% Entregable 2
tic
[x,y] = DiFiLineal_Entr2(0,pi/2,-1,1,101);
toc

for i=1:10
    tic
    [x,y] = DiFiLineal_Entr2(0,pi/2,-1,1,100);
    t(i)=toc
end


tic
[x2,y2] = Gauss_Entr2(0,pi/2,-1,1,101); 
toc

for i=1:10
    tic
    [x,y] = Gauss_Entr2(0,pi/2,-1,1,100); 
    t(i)=toc
end

z=linspace(0,pi/2);
Sol=sin(z);
plot(z,Sol)
hold on 
plot(x,y,'o')
grid on
xlabel('x_k')
ylabel('y_k')
title('Crout')
legend('sin(x)','Crout')
xlim([0,pi/2])
hold off



plot(x,y, 'o')
hold on 
grid on
plot(x2,y2,'x')
xlabel('x_k')
ylabel('y_k')
title('Comparativa')
legend('Crout','Gauss')
xlim([0,pi/2])