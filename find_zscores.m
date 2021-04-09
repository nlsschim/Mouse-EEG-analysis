% this is a new comment:
% trying to break everything

function [z_scores,mu,sigma] = find_zscores(matrix, baseline_rms)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
log_matrix=log(matrix);
mu=mean(baseline_rms);
sigma=std(baseline_rms);
z_scores=log_matrix-mu;
z_scores=z_scores/sigma;
%[z_scores,mu,sigma] = zscore(log_matrix);

end

