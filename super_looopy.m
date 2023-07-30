%% Authors: Devon Griggs, John Kucewicz, Nels Schimek, Kat Floerchinger, Hannah Mach, Alissa Phutirat, Henry Tan
% This code is like the original loopy_ecog but will run statistic analysis
% for kruskal wallis 3 pair, anova1, and mann whitney for all 3 pairs
% individually
close all
clear all
%Change folder path to match where you save the files and data
%always need "\" at the end of the folder name, copy adn paste so that no errors are made

% helpful: https://www.mathworks.com/help/wavelet/ug/wavelet-packet-harmonic-interference-removal.html

% note: trials have been formatted "trial x"; baselines : "baseline x"; 
% trials > 1:4 have been placed in separate folders 

%% PEN US - 2020-2021
% cohort_type = 'pen' ; 
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\06-23-21 RECUT 2.0 session 1\'; 
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_10_21 m1\';
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_10_21 m2\'; 
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_12_21 m1\' ; % maybe 
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\2-28_22 PEN\' ;
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\03-02-22 PEN\';
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\3_03_22 PEN\' ; 

%% SHAM US mice - 2020 
% cohort_type = 'sham' ; 
% folder= 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\05-29-2020 Mouse Experiment\'; 
% alldata.lightstimdata=data(datastart(5):dataend(5));
% folder= 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\06-23-2020 Mouse Experiment 2\';
% folder ='C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\06-24-2020 Mouse Experiment 1\'; 
% folder= 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\06_30_20 MOUSE 1 RECUT\' ;
% folder= 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_15_22\'; 
% folder= 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_24_22\';
% folder= 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_25_22\'; 

%% SHAM light mice - 2023 
cohort_type = 'sham_light' ; 
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\5_18_23 m1 RECUT\' ;
folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\5_26_23 m1 Gabe\' ;
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\5_18_23 m2 RECUT\' ;
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\5_18_23 m3 RECUT\' ;
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\5_25_23 m1 RECUT\' ;
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\5_25_23 m2 RECUT \' ;

% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\5_26_23 m1 RECUT\' ; % ambiguous issues--cut weird? 

% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\5_26_23 m2 RECUT\' ;
% folder = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM_light\5_26_23 m3 RECUT\' ;

baseline_medians_matrix = [];
% for subplotting waterfalls 

%% Change what is in the string depending on which file/files you want to run
file_list=dir([folder 'TRIAL*.mat']);
baseline=dir([folder 'last min baseline 2.mat']); % or baseline 1 or baseline 2 depending on trials 

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\06-23-2020 Mouse Experiment 2\"       
    set_channels=[1 2 3 4 7]; 
elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\06-24-2020 Mouse Experiment 1\" 
    set_channels=[1 2 3 4 7]; 
else 
    set_channels=[1 2 3 4 5]; % 6/24/21 data, 6/23/21 , 7/1/21, 12/13/19
end

if cohort_type == "sham_light"
    set_channels=[1 2 3 4 6];
end 

ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};
%plot_cwt=input('Plot CWTs? Y=1 N=2 :'); %CWT will show the frequency breakdown, use 2 if you just want to look at the averages of the EEG
% plot_cwt=2;

%% automation 

time_series = input('time series(3 or 10)?');
% brain_wave = input("'3-100' = 1, '5-55' = '2', low gamma = '3', beta = '4', alpha ='5', theta = '6', : ");
outliersyn = input("run outliers analysis? '1'= yes, '2' = no: ") ;
runningrms = input("'1'= runnning RMS, '2' = 1 second block RMS, '3'=running RMS 10th of a second: ") ; 

%% this names the channels based on where they were placed, make sure they match lab chart

%% channel configuration 

% pen channel assignments 
for i = 1:10 %to hide assignments 
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
end 
% sham channel assignments 
for i = 1:10 
    if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\5-29 recut 2.0\"
        V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5); 
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_24_22\"
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
    elseif folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\SHAM\2_25_22\" 
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
    else
        V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
    end   
end 

% sham light channel assignments 
if cohort_type == "sham_light"
    V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(1);V1R=set_channels(2);lightstim=set_channels(5);
