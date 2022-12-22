function dy=pvi_examen_eva_Secante(x,y)
dy=[y(2);...
    -y(2).*y(1)+2+2*x.*y(1)];
end