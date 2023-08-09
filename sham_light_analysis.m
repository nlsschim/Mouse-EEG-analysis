% %% SHAM LIGHT
close all
clear 
clc
% file1={'5_18_23 M1 RECUT\', '5_18_23 M2 RECUT\', '5_18_23 M3 RECUT\', '5_25_23 M1 RECUT\', '5_25_23 M2 RECUT\', '5_26_23 M2 RECUT\', '5_26_23 M3 RECUT\','5_26_23 m1 Gabe\'};
% str=string(file1);
% MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\';
% % creating SHAM Matrix to store medians or variance
% % shamLight_matrix = zeros(7,4);
% hold on
% baseline_medians_matrix = [];
% SHAMLIGHTmedianRMS = zeros(8, 30);
% % Reading experiment dates
% for f=1:length(str)
%    
%     folder = fullfile(MainDirectory,str{f});
%     % dir ('folder');
%     %Change what is in the string depending on which file\files you want to run
%     file_list = dir([folder 'TRIAL*.mat']);
%     baseline = dir([folder 'last min baseline 1.mat']); % or baseline 1 or baseline 2 deSHAMding on trials
%     disp(length(baseline))
%     set_channels=[1 2 3 4 6];
%     ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
%     trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};
%    
% %% Channel configuration
%     V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
% %  calculate pre-stim RMS for normalization
%     baseline_rms=[];
%     disp(baseline.name);
%     load([folder baseline.name])
%     calc_baseline2;
% % run through trials
%     trialnums = [1 2 4];
%     for z=1:3
%         % if isequal(file_list(z).name,"Trial 2.mat"), continue, end
%         disp(trialnums(z)) % display the number that the code is on in the terminal, do not put a ';' after it
%         disp(file_list(trialnums(z)).name); % displays the name of the file in the terminal
%         load([folder file_list(trialnums(z)).name]); % bringing the file data into matlab so that the code can run
%         amplitude_diag_stim;
%         sampleRate = 20000;
%         trialDuration = 600; % 10 minutes trial
%         numMinutes = trialDuration / 60;
%        
%         rmsValues = zeros(numMinutes, 1);
%         for minute = 1:numMinutes
%             startSample = (minute - 1) * sampleRate + 1;
%             endSample = minute * sampleRate;
%             % rmsValues(minute) = rms(data(startSample:endSample));
%             rmsValues(minute) = rms(alldata.V1Ldata(startSample:endSample));
%         end
%        
%         % Normalize the RMS values by the baseline median
%         normalizedRMS = rmsValues / rms_baseline;
%        
%         % medianRMS((f*3)-3+z,:) = normalizedRMS ;
%         SHAMLIGHTmedianRMS(f,1+(10*z-10):10*z) = normalizedRMS ;
%     end
% end
% figure(1)
% p1 = plot(1:30, SHAMLIGHTmedianRMS(1,:),'LineWidth', 2) ;
% hold on
% p2 = plot(1:30, SHAMLIGHTmedianRMS(2,:),'LineWidth', 2) ;
% hold on
% p3 = plot(1:30, SHAMLIGHTmedianRMS(3,:),'LineWidth', 2) ;
% hold on
% p4 = plot(1:30, SHAMLIGHTmedianRMS(4,:),'LineWidth', 2) ;
% hold on
% p5 = plot(1:30, SHAMLIGHTmedianRMS(5,:),'LineWidth', 2) ;
% hold on
% p6 = plot(1:30, SHAMLIGHTmedianRMS(6,:),'LineWidth', 2) ;
% hold on
% p7 = plot(1:30, SHAMLIGHTmedianRMS(7,:),'LineWidth', 2) ;
% hold on
% p8 = plot(1:30, SHAMLIGHTmedianRMS(8,:),'LineWidth', 2) ;
% legend([p1 p2 p3 p4 p5 p6 p7 p8], {'5/18/23 m1', '5/18/23 m2', '5/18/23 m3', '5/25/23 m1', '5/25/23 m2', '5/26/23 m2', '5/26/23 m3', '5-26-23 m1 Gabe'}, 'location', 'northwest','Fontsize', 12)
% ylabel('Baseline-Normalized RMS Brain Activity','Fontsize', 14)
% title('Median RMS per minute during 2nd LO')
% xlabel('Time (minutes)','Fontsize', 14)
% %arranging data for plotting
% % median_pen = zeros(1,30);
% % median_shamus = zeros(1,30);
% median_shamlight = zeros(1,30);
% for i = 1:30
% %     median_pen(i) = [median(PENmedianRMS(:,i))];
% %     median_shamus(i) = [median(SHAMUSmedianRMS(:,i))];
%     median_shamlight(i) = [median(SHAMLIGHTmedianRMS(:,i))];
% end
% figure(2)
% shamus = plot(1:30, median_shamlight, 'k--','LineWidth', 1.5) ;
% ylabel('Baseline-Normalized RMS Brain Activity','Fontsize', 14)
% title('Median RMS per minute ALL TRIALS')
% xlabel('Time (minutes)','Fontsize', 14)

