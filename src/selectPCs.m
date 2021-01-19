function [pcs_selected_cond1, pcs_selected_cond2, cutoff, features_n_freq] = selectPCs(selectedCols, numIters, numComps_cond1)

    features_n = cat(1, selectedCols.all{:});
    features_n_freq = sortrows(tabulate(features_n), 2, 'descend');
    features_n_freq(:,4) = features_n_freq(:,2)/numIters*100;
    [~, cutoff] = knee_pt(features_n_freq(:,4),1:length(features_n_freq));


   % OLD Criteria: top 20% of the features
   %  pcs_selected = features_n_freq(1:round(length(features_n_freq)*cutoff), 1);

    % Criteria: cut off is the knee point of the frequency curve
    pcs_selected = features_n_freq(1:cutoff, 1);
    
    % convert serial index to condition specific index
    % pcs_selected = sort([colp;coln]);
    inds = pcs_selected > numComps_cond1;
    pcs_selected_cond1 = pcs_selected(pcs_selected <= numComps_cond1); %pcs_selected(1:(min(inds)-1));
    pcs_selected_cond2 = pcs_selected(inds)-numComps_cond1;


end