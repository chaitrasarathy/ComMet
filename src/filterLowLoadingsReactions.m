function filtered_data = filterLowLoadingsReactions(rotatedComp)
% This function filters the low loading reactions

transposedData = rotatedComp';
mval = max(abs(transposedData),[],1);

cutoff = mad(mval, 1) + median(mval);

keep = mval > cutoff;
filtered_data = transposedData(:, keep)';


end

