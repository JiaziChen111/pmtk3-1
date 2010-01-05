function [C,lambda,S] = shrinkcov(X)
%
% [C,lambda,S] = shrinkcov(X);
%
% Ledoit-Wolf optimal shrinkage estimator for cov(X)  
%
%  C = lambda*T + (1-lambda)*S
%
% using the diagonal variance "target" T=diag(S) with the
% unbiased sample cov S as the unconstrained estimate

%#author Baback Moghaddam    
%baback@jpl.nasa.gov     01/25/09

[n p] = size(X);

% center X
Xmean = mean(X);
X = X - repmat(Xmean,n,1);

S = X'*X/(n-1); % unbiased estimate
Sbar = (n-1)*S/n;

VarS = zeros(p);
for i = 1:n
    VarS = VarS + [X(i,:)'*X(i,:) - Sbar].^2;    
end
VarS = (n/((n-1)^3)) * VarS;

% calculate optimal shrinkage
I = triu(true(p)); 
for i=1:p; I(i,i)=0; end

% Ledoit-Wolf formula
lambda = sum(VarS(I))/sum(S(I).^2);

% bound-constrain lambda
lambda = max([0 min([1 lambda])]);

% shrunk final estimate C
C = lambda*diag(diag(S)) + (1-lambda)*S;









