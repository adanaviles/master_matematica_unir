function du=ejemplo1_10(r,u)
du=[u(2);...
    -1./r.*u(2);...
    u(4);...
    -1./r.*u(4)];
end