end 

%% create data arrays

%calculate pre-stim RMS for normalization
baseline_rms=[];
disp(baseline.name);
load([folder baseline.name])
calc_baseline2;

% create matrix to hold data for statistical testing
for_stats_new = [];
for_stats_analysis=[];

%create figure for plotting histograms
%figure;
% measure each file 
%for z=1:length(file_list) %go through all the files that are in the folder  
% counter = 0 ;
%for z=1:3 

for z=1:4
%      if isequal(file_list(z).name,"TRIAL2.mat"), continue, end % skips trial 2 for refactory period trial does we dont car about (yet)
     if isequal(file_list(z).name,"Trial 2.mat"), continue, end 
     if isequal(file_list(z).name,"Trial 6.mat"), continue, end 
%      if isequal(file_list(z).name,"TRIAL 2.mat"), continue, end %for 12-23
     
%      if isequal(file_list(z).name,"TRIAL6.mat"), continue, end % for 6/24 second session 
%      if isequal(file_list(z).name,"TRIAL 10.mat"), continue, end 
%      if isequal(file_list(z).name,"TRIAL 14 mat"), continue, end 
     % data trials are 'Trial 2.mat w/ a space. Some are without a space
     % ex. 'trial1'
%     counter = counter + 1 ; 
    disp(z)%display the number that the code is on in the terminal, do not put a ';' after it 
    disp(file_list(z).name);%displays the name of the file in the terminal
    load([folder file_list(z).name]);%bringing the file data into matlab so that the code can run 
    super_US_diag_stim ;
end

%% outlier pi charts 

if outliersyn == 1 
    figure
    ax1 = subplot(1,3,1);
    yTrial_1 = [totaloutliers.Trial_1 nonoutliers.Trial_1];
    p=pie(ax1,yTrial_1);
    pielabels = {'Outliers','Non Outliers'};
    lgd = legend(pielabels);
    set(lgd,'visible','off')
    % pText = findobj(p,'Type','text');
    % percentValues = get(pText,'String'); 
    % txt = {'Outliers: ';'Non Outliers: '}; 
    % combinedtxt = strcat(txt,percentValues); 
    % pText(1).String = combinedtxt(1);
    % pText(2).String = combinedtxt(2);
    slice11 = p(1);
    slice11.FaceColor = [0.75, 0.6, 0.91];
    slice12 = p(3);
    slice12.FaceColor = [0.53, 0.77, 0.53];
    title('1st LO')

    % figure
    ax2 = subplot(1,3,2);
    yTrial_3 = [totaloutliers.Trial_3 nonoutliers.Trial_3];
    p2=pie(ax2,yTrial_3);
    pielabels = {'Outliers','Non Outliers'};
    lgd = legend(pielabels);
    lgd.Location = 'southoutside';
    % p2Text = findobj(p2,'Type','text');
    % percentValues = get(p2Text,'String'); 
    % txt = {'Outliers: ';'Non Outliers: '}; 
    % combinedtxt = strcat(txt,percentValues); 
    % p2Text(1).String = combinedtxt(1);
    % p2Text(2).String = combinedtxt(2);
    slice21 = p2(1);
    slice21.FaceColor = [0.75, 0.6, 0.91];
    slice22 = p2(3);
    slice22.FaceColor = [0.53, 0.77, 0.53];
    title('L+US')

    % figure
    ax3 = subplot(1,3,3);
    yTrial_4 = [totaloutliers.Trial_4 nonoutliers.Trial_4];
    p3=pie(ax3,yTrial_4);
    pielabels = {'Outliers','Non Outliers'};
    lgd = legend(pielabels);
    set(lgd,'visible','off')
    % p3Text = findobj(p3,'Type','text');
    % percentValues = get(p3Text,'String'); 
    % txt = {'Outliers: ';'Non Outliers: '}; 
    % combinedtxt = strcat(txt,percentValues); 
    % p3Text(1).String = combinedtxt(1);
    % p3Text(2).String = combinedtxt(2);
    slice31 = p3(1);
    slice31.FaceColor = [0.75, 0.6, 0.91];
    slice32 = p3(3);
    slice32.FaceColor = [0.53, 0.77, 0.53];
    title('2nd LO')
    sgtitle('Percent of Outliers') 
