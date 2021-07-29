%% Authors: Devon Griggs, John Kucewicz, Nels Schimek, Alissa Phutirat, Henry Tan
%This code is like the original loopy_ecog but will run statistic analysis
%for kruskal wallis 3 pair, anova1, and mann whitney for all 3 pairs
%individually
close all
clear all
%clears all data so that there are no missasinged values

%Change folder path to match where you save the files and data
%always need "\" at the end of the folder name, copy adn paste so that no errors are made

% note: trials have been formatted "trial x"; baselines : "baseline x"; 
% trials > 1:4 have been placed in separate folders 

%%
%work 

% SHAM 

folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\06-30-2020 Mouse Experiment 1\'; 
% use ch 7 as light stim, use baseline 1 and -1 for j

%  folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\06-23-2020 Mouse Experiment 2\'; 
% use ch 7 as light stim, -1 for j

% folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\06-25-2020 Mouse Experiment 1\'; 
% use ch 7 as light stim, works with baseline 1 and  for j=2:(length(index_stim)-3) for datastart(lightstim):dataend(lightstim)

%  folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\06-24-2020 Mouse Experiment 3\'; 
% use ch 7 as light stim, for j=2:(length(index_stim)-5) % 6/24 experiment 3 

% folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\06-24-2020 Mouse Experiment 1\';
% works w/ j=2:(length(index_stim)-3) % 6/24 experiment 1 in US Diag Stim
% Baseline 1.mat, use ch 7 as light stim,

% folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\05-29-2020 Mouse experiment\'; 
% index error in char(names(i)) in US diag stim, same as 12/16 data:
% error in US diag stim alldata.lightstimdata=data(datastart(lightstim):dataend(lightstim));
% breaks trial 1
% works if lightstim = 5 in US diagstim datastart(5):dataend(5)
% making sure the skipping refractory names are case sensitive (TRIAL vs.
% Trial. see line 15 of US-Diag stim 
%-1 for j

% folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\06-23-20 MOUSE 1 RECUT\' ;
% use ch 5 as light stim, -3 for j

% Not SHAM 

% folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\12-23 Mouse Experiment\'; 
% ch 7 as light stim

% folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\12-16 RECUT\'; 
% works if light stim channel is set to 9 instead of 7, -3 for j

% folder = 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\06-24-21 RECUT session 2\' ;
% works with channel 5 as light stim, baseline 2, -2 for j

% folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\06-23-21 RECUT\06-23-21 RECUT 2.0 session 1\' ;
%works with channel 5 as light stim, -3 for j

% folder = 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\12-24 Data\' ;
% runs with us_diag_stim j=2:(length(index_stim)-5)

% folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\12-13-2019 Mouse Experiment\' ;
%works but is missing events from 2nd light only please use recut

%  folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\12-13-19 recut RIGHT\' ;
%use ch 5 as light stim, -4 for j

% folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\12-27-19 RECUT\' ;
% use ch 5 as light stim, -3 for j

% folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\11-27-19 MOUSE RECUT\' ;
%use ch 5 as light stim, -3 for j 

%  folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\12-12-19 RECUT\' ;
%use ch 5 as light stim, -3 for j
%light + US very short 


% dont work 

% folder= 'C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\11-22-19 MOUSE RECUT\' ;

% folder='C:\Users\MouradLab\MATLAB\Projects\Mouse ecog\Data\07-01-21 Vis Stim Experiment Mouse 3\'; 

%% 
%Change what is in the string depending on which file/files you want to run
file_list=dir([folder 'TRIAL*.mat']);
baseline=dir([folder 'Baseline 1.mat']); % or baseline 1 or baseline 2 depending on trials 

set_channels=[1 2 3 4 7]; % updated so you do not have to change last number (we added code for searching for light). Change ddepending on channel in surgery notes (9?)
% set_channels=[1 2 3 4 9]; % for 12/16/19 data, 
% set_channels=[1 2 3 4 5]; % 6/24/21 data, 6/23/21 , 7/1/21

ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};
%plot_cwt=input('Plot CWTs? Y=1 N=2 :'); %CWT will show the frequency breakdown, use 2 if you just want to look at the averages of the EEG
plot_cwt=2;
%this names the channels based on where they were placed, make sure they match lab chart
V1L=set_channels(3);
S1L=set_channels(4);
S1R=set_channels(2);
V1R=set_channels(1);
lightstim=set_channels(5);
%this is important since its how the other code will find the channels.
%EverythinG is coded by name so it is not hard coded in 
%';' prevents the line outcome from appearing in the terminal everytime, it just looks bad and is useless 
%create data arrays

