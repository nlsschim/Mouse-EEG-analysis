 %%  Authors: Kat Floerchinger, Hannah Mach, Henry Tan
%This code is for the Sham cohort to run through the data and get the
%median values 
close all
% clear all
% clc

%% reading cohort files 

file1={'2_15_22\','2_24_22\','2_25_22\','06_30_20 MOUSE 1 RECUT\', '06-23-2020 Mouse Experiment 2\', '06-24-2020 Mouse Experiment 1\','05-29-2020 Mouse Experiment\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\';

%% medians or variance 
if penran ~= 1
    button = input("Create SHAM matrix of median values or variance? '1'=medians, '2'=variance: ") ;
    button2 = input("Matrix of L+US and 2nd LO minus medians minus 1st LO medians? '1' = yes, '0' = no: ") ; 
end 
% runnext = input("Run Harry_Plotter2? '1' = yes, '0' = no: ") ; 
% button3 = input("include rms baseline? '1' = yes, '2' = no: ") ; 
% normal = input("Normalize data by median of 1st LO or rms_baseline? '1'=median of 1LO, '2' =rms_baseline: "); 

%% creating SHAM Matrix to store medians or variance 

% SHAM_MATRIX = zeros(7,4);
figure 
hold on
baseline_medians_matrix = [];

%% Reading experiment dates 

for f=1:length(str)
    
    folder = fullfile(MainDirectory,str{f});
    % dir ('folder');

    %% 
    %Change what is in the string deSHAMding on which file\files you want to run
    file_list = dir([folder 'TRIAL*.mat']);
    baseline = dir([folder 'nb.mat']); % or baseline 1 or baseline 2 deSHAMding on trials 
    disp(length(baseline)) 

for i = 1 % channel configuration for each mouse
    if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\05-29-2020 Mouse Experiment\" 
        set_channels=[1 2 3 4 5]; 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_15_22\" 
        set_channels=[1 2 3 4 5]; 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_24_22\" 
        set_channels=[1 2 3 4 5]; 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_25_22\"
        set_channels=[1 2 3 4 5]; 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\06_30_20 MOUSE 1 RECUT\" 
        set_channels=[1 2 3 4 5];
    else 
        set_channels=[1 2 3 4 7];
    end
    ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
    trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};
    
%% Channel configuration 

    if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\5-29 recut 2.0\"
        V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5); 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_24_22\"
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_25_22\" 
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
    else
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
    end
end

%% calculate pre-stim RMS for normalization

    baseline_rms=[];
    disp(baseline.name);
    load([folder baseline.name])
    calc_baseline60sec;

    % create matrix to hold data for statistical testing
    for_stats_new = [];
    for_stats_analysis=[];
    %insert thresholding here

%% running through trials 1-4

for z=1:4
   
    if isequal(file_list(z).name,"Trial 2.mat"), continue, end %for 12-23
    if isequal(file_list(z).name,"Trial 6.mat"), continue, end 
    disp(z)%display the number that the code is on in the terminal, do not put a ';' after it 
    disp(file_list(z).name);%displays the name of the file in the terminal
    load([folder file_list(z).name]);%bringing the file data into matlab so that the code can run
    miniUS_Diag_stim;
        
    if medians_or_variance == 1 
        shammedians.(concat2) = medians.(concat2);
    else 
        shamvariances.(concat2) = variances.(concat2) ; 
    end 
        
end
        
% to rename trials and skip 2 
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 
end

clearvars -except penmedians penvariances medians_or_variance normalize_by_1LOmed ACTUAL_PEN_MATRIX shammedians shamvariances ACUTAL_SHAM_MATRIX runnext normalize_by_1LOvar penran

% if runnext == 1 
    Harry_Plotter2
% end 

