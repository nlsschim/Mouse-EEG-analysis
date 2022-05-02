%%  Authors: Kat Floerchinger, Hannah Mach, Henry Tan
% (1) This code is designed to plot the power of the 9 rms values for the seconds after each light
%   stim event (1-~60) for the SHAM US cohort 
% (2) This code also produces waterfall plots that differ from super_US Diag
%   stim in that magnitude scale is the same for all figures (not sure why)
% (3) more lightstim events are retained, and plotted
% (4) data is subject to more strict hardcoded filtering to omit electrical noise recorded in eCoG -- see line 193 of powerUS_diag_stim 
% additional instructions: event quantification can be ran for multiple
% mice; for power/rms plots, change f to desired mouse index in file1 
 
% close all
% clear all
% clc 

%% reading cohort files 

file1={'2_15_22\','2_24_22\','2_25_22\','06_30_20 MOUSE 1 RECUT\', '06-23-2020 Mouse Experiment 2\', '06-24-2020 Mouse Experiment 1\','05-29-2020 Mouse Experiment\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\';

%% medians or variance 

% button = input("Create SHAM matrix of median values or variance? '1'=medians, '2'=variance: ") ;
% button2 = input("Matrix of L+US and 2nd LO minus medians minus 1st LO medians? '1' = yes, '2' = no: ") ; 
% button3 = input("include rms baseline? '1' = yes, '2' = no: ") ; 
% normal = input("Normalize data by median of 1st LO or rms_baseline? '1'=median of 1LO, '2' =rms_baseline: "); 

%% quantifying ERP: event-related potential/brain response to stim - intialization 
% by cohort 
% eventresponsecounter.MouseXTrialX = [totaleventcount ERPcount responserate] 
    for mousenumber = 1:7 
        for trialnumber = 1:4 % trial 2 will be [0 0 0] (refractory) 
            eventconcat=['Mouse' num2str(mousenumber) 'Trial' num2str(trialnumber)];   
            eventresponsecounter.(eventconcat)= [0 0 0] ;
        end 
    end 
    eventresponsecounter.totalevents = 0;
    eventresponsecounter.totalERP = 0;
    eventresponsecounter.total1LOevents = 0;
    eventresponsecounter.total1LOERP = 0;
    eventresponsecounter.totalLUSevents = 0;
    eventresponsecounter.totalLUSERP = 0;
    eventresponsecounter.total2LOevents = 0;
    eventresponsecounter.total2LOERP = 0;
%% creating SHAM Matrix to store medians or variance 

% SHAM_MATRIX = zeros(7,4);
figure 
hold on

%% Reading experiment dates 

for f=1:length(str)
% for f=7
    folder = fullfile(MainDirectory,str{f});
    % dir ('folder');

    %% 
    %Change what is in the string deSHAMding on which file\files you want to run
    file_list = dir([folder 'TRIAL*.mat']);
    baseline = dir([folder 'nb.mat']); % or baseline 1 or baseline 2 deSHAMding on trials 
    disp(length(baseline)) 
    
    if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\05-29-2020 Mouse Experiment\" 
        set_channels=[1 2 3 4 5]; 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_15_22\" 
        set_channels=[1 2 3 4 5]; 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_24_22\" 
        set_channels=[1 2 3 4 5]; 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_25_22\"
        set_channels=[1 2 3 4 5]; 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\06_30_20 MOUSE 1 RECUT\" 
        set_channels=[1 2 3 4 5];
    else 
        set_channels=[1 2 3 4 7];
    end
    ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
    trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};

    
%% Channel configuration 

    if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\5-29 recut 2.0\"
        V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5); 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_24_22\"
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_25_22\" 
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
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
    
%% running through each trial type for a given mouse

for z=1:4
     if isequal(file_list(z).name,"Trial 2.mat"), continue, end %for 12-23
     if isequal(file_list(z).name,"Trial 6.mat"), continue, end %for 12-23
    disp(z)%display the number that the code is on in the terminal, do not put a ';' after it 
    disp(file_list(z).name);%displays the name of the file in the terminal
    load([folder file_list(z).name]);%bringing the file data into matlab so that the code can run
    ERPcount = 0;
    totaleventcount = 0;  
    % hardcoded filtering before plots that messes up timeseries (best for median analysis?) 
%     powerUS_diag_stim2;
    % no hardcoded filtering that removes data values, just 5-55Hz bandpass
    powerUS_diag_stim;

end

