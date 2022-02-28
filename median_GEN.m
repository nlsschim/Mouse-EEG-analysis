%% Authors: Kat Floerchinger, Hannah Mach, Henry Tan
%This code is for the GEN cohort to run through the data and get the
%median values 


%% reading cohort files 
file1={'12-23 Mouse Experiment\', '12-16 RECUT\', '12-13-19 recut RIGHT\', '12-24 Data\', '12-27-19 RECUT\','12-12-19 RECUT\', '11-27-19 MOUSE RECUT\'};
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\GEN\';

%% medians or variance 

button = input("Create GEN matrix of median values or variance? '1'=medians, '2'=variance: ") ;
button2 = input("Matrix of L+US and 2nd LO minus medians minus 1st LO medians? '1' = yes, '2' = no: ") ; 
normal = input("Normalize data by median of 1st LO or rms_baseline? '1'=median of 1LO, '2' =rms_baseline: "); 

%% creating GEN Matrix to store medians or variance 
% GEN_MATRIX = zeros(7,4);
% figure 
% hold on

%% Reading experiment dates 
for f=1:length(str)
folder = fullfile(MainDirectory,str{f});
% dir ('folder');

%Change what is in the string deGENding on which file\files you want to run
file_list = dir([folder 'TRIAL*.mat']);
baseline = dir([folder 'Baseline.mat']); % or baseline 1 or baseline 2 deGENding on trials 

    if f==1 || f== 4 || f==2
        set_channels=[1 2 3 4 7]; % updated so you do not have to change last number (we added code for searching for light). Change ddeGENding on channel in surgery notes (9?)
        % 1set_channels=[1 2 3 4 9]; % for 12\16\19 data, 
        % set_channels=[1 2 3 4 5]; % 6\24\21 data, 6\23\21 , 7\1\21, 12\13\19
    else
        set_channels=[1 2 3 4 5];
    end
    if f==2
        set_channels=[1 2 3 4 9];
    end
    ch_names={'V1L','S1L','S1R', 'V1R', 'lightstim'}; %setting up the names that will be assigned in the matrix and the order
    trial_names={' FIRST LIGHT ONLY' 'LIGHT + US' ' SECOND LIGHT ONLY'};

%% channel configuration 

V1L=set_channels(1);S1L=set_channels(2);S1R=set_channels(3);V1R=set_channels(4);lightstim=set_channels(5);

%% calculate pre-stim RMS for normalization
baseline_rms=[];
disp(baseline.name);
load([folder baseline.name])
calc_baseline;

% create matrix to hold data for statistical testing
for_stats_new = [];
for_stats_analysis=[];

%% running each experiment date 
for z=1:4
%      if isequal(file_list(z).name,"TRIAL2.mat"), continue, end % skips trial 2 for refactory period trial does we dont car about (yet)
%      if isequal(file_list(z).name,"Trial 2.mat"), continue, end 
     if isequal(file_list(z).name,"Trial 2.mat"), continue, end %for 12-23
     
%      if isequal(file_list(z).name,"TRIAL6.mat"), continue, end % for 6\24 second session 
%      if isequal(file_list(z).name,"TRIAL 10.mat"), continue, end 
%      if isequal(file_list(z).name,"TRIAL 14 mat"), continue, end 
     % data trials are 'Trial 2.mat w\ a space. Some are without a space
     % ex. 'trial1'
%     counter = counter + 1 ; 
    disp(z)%display the number that the code is on in the terminal, do not put a ';' after it 
    disp(file_list(z).name);%displays the name of the file in the terminal
    load([folder file_list(z).name]);%bringing the file data into matlab so that the code can run
%     US_diag_stim;  
%     super_US_diag_stim ;
    miniUS_Diag_stim;
end

%     to rename trials and skip refractory 1 - 1LO, 2 = L+US, 3 = 2LO  
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 
    

%% Creating a vector to call on later to plot the medians

% if button ==1 
%     GEN_FIRST_LIGHT = median(for_stats_analysis.Trial_1);
%     GEN_LIGHT_ULTRASOUND = median(for_stats_analysis.Trial_2);
%     GEN_SECOND_LIGHT = median(for_stats_analysis.Trial_3);
% end
% % variance 
% if button == 2 
%     GEN_FIRST_LIGHT = var(for_stats_analysis.Trial_1);
%     GEN_LIGHT_ULTRASOUND = var(for_stats_analysis.Trial_2);
%     GEN_SECOND_LIGHT = var(for_stats_analysis.Trial_3);
% end 
% 
% if button2 == 1 
%     % minus first light median/variance
%     GENY = [rms_baseline, GEN_FIRST_LIGHT-GEN_FIRST_LIGHT, GEN_LIGHT_ULTRASOUND-GEN_FIRST_LIGHT, GEN_SECOND_LIGHT-GEN_FIRST_LIGHT];
% else
%     % medianL+US and median2LO NOT - median of 1LO
%     GENY = [rms_baseline, GEN_FIRST_LIGHT, GEN_LIGHT_ULTRASOUND, GEN_SECOND_LIGHT];
% end
% 
% %% filling matrix 
% 
%     GEN_MATRIX(f, :) = [GENY] ;
%     plot(1:4, GENY, 'o-', 'DisplayName','GEN DATA')
%     title('GEN DATA')
% 

%% for plotting each experiment data normalized its median of 1st LO 

% GEN_MATRIX = [] ; 
% x=1:length(for_stats_analysis.Trial_1) 
% for i = 1:7 
%     for ii = 1:3 
%         concat=['Trial_' num2str(ii)];
%         GEN_MATRIX(ii,i) = for_stats_analysis.(concat) ; 
%         plot(x, for_stats_analysis.(concat)) 
%         hold on
%     end 
% end 
% % plot(1:x, for_stats_analysis.Trial 1) 

% GEN_MATRIX = [] ; 
% rows = f:f*3 ; 
% GEN_MATRIX(
% 
% counter = 0 ;
% GEN_MATRIX = [] ; 
% row = (counter*3) ;
% for ii = 1:3 
%     concat=['Trial_' num2str(ii)];
%     GEN_MATRIX(row+ii,ii) = for_stats_analysis.(concat) ;
% end 
% counter = counter+f ;

% concat = ['mouse_' num2str(f)];
% for ii = 1:3
% concat2 = ['Trial_' num2str(ii)];
% GEN_MATRIX.(concat)(ii, :) = for_stats_analysis.(concat2) ; 
% end 

if f == 1 
    GEN_MATRIX{1} = [for_stats_analysis.Trial_1] ;
    GEN_MATRIX{2} = [for_stats_analysis.Trial_2] ;
    GEN_MATRIX{3} = [for_stats_analysis.Trial_3] ;
elseif f == 2 
    GEN_MATRIX{4} = [for_stats_analysis.Trial_1] ;
    GEN_MATRIX{5} = [for_stats_analysis.Trial_2] ;
    GEN_MATRIX{6} = [for_stats_analysis.Trial_3] ; 
elseif f == 3 
    GEN_MATRIX{7} = [for_stats_analysis.Trial_1] ;
    GEN_MATRIX{8} = [for_stats_analysis.Trial_2] ;
    GEN_MATRIX{9} = [for_stats_analysis.Trial_3] ;
elseif f == 4 
    GEN_MATRIX{10} = [for_stats_analysis.Trial_1] ;
    GEN_MATRIX{11} = [for_stats_analysis.Trial_2] ;
    GEN_MATRIX{12} = [for_stats_analysis.Trial_3] ;
elseif f == 5 
    GEN_MATRIX{13} = [for_stats_analysis.Trial_1] ;
    GEN_MATRIX{14} = [for_stats_analysis.Trial_2] ;
    GEN_MATRIX{15} = [for_stats_analysis.Trial_3] ;
elseif f == 6
    GEN_MATRIX{16} = [for_stats_analysis.Trial_1] ;
    GEN_MATRIX{17} = [for_stats_analysis.Trial_2] ;
    GEN_MATRIX{18} = [for_stats_analysis.Trial_3] ;
elseif f == 7
    GEN_MATRIX{19} = [for_stats_analysis.Trial_1] ;
    GEN_MATRIX{20} = [for_stats_analysis.Trial_2] ;
    GEN_MATRIX{21} = [for_stats_analysis.Trial_3] ;
end 
end

%                 m1           m2              m3            m4               m5             m6               m7 
GEN{1} = {GEN_MATRIX{1}; GEN_MATRIX{4}; GEN_MATRIX{7}; GEN_MATRIX{10}; GEN_MATRIX{13}; GEN_MATRIX{16}; GEN_MATRIX{19}} ; % 1LO 
GEN{2} = {GEN_MATRIX{2}; GEN_MATRIX{5}; GEN_MATRIX{8}; GEN_MATRIX{11}; GEN_MATRIX{14}; GEN_MATRIX{17}; GEN_MATRIX{20}} ; % L+US 
GEN{3} = {GEN_MATRIX{3}; GEN_MATRIX{6}; GEN_MATRIX{9}; GEN_MATRIX{12}; GEN_MATRIX{15}; GEN_MATRIX{18}; GEN_MATRIX{21}} ; % 2LO 

% 7 x 3, top 3 are m1 1LO, L+US, 2LO 
