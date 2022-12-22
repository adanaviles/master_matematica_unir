function dy=ejemplo1_9(x,y)
dy(1)=y(2);
dy(2)=(1/8)*(32+2*x.^3-y(1).*y(2));
dy(3)=y(4);
dy(4)=(-1/8)*y(2).*y(3)-(1/8)*y(1).*y(4);
dy=dy(:);
end