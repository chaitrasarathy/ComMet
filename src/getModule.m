function [moduleRxnIDs, lenRotComp, moduleRxnInds] = getModule(model, rotatedComp)
% This function finds the modules from the given array of PC loadings
% 6 Nov 2019
% use 99.9th percentile to extract module

for ii=1:size(rotatedComp, 2)
%     inds = find(abs(rotatedComp(:,ii)) >= quantile(abs(rotatedComp(:,ii)), percentile));
    inds = find(abs(rotatedComp(:,ii)) >= max(abs(rotatedComp(:,ii))/2));
    lenRotComp(ii) = length(inds); 
    moduleRxnIDs{ii,:} = strjoin(model.rxns(inds), ',');
    moduleRxnInds{ii,:} = inds;
end

end

