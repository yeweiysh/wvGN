function [model]=twoclassTrain(label,X,param,Train)

trainLabel=full(label(Train,:));
xtrain=X(Train,:);
[l,n]=size(xtrain);

ytrain = trainLabel(:,1);
ytrain(ytrain==0) = -1;
prob = Problem(l,n,xtrain,ytrain);
ovaSVM = GCD(prob, param);

model.ovaSVM = ovaSVM;