%calculate pre-stim RMS for normalization
baseline_rms=[];
disp(baseline.name);
load([folder baseline.name])
calc_baseline;

% create matrix to hold data for statistical testing

for_stats_analysis=[];
%insert thresholding here

%create figure for plotting histograms
%figure;
% measure each file 
%for z=1:length(file_list) %go through all the files that are in the folder  
% counter = 0 ;
%for z=1:3 

for z=1:4
     % if isequal(file_list(z).name,"TRIAL2.mat"), continue, end % skips trial 2 for refactory period trial does we dont car about (yet)
%      if isequal(file_list(z).name,"Trial 2.mat"), continue, end 
     if isequal(file_list(z).name,"TRIAL 2.mat"), continue, end %for 12-23
     if isequal(file_list(z).name,"TRIAL 6.mat"), continue, end % for 6/24 second session 
%      if isequal(file_list(z).name,"TRIAL 10.mat"), continue, end 
%      if isequal(file_list(z).name,"TRIAL 14 mat"), continue, end 
     % data trials are 'Trial 2.mat w/ a space. Some are without a space
     % ex. 'trial1'
%     counter = counter + 1 ; 
    disp(z)%display the number that the code is on in the terminal, do not put a ';' after it 
    disp(file_list(z).name);%displays the name of the file in the terminal
    load([folder file_list(z).name]);%bringing the file data into matlab so that the code can run
%     US_diag_stim;  
    super_US_diag_stim ;
    
end

% to rename trials and skip 2 
for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 

%% histogram overlays - will remove second waterfall plot 

% % 1 overlaid by 2
% subplot(1,4,2);
% histogram(for_stats_analysis.Trial_1)
% hold on
% histogram(for_stats_analysis.Trial_2)
% legend('Trial 1','Trial 2')
% axis([0 0.5 0 400])
% 
% 
% % 2 overlaid by 3
% subplot(1,4,3);
% histogram(for_stats_analysis.Trial_2)
% hold on
% histogram(for_stats_analysis.Trial_3)
% legend('Trial 2','Trial 3')
% axis([0 0.5 0 400])
% 
% % 1 overlaid by 3
% subplot(1,4,4);
% histogram(for_stats_analysis.Trial_1)
% hold on
% histogram(for_stats_analysis.Trial_3)
% legend('Trial 1','Trial 3')
% axis([0 0.5 0 400])
% 
% 
% % all overlaid
% figure
% histogram(for_stats_analysis.Trial_1)
% hold on
% histogram(for_stats_analysis.Trial_2)
% hold on 
% histogram(for_stats_analysis.Trial_3)
% legend('Trial 1','Trial 2','Trial 3')
% title('12/23/19 Mouse')
%%
% Grouping the data together for comparative analysis - trial 2=the real
% trail 3 (refractory skipped). Thus, trial 3 = the real trial 4

% for kruskal-wallis 3 pairings 
first_second_third_vector=[for_stats_analysis.Trial_1 for_stats_analysis.Trial_2 for_stats_analysis.Trial_3];
% broken up for mann whitney/wilcox test (or just use stats analysis trials

% first_second_vector=[for_stats_analysis.Trial_1 for_stats_analysis.Trial_2];
% first_third_vector=[for_stats_analysis.Trial_1 for_stats_analysis.Trial_3];
% second_third_vector=[for_stats_analysis.Trial_2 for_stats_analysis.Trial_3];

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
run_stats_tests(first_second_third_vector, first_vs_second_vs_third);
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