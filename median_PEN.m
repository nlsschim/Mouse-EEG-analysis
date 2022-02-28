%%  Authors: Kat Floerchinger, Hannah Mach, Henry Tan
%This code is for the PEN cohort to run through the data and get the
%median values 


%% reading cohort files 

file1={'06-24-21 RECUT session 2 m2\', '8_10_21 m1\', '8_10_21 m2 session 1\', '06-23-21 RECUT 2.0 session 1 m1\','8_12_21 m1\','8_12_21 m2\', '8_13_21\' };
str=string(file1);
MainDirectory = 'C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\';

%% medians or variance 

button = input("Create PEN matrix of median values or variance? '1'=medians? '2'=variance: ") ;
button2 = input("Matrix of L+US and 2nd LO minus medians minus 1st LO medians? '1' = yes, '2' = no: ") ; 
normal = input("Normalize data by median of 1st LO or rms_baseline? '1'=median of 1LO, '2' =rms_baseline: "); 

%% creating PEN Matrix to store medians or variance 

% PEN_MATRIX = zeros(7,4);

figure 
hold on

%% Reading experiment dates 
counter = 0 ;
for f=1:length(str) 
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

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\06-23-21 RECUT 2.0 session 1 m1\"
V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\06-24-21 RECUT session 2 m2\" 
V1L=set_channels(3);S1L=set_channels(4);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_10_21 m1\" 
V1L=set_channels(4);S1L=set_channels(3);S1R=set_channels(2);V1R=set_channels(1);lightstim=set_channels(5);
end 

if folder == "C:\Users\Henry\MATLAB\Mourad Lab\Mouse_EEG\Data\PEN\8_10_21 m2 session 1\"
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

%% calculate pre-stim RMS for normalization

baseline_rms=[];
disp(baseline.name);
load([folder baseline.name])
calc_baseline;

% create matrix to hold data for statistical testing
for_stats_new = [];
for_stats_analysis=[];
%insert thresholding here

for z=1:4

     if isequal(file_list(z).name,"Trial 2.mat"), continue, end %for 12-23
     if isequal(file_list(z).name,"Trial 6.mat"), continue, end %for 12-23
    disp(z)%display the number that the code is on in the terminal, do not put a ';' after it 
    disp(file_list(z).name);%displays the name of the file in the terminal
    load([folder file_list(z).name]);%bringing the file data into matlab so that the code can run
%     US_diag_stim;  
%     super_US_diag_stim ;
    miniUS_Diag_stim;
end

% % to rename trials and skip 2 
    for_stats_analysis.Trial_2 = for_stats_analysis.Trial_3 ; 
    for_stats_analysis.Trial_3 = for_stats_analysis.Trial_4 ; 

%% Creating a vector to call on later to plot the medians
if button ==1 
    PEN_FIRST_LIGHT = median(for_stats_analysis.Trial_1);
    PEN_LIGHT_ULTRASOUND = median(for_stats_analysis.Trial_2);
    PEN_SECOND_LIGHT = median(for_stats_analysis.Trial_3);
end
% variance 
if button == 2 
    PEN_FIRST_LIGHT = var(for_stats_analysis.Trial_1);
    PEN_LIGHT_ULTRASOUND = var(for_stats_analysis.Trial_2);
    PEN_SECOND_LIGHT = var(for_stats_analysis.Trial_3);
end 

if button2 == 1 
    % minus first light median/variance
    PENY = [rms_baseline, PEN_FIRST_LIGHT-PEN_FIRST_LIGHT, PEN_LIGHT_ULTRASOUND-PEN_FIRST_LIGHT, PEN_SECOND_LIGHT-PEN_FIRST_LIGHT];
else
    % medianL+US and median2LO NOT - median of 1LO
    PENY = [rms_baseline, PEN_FIRST_LIGHT, PEN_LIGHT_ULTRASOUND, PEN_SECOND_LIGHT];
end

%% filling matrix 
%     
%     PEN_MATRIX(f, :) = [PENY] ;
%     plot(1:4, PENY, 'o-', 'DisplayName','PEN DATA')
%     title('PEN DATA') 
%     

%% for plotting each experiment data normalized its median of 1st LO 
% this was to try and create a matrix for our pen data, but differing lengths made this difficult--used string array instead 

% for ii = 1:3 
%     concat=['Trial_' num2str(ii)];
%     PEN_MATRIX.(f)(ii, : ) = for_stats_analysis.(concat)(1:550) ; 
% end 
% 
% counter = 0 ; 
% row = (counter*3);
% for ii = 1:3 
%     concat=['Trial_' num2str(ii)];
%     PEN_MATRIX.(ii) = for_stats_analysis.(concat) ; 
% end 
% counter = counter+f ;

% 
% for ii = 1:3 
% concat=[counter 'Trial_' num2str(ii)];
% concat2=['Trial_' num2str(ii)];
% PEN_MATRIX.(concat) = for_stats_analysis.(concat2) ;
% end
% counter = counter + 1 ;
% 
% PEN_MATRIX = for_stats_analysis ;

% dummy = [ for_stats_analysis.Trial_1(1:550);  for_stats_analysis.Trial_2(1:550);  for_stats_analysis.Trial_3(1:550)] ;

% for ii = 1+(3*counter):3*f 
%     concat=['Trial_' num2str(i)];
%     dummy(ii, :) = for_stats_analysis.(concat) ;
% end 
% counter = counter + 1 ;
% 
% if f == 1 
%     PEN_MATRIX1 = [for_stats_analysis.Trial_1(1:550); for_stats_analysis.Trial_2(1:550); for_stats_analysis.Trial_3(1:550)] ;
% elseif f == 2 
%     PEN_MATRIX2.a = [for_stats_analysis.Trial_1(1:329)] ;
%     PEN_MATRIX2.b = [for_stats_analysis.Trial_2(1:550)] ;
%     PEN_MATRIX2.c = [for_stats_analysis.Trial_3(1:550)] ; 
% elseif f == 3 
%     PEN_MATRIX3.a = [for_stats_analysis.Trial_1(1:416) ] ;
%     PEN_MATRIX3.b = [for_stats_analysis.Trial_2(1:550) ];
%     PEN_MATRIX3.c = [for_stats_analysis.Trial_3(1:550)] ; 
% elseif f == 4 
%     PEN_MATRIX4.a = [for_stats_analysis.Trial_1(1:529) ];
%     PEN_MATRIX4.b = [for_stats_analysis.Trial_2(1:529)] ;
%     PEN_MATRIX4.c = [for_stats_analysis.Trial_3(1:550)] ; 
% elseif f == 5 
%     PEN_MATRIX5 = [for_stats_analysis.Trial_1(1:550); for_stats_analysis.Trial_2(1:550); for_stats_analysis.Trial_3(1:550)] ; 
% elseif f == 6
%     PEN_MATRIX6 = [for_stats_analysis.Trial_1(1:550); for_stats_analysis.Trial_2(1:550); for_stats_analysis.Trial_3(1:550)] ; 
% elseif f == 7
%     PEN_MATRIX7 = [for_stats_analysis.Trial_1(1:550); for_stats_analysis.Trial_2(1:550); for_stats_analysis.Trial_3(1:550)] ; 
% end 

% for ii = 1+(3*counter):3*f 
%     for i= 1:3 
%         concat=['Trial_' num2str(i)];
%         PEN_MATRIX.(ii) = for_stats_analysis.(concat) ; 
%     end 
% end
% counter = counter + 1 ;

if f == 1 
    PEN_MATRIX{1} = [for_stats_analysis.Trial_1] ;
    PEN_MATRIX{2} = [for_stats_analysis.Trial_2] ;
    PEN_MATRIX{3} = [for_stats_analysis.Trial_3] ;
elseif f == 2 
    PEN_MATRIX{4} = [for_stats_analysis.Trial_1] ;
    PEN_MATRIX{5} = [for_stats_analysis.Trial_2] ;
    PEN_MATRIX{6} = [for_stats_analysis.Trial_3] ; 
elseif f == 3 
    PEN_MATRIX{7} = [for_stats_analysis.Trial_1] ;
    PEN_MATRIX{8} = [for_stats_analysis.Trial_2] ;
    PEN_MATRIX{9} = [for_stats_analysis.Trial_3] ;
elseif f == 4 
    PEN_MATRIX{10} = [for_stats_analysis.Trial_1] ;
    PEN_MATRIX{11} = [for_stats_analysis.Trial_2] ;
    PEN_MATRIX{12} = [for_stats_analysis.Trial_3] ;
elseif f == 5 
    PEN_MATRIX{13} = [for_stats_analysis.Trial_1] ;
    PEN_MATRIX{14} = [for_stats_analysis.Trial_2] ;
    PEN_MATRIX{15} = [for_stats_analysis.Trial_3] ;
elseif f == 6
    PEN_MATRIX{16} = [for_stats_analysis.Trial_1] ;
    PEN_MATRIX{17} = [for_stats_analysis.Trial_2] ;
    PEN_MATRIX{18} = [for_stats_analysis.Trial_3] ;
elseif f == 7
    PEN_MATRIX{19} = [for_stats_analysis.Trial_1] ;
    PEN_MATRIX{20} = [for_stats_analysis.Trial_2] ;
    PEN_MATRIX{21} = [for_stats_analysis.Trial_3] ;
end 
ACTUAL_PEN_MATRIX_(f, :) = [PENY] ;
end 

%                 m1           m2              m3            m4               m5             m6               m7 
PEN{1} = {PEN_MATRIX{1}; PEN_MATRIX{4}; PEN_MATRIX{7}; PEN_MATRIX{10}; PEN_MATRIX{13}; PEN_MATRIX{16}; PEN_MATRIX{19}} ; % 1LO 
PEN{2} = {PEN_MATRIX{2}; PEN_MATRIX{5}; PEN_MATRIX{8}; PEN_MATRIX{11}; PEN_MATRIX{14}; PEN_MATRIX{17}; PEN_MATRIX{20}} ; % L+US 
PEN{3} = {PEN_MATRIX{3}; PEN_MATRIX{6}; PEN_MATRIX{9}; PEN_MATRIX{12}; PEN_MATRIX{15}; PEN_MATRIX{18}; PEN_MATRIX{21}} ; % 2LO 
% how to call cell in cell array 
% PEN{1}(1,1) 

% PEN_MATRIX 
