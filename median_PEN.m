%% Authors: Devon Griggs, John Kucewicz, Nels Schimek
%This code is for the Pen cohort to run through the data and get the
%median values 
 
 
%% 
%Other dates not added:  '08-10-2021 Mouse Experiment 2 (Session 2)/',
file1={'06-24-2021 Mouse Experiment 1 (Session 2)/', '08-10-2021 Mouse Experiment 1 /', '08-10-2021 Mouse Experiment 2 (Session 1)/', '06-23-2021 Mouse Expirement 1/', '08-12-21 Mouse Experiment 1/', '08-12-21 Mouse Experiment 2/', '08-13-21 Mouse Experiment 1/'};
str=string(file1);
MainDirectory = '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/';
PEN_MATRIX = zeros(8,3);
% figure 
% hold on
for f=1:length(str)
folder = fullfile(MainDirectory,str{f});
% dir ('folder');
 
%% 
%Change what is in the string depending on which file\files you want to run
file_list = dir([folder 'TRIAL*.mat']);
baseline = dir([folder 'Baseline.mat']); % or baseline 1 or baseline 2 depending on trials 
 
set_channels=[1 2 3 4 5]; 
ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; 
trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};
 
%% channel configuration 
 
if folder == "/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/06-23-2021 Mouse Expirement 1/"
V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end
 
if folder == "/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/06-24-2021 Mouse Experiment 1 (Session 2)/" 
V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end
 
if folder == "/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/08-10-2021 Mouse Experiment 1 /" 
V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end 
 
if folder == "/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/08-10-2021 Mouse Experiment 2 (Session 1)/"
V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end 
 
if folder == "/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/08-12-21 Mouse Experiment 1/" 
V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
end
 
if folder == "/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/08-12-21 Mouse Experiment 2/"
V1L=set_channels(3);S1L=set_channels(1);S1R=set_channels(2);V1R=set_channels(4);lightstim=set_channels(5);
end
 
if folder == "/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/08-13-21 Mouse Experiment 1/"
V1L=set_channels(1);S1L=set_channels(4);S1R=set_channels(3);V1R=set_channels(2);lightstim=set_channels(5);
end 
 
%% calculate pre-stim RMS for normalization
baseline_rms=[];
disp(baseline.name);
load([folder baseline.name])
calc_baseline;
 
% create matrix to hold data for statistical testing
for_stats_new = [];
for_stats_analysis=[];
%insert thresholding here
 
 
for z=1:4
 
     if isequal(file_list(z).name,"TRIAL 2.mat"), continue, end %for 12-23
%      if isequal(file_list(z).name,"Trial 6.mat"), continue, end %for 12-23
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
    
Pen_1 = for_stats_analysis.Trial_1;
Pen_2 = for_stats_analysis.Trial_2;
Pen_3 = for_stats_analysis.Trial_3;
    %%Creating a vector to call on later to plot the medians
    PEN_FIRST_LIGHT = median(for_stats_analysis.Trial_1);
    PEN_LIGHT_ULTRASOUND = median(for_stats_analysis.Trial_2);
    PEN_SECOND_LIGHT = median(for_stats_analysis.Trial_3);
    
    PENY = [PEN_FIRST_LIGHT-PEN_FIRST_LIGHT, PEN_LIGHT_ULTRASOUND-PEN_FIRST_LIGHT, PEN_SECOND_LIGHT-PEN_FIRST_LIGHT];
    PEN_MATRIX(f, :) = [PENY] ;
%     plot(1:3, PENY, 'o-', 'DisplayName','PEN DATA')
%     title('PEN DATA') 
end
 
PEN_MATRIX 
Harry_Plotter;
