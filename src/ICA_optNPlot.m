
figure
mat = dir('R*.mat'); 
for q = 1:length(mat) 
    cont = load(mat(q).name);
    numComps(q) = str2double(extractBetween(mat(q).name, 'nComps_', '.mat'));
    score{q,:} = plot_Iq(cont.sR,numComps(q));
    plot(1:numComps(q),score{q},'Color',[0.5 0.5 0.5]);
    hold on
end
[~, ids] = sort(numComps, 'ascend');
score_sorted = score(ids);
nums = numComps;
[MSTDT, line1, line2, mx] = findNumFeatures(score_sorted);
% figure; 
plot([0 max(nums)],[line1(1) line1(1)+max(nums)*line1(2)],'r--','LineWidth',3); hold on;
plot([0 mx],[line2(1) line2(1)+mx*line2(2)],'b--','LineWidth',3);
xline(MSTDT,'--','LineWidth',1)
xlabel('Component rank'); ylabel('Component stability'); set(gca,'FontSize',16);
ylim([0 1]);
text(max(nums)*0.7, 0.9,sprintf('Optimal N =%i',MSTDT),'FontSize',20);