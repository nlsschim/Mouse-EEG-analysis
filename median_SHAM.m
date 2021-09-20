%%  Authors: Kat Floerchinger, Hannah Mach, Henry Tan
%This code is for the Sham cohort to run through the data and get the
%median values 

clc
clear all 
close all 

%% reading cohort files 

file1={'06-30-2020 Mouse Experiment 1\', '06-23-2020 Mouse Experiment 2\', '06-25-2020 Mouse Experiment 1\', '06-24-2020 Mouse Experiment 3\', '06-24-2020 Mouse Experiment 1\', '06-23-20 MOUSE 1 RECUT\','5-29-20 Mouse Experiment\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\';

%% medians or variance 

button = input("Create SHAM matrix of median values or variance? '1'=medians, '2'=variance: ") ;
button2 = input("Matrix of L+US and 2nd LO minus medians minus 1st LO medians? '1' = yes, '2' = no: ") ; 
normalize = input("Normalize data by median of 1st LO or rms_baseline? '1'=median of 1LO, '2' =rms_baseline: "); 

%% creating SHAM Matrix to store medians or variance 

% SHAM_MATRIX = zeros(7,4);
figure 
hold on

%% Reading experiment dates 

for f=1:length(str)
    folder = fullfile(MainDirectory,str{f});
    % dir ('folder');

    %% 
    %Change what is in the string deSHAMding on which file\files you want to run
    file_list = dir([folder 'TRIAL*.mat']);
    baseline = dir([folder 'Baseline.mat']); % or baseline 1 or baseline 2 deSHAMding on trials 
    disp(length(baseline)) 
    
    if f==6 || f==7
        set_channels=[1 2 3 4 5]; 
    else
        set_channels=[1 2 3 4 7];
    end
    ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
    trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};

    
%% Channel configuration 

    if f==7
    V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
    else
    V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
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
    %      if isequal(file_list(z).name,"TRIAL2.mat"), continue, end % skips trial 2 for refactory period trial does we dont car about (yet)
    %      if isequal(file_list(z).name,"Trial 2.mat"), continue, end 
         if isequal(file_list(z).name,"Trial 2.mat"), continue, end %for 12-23

    %     counter = counter + 1 ; 
        disp(z)%display the number that the code is on in the terminal, do not put a ';' after it 
        disp(file_list(z).name);%displays the name of the file in the terminal
        load([folder file_list(z).name]);%bringing the file data into matlab so that the code can run
        miniUS_Diag_stim;
    end
        
    
        % % to rename trials and skip 2 
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 

%% Creating a vector to call on later to plot the medians

if button ==1 
    SHAM_FIRST_LIGHT = median(for_stats_analysis.Trial_1);
    SHAM_LIGHT_ULTRASOUND = median(for_stats_analysis.Trial_2);
    SHAM_SECOND_LIGHT = median(for_stats_analysis.Trial_3);
end
% variance 
if button == 2 
    SHAM_FIRST_LIGHT = var(for_stats_analysis.Trial_1);
    SHAM_LIGHT_ULTRASOUND = var(for_stats_analysis.Trial_2);
    SHAM_SECOND_LIGHT = var(for_stats_analysis.Trial_3);
end 

if button2 == 1 
    % minus first light median/variance
    SHAMY = [rms_baseline, SHAM_FIRST_LIGHT-SHAM_FIRST_LIGHT, SHAM_LIGHT_ULTRASOUND-SHAM_FIRST_LIGHT, SHAM_SECOND_LIGHT-SHAM_FIRST_LIGHT];
else
    % medianL+US and median2LO NOT - median of 1LO
    SHAMY = [rms_baseline, SHAM_FIRST_LIGHT, SHAM_LIGHT_ULTRASOUND, SHAM_SECOND_LIGHT];
end

%% filling matrix 
%     SHAM_MATRIX(f, :) = [SHAMY] ;
%     plot(1:4, SHAMY, 'o-', 'DisplayName','SHAM DATA')
%     title('SHAM DATA') 

%% for plotting each experiment data normalized its median of 1st LO 

if f == 1 
    SHAM_MATRIX{1} = [for_stats_analysis.Trial_1] ;
    SHAM_MATRIX{2} = [for_stats_analysis.Trial_2] ;
    SHAM_MATRIX{3} = [for_stats_analysis.Trial_3] ;
elseif f == 2 
    SHAM_MATRIX{4} = [for_stats_analysis.Trial_1] ;
    SHAM_MATRIX{5} = [for_stats_analysis.Trial_2] ;
    SHAM_MATRIX{6} = [for_stats_analysis.Trial_3] ; 
elseif f == 3 
    SHAM_MATRIX{7} = [for_stats_analysis.Trial_1] ;
    SHAM_MATRIX{8} = [for_stats_analysis.Trial_2] ;
    SHAM_MATRIX{9} = [for_stats_analysis.Trial_3] ;
elseif f == 4 
    SHAM_MATRIX{10} = [for_stats_analysis.Trial_1] ;
    SHAM_MATRIX{11} = [for_stats_analysis.Trial_2] ;
    SHAM_MATRIX{12} = [for_stats_analysis.Trial_3] ;
elseif f == 5 
    SHAM_MATRIX{13} = [for_stats_analysis.Trial_1] ;
    SHAM_MATRIX{14} = [for_stats_analysis.Trial_2] ;
    SHAM_MATRIX{15} = [for_stats_analysis.Trial_3] ;
elseif f == 6
    SHAM_MATRIX{16} = [for_stats_analysis.Trial_1] ;
    SHAM_MATRIX{17} = [for_stats_analysis.Trial_2] ;
    SHAM_MATRIX{18} = [for_stats_analysis.Trial_3] ;
elseif f == 7
    SHAM_MATRIX{19} = [for_stats_analysis.Trial_1] ;
    SHAM_MATRIX{20} = [for_stats_analysis.Trial_2] ;
    SHAM_MATRIX{21} = [for_stats_analysis.Trial_3] ;
end 
end

%                 m1           m2              m3            m4               m5             m6               m7 
SHAM{1} = [SHAM_MATRIX{1}; SHAM_MATRIX{4}; SHAM_MATRIX{7}; SHAM_MATRIX{10}; SHAM_MATRIX{13}; SHAM_MATRIX{16}; SHAM_MATRIX{19}] ; % 1LO 
SHAM{2} = [SHAM_MATRIX{2}; SHAM_MATRIX{5}; SHAM_MATRIX{8}; SHAM_MATRIX{11}; SHAM_MATRIX{14}; SHAM_MATRIX{17}; SHAM_MATRIX{20}] ; % L+US 
SHAM{3} = [SHAM_MATRIX{3}; SHAM_MATRIX{6}; SHAM_MATRIX{9}; SHAM_MATRIX{12}; SHAM_MATRIX{15}; SHAM_MATRIX{18}; SHAM_MATRIX{21}] ; % 2LO 

