%%  Authors: Kat Floerchinger, Henry Tan
%This code is for the PEN cohort to run through the data and get the
% median values ; it calls median_SHAM at the end 
close all
clear all
clc
%% reading cohort files 
file1={'8_10_21 m1\', '8_10_21 m2\','8_12_21 m1\', '06-23-21 RECUT 2.0 session 1\', '2-28_22 PEN\', '03-02-22 PEN\', '3_03_22 PEN\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\';

%% medians or variance 
runningrms_or_10sec = input("Run 10 second waterfalls or 0.25 second running rms trial?: '1' = 10sec, '0' = runningrms: ") ;
simple_median_analysis = input("Run median analysis with 1 median value per waterfall/trial?: '1' = yes, '0' = no: ") ;
if simple_median_analysis == 1 % default other median calculations 
    shrink_matrix = input("run first x second after stim matrix analysis?: '1' = yes, '0' = no: ") ;
    if shrink_matrix == 1 
        former_mat = input("run former fraction of matrix?: '1' = yes, '0' = no: ") ;
        if former_mat == 1 
            secs = input("run how many seconds of waterfall matrix?: ") ;
        else 
            secs = input("run x-10 seconds of matrix: x=") ; % doesnt work for simple median analysis
        end 
    end 
    simple_medians_or_variance = input("run median or variance analysis?: '1' = medians, '0' = variance: ") ;
    medians_or_variance = 1 ;
    normalize_by_1LOvar = 0 ; 
end 

% more robust median analysis
if simple_median_analysis == 0
    medians_or_variance = input("Create PEN matrix of median values or variance? '1'=medians? '2'=variance: ") ;
    normalize_by_1LOvar = input("Matrix of L+US and 2LO var/medians divided by median 1LO var/medians? '1' = yes, '0' = no: ") ;
    shrink_matrix = input("run first x seconds after stim matrix analysis: '1' = yes, '0' = no: ") ;
    if shrink_matrix == 1 
        former_mat = input("run former fraction of matrix?: '1' = yes, '0' = no: ") ;
        if former_mat == 1
            secs = input("run how many seconds of waterfall matrix?: ") ;
        else 
            secs = input("run latter x-10 seconds of matrix: x=") ;
        end 
    end 
    if medians_or_variance == 2 
        if normallize_by_1LOvar == 0 
            normalize_by_1LOmed = input("Normalize LUS and 2LO by the median median 1LO rms value before variance calc? '1' = yes, '0' = no: ") ; 
        end
    end
end 
% button3 = input("include rms baseline? '1' = yes, '2' = no: ") ; 
% normal = input("Normalize data by median of 1st LO or rms_baseline? '1'=median of 1LO, '2' =rms_baseline: "); 

%% creating PEN Matrix to store medians or variance 

% PEN_MATRIX = zeros(7,4);
% figure 
% hold on
baseline_medians_matrix = [];
medians_1LO = [] ;
medians_LUS = [] ;
medians_2LO = [] ;
PEN_MATRIX = zeros(7,4); %simple median analysis 
PEN_MATRIX_1LOnormalized = zeros(7,4);

%% Reading experiment dates 
for f=1:length(str) 
% for f=4
folder = fullfile(MainDirectory,str{f});
% dir ('folder');

%Change what is in the string depending on which file\files you want to run
file_list = dir([folder 'TRIAL*.mat']);
baseline = dir([folder 'nb.mat']); 

set_channels=[1 2 3 4 5]; 
ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; 
trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};

%% channel configuration 
for i = 1 % to hide 
if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\06-23-21 RECUT 2.0 session 1\"
    V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\06-24-21 RECUT session 2 m2\" 
    V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_10_21 m1\" 
    V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_10_21 m2\"
    V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_12_21 m1\" 
    V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_12_21 m2\"
    V1L=set_channels(3);S1L=set_channels(1);S1R=set_channels(2);V1R=set_channels(4);lightstim=set_channels(5);
elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_13_21\"
    V1L=set_channels(1);S1L=set_channels(4);S1R=set_channels(3);V1R=set_channels(2);lightstim=set_channels(5);
elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\2-28_22 PEN\"
    V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
elseif folder =="C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\03-02-22 PEN\" 
    V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\3_03_22 PEN\"
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
for_stats_analysis =[];

for z=1:4
    if isequal(file_list(z).name,"Trial 2.mat"), continue, end 
    if isequal(file_list(z).name,"Trial 6.mat"), continue, end 
    disp(z)%display the number that the code is on in the terminal, do not put a ';' after it 
    disp(file_list(z).name);%displays the name of the file in the terminal
    load([folder file_list(z).name]);%bringing the file data into matlab so that the code can run
    miniUS_Diag_stim; 
    
    if medians_or_variance == 1 
        penmedians.(concat2) = medians.(concat2);
    else 
        penvariances.(concat2) = variances.(concat2) ; 
    end 
    
end

% to rename trials and skip trial 2 
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 

% first_second_third_vector=[for_stats_analysis.Trial_1 for_stats_analysis.Trial_2 for_stats_analysis.Trial_3];
% % waterfall caxis automation 
% bottom = min(first_second_third_vector, [], 'all') ; 
% top = max(first_second_third_vector, [], 'all'); 
% allAxes = findall(0, 'type','axes') ; 
% set(allAxes, 'clim', [bottom top]) ;

%% Creating a vector to call on later to plot the medians for simple median analysis
    if simple_median_analysis == 1 
        if simple_medians_or_variance == 1 
            PEN_FIRST_LIGHT = median(for_stats_analysis.Trial_1);
            PEN_LIGHT_ULTRASOUND = median(for_stats_analysis.Trial_2);
            PEN_SECOND_LIGHT = median(for_stats_analysis.Trial_3);

            PENY_1LOnormalized = [rms_baseline, PEN_FIRST_LIGHT-PEN_FIRST_LIGHT, PEN_LIGHT_ULTRASOUND-PEN_FIRST_LIGHT, PEN_SECOND_LIGHT-PEN_FIRST_LIGHT];
            PENY = [rms_baseline, PEN_FIRST_LIGHT, PEN_LIGHT_ULTRASOUND, PEN_SECOND_LIGHT];
            PEN_MATRIX(f, :) = [PENY] ;
            PEN_MATRIX_1LOnormalized(f, :) = [PENY_1LOnormalized] ;
        else 
            PEN_FIRST_LIGHT = var(for_stats_analysis.Trial_1);
            PEN_LIGHT_ULTRASOUND = var(for_stats_analysis.Trial_2);
            PEN_SECOND_LIGHT = var(for_stats_analysis.Trial_3);  
        end 
    end 

    
end 

% normalizing LUS and 2LO by 1LO for each mouse 
%     if medians_or_variance == 1 
%         firstLOmedianpen = median(penmedians.Mouse1Trial1) 
%         
%         
%     else 
%         penvariances.(concat2) = variances.(concat2) ; 

penran = 1 ;
% clearvars -except former_mat runningrms_or_10sec secs simple_medians_or_variance shrink_matrix simple_median_analysis simple_median_analysis_normalize penran medians_or_variance normalize_by_1LOvar normalize_by_1LOmed penmedians penvariances ACTUAL_PEN_MATRIX PEN_MATRIX PEN_MATRIX_1LOnormalized 
% median_SHAM
%for running sham light 
clearvars -except former_mat runningrms_or_10sec secs simple_medians_or_variance shrink_matrix simple_median_analysis simple_median_analysis_normalize penran medians_or_variance normalize_by_1LOvar normalize_by_1LOmed penmedians penvariances PEN_MATRIX PEN_MATRIX_1LOnormalized
median_SHAM_light


