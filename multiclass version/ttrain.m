function f=ttrain(prob, param,w1,logd)
l=prob.l;
n=prob.n;

perm=zeros(1,l);
y1=-1*prob.y;
[y,perm]=sort(y1);
x=prob.x(perm,:);

sub_prob=Problem(l,n,x,-1*y);

w=train_one(sub_prob,param,w1,logd);

f=w;


