%% SHAM LIGHT
close all
clear 
clc

file1={'5_18_23 M1 RECUT\', '5_18_23 M2 RECUT\', '5_18_23 M3 RECUT\', '5_25_23 M1 RECUT\', '5_26_23 M3 RECUT\', '5_26_23 m1 Gabe\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\';

% initialization 
shamlightRMSValues = cell(length(str), 3); 
shamlightBaselines = zeros(length(str), 1); 

for f=1:length(str)
% for f = 2
    folder = fullfile(MainDirectory,str{f});
    % dir ('folder');
    disp(str{f})
    %Change what is in the string depending on which file\files you want to run
    file_list = dir([folder 'TRIAL*.mat']);
    baseline = dir([folder 'last min baseline 2.mat']); % or baseline 1 or baseline 2 deSHAMding on trials 
    disp(length(baseline)) 

    set_channels=[1 2 3 4 6];
    ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
    trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};
    
%% Channel configuration 
    V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);

%  calculate pre-stim RMS for normalization
    baseline_rms=[];
    disp(baseline.name);
    load([folder baseline.name])
    calc_baseline2;
    shamlightBaselines(f,1) = rms_baseline;
    
% run through trials 
    trialnums = [1 3 4];
    for z=1:3
        % if isequal(file_list(z).name,"Trial 2.mat"), continue, end 
        disp(trialnums(z)) % display the number that the code is on in the terminal, do not put a ';' after it 
        disp(file_list(trialnums(z)).name); % displays the name of the file in the terminal
        load([folder file_list(trialnums(z)).name]); % bringing the file data into matlab so that the code can run
        amplitude_diag_stim; 

        sampleRate = tickrate(1);
        trialDuration = 600; % 10 minutes trial
        numMinutes = trialDuration / 60;

        rmsValues = zeros(numMinutes, 1);
        for minute = 1:numMinutes
            startSample = (minute - 1) * sampleRate + 1;
            endSample = minute * sampleRate;
            % rmsValues(minute) = rms(data(startSample:endSample));
            rmsValues(minute) = rms(alldata.V1Ldata(startSample:endSample));
        end

        % Normalize the RMS values by the baseline median
        normalizedRMS = rmsValues / rms_baseline;

        % Store RMS values for this trial in the cell array
        shamlightRMSValues{f, z} = normalizedRMS;
    end
end 

% Convert cell array to a matrix for easier plotting
% Rows correspond to a mouse's trials 1-3, then next mouse 
shamlightmedianRMS = zeros(length(str)*3, 10); % Assuming 3 trials (Trial 1, Trial 3, and Trial 4)

counter = 0 ;
for f = 1:length(str) 
    for z = 1:3
        trial_rms = shamlightRMSValues{f,z}(:) ;
        shamlightmedianRMS(f+z-1+counter,1:length(trial_rms)) = trial_rms ;
    end 
    counter = counter + 2 ;
end 

%% using the linear mixed-effects model 
% Load the required statistics toolbox if not already loaded
% addpath('path_to_statistics_toolbox');
num_trials = 4 ;
num_animals = length(str) ;
% creating trial_activity; each animal is one row, each column is median of
% median RMS for a given trial 
trial_activity = zeros(num_animals,3) ;
counter = 0 ;
for animal = 1:num_animals 
    trial_activity(animal,:) = [median(shamlightmedianRMS(animal+counter,:)) 
        median(shamlightmedianRMS(animal+counter+1,:)) 
        median(shamlightmedianRMS(animal+counter+2,:))] ;
    counter = counter + 2 ; 
end 

% creating ultrasound_indicator
ultrasound_indicator = zeros(num_animals, 4) ;
for animal = 1:length(str) 
    ultrasound_indicator(animal,:) = [0 0 1 0] ; 
end 

% Convert ultrasound_indicator to categorical for grouping
ultrasound_indicator = reshape(ultrasound_indicator', [], 1);
ultrasound_indicator = categorical(ultrasound_indicator);

% Combine initial_activity (baseline) and trial_activity into one variable
response = [shamlightBaselines trial_activity];
response = reshape(response', [], 1);

% Create a grouping variable for animals and trials
animal_idx = repelem(1:num_animals, num_trials);
animal_idx = categorical(animal_idx)' ;
% animal_idx = repmat((1:length(str))', 1, size(response, 2));
trial_idx = repmat(0:3,1, num_animals);
trial_idx = categorical(trial_idx)' ;

% time 
time_idx = categorical(10*ones(1,length(animal_idx))') ;

% Create a linear mixed-effects model
data = table(animal_idx, trial_idx, time_idx, ultrasound_indicator, response);
formula = 'response ~ ultrasound_indicator + (1|animal_idx) + (1|trial_idx)';
% formula = 'response ~ trial_idx*time_idx*ultrasound_indicator + (1|animal_idx)';
% formula = 'response ~ trial_idx*ultrasound_indicator + (1|animal_idx)';
lmeModel = fitlme(data, formula);

% Display the model summary
disp('Linear Mixed-Effects Model Summary:')
disp(lmeModel);
% 
% % Perform post-hoc tests (e.g., using the 'compare' function)
% comp = compare(lmeModel);
% disp('Post-hoc Comparisons:');
% disp(comp);

%% plotting 

figure(3) 
counter = 0 ;
for i = 1:num_animals 
    plot(1:4, response(counter+i:i+3+counter))
    counter = counter +4;
    hold on 
end 
    ylabel('Normalized RMS Brain Activity','Fontsize', 14) 
    labels = {'Baseline', '1st LO', 'L+tDUS', '2nd LO'};

    % Find the positions of the categorical labels
    labelPositions = find(~cellfun(@isempty, labels));

    % Set the x-tick positions and labels
    xticks(labelPositions);
    xticklabels(labels(labelPositions));

    % Adjust the x-axis limits if needed
    xlim([0, numel(labels)+1]);

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',14)
