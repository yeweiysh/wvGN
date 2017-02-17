function f = GCD(prob, param)

lamda = param.lamda;
l=prob.l;%number of training instances
n=prob.n;%number of features
xtrain=prob.x;
ytrain=prob.y;

wpos = sum(ytrain==-1)/sum(ytrain==1);
wneg = 1;

weight = zeros(size(ytrain));
weight(ytrain==1) = wpos;
weight(ytrain==-1) = wneg;
D=param.D;
degree = sum(D,2);
logd = degree;
logd(end+1,1)=1;
logd=logd';

w = rand(1,n);
w = w/norm(w);

obj_old=lamda*(w.*logd)*(w.*logd)';
pred = xtrain*w';
idx=pred.*ytrain<1;
obj_old=obj_old+sum((1-pred(idx)).^2)/l;

Tolerance1=1e-4;

cnt=0;
for t = 1:25
    
    if(mod(t,5) == 0)
        disp(strcat('iteration # ',num2str(t), '/', num2str(10)));
    end
    w_old = w;
    f_old=obj_old;
    f_new=f_old;
    pred = xtrain*w';
    
    randomSubset = randperm(l);
    idx1 = pred(randomSubset,:).*ytrain(randomSubset,:)<1;
    misClass = randomSubset(idx1);
    grad = weight(misClass,:).*ytrain(misClass);
    grad = grad'*xtrain(misClass,:);
    grad = lamda*w.*logd - 1/l*grad;
    
    for i=1:15
        
        etat=1/2^(i-1);
        w1 = w - etat * grad;
        pred = xtrain*w1';
        
        obj=lamda*(w1.*logd)*(w1.*logd)';
        
        idx=pred.*ytrain<1;
        obj=obj+sum((1-pred(idx)).^2)/l;
        if obj<obj_old
            f_new=obj;
            obj_old=obj;
            w=w1;
            break;
        end
    end

    if cnt<=2
        if(norm(f_new-f_old) < Tolerance1)
            w=ttrain(prob, param,w,logd);
            cnt=cnt+1;
        end
    end
    
end

f=w;
end
