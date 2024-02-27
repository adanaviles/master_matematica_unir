function dy=VerhulstPVI(t,y)
k=3;
p=0.1;
dy=(k-p*y).*y;
end