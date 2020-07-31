clear all

%% Load directories
path_name = '/Users/nlsschim/Dropbox/Rat ECOG project/Rat-EEG-Analysis-master/';
file_list = dir(path_name);
all_dirs = file_list([file_list.isdir]==1);
trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};


%% Get RMS and Baseline data for individual mice

trial_one_rms = []; % structure for storing data for each mouse experiment
trial_two_rms = [];
trial_three_rms = [];

s1='/';
for z = 3:length(all_dirs) % start at 3 to avoid '.' and '..' dirs
   curr_folder = all_dirs(z).name;
   curr_folder=strcat(path_name,curr_folder,s1);
   curr_file_list = dir([curr_folder 'TRIAL*.mat']);
   baseline=dir([curr_folder 'BASELINE.mat']);
   load([curr_folder baseline.name]);
   ch_names = {'V1L', 'lightstim'};
   set_channels = assign_channel_titles(titles, ch_names);
   V1L=set_channels{1};
   lightstim=set_channels{2};
   calc_baseline; % calculate baseline of individual mouse
   for zz = 1:length(curr_file_list)
       load([curr_folder curr_file_list(zz).name]);
       get_trial_rms;
       s=size(matrix);
       S=s(1)*s(2);
       for_stats=reshape(matrix,1,S);
       conc=['Trial_' num2str(zz)];
       if zz == 1
           trial_one_rms.(all_dirs(z).name)=for_stats;
       elseif zz == 2
           trial_two_rms.(all_dirs(z).name)=for_stats;
       elseif zz ==3
           trial_three_rms.(all_dirs(z).name)=for_stats;
       end
       disp(curr_file_list(zz).name);
   end
   disp(baseline_rms);
   disp(' ');
end

