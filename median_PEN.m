%%  Authors: Kat Floerchinger, Hannah Mach, Henry Tan
%This code is for the Sham cohort to run through the data and get the
%median values 

%% NOTES
% need to update more trial dates

%Change folder path to match where you save the files and data
%always need "/" at the end of the folder name, copy adn paste so that no errors are made

% note: trials have been formatted "trial x"; baselines : "baseline x"; 
% trials > 1:4 have been placed in separate folders 
%work 

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/06-24-2021 Mouse Experiment 1 (Session 2)/';
% works with channel 5 as light stim, baseline 2, -2 for j

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/08-10-2021 Mouse Experiment 1 /';
%use ch 5 as light stim, -1 for j

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/08-10-2021 Mouse Experiment 2 (Session 1)/';
%use ch 5 as light stim, -1 for j

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/08-10-2021 Mouse Experiment 2 (Session 2)/';
%use ch 5 as light stim, -1 for j

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/06-23-2021 Mouse Expirement 1/';
%works with channel 5 as light stim, -1 for j

%% 
file1={'06-24-21 RECUT session 2/', '8-10-21 m1/', '8-10-21 m2 session 1/', '8-10-21 m2 session 2/', '06-23-21 RECUT 2.0 session 1/'};
str=string(file1);
MainDirectory = 'C:/Users/Henry/MATLAB/Mourad Lab/Mouse_EEG/Data/PEN/';

for i=1:length(str)
folder = fullfile(MainDirectory,str{i});
% dir ('folder');

%% 
%Change what is in the string depending on which file/files you want to run
file_list = dir([folder 'TRIAL*.mat']);
baseline = dir([folder 'Baseline.mat']); % or baseline 1 or baseline 2 depending on trials 


% set_channels=[1 2 3 4 7]; % updated so you do not have to change last number (we added code for searching for light). Change ddepending on channel in surgery notes (9?)
% 1set_channels=[1 2 3 4 9]; % for 12/16/19 data, 
set_channels=[1 2 3 4 5]; % 6/24/21 data, 6/23/21 , 7/1/21, 12/13/19

ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};
%plot_cwt=input('Plot CWTs? Y=1 N=2 :'); %CWT will show the frequency breakdown, use 2 if you just want to look at the averages of the EEG
plot_cwt=2;
% time_series = input('time series(3 or 10)?');
% brain_wave = input("'3-100' = 1, low gamma = '2', beta = '3', theta = '4', alpha ='5': ");
%this names the channels based on where they were placed, make sure they match lab chart
% V1L=set_channels(3);
% S1L=set_channels(4);
% S1R=set_channels(2);
% V1R=set_channels(1);
% lightstim=set_channels(5);
if i==2
% 8/10/21 Mouse 1
V1L=set_channels(4);
S1L=set_channels(3);
S1R=set_channels(2);
V1R=set_channels(1);
lightstim=set_channels(5);
else
    V1L=set_channels(3);
S1L=set_channels(4);
S1R=set_channels(2);
V1R=set_channels(1);
lightstim=set_channels(5);
end
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
% % to rename trials and skip 2 
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 

    %%Creating a vector to call on later to plot the medians
    PEN_FIRST_LIGHT = median(for_stats_analysis.Trial_1);
    PEN_LIGHT_ULTRASOUND = median(for_stats_analysis.Trial_2);
    PEN_SECOND_LIGHT = median(for_stats_analysis.Trial_3);
    
    PENY = [PEN_FIRST_LIGHT-PEN_FIRST_LIGHT, PEN_LIGHT_ULTRASOUND-PEN_FIRST_LIGHT, PEN_SECOND_LIGHT-PEN_FIRST_LIGHT];
    plot(1:3, PENY, 'o-', 'DisplayName','PEN DATA')
end