end 

% to rename trials and skip 2 
for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 

if outliersyn == 1
    LastName = {'1st LO';'L+US';'2nd LO'};
    firstQuartile = [quantile(for_stats_analysis.Trial_1,0.25) ;quantile(for_stats_analysis.Trial_2,0.25);quantile(for_stats_analysis.Trial_3,0.25)];
    thirdQuartile = [quantile(for_stats_analysis.Trial_1,0.75) ;quantile(for_stats_analysis.Trial_2,0.75);quantile(for_stats_analysis.Trial_3,0.75)];
    Outliers = [totaloutliers.Trial_1 ;totaloutliers.Trial_3;totaloutliers.Trial_4];
    TotalData = [totalpoints.Trial_1 ;totalpoints.Trial_3;totalpoints.Trial_4];
    PercentOutliers= [totaloutliers.Trial_1/totalpoints.Trial_1*100; totaloutliers.Trial_3/totalpoints.Trial_3*100; totaloutliers.Trial_4/totalpoints.Trial_4*100];
    IQRs=thirdQuartile-firstQuartile
    UpperLimit= [thirdQuartile(1)+1.5*IQRs(1); thirdQuartile(2)+1.5*IQRs(2); thirdQuartile(3)+1.5*IQRs(3)];
    LowerLimit= [firstQuartile(1)-1.5*IQRs(1); firstQuartile(2)-1.5*IQRs(2); firstQuartile(3)-1.5*IQRs(3)];
    All_Data_Points = [totalpoints.Trial_1 ; totalpoints.Trial_3; totalpoints.Trial_4];
    T = table(firstQuartile,thirdQuartile,Outliers,All_Data_Points,PercentOutliers,UpperLimit,LowerLimit,'RowNames',LastName)
end

%%
% Grouping the data together for comparative analysis - trial 2=the real
% trial 3 (refractory skipped). Thus, trial 3 = the real trial 4


