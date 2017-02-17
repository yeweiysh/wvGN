function [result,predlabel] = WVGN ( Test, Train, label, A)

X=structuralNeighborhoodRepresentation(A,5);
n=size(A,1);
X(:,n+1)=ones(n,1);

degs=sum(A, 2);
degs(degs==0)=eps;
D=spdiags(1./(degs.^0.5), 0, size(D,1), size(D,2));

C=1;
epps=0.01;

param = ParamInitial(C, epps, D);


for run=1:size(Train,1)

    tr=Train{run,1};
    te=Test{run,1};
    param.C=1.0/size(tr,1);
    trainLabel=label(tr,1);
    
    model=twoclassTrain(label,X,param,tr);
    score=twoclassPredict(X,model);
    predlabel=score;
    index=find(score==-1);
    predlabel(index,1)=2;
    
    ind=zeros(size(score));
    if sum(trainLabel)~=0
        index=find(score==1);
        ind(index,1)=1;
        index=find(score==-1);
        ind(index,2)=1;
        
    else
        index=find(score==1);
        ind(index,2)=1;
        index=find(score==-1);
        ind(index,1)=1;
    end
    
    
    testLabel=label(te,:);
    testScore=ind(te,:);
    [perf, pred] = evaluate(testScore, testLabel);
    hammingScore(run)=1;
    microF1(run)=perf.micro_F1;
    macroF1(run)=perf.macro_F1;
end

result(1,1)=mean(microF1);
result(1,2)=mean(macroF1);

result(2,1)=std(microF1);
result(2,2)=std(macroF1);
