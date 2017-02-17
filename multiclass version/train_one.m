function f=train_one(sub_prob, param,w1,logd)
index=1:sub_prob.n;

[x_val,x_ind,x_ptr]=transport(sub_prob, index);

w=solve_l2r_l2_cdprimal_regularized_svc(w1,logd,sub_prob, param, x_val, x_ind, x_ptr);
f=w;
