%%  Authors: Kat Floerchinger, Hannah Mach, Henry Tan
%This code is for the Sham cohort to run through the data and get the
%median values 
close all
clear all
%clears all data so that there are no missasinged values
 
 
file1={'06-30-2020 Mouse Experiment 1/', '06-23-2020 Mouse Experiment 2/', '06-25-2020 Mouse Experiment 1/', '06-24-2020 Mouse Experiment 3/', '06-24-2020 Mouse Experiment 1/', '06-23-2020 Mouse Experiment 1/','05-29-2020 Mouse Experiment 1/'};
str=string(file1);
MainDirectory = '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/';
 
SHAM_MATRIX = zeros(7,3);
figure 
hold on
for f=1:length(str)
    folder = fullfile(MainDirectory,str{f});
    % dir ('folder');
 
    %% 
    %Change what is in the string depending on which file\files you want to run
    file_list = dir([folder 'TRIAL*.mat']);
    baseline = dir([folder 'Baseline.mat']); % or baseline 1 or baseline 2 depending on trials 
    disp(length(baseline)) 
    
    if f==6 || f==7
        set_channels=[1 2 3 4 5]; 
    else
        set_channels=[1 2 3 4 7];
    end
    ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
    trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};
 
    
%% Channel configuration 
    button = 0;
    if f==7
    V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
    button = 7;
    else
    V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
    end
 
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
    
         if isequal(file_list(z).name,"TRIAL 2.mat"), continue, end %for 12-23
 
    %     counter = counter + 1 ; 
        disp(z)%display the number that the code is on in the terminal, do not put a ';' after it 
        disp(file_list(z).name);%displays the name of the file in the terminal
        load([folder file_list(z).name]);%bringing the file data into matlab so that the code can run
        miniUS_Diag_stim;
    end
        
    
        % % to rename trials and skip 2 
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 
    
Sham_1 = for_stats_analysis.Trial_1;
Sham_2 = for_stats_analysis.Trial_2;
Sham_3 = for_stats_analysis.Trial_3;
    
    %%Creating a vector to call on later to plot the medians
    SHAM_FIRST_LIGHT = median(for_stats_analysis.Trial_1);
    SHAM_LIGHT_ULTRASOUND = median(for_stats_analysis.Trial_2);
    SHAM_SECOND_LIGHT = median(for_stats_analysis.Trial_3);
    
    % minus first light median 
    SHAMY = [SHAM_FIRST_LIGHT-SHAM_FIRST_LIGHT, SHAM_LIGHT_ULTRASOUND-SHAM_FIRST_LIGHT, SHAM_SECOND_LIGHT-SHAM_FIRST_LIGHT];
    SHAM_MATRIX(f, :) = [SHAMY] ;
    plot(1:3, SHAMY, 'o-', 'DisplayName','SHAM DATA')
    title('SHAM DATA') 
 
end
 
SHAM_MATRIX
median_GEN;
