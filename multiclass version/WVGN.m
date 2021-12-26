function [result] = WVGN ( Test, Train, label, A)

degs=sum(A, 2);
degs(degs==0)=eps;
D=sparse(1:size(A,1), 1:size(A,2), degs);
D=spdiags(1./(degs.^0.5), 0, size(D,1), size(D,2));
n=size(A,1);

X=structuralNeighborhoodRepresentation(A,5);
X(:,n+1)=ones(n,1);

nClass=size(label,2);
C=1;
gamma=10.0/n^2;
epps=0.01;

param = ParamInitial(C, epps, D);


for run=1:size(Train,1)

    fprintf('the ');
    fprintf('%d',run);
    fprintf('-th running\n');
    tr=Train{run,1};
    te=Test{run,1};
    param.C=1.0/size(tr,1);
    
    model=multiclassTrain(label,X,param,tr);
    score=multiclassPredict(X,model,nClass);
    
%     predlabel=zeros(size(label,1),1);
%     for i=1:size(label,1)
%         [~,Ind] = max(score(i,:));
%         predlabel(i,1)=Ind;
%     end
    
    testLabel=label(te,:);
    testScore=score(te,:);

    [perf, pred] = evaluate(testScore, testLabel);
    hammingScore(run)=1;
    microF1(run)=perf.micro_F1;
    macroF1(run)=perf.macro_F1;
end

result(1,1)=mean(microF1);
result(1,2)=mean(macroF1);

result(2,1)=std(microF1);
result(2,2)=std(macroF1);
