function [p_kw,tbl,stats, p_anova] = run_stats_tests(data, groups)
[p_kw,tbl,stats] = kruskalwallis(data,groups);
title('Kruskal-Wallis') 
ylabel('magnitude (mV)')
% [c,m] = multcompare(stats)
% anova analysis 
% p_anova = anova1(data,groups);
% title('ANOVA1') 
% ylabel('magnitude (mV)')
end 