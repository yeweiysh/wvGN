function [x_val,x_ind,x_ptr]=transport(prob, index)
n=prob.n;%number of features
l=prob.l;%number of traininig instances
y=prob.y;
x=prob.x;
nl=zeros(1,n);
elements=prob.l*prob.n-sum(prob.x(:)==0);
nl=l*ones(1,n)-sum(prob.x==0);

x_val=zeros(1,elements);
x_ind=zeros(1,elements);
x_ptr=ones(1,n+1);
t_ptr=ones(1,n+1);

for i=2:n+1
    x_ptr(1,i)=x_ptr(1,i-1)+nl(1,i-1);
    t_ptr(1,i)=x_ptr(1,i);
end

for i=1:prob.l
    ind1=find(x(i,:)~=0);
    ind=index(1,ind1);
    x_val(1,uint32(t_ptr(1,ind)))=x(i,ind)*y(i,1);
    x_ind(1,uint32(t_ptr(1,ind)))=i;
    t_ptr(1,ind)=t_ptr(1,ind)+1;
end