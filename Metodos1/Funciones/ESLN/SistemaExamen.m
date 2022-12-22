function [F,dF] = SistemaExamen(X) 
x=X(1); y=X(2); z=X(3);
F=[3.*x+cos(y.*z)-1/2;x.^2-81.*(y+0.1).^2+sin(z)+1.06;exp(-x.*y)+20.*z-(3-10*pi)/3];
dF=[3, -z.*sin(y.*z), -y.*sin(y.*z);...
    2*x, -162*(y+0.1), cos(z);...
    -y.*exp(-x.*y), -x.*exp(-x.*y), 20]; 
end