%% Authors: Kat Floerchinger, Hannah Mach, Henry Tan
%This code is for the Gen cohort to run through the data and get the
%median values 
 
%% 
file1={'12-23-2019 Mouse Experiment 1/', '12-16-2019 Mouse Experiment 1/', '12-13-2019 Mouse Experiment 1/', '12-24-2019 Mouse Experiment 1/', '12-27-2019 Mouse Experiment 1/','12-12-2019 Mouse Experiment 1/', '11-27-2019 Mouse Experiment 1/'};
str=string(file1);
MainDirectory = '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/';
 
GEN_MATRIX = zeros(7,3);
% figure 
% hold on
for f=1:length(str)
folder = fullfile(MainDirectory,str{f});
% dir ('folder');
 
%% 
%Change what is in the string depending on which file\files you want to run
file_list = dir([folder 'TRIAL*.mat']);
baseline = dir([folder 'Baseline.mat']); % or baseline 1 or baseline 2 depending on trials 
button = 0;
    if f==1 || f== 4 || f==2
        set_channels=[1 2 3 4 7]; % updated so you do not have to change last number (we added code for searching for light). Change ddepending on channel in surgery notes (9?)
        
    else
        set_channels=[1 2 3 4 5];
    end
    if f==2
        set_channels=[1 2 3 4 9];
    end
    ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
    trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};
 
%% channel configuration 
 
V1L=set_channels(1);S1L=set_channels(2);S1R=set_channels(3);V1R=set_channels(4);lightstim=set_channels(5);
 
%% calculate pre-stim RMS for normalization
baseline_rms=[];
disp(baseline.name);
load([folder baseline.name])
calc_baseline;
 
% create matrix to hold data for statistical testing
for_stats_new = [];
for_stats_analysis=[];
 
for z=1:4
     if isequal(file_list(z).name,"TRIAL 2.mat"), continue, end % skips trial 2 for refactory period trial does we dont car about (yet)
 
     % data trials are 'Trial 2.mat w\ a space. Some are without a space
     % ex. 'trial1'
%     counter = counter + 1 ; 
    disp(z)%display the number that the code is on in the terminal, do not put a ';' after it 
    disp(file_list(z).name);%displays the name of the file in the terminal
    load([folder file_list(z).name]);%bringing the file data into matlab so that the code can run
%     US_diag_stim;  
%     super_US_diag_stim ;
    miniUS_Diag_stim;
end
 
%     to rename trials and skip 2 
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 
   
 
%     Creating a vector to call on later to plot the medians
    GEN_FIRST_LIGHT = var(for_stats_analysis.Trial_1);
    GEN_LIGHT_ULTRASOUND = var(for_stats_analysis.Trial_2);
    GEN_SECOND_LIGHT = var(for_stats_analysis.Trial_3);
    
    GENY = [GEN_FIRST_LIGHT-GEN_FIRST_LIGHT, GEN_LIGHT_ULTRASOUND-GEN_FIRST_LIGHT, GEN_SECOND_LIGHT-GEN_FIRST_LIGHT];
    GEN_MATRIX(f, :) = [GENY] ;
%     plot(1:3, GENY, 'o-', 'DisplayName','GEN DATA')
%     title('GEN DATA') 
end
 
GEN_MATRIX 
median_PEN;
