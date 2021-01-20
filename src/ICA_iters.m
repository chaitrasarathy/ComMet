function [ica_iters, end_time] = ICA_iters(pcs_all, optN, numIters)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


nn = 1:numIters;
tic;
for uu = 1:length(nn)
    fprintf("Iteration: %d\n", uu);
    % ICA with fixed random variable
    rng(uu, 'twister');
    ica_iters{uu} =  fastica(pcs_all, 'numOfIC', optN, 'g', 'pow3', 'approach', 'symm');
    if any(uu == [0:500:numIters])
        save(['Results_iter_',num2str(uu),'.mat'],'ica_iters');
    end
end_time=toc;

end

