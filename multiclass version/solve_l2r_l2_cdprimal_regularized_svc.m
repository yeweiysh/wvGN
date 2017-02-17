function f=solve_l2r_l2_cdprimal_regularized_svc(w1,logd,prob, param, x_val, x_ind, x_ptr)
l=prob.l;%number of training instances
n=prob.n;%number of features
C=param.C;

iter=0;
sigma=0.01;
max_iter=10;
w=w1;
b=ones(1,l);
i_index=1:n;

k=ceil(0.1*n);
% k=n;

while(iter<max_iter)
    Dpmax=0;
    
    i_index=randperm(n);
    
    for s=1:k
        
        i=i_index(s);
        Dp=0;
        Dpp=0;
        loss=0;
        
        
        col_i=x_ptr(1,i);
        while(col_i<x_ptr(i+1))
            xji=x_val(1,col_i);
            ind=x_ind(1,col_i);
            if b(1,ind)>0
                Dp=Dp-b(1,ind)*xji*C;
                Dpp=Dpp+xji*xji*C;
                loss=loss+b(1,ind)*b(1,ind)*C;
            end
            col_i=col_i+1;
        end

        w2=w.*logd;
        Dp=w2(1,i)+2*Dp;
        Dpp=logd(i)+2*Dpp;
        
        if abs(Dp)>Dpmax
            Dpmax=abs(Dp);
        end
        
        if abs(Dp/Dpp)<1e-4
            continue;
        end
        
        d=-Dp/Dpp;
        old_d=0;
        step=0;
        
        
        while(1)
            ddiff=old_d-d;
            step=step+1;
            % Recompute b if line search too many times
            if mod(step,10)==0
                loss=recompute(prob,x_ind,x_val,x_ptr,w,param,i);
                
                col_i=x_ptr(1,i);
                while(col_i<x_ptr(1,i+1))
                    b(1,x_ind(1,col_i))=b(1,x_ind(1,col_i))-old_d*x_val(1,col_i);
                    col_i=col_i+1;
                end
                
            end
            
            new_loss=0;
            for col_i=x_ptr(1,i):(x_ptr(1,i+1)-1)
                tmp=b(1,x_ind(1,col_i))+ddiff*x_val(1,col_i);
                b(1,x_ind(1,col_i))=tmp;
                if tmp>0
                    new_loss=new_loss+tmp*tmp*C;
                end
            end

            old_d=d;
            w2=w.*logd;
            sub=w2(1,i)*d+(0.5+sigma)*d*d+new_loss-loss;
            
            if (sub<=0)||(step>10)
                break;
            else
                d=d/2;
            end
        end
        
        w(1,i)=w(1,i)+d;
    end
    
    iter=iter+1;
    if mod(iter,5)==0
        fprintf('%d\n',iter);
    end
    
    if (Dpmax<param.epps)
        break;
    end
end
f=w;

