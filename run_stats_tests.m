  
function [p_kw,tbl,stats, p_anova] = run_stats_tests(data, groups)
% KW for vector input data:
[p_kw,tbl,stats] = kruskalwallis(data,groups,'on'); % (3) can be off
% KW for matrix input data:
% [p_kw,tbl,stats] = kruskalwallis(data);
title('Kruskal-Wallis') 
ylabel('magnitude (mV)')
% for vector input:
p_anova = anova1(data,groups);
% for matrix input: 
% p_anova = anova1(data);
title('ANOVA1') 
ylabel('magnitude (mV)')
end 