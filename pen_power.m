%%  Authors: Henry Tan
% (1) This code is designed to plot the power of the 9 rms values for the seconds after each light
%   stim event (1-60) for the PEN US cohort 
% (2) This code also produces waterfall plots that differ from super_US Diag
%   stim in that magnitude scale is the same for all figures (not sure why)
% (3) more lightstim events are retained, and plotted
% (4) data is subject to more strict hardcoded filtering to omit electrical noise recorded in eCoG -- see line 193 of powerUS_diag_stim 
% additional instructions: event quantification can be ran for multiple
% mice; for power/rms plots, change f to desired mouse index in file1 

close all 
clear all
clc 

%% reading cohort files 
file1={'8_10_21 m1\', '8_10_21 m2\','8_12_21 m1\', '06-23-21 RECUT 2.0 session 1\', '2-28_22 PEN\', '03-02-22 PEN\', '3_03_22 PEN\'};
% file1={'8_10_21 m1\', '8_10_21 m2\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\';

%% medians or variance 

% button = input("Create PEN matrix of median values or variance? '1'=medians? '2'=variance: ") ;
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
%% Reading experiment dates 

% micerancounter = 0 ; % mice ran counter
for f=1:length(str) 
% for f=7
folder = fullfile(MainDirectory,str{f});
% dir ('folder');

%Change what is in the string depending on which file\files you want to run
file_list = dir([folder 'TRIAL*.mat']);
baseline = dir([folder 'nb.mat']); % or baseline 1 or baseline 2 depending on trials 
% baseline = dir([folder 'Baseline.mat']); % or baseline 1 or baseline 2 depending on trials 

set_channels=[1 2 3 4 5]; 
ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; 
trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};

%% channel configuration 

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\06-23-21 RECUT 2.0 session 1\"
V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\06-24-21 RECUT session 2 m2\" 
V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_10_21 m1\" 
V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end 

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_10_21 m2\"
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

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\2-28_22 PEN\"
    V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
end 

if folder =="C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\03-02-22 PEN\" 
    V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
end     

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\3_03_22 PEN\"
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
    
% quantifying ERP: event-related potential/brain response to stim 
% by mouse 

    ERPcount = 0;
    totaleventcount = 0;  
    % has hardcoded filtering before plots that messes up timeseries (best for median analysis?)
%     powerUS_diag_stim2;
    % without hardcoded filtering, only bandpass 
    powerUS_diag_stim;
    
%     micerancounter = micerancounter + 1;

%     if z ==1 
%         ERPcount_1LO = ERPcount ;
%         totaleventcount_1LO = totaleventcount ;
%     elseif z==3 
%         ERPcount_LUS = ERPcount ;   
%         totaleventcount_LUS = totaleventcount ;
%     elseif z==4
%         ERPcount_2LO = ERPcount ;
%         totaleventcount_2LO = totaleventcount ;
%     end 

% if z == 4
%     fileorder = {'one' 'two' 'three' 'four' 'five' 'six' 'seven'};
%     pen.(char(fileorder(f)))= [];
%     concat3 = ['Mouse' num2str(f) 'Trial1'];concat4 = ['Mouse' num2str(f) 'Trial3'];concat5 = ['Mouse' num2str(f) 'Trial4'];
%     firstlightLUSsecondlight = [eventresponsecounter.(concat3)(1,3) eventresponsecounter.(concat4)(1,3) eventresponsecounter.(concat5)(1,3)];
% %     pen.(char(fileorder(f)))= plot(firstlightLUSsecondlight, 'o-') ;
%     if f == 1 
%         q1 = plot(1:3, firstlightLUSsecondlight, 'o-') ;
%     elseif f == 2 
%         q2 = plot(1:3, firstlightLUSsecondlight, 'o-') ;
%     end 
% end 



end

%% to rename trials and skip 2 
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 
    
%   plotting 
    figure(2)
    concat3 = ['Mouse' num2str(f) 'Trial1'];concat4 = ['Mouse' num2str(f) 'Trial3'];concat5 = ['Mouse' num2str(f) 'Trial4'];
    firstlightLUSsecondlight = [eventresponsecounter.(concat3)(1,3) eventresponsecounter.(concat4)(1,3) eventresponsecounter.(concat5)(1,3)];
    PENresponse_matrix(f, :) = [firstlightLUSsecondlight] ;
    fileorder = {'one' 'two' 'three' 'four' 'five' 'six' 'seven'};
    pen.(char(fileorder(f)))= [0 0 0];
    pen.(char(fileorder(f)))= plot(1:3, PENresponse_matrix(f,:), 'o-') ;
    hold on 
    
end

%% display quantification results (mice)

cohortavgresponserate = (eventresponsecounter.totalERP/eventresponsecounter.totalevents)*100 ; 
pencohortavg1LOresponserate = (eventresponsecounter.total1LOERP/eventresponsecounter.total1LOevents)*100 ; 
pencohortavgLUSresponserate = (eventresponsecounter.totalLUSERP/eventresponsecounter.totalLUSevents)*100 ; 
pencohortavg2LOresponserate = (eventresponsecounter.total2LOERP/eventresponsecounter.total2LOevents)*100 ; 
   
% message = ['For the mice ran, the average response rate was: ' num2str(cohortavgresponserate) '%' newline 'The average 1st Light Only response rate was: ' num2str(cohortavg1LOresponserate) '%' newline 'The average Light+Ultrasound response rate was: ' num2str(cohortavgLUSresponserate) '%' newline 'The average 2nd Light Only response rate was: ' num2str(cohortavg2LOresponserate) '%' ];
message = ['For the mice ran,' newline 'the average 1st Light Only response rate was: ' num2str(pencohortavg1LOresponserate) '%' newline 'The average Light+Ultrasound response rate was: ' num2str(pencohortavgLUSresponserate) '%' newline 'The average 2nd Light Only response rate was: ' num2str(pencohortavg2LOresponserate) '%' ];
disp(message)

% plotting 
title('PEN Cohort Response Rates vs. Trial Type')
ylabel('Response rate (%)') 
legend([pen.one pen.two pen.three pen.four pen.five pen.six pen.seven],file1)
trialtype = {'1LO' '' '' '' '' 'L+US' '' '' '' '' '2LO'};
xticklabels(trialtype) ;

penran = 1;
sham_power