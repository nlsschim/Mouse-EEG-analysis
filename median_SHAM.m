%%  Authors: Kat Floerchinger, Hannah Mach, Henry Tan
%This code is for the Sham cohort to run through the data and get the
%median values 
close all
clear all
%clears all data so that there are no missasinged values

%Change folder path to match where you save the files and data
%always need "/" at the end of the folder name, copy adn paste so that no errors are made

% note: trials have been formatted "trial x"; baselines : "baseline x"; 
% trials > 1:4 have been placed in separate folders 
%work 

% SHAM 

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/06-30-2020 Mouse Experiment 1/';
% use ch 7 as light stim, use baseline 1 and -1 for j

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/06-23-2020 Mouse Experiment 2/'; 
% use ch 7 as light stim, -1 for j

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/06-25-2020 Mouse Experiment 1/'; 
% use ch 7 as light stim, works with baseline 1 and  for j=2:(length(index_stim)-3) for datastart(lightstim):dataend(lightstim)

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/06-24-2020 Mouse Experiment 3/';
% use ch 7 as light stim, for j=2:(length(index_stim)-1) % 6/24 experiment 3 

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/06-24-2020 Mouse Experiment 1/';
% works w/ j=2:(length(index_stim)-3) % 6/24 experiment 1 in US Diag Stim
% Baseline 1.mat, use ch 7 as light stim,

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/05-29-2020 Mouse Experiment 1/'; 
% index error in char(names(i)) in US diag stim, same as 12/16 data:
% error in US diag stim alldata.lightstimdata=data(datastart(lightstim):dataend(lightstim));
% breaks trial 1
% works if lightstim = 5 in US diagstim datastart(5):dataend(5)
% making sure the skipping refractory names are case sensitive (TRIAL vs.
% Trial. see line 15 of US-Diag stim 
%-1 for j

% folder= '/Users/laurieryan/MATLAB/Mourad Lab/Mouse-EEG-analysis github/Data/06-23-2020 Mouse Experiment 1/' ;
% use ch 5 as light stim, -3 for j


file1={'06-30-2020 Mouse Experiment 1/', '06-23-2020 Mouse Experiment 2/', '06-25-2020 Mouse Experiment 1/', '06-24-2020 Mouse Experiment 3/', '06-24-2020 Mouse Experiment 1/', '06-23-2020 Mouse Experiment 1/','05-29-2020 Mouse Experiment 1/'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM/';

figure 
hold on
for i=1:length(str)
    folder = fullfile(MainDirectory,str{i});
    % dir ('folder');

    %% 
    %Change what is in the string depending on which file/files you want to run
    file_list = dir([folder 'TRIAL*.mat']);
    baseline = dir([folder 'Baseline.mat']); % or baseline 1 or baseline 2 depending on trials 
    disp(length(baseline)) 
    
    if i==6 || i==7
    % set_channels=[1 2 3 4 7]; % updated so you do not have to change last number (we added code for searching for light). Change ddepending on channel in surgery notes (9?)
    % 1set_channels=[1 2 3 4 9]; % for 12/16/19 data, 
    set_channels=[1 2 3 4 5]; % 6/24/21 data, 6/23/21 , 7/1/21, 12/13/19
    else
        set_channels=[1 2 3 4 7];
    end
    ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
    trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};

    %this names the channels based on where they were placed, make sure they match lab chart
    % V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);

    if i==7
    V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
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
        miniUS_Diag_stim;
    end
        
    
%         % % to rename trials and skip 2 
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 

    %%Creating a vector to call on later to plot the medians
    SHAM_FIRST_LIGHT = median(for_stats_analysis.Trial_1);
    SHAM_LIGHT_ULTRASOUND = median(for_stats_analysis.Trial_2);
    SHAM_SECOND_LIGHT = median(for_stats_analysis.Trial_3);
    
    SHAMY = [SHAM_FIRST_LIGHT-SHAM_FIRST_LIGHT, SHAM_LIGHT_ULTRASOUND-SHAM_FIRST_LIGHT, SHAM_SECOND_LIGHT-SHAM_FIRST_LIGHT];
    plot(1:3, SHAMY, 'o-', 'DisplayName','SHAM DATA')

end

