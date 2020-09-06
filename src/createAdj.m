function rxnMat = createAdj(model)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% ss = abs(model.S);
% adj = ss' * ss;
rxnNum = length(model.rxns);
rxnMat = nan(rxnNum,rxnNum);

for aa = 1:rxnNum
    %get products of first reaction
    lhs = find(model.S(:,aa) > 0 );    
    for bb = 1:rxnNum
        % get the ractants of second reaction
        rhs = find(model.S(:,bb) < 0 );
        
        %if product of first reaction is reactant of second reaction and 
        %if the cell has not been populated (as 1) before then, then populate it
        
       if(any(ismember(lhs, rhs)))
%             if(isnan(rxnMat(aa,bb)))
                rxnMat(aa, bb) = 1;
%             else
%             rxnMat(aa, bb) = 0;
%             rxnMat(bb, aa) = 0;
%             end
        end          
    end
end
%replace nans with zeros, name the rows and save as csv
rxnMat(isnan(rxnMat))=0;
%rxnTab = array2table(rxnMat, 'RowNames',model.rxns','VariableNames',model.rxns');


end

