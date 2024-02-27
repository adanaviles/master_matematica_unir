[sol,iter, dif,ACOC] = Newton_Sist('Sistema',vpa([2;-1]),1e-12,40);

[sol,iter, dif,ACOC] = Trapecios_Sist('Sistema',vpa([2;-1]),1e-12,40);

[sol,iter, dif,ACOC] = Jarrat_Sist('Sistema',vpa([2;-1]),1e-12,40);

[sol,iter, dif,ACOC] = GoldenRatio_Sist('Sistema',vpa([2;-1]),1e-12,40);

[sol,iter, dif,ACOC] = NA_Sist('Sistema',vpa([2;-1]),1e-12,40);

[sol,iter, dif,ACOC] = RN_Sist('Sistema',vpa([2;-1]),1e-12,40);

[sol,iter, dif,ACOC] = PuntoMedio_Sist('Sistema',vpa([2;-1]),1e-12,40);

[sol,iter, dif,ACOC] = Simpson_Sist('Sistema',vpa([2;-1]),1e-12,40);

[sol,iter, dif,ACOC] = Traub_Sist('Sistema',vpa([2;-1]),1e-12,40);