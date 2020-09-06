function file2 = createAttribFile(modelEP, subModel, rotatedRxnIDs, PC_IDs)

% reformat rxn IDs in module
maxEl = max(cellfun(@numel, rotatedRxnIDs));
E = cellfun( @(v) [reshape(v, 1, []) zeros(1,maxEl - numel(v))], rotatedRxnIDs, 'uni',false);
rxnSet_matrix = reshape(cell2mat(E), size(E,1), maxEl);

% remove the unused rxns, i.e., those that contain only ubiquitous mets,
% that have been removed from the submodel already
matchingInds = find(ismember(modelEP.rxns, subModel.rxns));
matchingInds = [matchingInds;0];
for aa = 1:size(rxnSet_matrix, 1)
    for bb = 1:size(rxnSet_matrix, 2)
        if(~ismember(rxnSet_matrix(aa,bb), matchingInds))
        rxnSet_matrix(aa,bb) = 0;
        end        
    end
end
% this section is only necessary when supplying submodel without unused
% reactions


% find the PC index that each reaction is part of and count the total
% number of involved PCs
uniqRxnInds = nonzeros(unique(rxnSet_matrix));
for kk = 1:length(uniqRxnInds)
   [setNums, ~] = find(rxnSet_matrix == uniqRxnInds(kk));
   pcNums(kk) = length(setNums);
   setInds(kk) = join(string(PC_IDs(setNums)), ',');
end

% create files necessary for network creation
file2 = table(modelEP.rxns(uniqRxnInds), subModel.subSystems(find(contains(subModel.rxns, modelEP.rxns(uniqRxnInds)))), setInds', pcNums');

end

