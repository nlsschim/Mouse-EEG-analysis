%%  Authors: Kat Floerchinger, Hannah Mach, Henry Tan
% (1) This code is designed to plot the power of the 9 rms values for the seconds after each light
%   stim event (1-~60) for the SHAM US cohort 
% (2) This code also produces waterfall plots that differ from super_US Diag
%   stim in that magnitude scale is the same for all figures (not sure why)
% (3) more lightstim events are retained, and plotted
% (4) data is subject to more strict hardcoded filtering to omit electrical noise recorded in eCoG -- see line 193 of powerUS_diag_stim 
% additional instructions: event quantification can be ran for multiple
% mice; for power/rms plots, change f to desired mouse index in file1 
% (5) this code also quantifies event-related potentials (ERPs) by trial, by
% cohort 

if penran ~= 1 
    close all
    clear all
    clc 
end 

%% reading cohort files 

file1={'2_15_22\','2_24_22\','2_25_22\','06_30_20 MOUSE 1 RECUT\', '06-23-2020 Mouse Experiment 2\', '06-24-2020 Mouse Experiment 1\','05-29-2020 Mouse Experiment\'};
str=string(file1);
MainDirectory = 'C:\Matlab Stuff\Mourad Lab\Vis Stim Code\Data\SHAM\';

%% medians or variance 

% button = input("Create SHAM matrix of median values or variance? '1'=medians, '2'=variance: ") ;
% button2 = input("Matrix of L+US and 2nd LO minus medians minus 1st LO medians? '1' = yes, '2' = no: ") ; 
% button3 = input("include rms baseline? '1' = yes, '2' = no: ") ; 
% normal = input("Normalize data by median of 1st LO or rms_baseline? '1'=median of 1LO, '2' =rms_baseline: "); 
if penran ~= 1
    responseratedecision = input("Would you like to plot response rates? '1' = yes, '2' = no: "); 
    histogramdecision = input("Would you like to plot one second after stim histogram? '1' = yes, '2' = no: "); 
end 

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
    calc_baseline60sec;
%     if histogramdecision == 1 
%         figure(2) 
%         histogram(baseline_medians, 'Facecolor', 'b')  
%         hold on 
%     end 
%     title('Baseline rms values') 
%     ylabel('Number of points') 
%     xlabel('RMS value') 
    
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
    
%   plotting response rates 
    if responseratedecision == 1 
        figure(3)
        concat3 = ['Mouse' num2str(f) 'Trial1'];concat4 = ['Mouse' num2str(f) 'Trial3'];concat5 = ['Mouse' num2str(f) 'Trial4'];
        firstlightLUSsecondlight = [eventresponsecounter.(concat3)(1,3) eventresponsecounter.(concat4)(1,3) eventresponsecounter.(concat5)(1,3)];
        SHAMresponse_matrix(f, :) = [firstlightLUSsecondlight] ;
        fileorder = {'one' 'two' 'three' 'four' 'five' 'six' 'seven'};
        sham.(char(fileorder(f)))= [0 0 0];
        sham.(char(fileorder(f)))= plot(1:3, SHAMresponse_matrix(f,:), 'o-') ;
        hold on     
    end 
end 
%% display quantification results (mice)

cohortavgresponserate = (eventresponsecounter.totalERP/eventresponsecounter.totalevents)*100 ; 
shamcohortavg1LOresponserate = (eventresponsecounter.total1LOERP/eventresponsecounter.total1LOevents)*100 ; 
shamcohortavgLUSresponserate = (eventresponsecounter.totalLUSERP/eventresponsecounter.totalLUSevents)*100 ; 
shamcohortavg2LOresponserate = (eventresponsecounter.total2LOERP/eventresponsecounter.total2LOevents)*100 ;

if responseratedecision == 1    
    % message = ['For the mice ran, the average response rate was: ' num2str(cohortavgresponserate) '%' newline 'The average 1st Light Only response rate was: ' num2str(cohortavg1LOresponserate) '%' newline 'The average Light+Ultrasound response rate was: ' num2str(cohortavgLUSresponserate) '%' newline 'The average 2nd Light Only response rate was: ' num2str(cohortavg2LOresponserate) '%' ];
    message = ['For the mice ran,' newline 'the average 1st Light Only response rate was: ' num2str(shamcohortavg1LOresponserate) '%' newline 'The average Light+Ultrasound response rate was: ' num2str(shamcohortavgLUSresponserate) '%' newline 'The average 2nd Light Only response rate was: ' num2str(shamcohortavg2LOresponserate) '%' ];
    disp(message)


    % plotting 
    title('SHAM Cohort Response Rates vs. Trial Type')
    ylabel('Response rate (%)') 
    legend([sham.one sham.two sham.three sham.four sham.five sham.six sham.seven],file1)
    trialtype = {'1LO' '' '' '' '' 'L+US' '' '' '' '' '2LO'};
    xticklabels(trialtype) ;

%% response rate plotting 
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
end

%% histo plotting
if histogramdecision == 1
% % Baseline 
%     figure(2) 
%     baseline_medians_vector = baseline_medians_matrix(:)';
%     histogram(baseline_medians_vector, 'Facecolor', 'b')
%         title('baseline rms values')
%         ylabel('Number of points') 
%         xlabel('RMS value') 

%     1LO 
%     figure(3)
%     firstLOhisto = [onesechistogram.Trial_1_m_1 onesechistogram.Trial_1_m_2 onesechistogram.Trial_1_m_3 onesechistogram.Trial_1_m_4 onesechistogram.Trial_1_m_5 onesechistogram.Trial_1_m_6 onesechistogram.Trial_1_m_7]; 
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
%     LUShisto = [onesechistogram.Trial_3_m_1 onesechistogram.Trial_3_m_2 onesechistogram.Trial_3_m_3 onesechistogram.Trial_3_m_4 onesechistogram.Trial_3_m_5 onesechistogram.Trial_3_m_6 onesechistogram.Trial_3_m_7]; 
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
%     twoLOhisto = [onesechistogram.Trial_4_m_1 onesechistogram.Trial_4_m_2 onesechistogram.Trial_4_m_3 onesechistogram.Trial_4_m_4 onesechistogram.Trial_4_m_5 onesechistogram.Trial_4_m_6 onesechistogram.Trial_4_m_7]; 
%     p3 = histogram(twoLOhisto, 'Facecolor', 'g') ;
%     for mouse = 1:7
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
%     figure(5)
%     shamhisto = [firstLOhisto LUShisto twoLOhisto] ; 
%     p5 = histogram(shamhisto, 'Facecolor', 'b') ;
%     ylabel('Number of points') 
%         xlabel('RMS value')
%         title('Both cohorts all trial types rms values')
   figure(2) 
    shambaseline_medians_vector = baseline_medians_matrix(:)';
    p6 = histogram(shambaseline_medians_vector, 'Facecolor', 'b');
    legend([p1 p6], {'PEN', 'SHAM'})
    if penran == 1 
        baselineMW = ranksum(penbaseline_medians_vector,shambaseline_medians_vector)
        figure(7)
        baselineqq = qqplot(penbaseline_medians_vector,shambaseline_medians_vector) ;
        title('QQ plot of pen baseline second medians versus sham')
        hold on 
        plot(0:0.2:1.6, 0:0.2:1.6)
        
%         xlabel('Quantiles of sham data')
%         ylabel('Quantiles of sham data')
    end 

%     1LO 
    figure(3)
    sham1LOhisto = [onesechistogram.Trial_1_m_1 onesechistogram.Trial_1_m_2 onesechistogram.Trial_1_m_3 onesechistogram.Trial_1_m_4 onesechistogram.Trial_1_m_5 onesechistogram.Trial_1_m_6 onesechistogram.Trial_1_m_7]; 
    p7 = histogram(sham1LOhisto, 'Facecolor', 'b', 'BinWidth', 0.025) ;
    legend([p2 p7], {'PEN', 'SHAM'})
    if penran == 1 
        firstLOMW = ranksum(pen1LOhisto,sham1LOhisto)
        figure(8)
        firstLOqq = qqplot(pen1LOhisto,sham1LOhisto) ;
        title('QQ plot of pen 1st second after 1LO event rms values versus sham')
        hold on 
        plot(0:1:6, 0:1:6)
    end 

    % L+US
    figure(4)
    shamLUShisto = [onesechistogram.Trial_3_m_1 onesechistogram.Trial_3_m_2 onesechistogram.Trial_3_m_3 onesechistogram.Trial_3_m_4 onesechistogram.Trial_3_m_5 onesechistogram.Trial_3_m_6 onesechistogram.Trial_3_m_7]; 
    p8 = histogram(shamLUShisto, 'Facecolor', 'b', 'BinWidth', 0.025) ;
    legend([p3 p8], {'PEN', 'SHAM'})
    if penran == 1 
        LUSMW = ranksum(penLUShisto,shamLUShisto)
        figure(9)
        LUSqq = qqplot(penLUShisto,shamLUShisto) ;
        title('QQ plot of pen 1st second after L+US event rms values versus sham')
        hold on 
        plot(0:1:6, 0:1:6)
    end 
% for_stats_analysis.(conc) = for_stats_analysis.(conc)(for_stats_analysis.(conc)<trialmean+4*deviation);
    % 2LO 
    figure(5)
    sham2LOhisto = [onesechistogram.Trial_4_m_1 onesechistogram.Trial_4_m_2 onesechistogram.Trial_4_m_3 onesechistogram.Trial_4_m_4 onesechistogram.Trial_4_m_5 onesechistogram.Trial_4_m_6 onesechistogram.Trial_4_m_7]; 
    p9 = histogram(sham2LOhisto, 'Facecolor', 'b', 'BinWidth', 0.025) ;
    legend([p4 p9], {'PEN', 'SHAM'})
    if penran == 1 
        secondLOMW = ranksum(pen2LOhisto,sham2LOhisto)
        figure(10)
        secondLOqq = qqplot(pen2LOhisto,sham2LOhisto) ;
        title('QQ plot of pen 1st second after 2LO event rms values versus sham')
        hold on 
        plot(0:1:3, 0:1:3)
    end 

% % all trial types 
%     figure(6)
%     shamhisto = [sham1LOhisto shamLUShisto sham2LOhisto] ; 
%     p10 = histogram(shamhisto, 'Facecolor', 'b', 'BinWidth', 0.02) ;
%     legend([p5 p10], {'PEN', 'SHAM'})
%     if penran == 1 
%         alltrialsMW = ranksum(penhisto,shamhisto)
%         figure(11)
%         alltrialsqq = qqplot(penhisto,shamhisto) ;
%         title('QQ plot of pen 1st second after event rms values versus sham')
%     end 
    
%     figure(12)
%     pen1LOpenLUSqq = qqplot(log(pen1LOhisto), log(penLUShisto));
%     hold on 
%     plot(0:0.2:1.2,0:0.2:1.2)
%     title('pen 1LO vs pen LUS')
%     figure(13)
%     sham1LOshamLUSqq = qqplot(log(sham1LOhisto), log(shamLUShisto));
%     hold on 
%     plot(0:0.2:1.2,0:0.2:1.2)
%     title('sham 1LO vs sham LUS')
end 