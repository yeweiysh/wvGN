function [model]=multiclassTrain(label,X,param,Train)

trainLabel=full(label(Train,:));
xtrain=X(Train,:);
[l,n]=size(xtrain);

nClass = size(trainLabel,2);

for i=1:nClass
    fprintf('the ');
    fprintf('%d',i);
    fprintf('-th class\n');
    
    ytrain = trainLabel(:,i);
    ytrain(ytrain==0) = -1;
    prob = Problem(l,n,xtrain,ytrain);
    
    ovaSVM{i} = GCD(prob, param);

    [decVal]=predict(ovaSVM{i},xtrain);
    ytrain(ytrain==-1)=0;
    ytrain=double(ytrain);
    [logitParam{i}] = glmfit(decVal, ytrain, 'binomial', 'link', 'logit');
end

model.ovaSVM = ovaSVM;
model.logitParam = logitParam;