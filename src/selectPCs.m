function [pcs_selected_cond1, pcs_selected_cond2, cutoff, features_n_freq] = selectPCs(selectedCols, numIters, numComps_cond1)
% This function selects PCs based on the frequency they were estimated by
% ICA as a unique feature

    features_n = cat(1, selectedCols.all{:});
    features_n_freq = sortrows(tabulate(features_n), 2, 'descend');
    features_n_freq(:,4) = features_n_freq(:,2)/numIters*100;
    
    % Criteria: cut off is the knee point of the frequency curve
    [~, cutoff] = knee_pt(features_n_freq(:,4),1:length(features_n_freq));
    pcs_selected = features_n_freq(1:cutoff, 1);
    
    % convert serial index to condition specific index
    inds = pcs_selected > numComps_cond1;
    pcs_selected_cond1 = pcs_selected(pcs_selected <= numComps_cond1);
    pcs_selected_cond2 = pcs_selected(inds)-numComps_cond1;


end