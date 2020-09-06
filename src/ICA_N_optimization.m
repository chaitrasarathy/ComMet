% This script finds the optimum 'N' (or number of independent components
% necessary for decomposition) for the dataset using a bootstrapping
% approach

% load PCs from both simulations

% set decimal precision and filter reactions with low loadings
pcs_all =  [round(rotatedComp_un_unnorm, 3), round(rotatedComp_bcaa0_unnorm, 3)];
pcs_all_rem = filterLowLoadingsReactions(pcs_all)'; % 4061 to 1803 rxns

% Reduce dimension from 1033 ordinal signals to 'numComps' (lastEig) in each iteration. 
% Resample 100 (M) times using random initial conditions and bootstrapping
% (use FastICA parameters: kurtosis as non-linearity,
% symmetric estimation approach)

numIter = 100;
numComps = [2:1:101];

for uu = 1:length(numComps)
    tic;
    boot_ica = icassoEst('both', pcs_all_rem, numIter, 'g', 'pow3', 'approach', 'symm', 'lastEig', numComps(uu));
    end_time_boot = toc;
    sR = icassoExp(boot_ica);
    end_time_sR = toc;
    save(['Results_nComps_',num2str(numComps(uu)),'.mat'],'boot_ica','sR',...
        'end_time_boot','end_time_sR');
end