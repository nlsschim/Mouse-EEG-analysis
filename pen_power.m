%%  Authors: Henry Tan
% (1) This code is designed to plot the power of the 9 rms values for the seconds after each light
%   stim event (1-60) for the PEN US cohort 
% (2) This code also produces waterfall plots that differ from super_US Diag
%   stim in that magnitude scale is the same for all figures (not sure why)
% (3) more lightstim events are retained, and plotted
% (4) data is subject to more strict hardcoded filtering to omit electrical noise recorded in eCoG -- see line 193 of powerUS_diag_stim 
% additional instructions: event quantification can be ran for multiple
% mice; for power/rms plots, change f to desired mouse index in file1
% (5) this code also quantifies event-related potentials (ERPs) by trial, by
% cohort 

close all 
clear all
clc 

%% reading cohort files 
file1={'8_10_21 m1\', '8_10_21 m2\','8_12_21 m1\', '06-23-21 RECUT 2.0 session 1\', '2-28_22 PEN\', '03-02-22 PEN\', '3_03_22 PEN\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\';

%% medians or variance 

% button = input("Create PEN matrix of median values or variance? '1'=medians? '2'=variance: ") ;
% button2 = input("Matrix of L+US and 2nd LO minus medians minus 1st LO medians? '1' = yes, '2' = no: ") ; 
% button3 = input("include rms baseline? '1' = yes, '2' = no: ") ; 
% normal = input("Normalize data by median of 1st LO or rms_baseline? '1'=median of 1LO, '2' =rms_baseline: "); 
responseratedecision = input("Would you like to plot response rates? '1' = yes, '2' = no: "); 
histogramdecision = input("Would you like to plot one second after stim histogram? '1' = yes, '2' = no: "); 

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
    
    baseline_medians_matrix = [];
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
calc_baseline60sec;
% % for baseline histo breakdown by mouse
% if histogramdecision == 1 
%     figure(2) 
%     histogram(baseline_medians, 'Facecolor', 'r')  
%     hold on 
% end 
% title('Baseline rms values') 
% ylabel('Number of points') 
% xlabel('RMS value') 

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
    
% quantifying ERP: event-related potential/brain response to stim by mouse 
    ERPcount = 0;
    totaleventcount = 0;  
    % has hardcoded filtering before plots that messes up timeseries (best for median analysis?)
%     powerUS_diag_stim2;
    % without hardcoded filtering, only bandpass 
    powerUS_diag_stim;   
 
% % plotting first second histogram 
%     figure(2)
%     histogram(onesechistogram.(histoname))
%     hold on 

end

%% to rename trials and skip 2 
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 
    
%   plotting response rates 
    if responseratedecision == 1 
        figure(2)
        concat3 = ['Mouse' num2str(f) 'Trial1'];concat4 = ['Mouse' num2str(f) 'Trial3'];concat5 = ['Mouse' num2str(f) 'Trial4'];
        firstlightLUSsecondlight = [eventresponsecounter.(concat3)(1,3) eventresponsecounter.(concat4)(1,3) eventresponsecounter.(concat5)(1,3)];
        PENresponse_matrix(f, :) = [firstlightLUSsecondlight] ;
        fileorder = {'one' 'two' 'three' 'four' 'five' 'six' 'seven'};
        pen.(char(fileorder(f)))= [0 0 0];
        pen.(char(fileorder(f)))= plot(1:3, PENresponse_matrix(f,:), 'o-') ;
        hold on 
    end     
    
end

%% display quantification results (mice)

cohortavgresponserate = (eventresponsecounter.totalERP/eventresponsecounter.totalevents)*100 ; 
pencohortavg1LOresponserate = (eventresponsecounter.total1LOERP/eventresponsecounter.total1LOevents)*100 ; 
pencohortavgLUSresponserate = (eventresponsecounter.totalLUSERP/eventresponsecounter.totalLUSevents)*100 ; 
pencohortavg2LOresponserate = (eventresponsecounter.total2LOERP/eventresponsecounter.total2LOevents)*100 ; 

%% response rate plotting 

if responseratedecision == 1 
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
end 

%% histo plotting 
if histogramdecision == 1
% % Baseline 
    figure(2) 
    penbaseline_medians_vector = baseline_medians_matrix(:)';
    p1 = histogram(penbaseline_medians_vector, 'Facecolor', 'r');
    title('baseline rms values')
    ylabel('Number of points') 
    xlabel('RMS value')
    hold on 

%     1LO 
    figure(3)
    pen1LOhisto = [onesechistogram.Trial_1_m_1 onesechistogram.Trial_1_m_2 onesechistogram.Trial_1_m_3 onesechistogram.Trial_1_m_4 onesechistogram.Trial_1_m_5 onesechistogram.Trial_1_m_6 onesechistogram.Trial_1_m_7]; 
    p2 = histogram(pen1LOhisto, 'Facecolor', 'r', 'BinWidth', 0.025) ;
    title('1LO 1s after stim rms values')
    ylabel('Number of points') 
    xlabel('RMS value') 
    hold on 
%     p1 = histogram(firstLOhisto, 'Facecolor', 'b') ;
%     hold on 
%     for mouse = 1:7
%         figure(3)
%         histoname = ['Trial_1_m_' num2str(mouse)] ; 
%         p1 = histogram(onesechistogram.(histoname), 'Facecolor', 'b') ;
%         hold on 
%         title('1LO rms values')
%         ylabel('Number of points') 
%         xlabel('RMS value') 
%     end

    % L+US
    figure(4)
    penLUShisto = [onesechistogram.Trial_3_m_1 onesechistogram.Trial_3_m_2 onesechistogram.Trial_3_m_3 onesechistogram.Trial_3_m_4 onesechistogram.Trial_3_m_5 onesechistogram.Trial_3_m_6 onesechistogram.Trial_3_m_7]; 
    p3 = histogram(penLUShisto, 'Facecolor', 'r', 'BinWidth', 0.025) ;
    title('L+US 1s after stim rms values')
    ylabel('Number of points') 
    xlabel('RMS value') 
    hold on 
%     p2 = histogram(LUShisto, 'Facecolor', 'r') ;
%     hold on
%     for mouse = 1:7
%         figure(3)
%         histoname = ['Trial_3_m_' num2str(mouse)] ; 
%         p2 = histogram(onesechistogram.(histoname), 'Facecolor', 'r') ;
%         hold on 
%         title('LUS rms values')
%         ylabel('Number of points') 
%         xlabel('RMS value')
%     end
    % 2LO 
    figure(5)
    pen2LOhisto = [onesechistogram.Trial_4_m_1 onesechistogram.Trial_4_m_2 onesechistogram.Trial_4_m_3 onesechistogram.Trial_4_m_4 onesechistogram.Trial_4_m_5 onesechistogram.Trial_4_m_6 onesechistogram.Trial_4_m_7]; 
    p4 = histogram(pen2LOhisto, 'Facecolor', 'r', 'BinWidth', 0.025) ;
    title('2LO 1s after stim rms values')
    ylabel('Number of points') 
    xlabel('RMS value') 
    hold on 
%     p3 = histogram(twoLOhisto, 'Facecolor', 'g') ;
%     for mouse = 1:7.0
%         figure(3)
%         histoname = ['Trial_4_m_' num2str(mouse)] ; 
%         p3 = histogram(onesechistogram.(histoname), 'Facecolor', 'y') ;
%         hold on
%         title('2LO rms values')
%         ylabel('Number of points') 
%         xlabel('RMS value')
%         title('PEN all trial types rms values')
%         legend([p1 p2 p3], {'1LO', 'LUS', '2LO'})
%     end

% all trial types 
    figure(6)
    penhisto = [pen1LOhisto penLUShisto pen2LOhisto] ; 
    p5 = histogram(penhisto, 'Facecolor', 'r', 'BinWidth', 0.02) ;
    hold on
    ylabel('Number of points') 
    xlabel('RMS value')
    title('Both cohorts all trial types rms values')
    hold on 
end 

penran = 1;
clearvars -except responseratedecision histogramdecision penran pencohortavg1LOresponserate pencohortavgLUSresponserate pencohortavg2LOresponserate PENresponse_matrix
sham_power