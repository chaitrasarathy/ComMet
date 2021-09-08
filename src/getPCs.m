function [rotatedComp, numRot_perVar, sortedVariance, cols, rem] = getPCs(covMatrix, var)
% This function takes a covariance matrix, computes its principal components and rotates
% the components that explain certain (ex. 99.9%) variation in the sampled space
%
% USAGE
%   rotatedComp = getPCs(covMatrix, var);
%
% INPUT
%   covMatrix:   covariance matrix resulting from EP MetabolicEP() 
%   var:         value for extracting components that explain 
%                certain percent of the variation in the flux space. ex: 99.9
%
% OUTPUT
%	rotatedComp:    matrix containing the rotated principal components
%
% OPTIONAL OUTPUT
%
%   cols:           total number of columns explaining 'var' percent vatriation
%   numRot_perVar:  number of variables explaining (cumulative) variation
%   sortedVariance: principal component loading matrix sorted by variance explained
%
% EXAMPLE:
%   rotatedComp = getPCs(covMatrix, 99.9);
%
% ..Author: 
%   Chaitra Sarathy, 31 Aug 2020 (initial commit of ComMet)

% basis rotation (PCA) with cols=variables(rxns), rows=sampled datapoints

tic
[coeff,D] = eig(covMatrix);

% calculate variance explained by normalizing eigen values
variance = D / sum(D(:));

% sort the variances
eigVals = diag(variance)*100;
sortedVariance = sort(eigVals,'descend');

% select the number of variables explaining 'var'% variation
numRot = length(find(cumsum(sortedVariance)<=var));
cols = cell2mat(arrayfun(@(x) find(eigVals == x), sortedVariance(1:numRot),'uni', 0)) ;

% cumulative variance
numRot_perVar=[];
num = 0:0.1:99.9;
for tt=1:length(num)
    numRot_perVar(tt) = length(find(cumsum(sortedVariance)<=num(tt)));
end

% varimax rotation
[rem,~] = find(coeff(:,cols)==0);
forRotation = coeff(:,cols);
forRotation(unique(rem),:)=[]; 
rotatedComp = rotatefactors(forRotation, 'Maxit', 1000, 'Normalize', 'off');

toc
tPCA_Rot=toc;

% re-insert the removed rows to maintain consistency in indices
rotatedComp = insertrows(rotatedComp,zeros(1,size(rotatedComp,2)),unique(rem));

end

