function [score] = twoclassPredict(X,model)
[decVal] = predict(model.ovaSVM,X);
score=sign(decVal);
end
