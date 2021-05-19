
% trial 3 may have been used as "trial 2", trial 4 as "3" 

data_1 = for_stats_analysis.Trial_1;
[n,x] = hist(data_1,[]);
[N,edges] = histcounts(data_1,'Normalization','pdf');
edges = edges(2:end)-(edges(2)-edges(1))/2;
length(edges)
length(N)
figure
plot(edges, N)
hold on


data_2 = for_stats_analysis.Trial_2;
[n,x] = hist(data_2,[]);
[N,edges] = histcounts(data_2,'Normalization','pdf');
edges = edges(2:end)-(edges(2)-edges(1))/2;
length(edges)
length(N)
plot(edges, N)

data_3 = for_stats_analysis.Trial_3;
[n,x] = hist(data_3,[]);
[N,edges] = histcounts(data_3,'Normalization','pdf');
edges = edges(2:end)-(edges(2)-edges(1))/2;
length(edges)
length(N)
plot(edges, N)
title('Distribution of RMS values')
xlabel('RMS values')
ylabel('Count')

legend('FIRST LIGHT ONLY', 'LIGHT + US', 'SECOND LIGHT ONLY')
hold off

figure

subplot(1,3,1)
boxplot(data_1)
title('FIRST LIGHT ONLY')
ylabel('RMS')
ylim([0 0.6])

subplot(1,3,2)
boxplot(data_2)
title('LIGHT + US')
ylim([0 0.6])

subplot(1,3,3)
boxplot(data_3)
title('SECOND LIGHT ONLY')
ylim([0 0.6])