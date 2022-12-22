function[x, U] = EJ3explicito(CC1 ,CC2 ,CI1 ,a,b,Tmax , nx ,nt)
k=Tmax /nt; h=(b-a)/nx;
x=a:h:b; x=x(:);
t=0:k:Tmax ;
U= zeros (nx+1,nt +1);
U(1 ,:)= feval (CC1 ,t);
U(nx +1 ,:)= feval (CC2 ,t);
U(: ,1)= feval (CI1 ,x);
lambda=k/(h);
for i=2: nx
U(i ,2) =(1 -lambda^2)*U(i ,1) +lambda^2/2*(U(i+1 ,1) +U(i -1 ,1));
end

for j=2: nt
for i=2: nx
U(i,j+1) =1/(1+k/2*x(i))*((2-2*lambda^2)*U(i,j) +lambda^2*(U(i+1,j)+U(i-1,j)) +(k/2*x(i)-1)*U(i,j -1));
end
end
end