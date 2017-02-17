function f=recompute(prob,x_ind,x_val,x_ptr,w,param,i)
l=prob.l;%number of training instances
n=prob.n;%number of features
b=ones(1,l);
Cp=param.C;

for j=1:n
    col_i=x_ptr(1,j):(x_ptr(1,j+1)-1);
    b(1,x_ind(1,col_i))=b(1,x_ind(1,col_i))-w(1,j)*x_val(1,col_i);
end

loss=0;

col_i=x_ptr(1,i):(x_ptr(1,i+1)-1);
c=b(1,x_ind(1,col_i));
index=find(c>0);
loss=loss+c(1,index)*c(1,index)'*Cp;

f=loss;