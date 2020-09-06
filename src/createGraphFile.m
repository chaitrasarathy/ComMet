function graphFile = createGraphFile(subModel)


% create rxn-rxn mat identifying connections
rxnMat = createAdj(subModel);

% find indices of source and target rxns
[sourceRxn, targetRxn] = find(rxnMat); % these indices correspond to the submodel!

% find connecting metabolite ID and name
for matchingInds = 1:length(sourceRxn)
    mets_source = find(subModel.S(:,sourceRxn(matchingInds))>0);
    mets_target = find(subModel.S(:,targetRxn(matchingInds))<0);
    mets_shared = intersect(mets_source, mets_target);    
    sharedMetaboliteIDs(matchingInds) = join(subModel.mets(mets_shared), ',');
    sharedMetaboliteNames(matchingInds) = join(subModel.metNames(mets_shared), ',');
end

% create files necessary for network creation
graphFile = table(subModel.rxns(sourceRxn), subModel.rxns(targetRxn), sharedMetaboliteIDs', sharedMetaboliteNames');

end

