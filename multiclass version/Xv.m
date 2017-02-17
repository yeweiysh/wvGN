function f=Xv(prob,v)
l=prob.l;
x=prob.x;
xv=zeros(1,l);
for i=1:l
    index=find(x(i,:)~=0);
    xv(1,i)=v(1,index)*x(i,index)';
end
f=xv;