function selectedCols = findFeatures_iters(ica_iters, kurt_cutoff)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% for each run, find features with kurtosis >= 1 or <= -1
for kk = 1:length(ica_iters)
    temp = ica_iters{kk};
    [~, colp] = (find(temp >= kurt_cutoff));
    [~, coln] = (find(temp <= -kurt_cutoff));
    selectedCols.pos{kk} = unique(colp);
    selectedCols.neg{kk} = unique(coln);
    selectedCols.all{kk} = unique([colp; coln]);
end

end

