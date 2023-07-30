close all
clear all
clc

%% reading PEN cohort files 
file1={'8_10_21 m1\', '8_10_21 m2\','8_12_21 m1\', '06-23-21 RECUT 2.0 session 1\', '2-28_22 PEN\', '03-02-22 PEN\', '3_03_22 PEN\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\PEN\';

% intialization

baseline_medians_matrix = [];
% Define the number of trials and animals
% numTrials = 3; % Update this value if needed
% numAnimals = 7; % Update this value if needed

% Initialize arrays to store the median RMS values
% medianRMS = zeros(numAnimals, numTrials);
% normalizedRMS = zeros(numAnimals, numTrials);

% PENmedianRMS = zeros(7, 30);

PENmedianRMS = zeros(7, 12);

    % Reading experiment dates 
for f=1:length(str) 
    folder = fullfile(MainDirectory,str{f});
    % dir ('folder');
    disp(str{f})
    %Change what is in the string depending on which file\files you want to run
    file_list = dir([folder 'TRIAL*.mat']);
    baseline = dir([folder 'nb.mat']); 

    set_channels=[1 2 3 4 5]; 
    ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; 
    trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};

    % channel configuration 
    for i = 1 % to hide 
    if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\PEN\06-23-21 RECUT 2.0 session 1\"
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\PEN\06-24-21 RECUT session 2 m2\" 
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\PEN\8_10_21 m1\" 
        V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\PEN\8_10_21 m2\"
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\PEN\8_12_21 m1\" 
        V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\PEN\8_12_21 m2\"
        V1L=set_channels(3);S1L=set_channels(1);S1R=set_channels(2);V1R=set_channels(4);lightstim=set_channels(5);
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\PEN\8_13_21\"
        V1L=set_channels(1);S1L=set_channels(4);S1R=set_channels(3);V1R=set_channels(2);lightstim=set_channels(5);
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\PEN\2-28_22 PEN\"
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
    elseif folder =="C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\PEN\03-02-22 PEN\" 
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\PEN\3_03_22 PEN\"
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
    end  
    end

    % calculate pre-stim RMS for normalization

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

        sampleRate = tickrate(1);
%         sampleRate = 10000;
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

        % medianRMS((f*3)-3+z,:) = normalizedRMS ;
        PENmedianRMS(f,1+(10*z-10):10*z) = normalizedRMS ;

        % segmentDuration = 150; % 2.5 minutes segment
        % numSegments = floor(trialDuration / segmentDuration);
        % 
        % rmsValues = zeros(numSegments, 1);
        % for segment = 1:numSegments
        %     startSample = (segment - 1) * sampleRate * segmentDuration + 1;
        %     endSample = segment * sampleRate * segmentDuration;
        %     rmsValues(segment) = rms(alldata.V1Ldata(startSample:endSample));
        % end
        % 
        % % Normalize the RMS values by the baseline median
        % normalizedRMS = rmsValues / rms_baseline;
        % 
        % PENmedianRMS(f, 1 + (4 * z - 4):4 * z) = normalizedRMS;

    end
end 

PENstd = std(PENmedianRMS)/sqrt(7);
clearvars -except PENmedianRMS PENstd

%% sham US 

file1={'2_15_22\','2_24_22\','2_25_22\','06_30_20 MOUSE 1 RECUT\', '06-23-2020 Mouse Experiment 2\', '06-24-2020 Mouse Experiment 1\','05-29-2020 Mouse Experiment\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\SHAM\';

baseline_medians_matrix = [];
SHAMUSmedianRMS = zeros(7, 30);
% Reading experiment dates 

for f=1:length(str)
    disp(str{f})
    folder = fullfile(MainDirectory,str{f});
    % dir ('folder');

    %Change what is in the string depending on which file\files you want to run
    file_list = dir([folder 'TRIAL*.mat']);
    baseline = dir([folder 'nb.mat']); % or baseline 1 or baseline 2 deSHAMding on trials 
    disp(length(baseline)) 

    for i = 1 % channel configuration for each mouse
    if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\SHAM\05-29-2020 Mouse Experiment\" 
        set_channels=[1 2 3 4 5]; 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\SHAM\2_15_22\" 
        set_channels=[1 2 3 4 5]; 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\SHAM\2_24_22\" 
        set_channels=[1 2 3 4 5]; 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\SHAM\2_25_22\"
        set_channels=[1 2 3 4 5]; 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\SHAM\06_30_20 MOUSE 1 RECUT\" 
        set_channels=[1 2 3 4 5];
    else 
        set_channels=[1 2 3 4 7];
    end
    ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
    trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};
    
