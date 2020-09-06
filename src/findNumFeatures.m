function [MSTDT, line1, line2, mx] = findNumFeatures(score_sorted)

count = 1;
total = [0 0];

for i=1:size(score_sorted,1)
    xx = score_sorted{i};

    array(count,1) = size(xx,1);
    array(count,2) = mean(xx);
    array(count,3) = mean(xx(1:min(10,size(xx,1))));
    array(count,4) = mean(xx(1:min(20,size(xx,1))));
    array(count,5) = mean(xx(1:min(30,size(xx,1))));

    x = sort(xx,'descend'); [fo,gdn] = fit([1:size(x,1)]',x,'poly1');
    array(count,6) = fo.p1; 
    array(count,7) = fo.p2;
    array(count,8) = -mean((1-x)./[2:size(x,1)+1]');

    array(count,9) = sum((x-fo.p2-fo.p1*[1:size(x,1)]').^2)/count;
    array(count,9) = sqrt(array(count,9));

    array(count,10) = sum((x-1+array(count,8)*[1:size(x,1)]').^2)/count;
    array(count,10) = sqrt(array(count,10));

    array(count,11) = gdn.adjrsquare;

    count = count+1;

    tot = size(total,1);
    for l=1:size(x,1)
        total(tot+l-1,1) = l;
        total(tot+l-1,2) = x(l);
    end
end
           
[xs, inds] = sort(array(:,1));
averageStability = array(inds,2);
nums = array(inds,1);
slopes = array(inds,6);
intercepts= array(inds,7);
slopes0 = array(inds,8);
residues = array(inds,9);
residues0 = array(inds,10);
goodness = array(inds,11);            
[sminvalues, mstd] = computeMSTDProfile(nums,averageStability);
        nmstd5 = mstd(find(abs(sminvalues-0.5)<0.001));
        nmstd6 = mstd(find(abs(sminvalues-0.6)<0.001));
        nmstd7 = mstd(find(abs(sminvalues-0.7)<0.001));
        nmstd8 = mstd(find(abs(sminvalues-0.8)<0.001));

% if isdeployed|1
% figure('doublebuffer','off','Visible','Off');
% else
% figure;
% end

ttl = [total(:,1)/std(total(:,1)) (total(:,2))/std(total(:,2))];

[line1,line2,inters] = TwoLineClustering(ttl,[mean(ttl(:,1)) 0],[mean(ttl(:,2)) 1000]);
MSTDT = round(inters*std(total(:,1)));
display(sprintf('MSTDT = %f',MSTDT));     

line1(1) = line1(1)*std(total(:,2));
line1(2) = line1(2)*std(total(:,2))/std(total(:,1));
line2(1) = line2(1)*std(total(:,2));
line2(2) = line2(2)*std(total(:,2))/std(total(:,1));

mx = -line2(1)/line2(2);

