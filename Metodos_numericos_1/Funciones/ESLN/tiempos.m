function [tJ, tGJ, tGS]=tiempos(A,b,x0,tol,maxiter)
tGJ =0; tJ =0;
for i =1:1000
    t0= tic ;
    rref([A b]);
    tGJ = tGJ + toc(t0);
end
for i =1:1000
    t0= tic ;
    Jacobi(A,b,x0 ,tol , maxiter );
    tJ=tJ+ toc(t0);
end
for i =1:1000
    t0= tic ;
    Gauss_Seidel(A,b,x0 ,tol , maxiter );
    tJ=tJ+ toc(t0);
end
end