%% SHAM LIGHT 

% file1={'5_18_23 m1\', '5_18_23 m2\', '5_18_23 m3\', '5_25_23 m1\', '5_25_23 m2\', '5_26_23 m2\', '5_26_23 m3\'};
file1={'5_18_23 M1 RECUT\', '5_18_23 M2 RECUT\', '5_18_23 M3 RECUT\', '5_25_23 M1 RECUT\', '5_25_23 M2 RECUT\', '5_26_23 M2 RECUT\', '5_26_23 M3 RECUT\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\';

% creating SHAM Matrix to store medians or variance 

% shamLight_matrix = zeros(7,4);
figure 
hold on
% shamlightmedianRMS = zeros(7, 12);
shamlightRMSValues = cell(7, 3); 
% Reading experiment dates 

% for f=1:length(str)
for f = 4
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

% run through trials 
    trialnums = [1 3 4];
    for z=1:3
        % if isequal(file_list(z).name,"Trial 2.mat"), continue, end 
        disp(trialnums(z)) % display the number that the code is on in the terminal, do not put a ';' after it 
        disp(file_list(trialnums(z)).name); % displays the name of the file in the terminal
        load([folder file_list(trialnums(z)).name]); % bringing the file data into matlab so that the code can run
        amplitude_diag_stim; 

        % Calculate the number of segments (2.5 minutes each) in the trial
        sampleRate = tickrate(1);
        % Define the segment duration (in seconds)
        segmentDuration = 2.5; % 2.5 minutes
        trialDuration = (length(alldata.V1Ldata) / sampleRate)/60;
        numSegments = floor(trialDuration / segmentDuration);
        numSegments = min(numSegments, 4);
        % Initialize an array to store RMS values for each segment in this trial
        trial_RMS = zeros(1, numSegments);

        % Calculate RMS values for each segment
        for segmentIndex = 1:numSegments
            startSample = (segmentIndex - 1) * sampleRate * segmentDuration + 1;
            endSample = segmentIndex * sampleRate * segmentDuration;
            segment_data = alldata.V1Ldata(startSample:endSample);
            trial_RMS(segmentIndex) = rms(segment_data);
        end

        % Normalize RMS values by baseline median RMS
        trial_RMS = trial_RMS / rms_baseline;

        % Store RMS values for this trial in the cell array
        shamlightRMSValues{f, z} = trial_RMS;
    end
end 

% Convert cell array to a matrix for easier plotting
% Rows correspond to a mouse's trials 1-3, then next mouse 
shamlightmedianRMS = zeros(21, 4); % Assuming 3 trials (Trial 1, Trial 3, and Trial 4)

counter = 0 ;
for f = 1:7 
    for z = 1:3
        trial_rms = shamlightRMSValues{f,z}(:) ;
        shamlightmedianRMS(f+z-1+counter,1:length(trial_rms)) = trial_rms ;
    end 
    counter = counter + 2 ;
end 

% clearvars -except SHAMUSmedianRMS 

shamlight1LO = [shamlightmedianRMS(1,:); shamlightmedianRMS(4,:); shamlightmedianRMS(7,:); shamlightmedianRMS(10,:); shamlightmedianRMS(13,:); shamlightmedianRMS(16,:); shamlightmedianRMS(19,:)] ;
shamlighttDUS = [shamlightmedianRMS(2,:); shamlightmedianRMS(5,:); shamlightmedianRMS(8,:); shamlightmedianRMS(11,:); shamlightmedianRMS(14,:); shamlightmedianRMS(17,:); shamlightmedianRMS(20,:)] ;
shamlight2LO = [shamlightmedianRMS(3,:); shamlightmedianRMS(6,:); shamlightmedianRMS(9,:); shamlightmedianRMS(12,:); shamlightmedianRMS(15,:); shamlightmedianRMS(18,:); shamlightmedianRMS(21,:)] ;
shamlight_all = [shamlight1LO shamlighttDUS shamlight2LO] ; 
median_shamlight = median(shamlight_all) ;
std_shamlight = std(shamlight_all)/sqrt(7);


% clearvars -except PENmedianRMS std_pen median_pen SHAMUSmedianRMS std_shamus median_shamus shamlightmedianRMS std_shamlight median_shamlight

%% MW for last quarter of L+tDUS trial 

% last quarter of tDUS 
lq_pentDUS = pentDUS(:,4) ; lq_pentDUS = lq_pentDUS(lq_pentDUS ~= 0);
lq_shamustDUS = shamustDUS(:,4) ; lq_shamustDUS = lq_shamustDUS(lq_shamustDUS ~= 0);
lq_shamlighttDUS = shamlighttDUS(:,4) ; lq_shamlighttDUS = lq_shamlighttDUS(lq_shamlighttDUS ~= 0);

lq1LO_pentDUS = lq_pentDUS/penmedian1LO ;
lq1LO_shamustDUS = lq_shamustDUS/shamusmedian1LO ;
lq1LO_shamlighttDUS = lq_pentDUS/shamlightmedian1LO ;

MW_lq_psl = ranksum(lq_pentDUS, lq_shamlighttDUS);
MW_lq_ps = ranksum(lq_pentDUS, lq_shamustDUS);
MW_lq_ssl = ranksum(lq_shamustDUS, lq_shamlighttDUS);

MW1LO_lq_psl = ranksum(lq1LO_pentDUS, lq1LO_shamlighttDUS);
MW1LO_lq_ps = ranksum(lq1LO_pentDUS, lq1LO_shamustDUS);
MW1LO_lq_ssl = ranksum(lq1LO_shamustDUS, lq1LO_shamlighttDUS);


% first quarter of 2LO  
fq_pen2LO = pen2LO(:,4) ; fq_pen2LO = fq_pen2LO(fq_pen2LO ~= 0);
fq_shamus2LO = shamus2LO(:,4) ; fq_shamus2LO = fq_shamus2LO(fq_shamus2LO ~= 0);
fq_shamlight2LO = shamlight2LO(:,4) ; fq_shamlight2LO = fq_shamlight2LO(fq_shamlight2LO ~= 0);

fq1LO_pen2LO = fq_pen2LO/penmedian1LO ;
fq1LO_shamus2LO = fq_shamus2LO/shamusmedian1LO ;
fq1LO_shamlight2LO = fq_pen2LO/shamlightmedian1LO ;

MW_fq_psl = ranksum(fq_pen2LO, fq_shamlight2LO);
MW_fq_ps = ranksum(fq_pen2LO, fq_shamus2LO);
MW_fq_ssl = ranksum(fq_shamus2LO, fq_shamlight2LO);

MW1LO_fq_psl = ranksum(fq1LO_pen2LO, fq1LO_shamlight2LO);
MW1LO_fq_ps = ranksum(fq1LO_pen2LO, fq1LO_shamus2LO);
MW1LO_fq_ssl = ranksum(fq1LO_shamus2LO, fq1LO_shamlight2LO);

% lq L+tDUS vs. fq 2nd LO 

MW_fqlq_pen = ranksum(fq_pen2LO, lq_pentDUS);
MW_fqlq_shamus = ranksum(fq_shamus2LO, lq_shamustDUS);
MW_fqlq_shamlight = ranksum(fq_shamlight2LO, lq_shamlighttDUS);

MW1LO_fqlq_pen = ranksum(fq1LO_pen2LO, lq1LO_pentDUS);
MW1LO_fqlq_shamus = ranksum(fq1LO_shamus2LO, lq1LO_shamustDUS);
MW1LO_fqlq_shamlight = ranksum(fq1LO_shamlight2LO, lq1LO_shamlighttDUS);