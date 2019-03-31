function D=degree_inv(W)

n=size(W,1);
d=sum(W,2).^-1;
d(isinf(d))=0;
D=spdiags(d,0,n,n);

end