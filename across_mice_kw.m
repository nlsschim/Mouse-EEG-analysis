%% Run kruskall-wallis tests on the data

fields=fieldnames(trial_one_rms); % get the field names of the struct
sum = 0;
% preallocate matrix size
for ii = 1:length(fields)
    sum = sum + length(trial_one_rms.(fields{ii}));
end
trial_one_rms_vector = zeros(1,sum);

trial_one_rms_vector=[trial_one_rms.(fields{1})];
for ii=2:length(fields)
    trial_one_rms_vector = [trial_one_rms_vector trial_one_rms.(fields{ii})];
end

fields=fieldnames(trial_two_rms); % get the field names of the struct


trial_two_rms_vector=[trial_two_rms.(fields{1})];
for ii=2:length(fields)
    trial_two_rms_vector = [trial_two_rms_vector trial_two_rms.(fields{ii})];
end

fields=fieldnames(trial_three_rms); % get the field names of the struct

trial_three_rms_vector=[trial_three_rms.(fields{1})];
for ii=2:length(fields)
    trial_three_rms_vector = [trial_three_rms_vector trial_three_rms.(fields{ii})];
end