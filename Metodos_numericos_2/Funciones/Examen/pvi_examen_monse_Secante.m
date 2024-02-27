function dy=pvi_examen_monse_Secante(x,y)
dy=[y(2);...
    8/6*exp(-x).*y(1).*y(2)+exp(x)/6];
end