%% Channel configuration 

    if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\SHAM\05-29-2020 Mouse Experiment\"
        V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5); 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\SHAM\2_24_22\"
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\old data\SHAM\2_25_22\" 
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
    else
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
    end
    end

% calculate pre-stim RMS for normalization

    baseline_rms=[];
    disp(baseline.name);
    load([folder baseline.name])
    calc_baseline2;

% running through trials 1-4

    % run through trials 
    trialnums = [1 3 4];
    for z=1:3
        % if isequal(file_list(z).name,"Trial 2.mat"), continue, end 
        disp(trialnums(z)) % display the number that the code is on in the terminal, do not put a ';' after it 
        disp(file_list(trialnums(z)).name); % displays the name of the file in the terminal
        load([folder file_list(trialnums(z)).name]); % bringing the file data into matlab so that the code can run
        amplitude_diag_stim; 

        sampleRate = tickrate(1);
%         sampleRate = 10000;
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

        % medianRMS((f*3)-3+z,:) = normalizedRMS ;
        SHAMUSmedianRMS(f,1+(10*z-10):10*z) = normalizedRMS ;

        % segmentDuration = 150; % 2.5 minutes segment
        % numSegments = trialDuration / segmentDuration;
        % 
        % rmsValues = zeros(numSegments, 1);
        % for segment = 1:numSegments
        %     startSample = (segment - 1) * sampleRate + 1;
        %     endSample = segment * sampleRate;
        %     rmsValues(segment) = rms(alldata.V1Ldata(startSample:endSample));
        % end

        % Normalize the RMS values by the baseline median
        % normalizedRMS = rmsValues / rms_baseline;
        % 
        % SHAMUSmedianRMS(f, 1 + (4 * z - 4):4 * z) = normalizedRMS;
    end
end 
SHAMUSstd = std(SHAMUSmedianRMS)/sqrt(7);
clearvars -except PENmedianRMS PENstd SHAMUSmedianRMS SHAMUSstd 

%% SHAM LIGHT 

