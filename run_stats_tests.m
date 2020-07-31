function [p_kw,tbl,stats, p_anova] = run_stats_tests(data, groups)
[p_kw,tbl,stats] = kruskalwallis(data,groups);
p_anova = anova1(data,groups);
end