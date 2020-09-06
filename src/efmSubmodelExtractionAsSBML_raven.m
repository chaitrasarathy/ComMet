% function modelEFM = efmSubmodelExtractionAsSBML_raven(model, rxnsForSubmodel, outputFileName, remFlag, ubiquitousMets) 
function modelEFM = efmSubmodelExtractionAsSBML_raven(model, rxnsForSubmodel, remFlag, ubiquitousMets) 
% This function takes an input array containing reaction indices (in an EFM) and extracts as a sub-model (SBML file) which can be visualised in Cytoscape
%
% USAGE:
%    modelEFM = extractSBMLFromEFM(model, data, outputFileName); % without optional inputs
%    modelEFM = extractSBMLFromEFM(model, data, outputFileName, remFlag, ubiquitousMets); % with optional inputs
%    
% INPUTS:
%    model:              COBRA model that was used for EFM calculation
%    rxnsForSubmodel:    array of reaction indices (such as those in an EFM)
%    outputFileName:     file name of the output sbml file e.g., <name>.xml
%
% OPTIONAL INPUTS:
%    remFlag:           boolean indicating whether ubiquitous metabolites should be removed
%    ubiquitousMets:    list of metabolites to remove. 
%                       An example list of ubiquitous metabolites: 
%                       ubiquitousMets = {'h';'h2';'fe3';'fe2';'h2o';'na1';'atp';'datp';'hco3';'pi';'adp';'dadp';'nadp';'nadph';'coa';'o2';'nad';'nadh';'ppi';'pppi';'amp';'so4';'fad';'fadh2';'udp';'dudp';'co2';'h2o2';'nh4';'ctp';'utp';'gtp';'cdp';'gdp';'dcdp';'dgdp';'dtdp';'dctp';'dttp';'dutp';'dgtp';'cmp';'gmp';'ump';'dcmp';'dtmp';'dgmp';'dump';'damp';'cl'};
%
% OUTPUTS:
%    modelEFM:    submodel containing reactions, metabolites and genes in the EFM of interest
%
% EXAMPLE:
%    data = [1 2 3 4 5]; % select first 5 reactions 
%    modelEFM = extractSBMLFromEFM(model, data) ;
%
% .. Author: Last modified: Chaitra Sarathy, 1 Oct 2019

if nargin < 4
    remFlag = 0;
    ubiquitousMets = [];
end

%remove reactions other than those in EFM
rxnRemoveList = model.rxns(setdiff(1:length(model.rxns), rxnsForSubmodel));

% write a model with the reactions (and corresponding metabolites) from the
% EFM
%%% modelEFM = removeRxns(model, rxnRemoveList, 'metFlag', true);
modelEFM = removeReactions(model,rxnRemoveList,true,true,true);

if (remFlag)

    % Remove metabolites and unused genes, if any
   %%% modelEFM = removeMetabolites(modelEFM, ubiquitousMets, true); 
   modelEFM = removeMets(modelEFM, ubiquitousMets, true);
end

% the unused genes in the model do not get removed, so remove mannually
%%% modelEFM = removeUnusedGenes(modelEFM);

%%% writeCbModel(modelEFM, 'format','sbml', 'fileName', outputFileName);
% exportModel(modelEFM,outputFileName)

end

