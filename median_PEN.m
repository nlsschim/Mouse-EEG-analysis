%%  Authors: Kat Floerchinger, Hannah Mach, Henry Tan
%This code is for the Sham cohort to run through the data and get the
%median values 

clc
clear all 
close all 

%% reading cohort files 

file1={'06-24-21 RECUT session 2\', '8_10_21 m1\', '8_10_21 m2 session 1\', '06-23-21 RECUT 2.0 session 1\','8_12_21 m1\','8_12_21 m2\', '8_13_21\' };
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\';

%% medians or variance 

button = input("Create SHAM matrix of median values or variance? '1'=medians? '2'=variance: ") ;
button2 = input("Matrix of L+US and 2nd LO minus medians minus 1st LO medians? '1' = yes, '2' = no: ") ; 

%% creating PEN Matrix to store medians or variance 

PEN_MATRIX = zeros(7,4);
figure 
hold on

%% Reading experiment dates 

for f=1:length(str)
folder = fullfile(MainDirectory,str{f});
% dir ('folder');


%Change what is in the string depending on which file\files you want to run
file_list = dir([folder 'TRIAL*.mat']);
baseline = dir([folder 'Baseline.mat']); % or baseline 1 or baseline 2 depending on trials 

set_channels=[1 2 3 4 5]; 
ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; 
trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};

%% channel configuration 

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\06-23-21 RECUT 2.0 session 1\"
V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\06-24-21 RECUT session 2\" 
V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_10_21 m1\" 
V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end 

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_10_21 m2 session 1\"
V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end 

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_12_21 m1\" 
V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
end

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_12_21 m2\"
V1L=set_channels(3);S1L=set_channels(1);S1R=set_channels(2);V1R=set_channels(4);lightstim=set_channels(5);
end

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_13_21\"
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

     if isequal(file_list(z).name,"Trial 2.mat"), continue, end %for 12-23
     if isequal(file_list(z).name,"Trial 6.mat"), continue, end %for 12-23
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

%% Creating a vector to call on later to plot the medians
if button ==1 
    PEN_FIRST_LIGHT = median(for_stats_analysis.Trial_1);
    PEN_LIGHT_ULTRASOUND = median(for_stats_analysis.Trial_2);
    PEN_SECOND_LIGHT = median(for_stats_analysis.Trial_3);
end
% variance 
if button == 2 
    PEN_FIRST_LIGHT = var(for_stats_analysis.Trial_1);
    PEN_LIGHT_ULTRASOUND = var(for_stats_analysis.Trial_2);
    PEN_SECOND_LIGHT = var(for_stats_analysis.Trial_3);
end 

if button2 == 1 
    % minus first light median/variance
    PENY = [rms_baseline, PEN_FIRST_LIGHT-PEN_FIRST_LIGHT, PEN_LIGHT_ULTRASOUND-PEN_FIRST_LIGHT, PEN_SECOND_LIGHT-PEN_FIRST_LIGHT];
else
    % medianL+US and median2LO NOT - median of 1LO
    PENY = [rms_baseline, PEN_FIRST_LIGHT, PEN_LIGHT_ULTRASOUND, PEN_SECOND_LIGHT];
end

%% filling matrix 
    
    PEN_MATRIX(f, :) = [PENY] ;
    plot(1:4, PENY, 'o-', 'DisplayName','PEN DATA')
    title('PEN DATA') 
end

PEN_MATRIX 