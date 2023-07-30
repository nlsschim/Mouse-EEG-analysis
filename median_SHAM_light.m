%%  Authors: Kat Floerchinger, Hannah Mach, Henry Tan
%This code is for the PEN cohort to run through the data and get the
% median values ; it calls median_SHAM at the end 
close all

%% reading cohort files 
% file1={'5_18_23 m1\', '5_18_23 m2\', '5_18_23 m3\', '5_25_23 m1\', '5_25_23 m2\', '5_26_23 m2\', '5_26_23 m3\'};
file1={'5_18_23 M1 RECUT\', '5_18_23 M2 RECUT\', '5_18_23 M3 RECUT\', '5_25_23 M1 RECUT\', '5_25_23 M2 RECUT\', '5_26_23 M2 RECUT\', '5_26_23 M3 RECUT\'};
% file1={'5_18_23 M1 RECUT\', '5_25_23 M1 RECUT\', '5_26_23 M3 RECUT\','5_26_23 m1 Gabe\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\';

%% creating SHAM Matrix to store medians or variance 

% shamLight_matrix = zeros(7,4);
figure 
hold on
baseline_medians_matrix = [];
shamLight_matrix = zeros(7,4); %simple median analysis
shamLight_matrix_1LOnormalized = zeros(7,4);

%% Reading experiment dates 

for f=1:length(str)
% for f = 1
    
    folder = fullfile(MainDirectory,str{f});
    % dir ('folder');
    disp(file1(f))
    %Change what is in the string depending on which file\files you want to run
    file_list = dir([folder 'TRIAL*.mat']);
    baseline = dir([folder 'last min baseline 2.mat']); % or baseline 1 or baseline 2 deSHAMding on trials 
    disp(length(baseline)) 

    set_channels=[1 2 3 4 6];
    ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
    trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};
    
%% Channel configuration 

    V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);

%% calculate pre-stim RMS for normalization

    baseline_rms=[];
    disp(baseline.name);
    load([folder baseline.name])
    % calc_baseline60sec;
    calc_baseline2

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
        shamLightmedians.(concat2) = medians.(concat2);
    else 
        shamLightvariances.(concat2) = variances.(concat2) ; 
    end 
        
end
        
% to rename trials and skip 2 
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 
    
    %% Creating a vector to call on later to plot the medians for simple median analysis
    if simple_median_analysis == 1 
        if simple_medians_or_variance == 1 
            SHAML_FIRST_LIGHT = median(for_stats_analysis.Trial_1);
            SHAML_LIGHT_ULTRASOUND = median(for_stats_analysis.Trial_2);
            SHAML_SECOND_LIGHT = median(for_stats_analysis.Trial_3);
        else 
            SHAML_FIRST_LIGHT = var(for_stats_analysis.Trial_1);
            SHAML_LIGHT_ULTRASOUND = var(for_stats_analysis.Trial_2);
            SHAML_SECOND_LIGHT = var(for_stats_analysis.Trial_3);
        end     
        SHAMLY_1LOnormalized = [rms_baseline, SHAML_FIRST_LIGHT-SHAML_FIRST_LIGHT, SHAML_LIGHT_ULTRASOUND-SHAML_FIRST_LIGHT, SHAML_SECOND_LIGHT-SHAML_FIRST_LIGHT];
        % medianL+US and median2LO NOT - median of 1LO
        SHAMLY = [rms_baseline, SHAML_FIRST_LIGHT, SHAML_LIGHT_ULTRASOUND, SHAML_SECOND_LIGHT];
        shamLight_matrix(f, :) = [SHAMLY] ;
        shamLight_matrix_1LOnormalized(f, :) = [SHAMLY_1LOnormalized] ;
    end 
end

penran = 1 ;
if sham_light == 1 
    % for median_SAHM_light 
    clearvars -except former_mat runningrms_or_10sec secs simple_medians_or_variance shrink_matrix simple_median_analysis simple_median_analysis_normalize penran medians_or_variance normalize_by_1LOvar normalize_by_1LOmed penmedians penvariances PEN_MATRIX PEN_MATRIX_1LOnormalized shamLightmedians shamLightvariances shamLight_matrix shamLight_matrix_1LOnormalized sham_light
    median_SHAM
else 
    clearvars -except former_mat runningrms_or_10sec secs shrink_matrix shamLight_matrix_1LOnormalized SHAMLY_1LOnormalized shamLightmedians shamLightvariances ACUTAL_SHAML_MATRIX PEN_MATRIX_1LOnormalized PEN_MATRIX simple_median_analysis penmedians penvariances medians_or_variance normalize_by_1LOmed ACTUAL_PEN_MATRIX runnext normalize_by_1LOvar penran sham_light
end 

