function [p_kw,tbl,stats, p_anova] = chamber_of_statistics(data)
[p_kw,tbl,stats] = kruskalwallis(data);
ylabel('magnitude difference from 1st LO (mV)')

% Trying to connect median lines to see the trend better

lines = findobj(gcf, 'type', 'line', 'Tag','Median');
xMed = mean(vertcat(lines.XData),2);
yMed = vertcat(lines.YData);
hold on

plot(xMed, yMed, 'ro-') %this one has a circle to mark median

end 