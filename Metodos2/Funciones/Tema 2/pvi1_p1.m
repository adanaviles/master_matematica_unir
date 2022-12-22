function dy=pvi1_p1(x,y)
dy=[y(2);
    -y(2).^2-y(1)+log(x)];
end