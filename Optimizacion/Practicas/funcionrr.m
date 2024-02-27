
function f = funcionrr ( x )

    xini=[x 0];
    t=[0 2*pi];
    
    options=odeset('RelTol',1e-13,'AbsTol',1e-13);
    
    [ts,xs]=ode45(@campo_pendulo,t,xini,options);
    
   f=xs(end,1);
end

function px = campo_pendulo(t,x)

    px(1)= x(2);
    px(2)=sin(x(1))+0.5*sin(t);
    px=px';
end