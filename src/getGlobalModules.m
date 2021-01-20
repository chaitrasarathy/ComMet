function [module_uniqRxns, singleModuleRxnIDs, lenRotComp, singleModuleRxnInds, graphTab, attTab] = getGlobalModules(modelEP, model, rotatedComp, singlesIDs, ubiquitousMets, graphFileName, attFileName)

% filter singletons from all PCs
singlePCs_PC = rotatedComp(:,singlesIDs);

% for each PC, get module
[singleModuleRxnIDs, lenRotComp, singleModuleRxnInds] = getModule(modelEP, singlePCs_PC);

% get unique reactions from the modules (pass the inds, not rxn IDs)
module_uniqRxns = unique(cell2mat(singleModuleRxnInds));
inds = find(contains(model.rxns, modelEP.rxns(module_uniqRxns)));

% extract submodel of module rxns
% subModel = efmSubmodelExtractionAsSBML_raven(iAdipo_ex, inds);
% metaboliteList = subModel.mets(find(ismember(subModel.metNames, ubiquitousMets)));
% subModel_woUb = removeMetabolites(subModel, metaboliteList, 0);

subModel = efmSubmodelExtractionAsSBML_raven(modelEP, module_uniqRxns);
% subModel2 = efmSubmodelExtractionAsSBML_raven(modelEP, module_uniqRxns, true, ubiquitousMets);

% remove reactions that contain only ubiquitous metabolites
subModel_woUb = removeMets(subModel, ubiquitousMets, true, true);

% extract rxns graph and attirbutes file for rxn nws
% [file1, file2] = createRxnNw(subModel_woUb, modelEP, singleModuleRxnInds, singlesIDs);

% create graph file
graphTab = createGraphFile(subModel_woUb);

% create attribute file
attTab = createAttribFile(modelEP, subModel_woUb, singleModuleRxnInds, singlesIDs);

writetable(graphTab, graphFileName, 'Delimiter', ';');
writetable(attTab, attFileName, 'Delimiter', ';');

end

