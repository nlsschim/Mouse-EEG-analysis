%% Authors: Kat Floerchinger, Hannah Mach, Henry Tan
%This code is for the Sham cohort to run through the data and get the
%median values 


%Change folder path to match where you save the files and data
%always need "/" at the end of the folder name, copy adn paste so that no errors are made

% note: trials have been formatted "trial x"; baselines : "baseline x"; 
% trials > 1:4 have been placed in separate folders 
%work 

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/12-23-2019 Mouse Experiment 1/';
% ch 7 as light stim, -2 FOR J 
% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/12-16-2019 Mouse Experiment 1/';
% works if light stim channel is set to 9 instead of 7, -1 for j, 
% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/12-13-2019 Mouse Experiment 1/';
%use ch 5 as light stim, -4 for j
% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/12-24-2019 Mouse Experiment 1/';
% use ch 7 as light stim, runs with us_diag_stim j=2:(length(index_stim)-2),
% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/12-13-2019 Mouse Experiment 1/';
%use ch 5 as light stim, -4 for j
% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/12-27-2019 Mouse Experiment 1/';
% use ch 5 as light stim, -1 for j
% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/12-12-2019 Mouse Experiment 1/';
%use ch 5 as light stim, -3 for j
% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/11-27-2019 Mouse Experiment 1/';
%use ch 5 as light stim, -3 for j 

%% 
file1={'12-23-2019 Mouse Experiment 1/', '12-16-2019 Mouse Experiment 1/', '12-13-2019 Mouse Experiment 1/', '12-24-2019 Mouse Experiment 1/', '12-27-2019 Mouse Experiment 1/','12-12-2019 Mouse Experiment 1/', '11-27-2019 Mouse Experiment 1/'};
str=string(file1);
MainDirectory = 'C:/Users/Henry/MATLAB/Mourad Lab/Mouse_EEG/Data/GEN/';

for i=1:length(str)
folder = fullfile(MainDirectory,str{i});
% dir ('folder');

%% 
%Change what is in the string depending on which file/files you want to run
file_list = dir([folder 'TRIAL*.mat']);
baseline = dir([folder 'Baseline.mat']); % or baseline 1 or baseline 2 depending on trials 

if i==1 || i== 4
set_channels=[1 2 3 4 7]; % updated so you do not have to change last number (we added code for searching for light). Change ddepending on channel in surgery notes (9?)
% 1set_channels=[1 2 3 4 9]; % for 12/16/19 data, 
% set_channels=[1 2 3 4 5]; % 6/24/21 data, 6/23/21 , 7/1/21, 12/13/19
else
    set_channels=[1 2 3 4 5];
end
if i==2
    set_channels=[1 2 3 4 9];
end
ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};
%plot_cwt=input('Plot CWTs? Y=1 N=2 :'); %CWT will show the frequency breakdown, use 2 if you just want to look at the averages of the EEG
plot_cwt=2;
% time_series = input('time series(3 or 10)?');
% brain_wave = input("'3-100' = 1, low gamma = '2', beta = '3', theta = '4', alpha ='5': ");
%this names the channels based on where they were placed, make sure they match lab chart
V1L=set_channels(3);
S1L=set_channels(4);
S1R=set_channels(2);
V1R=set_channels(1);
lightstim=set_channels(5);

% 8/10/21 Mouse 1
% V1L=set_channels(4);
% S1L=set_channels(3);
% S1R=set_channels(2);
% V1R=set_channels(1);
% lightstim=set_channels(5);

%this is important since its how the other code will find the channels.
%EverythinG is coded by name so it is not hard coded in 
%';' prevents the line outcome from appearing in the terminal everytime, it just looks bad and is useless 
%create data arrays

%calculate pre-stim RMS for normalization
baseline_rms=[];
disp(baseline.name);
load([folder baseline.name])
calc_baseline;

% create matrix to hold data for statistical testing
for_stats_new = [];
for_stats_analysis=[];
%insert thresholding here



for z=1:4
%      if isequal(file_list(z).name,"TRIAL2.mat"), continue, end % skips trial 2 for refactory period trial does we dont car about (yet)
%      if isequal(file_list(z).name,"Trial 2.mat"), continue, end 
     if isequal(file_list(z).name,"TRIAL 2.mat"), continue, end %for 12-23
     
%      if isequal(file_list(z).name,"TRIAL6.mat"), continue, end % for 6/24 second session 
%      if isequal(file_list(z).name,"TRIAL 10.mat"), continue, end 
%      if isequal(file_list(z).name,"TRIAL 14 mat"), continue, end 
     % data trials are 'Trial 2.mat w/ a space. Some are without a space
     % ex. 'trial1'
%     counter = counter + 1 ; 
    disp(z)%display the number that the code is on in the terminal, do not put a ';' after it 
    disp(file_list(z).name);%displays the name of the file in the terminal
    load([folder file_list(z).name]);%bringing the file data into matlab so that the code can run
%     US_diag_stim;  
%     super_US_diag_stim ;
    miniUS_Diag_stim;
end
end


% % to rename trials and skip 2 
for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 
 




str1=strings(1,length(for_stats_analysis.Trial_1));
for ii=1:length(for_stats_analysis.Trial_1)
    str1(ii)='LIGHT ONLY - FIRST';
end

str2=strings(1,length(for_stats_analysis.Trial_2));
for ii=1:length(for_stats_analysis.Trial_2)
    str2(ii)='LIGHT + ULTRASOUND';
end

str3=strings(1,length(for_stats_analysis.Trial_3));
for ii=1:length(for_stats_analysis.Trial_3)
    str3(ii)='LIGHT ONLY - SECOND';
end


%%Creating a vector to call on later to plot the medians
GEN_FIRST_LIGHT = [for_stats_analysis.Trial_1];
GEN_LIGHT_ULTRASOUND = [for_stats_analysis.Trial_2];
GEN_SECOND_LIGHT = [for_stats_analysis.Trial_3];

median_PEN;
