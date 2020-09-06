function filtered_data = filterLowLoadingsReactions(rotatedComp)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
transposedData = rotatedComp';
mval = max(abs(transposedData));


% subplot(1,2,1);
% plot(mval, 'o');
cutoff = mad(mval, 1) + median(mval);

keep = mval > cutoff;
filtered_data = transposedData(:, keep)';
% subplot(1,2,2);
% plot(max(abs(filtered_data)),'o');


end

