function [score] = multiclassPredict(X,model,nClass)
	score = [];
	for i=1:nClass
		[decVal] = predict(model.ovaSVM{i},X);
        param = model.logitParam{i};
		score(:,i) = 1./(1 + exp(-param(1)-decVal*param(2)));
	end
end