%% to rename trials and skip 2 
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 
    
    % plotting 
    figure(3)
    concat3 = ['Mouse' num2str(f) 'Trial1'];concat4 = ['Mouse' num2str(f) 'Trial3'];concat5 = ['Mouse' num2str(f) 'Trial4'];
    firstlightLUSsecondlight = [eventresponsecounter.(concat3)(1,3) eventresponsecounter.(concat4)(1,3) eventresponsecounter.(concat5)(1,3)];
    SHAMresponse_matrix(f, :) = [firstlightLUSsecondlight] ;
    fileorder = {'one' 'two' 'three' 'four' 'five' 'six' 'seven'};
    sham.(char(fileorder(f)))= [0 0 0];
    sham.(char(fileorder(f)))= plot(1:3, SHAMresponse_matrix(f,:), 'o-') ;
    hold on 
%     
end 

%% display quantification results (mice)

cohortavgresponserate = (eventresponsecounter.totalERP/eventresponsecounter.totalevents)*100 ; 
shamcohortavg1LOresponserate = (eventresponsecounter.total1LOERP/eventresponsecounter.total1LOevents)*100 ; 
shamcohortavgLUSresponserate = (eventresponsecounter.totalLUSERP/eventresponsecounter.totalLUSevents)*100 ; 
shamcohortavg2LOresponserate = (eventresponsecounter.total2LOERP/eventresponsecounter.total2LOevents)*100 ;
   
% message = ['For the mice ran, the average response rate was: ' num2str(cohortavgresponserate) '%' newline 'The average 1st Light Only response rate was: ' num2str(cohortavg1LOresponserate) '%' newline 'The average Light+Ultrasound response rate was: ' num2str(cohortavgLUSresponserate) '%' newline 'The average 2nd Light Only response rate was: ' num2str(cohortavg2LOresponserate) '%' ];
message = ['For the mice ran,' newline 'the average 1st Light Only response rate was: ' num2str(shamcohortavg1LOresponserate) '%' newline 'The average Light+Ultrasound response rate was: ' num2str(shamcohortavgLUSresponserate) '%' newline 'The average 2nd Light Only response rate was: ' num2str(shamcohortavg2LOresponserate) '%' ];
disp(message)


% plotting 
title('SHAM Cohort Response Rates vs. Trial Type')
ylabel('Response rate (%)') 
legend([sham.one sham.two sham.three sham.four sham.five sham.six sham.seven],file1)
trialtype = {'1LO' '' '' '' '' 'L+US' '' '' '' '' '2LO'};
xticklabels(trialtype) ;

% pen and sham plotting 
try 
    if  penran ==1 

        peny = [pencohortavg1LOresponserate pencohortavgLUSresponserate pencohortavg2LOresponserate];
        shamy = [shamcohortavg1LOresponserate shamcohortavgLUSresponserate shamcohortavg2LOresponserate];
        stderror = zeros(2,3) ;
        for ii = 1:3 
            stderror(1, ii) = std(PENresponse_matrix(:,ii))/sqrt(length(PENresponse_matrix(:,ii))) ;
        end 
        for ii = 1:3 
            stderror(2, ii) = std(SHAMresponse_matrix(:,ii))/sqrt(length(SHAMresponse_matrix(:,ii))) ;
        end
        % stderror matrix = [pen1LO, LUS, 2LO;
                    %        sham1LO, LUS, 2LO] 
        figure(4)
        q1 = errorbar(1:3, peny, stderror(1,:), 'o-r', 'DisplayName', 'pen avg response rates') ;
        hold on 
        q2 = errorbar(1:3, shamy, stderror(2,:), 'o-b', 'DisplayName', 'sham avg response rates') ;
        title('Cohort Response Rates vs. Trial Type')
        ylabel('Response rate (%)') 
        trialtype = {'1LO' '' '' '' '' 'L+US' '' '' '' '' '2LO'};
        xticklabels(trialtype) ;
        legend([q1 q2], {'PEN', 'SHAM'}) 

        % MW analysis - x and y = datasets to be compared 
       MWLO1 = ranksum(PENresponse_matrix(:,1), SHAMresponse_matrix(:,1))
       MWLUS = ranksum(PENresponse_matrix(:,2), SHAMresponse_matrix(:,2))
       MW2LO = ranksum(PENresponse_matrix(:,3), SHAMresponse_matrix(:,3))
    end 
catch 
    disp('SHAM data only ran') 
end 