function [pcs_selected_cond1, pcs_selected_cond2] = selectPCs(selectedCols, cutoff, numIters, numComps_cond1)

    features_n = cat(1, selectedCols.all{:});
    features_n_freq = sortrows(tabulate(features_n), 2, 'descend');
    features_n_freq(:,4) = features_n_freq(:,2)/numIters*100;
%     plot(features_n_freq(:,4), 'black','LineWidth',2)
%     xlim([-10 1040])
%     ylim([-5 100])
%     set(gca, 'FontSize', 18, 'FontWeight','bold')
%     xlabel("Index of features")
%     ylabel("Frequency of estimation (%)")
%     axis square

    % Criteria: top 20% of the features
    pcs_selected = features_n_freq(1:round(length(features_n_freq)*cutoff), 1);
    
    % convert serial index to condition specific index
    % pcs_selected = sort([colp;coln]);
    inds = pcs_selected > numComps_cond1;
    pcs_selected_cond1 = pcs_selected(pcs_selected < numComps_cond1); %pcs_selected(1:(min(inds)-1));
    pcs_selected_cond2 = pcs_selected(inds)-numComps_cond1;


end