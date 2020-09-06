function [ica_iters, end_time] = ICA_iters(pcs_all, optN, numIters)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


nn = 1:numIters;
tic;
for uu = 1:length(nn)
    
    % ICA with fixed random variable
    rng(uu);
    ica_iters{uu} = fastICA(pcs_all, optN);

end
end_time=toc;

end