% file1={'5_18_23 m1\', '5_18_23 m2\', '5_18_23 m3\', '5_25_23 m1\', '5_25_23 m2\', '5_26_23 m2\', '5_26_23 m3\'};
file1={'5_18_23 M1 RECUT\', '5_18_23 M2 RECUT\', '5_18_23 M3 RECUT\', '5_25_23 M1 RECUT\', '5_25_23 M2 RECUT\', '5_26_23 M2 RECUT\', '5_26_23 M3 RECUT\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\';

% creating SHAM Matrix to store medians or variance 

% shamLight_matrix = zeros(7,4);
figure 
hold on
baseline_medians_matrix = [];
SHAMLIGHTmedianRMS = zeros(7, 30);
% Reading experiment dates 

for f=1:length(str)
    
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

        sampleRate = tickrate(1);
%         sampleRate = 10000;
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

        % medianRMS((f*3)-3+z,:) = normalizedRMS ;
        SHAMLIGHTmedianRMS(f,1+(10*z-10):10*z) = normalizedRMS ;

        % segmentDuration = 150; % 2.5 minutes segment
        % numSegments = trialDuration / segmentDuration;
        % 
        % rmsValues = zeros(numSegments, 1);
        % for segment = 1:numSegments
        %     startSample = (segment - 1) * sampleRate + 1;
        %     endSample = segment * sampleRate;
        %     rmsValues(segment) = rms(alldata.V1Ldata(startSample:endSample));
        % end
        % 
        % % Normalize the RMS values by the baseline median
        % normalizedRMS = rmsValues / rms_baseline;
        % 
        % SHAMLIGHTmedianRMS(f, 1 + (4 * z - 4):4 * z) = normalizedRMS;
    end
end 
SHAMLIGHTstd = std(SHAMLIGHTmedianRMS)/sqrt(7);
clearvars -except PENmedianRMS PENstd SHAMUSmedianRMS SHAMUSstd SHAMLIGHTmedianRMS SHAMLIGHTstd

%% plotting

% arranging data for plotting 
median_pen = zeros(1,30);
median_shamus = zeros(1,30);
median_shamlight = zeros(1,30);
for i = 1:30 
    median_pen(i) = [median(PENmedianRMS(:,i))]; 
    median_shamus(i) = [median(SHAMUSmedianRMS(:,i))]; 
    median_shamlight(i) = [median(SHAMLIGHTmedianRMS(:,i))]; 
end 
% 
% % full 3 trials 
% figure(1) 
% pen = plot(1:30, median_pen, 'k-','LineWidth', 1.5) ; 
% hold on
% shamus = plot(1:30, median_shamus, 'k--','LineWidth', 1.5) ; 
% hold on 
% shamlight = plot(1:30, median_shamlight, 'k:','LineWidth', 3) ; 
% legend([pen shamus shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
% ylabel('Baseline-Normalized RMS Brain Activity','Fontsize', 14) 
% title('Median RMS per minute ALL TRIALS')
% xlabel('Time (minutes)')

% 1st LO 
figure(1) 
pen = plot(1:10, median_pen(1:10), 'k-','LineWidth', 1.5) ; 
hold on
shamus = plot(1:10, median_shamus(1:10), 'k--','LineWidth', 1.5) ; 
hold on 
shamlight = plot(1:10, median_shamlight(1:10), 'k:','LineWidth', 3) ; 
legend([pen shamus shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
ylabel('Baseline-Normalized RMS Brain Activity','Fontsize', 14) 
title('Median RMS per minute 1st LO')
xlabel('Time (minutes)')


figure(2) 
pen = plot(1:10, median_pen(11:20), 'k-','LineWidth', 1.5) ; 
hold on
shamus = plot(1:10, median_shamus(11:20), 'k--','LineWidth', 1.5) ; 
hold on 
shamlight = plot(1:10, median_shamlight(11:20), 'k:','LineWidth', 3) ; 
legend([pen shamus shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
ylabel('Baseline-Normalized RMS Brain Activity','Fontsize', 14) 
title('Median RMS per minute during L+tDUS')
xlabel('Time (minutes)')

figure(3) 
pen = plot(1:10, median_pen(21:30), 'k-','LineWidth', 1.5) ; 
hold on
shamus = plot(1:10, median_shamus(21:30), 'k--','LineWidth', 1.5) ; 
hold on 
shamlight = plot(1:10, median_shamlight(21:30), 'k:','LineWidth', 3) ; 
legend([pen shamus shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
ylabel('Baseline-Normalized RMS Brain Activity','Fontsize', 14) 
title('Median RMS per minute during 2nd LO')
xlabel('Time (minutes)')

% median1LO

% penmedian1LO = median(median_pen(1:10));
% shamusmedian1LO = median(median_shamus(1:10));
% shamlightmedian1LO = median(median_shamlight(1:10));

penmedian1LO = median(median_pen(1:4));
shamusmedian1LO = median(median_shamus(1:4));
shamlightmedian1LO = median(median_shamlight(1:4));

median_pen1LO = median_pen / penmedian1LO;
median_shamus1LO = median_shamus / shamusmedian1LO;
median_shamlight1LO = median_shamlight / shamlightmedian1LO;

% full 3 trials 
figure(4) 
pen = plot(1:30, median_pen1LO, 'k-','LineWidth', 1.5) ; 
hold on
shamus = plot(1:30, median_shamus1LO, 'k--','LineWidth', 1.5) ; 
hold on 
shamlight = plot(1:30, median_shamlight1LO, 'k:','LineWidth', 3) ; 
legend([pen shamus shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
ylabel('Median 1st LO-Normalized RMS Brain Activity','Fontsize', 14) 
title('Median RMS per minute ALL TRIALS')
xlabel('Time (minutes)')

figure(5) 
pen = plot(1:10, median_pen1LO(11:20), 'k-','LineWidth', 1.5) ; 
hold on
shamus = plot(1:10, median_shamus1LO(11:20), 'k--','LineWidth', 1.5) ; 
hold on 
shamlight = plot(1:10, median_shamlight1LO(11:20), 'k:','LineWidth', 3) ; 
legend([pen shamus shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
ylabel('Median 1st LO-Normalized RMS Brain Activity','Fontsize', 14) 
title('Median RMS per minute during L+tDUS')
xlabel('Time (minutes)')

figure(6) 
pen = plot(1:10, median_pen1LO(21:30), 'k-','LineWidth', 1.5) ; 
hold on
shamus = plot(1:10, median_shamus1LO(21:30), 'k--','LineWidth', 1.5) ; 
hold on 
shamlight = plot(1:10, median_shamlight1LO(21:30), 'k:','LineWidth', 3) ; 
legend([pen shamus shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
ylabel('Median 1st LO-Normalized RMS Brain Activity','Fontsize', 14) 
title('Median RMS per minute during 2nd LO')
xlabel('Time (minutes)')

% figure(1)
% std_pen = errorbar(1:30, median_pen, PENstd,'k-','LineWidth', 1.5);
% hold on
% scatter_pen = scatter(1:30, median_pen, 500, 'k.');
% hold on
% std_shamus = errorbar(1:30, median_shamus, SHAMUSstd,'k--','LineWidth', 1.5);
% hold on
% scatter_shamus = scatter(1:30, median_shamlight, 500, 'k.');
% hold on
% std_shamlight = errorbar(1:30, median_shamlight, SHAMLIGHTstd,'k:','LineWidth', 1.5);
% hold on
% scatter_shamlight = scatter(1:30, median_shamlight, 500, 'k.');
% legend([std_pen std_shamus std_shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
% ylabel('Baseline-Normalized RMS Brain Activity','Fontsize', 14)
% title('ALL TRIALS','Fontsize', 14)
% 
% % 1st LO
% figure(2)
% std_pen = errorbar(1:10, median_pen(1:10), PENstd(1:10),'k-','LineWidth', 1.5);
% hold on
% scatter(1:10, median_pen(1:10), 500, 'k.');
% hold on
% std_shamus = errorbar(1:10, median_shamus(1:10), SHAMUSstd(1:10),'k--','LineWidth', 1.5);
% hold on
% scatter(1:10, median_shamlight(1:10), 500, 'k.');
% hold on
% std_shamlight = errorbar(1:10, median_shamlight(1:10), SHAMLIGHTstd(1:10),'k:','LineWidth', 1.5);
% hold on
% scatter(1:10, median_shamlight(1:10), 500, 'k.');
% legend([std_pen std_shamus std_shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
% ylabel('Baseline-Normalized RMS Brain Activity','Fontsize', 14)
% title('1st LO','Fontsize', 14)
% 
% % L+tDUS
% figure(3)
% std_pen = errorbar(1:10, median_pen(11:20), PENstd(11:20),'k-','LineWidth', 1.5);
% hold on
% scatter(1:10, median_pen(11:20), 500, 'k.');
% hold on
% std_shamus = errorbar(1:10, median_shamus(11:20), SHAMUSstd(11:20),'k--','LineWidth', 1.5);
% hold on
% scatter(1:10, median_shamlight(11:20), 500, 'k.');
% hold on
% std_shamlight = errorbar(1:10, median_shamlight(11:20), SHAMLIGHTstd(11:20),'k:','LineWidth', 1.5);
% hold on
% scatter(1:10, median_shamlight(11:20), 500, 'k.');
% legend([std_pen std_shamus std_shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
% ylabel('Baseline-Normalized RMS Brain Activity','Fontsize', 14)
% title('L+tDUS','Fontsize', 14)
% 
% % 2nd LO
% figure(4)
% std_pen = errorbar(1:10, median_pen(21:30), PENstd(21:30),'k-','LineWidth', 1.5);
% hold on
% scatter_pen = scatter(1:10, median_pen(21:30), 500, 'k.');
% hold on
% std_shamus = errorbar(1:10, median_shamus(21:30), SHAMUSstd(21:30),'k--','LineWidth', 1.5);
% hold on
% scatter_shamus = scatter(1:10, median_shamlight(21:30), 500, 'k.');
% hold on
% std_shamlight = errorbar(1:10, median_shamlight(21:30), SHAMLIGHTstd(21:30),'k:','LineWidth', 1.5);
% hold on
% scatter_shamlight = scatter(1:10, median_shamlight(21:30), 500, 'k.');
% legend([std_pen std_shamus std_shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
% ylabel('Baseline-Normalized RMS Brain Activity','Fontsize', 14)
% title('2nd LO','Fontsize', 14)
% 
% % median1LO
% penmedian1LO = median(median_pen(1:10));
% shamusmedian1LO = median(median_shamus(1:10));
% shamlightmedian1LO = median(median_shamlight(1:10));
% median_pen1LO = median_pen / penmedian1LO;
% median_shamus1LO = median_shamus / shamusmedian1LO;
% median_shamlight1LO = median_shamlight / shamlightmedian1LO;
% 
% % all 3 trials
% figure(5)
% std_pen = errorbar(1:30, median_pen1LO, PENstd,'k-','LineWidth', 1.5);
% hold on
% scatter_pen = scatter(1:30, median_pen1LO, 500, 'k.');
% hold on
% std_shamus = errorbar(1:30, median_shamus1LO, SHAMUSstd,'k--','LineWidth', 1.5);
% hold on
% scatter_shamus = scatter(1:30, median_shamlight1LO, 500, 'k.');
% hold on
% std_shamlight = errorbar(1:30, median_shamlight1LO, SHAMLIGHTstd,'k:','LineWidth', 1.5);
% hold on
% scatter_shamlight = scatter(1:30, median_shamlight1LO, 500, 'k.');
% legend([std_pen std_shamus std_shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
% ylabel('1st LO-Normalized RMS Brain Activity','Fontsize', 14)
% title('ALL TRIALS','Fontsize', 14)
% 
% % 1st LO
% figure(6)
% std_pen = errorbar(1:10, median_pen1LO(1:10), PENstd(1:10),'k-','LineWidth', 1.5);
% hold on
% scatter(1:10, median_pen(1:10), 500, 'k.');
% hold on
% std_shamus = errorbar(1:10, median_shamus1LO(1:10), SHAMUSstd(1:10),'k--','LineWidth', 1.5);
% hold on
% scatter(1:10, median_shamlight1LO(1:10), 500, 'k.');
% hold on
% std_shamlight = errorbar(1:10, median_shamlight1LO(1:10), SHAMLIGHTstd(1:10),'k:','LineWidth', 1.5);
% hold on
% scatter(1:10, median_shamlight1LO(1:10), 500, 'k.');
% legend([std_pen std_shamus std_shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
% ylabel('1st LO-Normalized RMS Brain Activity','Fontsize', 14)
% title('1st LO','Fontsize', 14)
% 
% % L+tDUS
% figure(7)
% std_pen = errorbar(1:10, median_pen1LO(11:20), PENstd(11:20),'k-','LineWidth', 1.5);
% hold on
% scatter(1:10, median_pen1LO(11:20), 500, 'k.');
% hold on
% std_shamus = errorbar(1:10, median_shamus1LO(11:20), SHAMUSstd(11:20),'k--','LineWidth', 1.5);
% hold on
% scatter(1:10, median_shamlight1LO(11:20), 500, 'k.');
% hold on
% std_shamlight = errorbar(1:10, median_shamlight1LO(11:20), SHAMLIGHTstd(11:20),'k:','LineWidth', 1.5);
% hold on
% scatter(1:10, median_shamlight1LO(11:20), 500, 'k.');
% legend([std_pen std_shamus std_shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
% ylabel('1st LO-Normalized RMS Brain Activity','Fontsize', 14)
% title('L+tDUS','Fontsize', 14)
% 
% % 2nd LO
% figure(8)
% std_pen = errorbar(1:10, median_pen1LO(21:30), PENstd(21:30),'k-','LineWidth', 1.5);
% hold on
% scatter_pen = scatter(1:10, median_pen1LO(21:30), 500, 'k.');
% hold on
% std_shamus = errorbar(1:10, median_shamus1LO(21:30), SHAMUSstd(21:30),'k--','LineWidth', 1.5);
% hold on
% scatter_shamus = scatter(1:10, median_shamlight1LO(21:30), 500, 'k.');
% hold on
% std_shamlight = errorbar(1:10, median_shamlight1LO(21:30), SHAMLIGHTstd(21:30),'k:','LineWidth', 1.5);
% hold on
% scatter_shamlight = scatter(1:10, median_shamlight1LO(21:30), 500, 'k.');
% legend([std_pen std_shamus std_shamlight], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
% ylabel('1st LO-Normalized RMS Brain Activity','Fontsize', 14)
% title('2nd LO','Fontsize', 14)