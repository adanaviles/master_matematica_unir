function dy=pvi_examen_Newton(x,y)
dy(1)=y(2);
dy(2)= -y(2).*y(1)+2+2*x.*y(1);
dy(3)=y(4);
dy(4)=(-y(2)+2*x).*y(3)-y(1).*y(4);
dy=dy(:);
end