% for kruskal-wallis 3 pairings 
first_second_third_vector=[for_stats_analysis.Trial_1 for_stats_analysis.Trial_2 for_stats_analysis.Trial_3];
% broken up for mann whitney/wilcox test (or just use stats analysis trials

% first_second_vector=[for_stats_analysis.Trial_1 for_stats_analysis.Trial_2];
% first_third_vector=[for_stats_analysis.Trial_1 for_stats_analysis.Trial_3];
% second_third_vector=[for_stats_analysis.Trial_2 for_stats_analysis.Trial_3];

%% waterfall caxis automation 

bottom = min(first_second_third_vector, [], 'all') ; 
top = max(first_second_third_vector, [], 'all'); 
allAxes = findall(0, 'type','axes') ; 
set(allAxes, 'clim', [bottom top]) ;

%%

str1=strings(1,length(for_stats_analysis.Trial_1));
for ii=1:length(for_stats_analysis.Trial_1)
    str1(ii)='LIGHT ONLY - FIRST';
end

str2=strings(1,length(for_stats_analysis.Trial_2));
for ii=1:length(for_stats_analysis.Trial_2)
    str2(ii)='LIGHT + ULTRASOUND';
end

str3=strings(1,length(for_stats_analysis.Trial_3));
for ii=1:length(for_stats_analysis.Trial_3)
    str3(ii)='LIGHT ONLY - SECOND';
end

%% STATISTICAL ANALYSIS

% creating a list of group labels corresponding to the data
first_vs_second_vs_third=[str1 str2 str3];
% first_vs_third=[str1 str3];
% second_vs_third=[str2 str3];

% % grouping={my_string};
% [p12,tbl12,stats12]=kruskalwallis(first_second_vector,first_vs_second);
% [p13,tbl13,stats13]=kruskalwallis(first_third_vector,first_vs_third);
% [p23,tbl23,stats23]=kruskalwallis(second_third_vector,second_vs_third);

%Kruskal-wallis and Anova1 tests between trials 1&2, 1&3, 2&3
run_stats_tests(first_second_third_vector, first_vs_second_vs_third); %ANOVA BETWEEN ALL
% run_stats_tests(first_third_vector, first_vs_third);
% run_stats_tests(second_third_vector, second_vs_third);


% Mann-Whitney U test / Wilcoxon rank sum test significant if Kruskal-Wallis p < 0.05 
MWp1 = ranksum(for_stats_analysis.Trial_1,for_stats_analysis.Trial_2); % pairing 1 1st LO vs. L+US 
MWp2 = ranksum(for_stats_analysis.Trial_1,for_stats_analysis.Trial_3); % pairing 2 1st. LO vs. 2nd LO 
MWp3 = ranksum(for_stats_analysis.Trial_2,for_stats_analysis.Trial_3); % pairing 3 L+US vs. 2nd LO 

% Chi-squared variance test, between trials 1&2, 1&3
% variance_trial_one=var(for_stats_analysis.Trial_1);
% [h,p]=vartest(for_stats_analysis.Trial_2, variance_trial_one);
% [h1,p1]=vartest(for_stats_analysis.Trial_3, variance_trial_one);

%% subplotting imagesc plots for each trial (only works for 10 sec analysis) 
% use imagesc_subplot function for tighter margins. Code below works 
% with very thick margins 
% if time_series == 10 && runningrms == 2
if time_series == 10 
figure(7);

% 1LO 
    subaxis(1, 3, 1, 'Spacing', 0.03);
    imagesc(imagesc_data.Trial_1matrix')
    colorbar
    title('1st LO', 'Fontsize', 14) 
    % setting waterfall axes 
    ylim=[0 0.3];
    ylabel('Event Number', 'Fontsize', 14); 
%     xlabel('Time After Light Stimulus (s)', 'Fontsize', 14) 
    xlol = 4:4:40;
    xlol2 = 1:1:10;
    set(gca,'XTick',xlol ); %This is going to be the only values affected. 
    set(gca,'XTickLabel',xlol2 ); %This is what it's going to appear in those places
    
    yticks = 0:10:60 ; 
    set(gca,'YTick',yticks); %This is going to be the only values affected. 
%     set(gca,'YTick','');
    ax = gca;
    ax.FontSize = 16; 
    xlabel('','FontSize',10)
    
%     caxis manual 
    v = caxis ;
%     caxis(v)

% 2LO 
    subaxis(1, 3, 3, 'Spacing', 0.03);
    imagesc(imagesc_data.Trial_4matrix')
    colorbar
    title('2nd LO', 'Fontsize', 14) 
    % setting waterfall axes 
    %     ylim=[0 0.3];
    %     ylabel('Stimulus Event Number', 'Fontsize', 14); 
%     ticks = 0:5:60 ; 
%     yticks(ticks) ; 
    %     xlabel('Time After Light Stimulus (s)', 'Fontsize', 14) 
    xlol = 4:4:40;
    xlol2 = 1:1:10;
    set(gca,'XTick',xlol ); %This is going to be the only values affected. 
    set(gca,'XTickLabel',xlol2 ); %This is what it's going to appear in those places
    
%     yticks = 0:10:60 ; 
%     set(gca,'YTick',yticks); %This is going to be the only values affected. 
    set(gca,'YTick','');
    
    ax = gca;
    ax.FontSize = 16; 
    xlabel('','FontSize',10)
    
%     v = caxis ;  
        caxis(v)
    
   
% L+US 
    subaxis(1, 3, 2, 'Spacing', 0.03);
    imagesc(imagesc_data.Trial_3matrix')
    colorbar
    title('L+tDUS', 'Fontsize', 14) 
    % setting waterfall axes 
    ylim=[0 0.3];
    %     ylabel('Stimulus Event Number', 'Fontsize', 16); 
%     xlabel('Time After Light Stimulus (s)', 'Fontsize', 14) 
    xlol = 4:4:40;
    xlol2 = 1:1:10;
    set(gca,'XTick',xlol ); %This is going to be the only values affected. 
    set(gca,'XTickLabel',xlol2 ); %This is what it's going to appear in those places 
    
    yticks = 0:10:60 ; 
%     ylol2 = ['' 5 '' 15 '' 25 '' 35 '' 45 '' 55 ''];
    set(gca,'YTick','');
%     set(gca,'YTick',yticks); %This is going to be the only values affected. 
%     set(gca,'YTickLabel',ylol2); %This is what it's going to appear in those places 
    ax = gca;
    ax.FontSize = 16; 
    xlabel('Time After Light Stimulus (s)','FontSize',15)
    
    caxis(v) 
%     v = caxis ;
    


% Adjust the horizontal spacing between subplots
hSpacing = 0.005; % Modify this value to adjust the spacing
subaxis('SpacingHoriz', hSpacing);
end 


% figure 3 plotting code
figure(9)
matrix1 = imagesc_data.Trial_3matrix;
imagesc(matrix1(:,1)')
set(gca,'YTickLabel',[]);

if runningrms == 1 
    xlol = 4:4:40;
    xlol2 = 1:1:10;
    set(gca,'XTick',xlol ); %This is going to be the only values affected. 
    set(gca,'XTickLabel',xlol2 ); %This is what it's going to appear in those places 
end   

if runningrms == 2 
    xlol = 1:1:10;
    xlol2 = 1:1:10;
    set(gca,'XTick',xlol ); %This is going to be the only values affected. 
    set(gca,'XTickLabel',xlol2 ); %This is what it's going to appear in those places
%     xlabel('Time After Light Stimulus (s)', 'Fontsize', 10)
end 

if runningrms == 3 
    xlol = 10:10:100;
    xlol2 = 1:1:10;
    set(gca,'XTick',xlol ); %This is going to be the only values affected. 
    set(gca,'XTickLabel',xlol2 ); %This is what it's going to appear in those places
%     xlabel('Time After Light Stimulus (s)', 'Fontsize', 10)
end 
% 127537 - index of first event 
% 227535 - index of second event 
% sampling rate = 20k/s 
% 10 sec after event = 200000

ax = gca;
ax.FontSize = 9; 
xlabel('','FontSize', 10)

figure(10)
% plot(stas.V1Ldata(1,127537:127537+200000))
% plot(alldata.V1Ldata(127537:127537+100000))
% xlim([0 10*10^4]) ;
plot(alldata.V1Ldata(index_stim(57):index_stim(57)+fs*10))
set(gca,'XLim',[0 10*10^4])

% for median 1LO array
matrix2 = imagesc_data.Trial_1matrix;
s=size(matrix2); % 10 by 60 matrix 
tmatrix = matrix2'; % get matrix x to be seconds, y to be event number 
trialmedians = [];
for i = 1:s(2) % 1 to ~60, to get a vector of median values (each from a single event) 
    eventmedian = median(tmatrix(i,:)) ; 
    trialmedians = [trialmedians eventmedian] ;
end 
% median_of_medians = median(trialmedians); % median of 1LO medians 
% matrix = matrix/median_of_medians ; % normalize 1LO matrix by 1LO median median 
ax = gca;
ax.FontSize = 10.5; 
xlabel('','FontSize', 10)

figure(11)
clims = [0 3];
imagesc(trialmedians', clims)
% imagesc(trialmedians')
set(gca,'XTickLabel', []);
% ylabel('Event') 
% set(gca,'XTick',xlol ); %This is going to be the only values affected. 
% set(gca,'XTickLabel',xlol2 ); %This is what it's going to appear in those places

figure(12)
% clims = [0 3];
imagesc(mean(trialmedians),clims)
% imagesc(0.7754,clims)1.4586
set(gca,'YTickLabel',[], 'XTickLabel', []);

% 1LO normalized L+US 
median_of_medians = median(trialmedians); % median of 1LO medians 
matrix1 = matrix1./median_of_medians ; % normalize L+US matrix by 1LO median median 
figure(13)
imagesc(matrix1')
set(gca,'XTick',xlol ); %This is going to be the only values affected. 
set(gca,'XTickLabel',xlol2 ); %This is what it's going to appear in those places
ylabel('Event Number','Fontsize', 14) 
xlabel('Time After Light Stimulus (s)', 'Fontsize', 14)
title('1LO normalized L+US', 'Fontsize', 14)