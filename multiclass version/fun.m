function f=fun(prob, param, w, logd)
l=prob.l;%number of training instances
n=prob.n;%number of features
y=prob.y;
C=param.C;
z=zeros(1,l);
obj=0;

z=Xv(prob,w);

z=y'.*z;
d=1-z;
index=find(d>0);
d1=d(1,index);
obj=obj+d1*d1'*C;

% obj=2*obj;
obj=obj+0.5*(w.*logd)*(w.*logd)';
% obj=obj/2;

f=obj;
