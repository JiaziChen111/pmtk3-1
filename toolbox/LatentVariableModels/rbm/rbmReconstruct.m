function Xrecon = rbmReconstruct(model, X)

%up = rbmVtoH(model, X);
%Xrecon = rbmHtoV(model, up);

N = size(X,1);
ph = rbmInferLatent(model, X);
Xrecon = sigmoid(ph*model.W' + repmat(model.c,N,1));
end
