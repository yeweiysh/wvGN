
function f=structuralNeighborhoodRepresentation(A,t)

baseconv=1e-4;
n=size(A,1);
P=normrow(A);
clear A;

maxit=50;
conv=baseconv;

sumP=[];
for runtime=1:n
    if mod(runtime,1000)==0
        fprintf('%d\n',runtime);
    end
    vt=t*P*P(runtime,:)';
    dt=ones(n,1);
    dtp=zeros(n,1);
    i=1;
    sumP(:,runtime)=vt;
    vt=sparse(vt);
    while(max(abs(dt-dtp))>conv&&i<maxit)        
        vtp=vt;
        dtp=dt;
        vt=t/(i+1)*P*vt;
        sumP(:,runtime)=sumP(:,runtime)+full(vt);
        dt=abs(full(vt)-vtp);
        i=i+1;
    end

end

f=sumP';

