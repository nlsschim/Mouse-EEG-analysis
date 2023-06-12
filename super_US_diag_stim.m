%% Authors: Devon Griggs, John Kucewicz, Nels Schimek, Kat Floerchinger, Hannah Mach, Alissa Phutirat, Henry Tan
%this code is meant to set the index_stim equal to 60 so that we can
%standardize the length to calculate reliable p values 
fs=tickrate(1);
time1=1:dataend(1);
time=time1/fs/60;

%% change the bandpass for filtering pls

% bandpasses = [3, 100; 5, 55; 30, 59; 12, 29; 4, 7; 8, 11] ; % automated bands 
%     [bb,aa]=butter(3,bandpasses(brain_wave,:)/(fs/2));

[bb,aa]=butter(2,[5,55]/(fs/2));

%Organize data into structure array
alldata=[]; %initialize structure array
alldata.V1Ldata=filtfilt(bb,aa,data(datastart(V1L):dataend(V1L))')';
alldata.S1Ldata=filtfilt(bb,aa,data(datastart(S1L):dataend(S1L))')';
alldata.S1Rdata=filtfilt(bb,aa,data(datastart(S1R):dataend(S1R))')';
alldata.V1Rdata=filtfilt(bb,aa,data(datastart(V1R):dataend(V1R))')';

alldata.lightstimdata=filtfilt(bb,aa,data(datastart(lightstim):dataend(lightstim))')';

% alldata.lightstimdata=data(datastart(lightstim):dataend(lightstim)); % USE THIS

% alldata.lightstimdata=filtfilt(bb,aa,data(datastart(5):dataend(5))')'; % for 5/29 Hypothesis:
% this works if not all channels are imported; channel 7 = channel 5 vs.
% channel 1... 5, 6, 7 => channel 1-4, channel 7 
% what changes in experiments is whether channels 5-6 are included in
% export

%create names to access fields of 'alldata' for plotting loops
names={'V1Ldata','S1Ldata','S1Rdata','V1Rdata','lightstimdata'}; 
foranalysis={'V1Ldata','S1Ldata','S1Rdata','V1Rdata'}; 
 
Wo = 0.5/(10000/2);  BW = Wo/35;
[b,a] = iirnotch(Wo,BW); 
y = filter(b,a,alldata.V1Ldata);

Wo = 0.5/(10000/2);  BW = Wo/100;
[b,a] = iirnotch(Wo,BW); 
y = filter(b,a,y);

Wo = 1/(10000/2);  BW = Wo/35;
[b,a] = iirnotch(Wo,BW); 
y = filter(b,a,y);

Wo = 1/(10000/2);  BW = Wo/100;
[b,a] = iirnotch(Wo,BW); 
y = filter(b,a,y);

%% additional filtering 
%Filter out noise
% alldata.V1Ldata=alldata.V1Ldata(abs(alldata.V1Ldata)<0.02); %hardcoded filtering

% extra filtering borrowed from end of code for stat analysis?? 6_24_22
deviation=std(alldata.V1Ldata);
trialmean = mean(alldata.V1Ldata);
index = abs(alldata.V1Ldata)>trialmean+4*deviation;


% THIS SEEMS TO MAINTAIN POSITION of events in waterfall! 
% making all abs(values) >4*std = 0 
alldata.V1Ldata(index) = 0 ; 
% creating a copy of alldata with artifact removed 
tempV1Ldata = alldata.V1Ldata;
% finding the indexes where alldata = 0 
index2 = find(alldata.V1Ldata==0);
% replacing  indices with a value of '0' with the median of alldata 
alldata.V1Ldata(index2) = median(tempV1Ldata) ; 

%% detect stimuli

X = alldata.lightstimdata;
X=X-min(X);
X=X/max(X);
Y=X>0.5;
Z=diff(Y);
index_allstim=find(Z>0.5);
index_allstim=index_allstim+1;

%find first pulse of each train, if stimulation contains trains
index_trains=diff(index_allstim)>2*fs; 
index_allstim(1)=[];
index_stim=index_allstim(index_trains);

%% PLOTTING V1Ldata
%     figure
%     plot(alldata.V1Ldata(index_stim(57):index_stim(57)+fs*10))
%     set(gca,'XLim',[0 10*10^4])


%% Create STAs
for i=1:4 %initiate data array to hold STAs
stas.(char(names(i)))=[];
       % title(file_list(z).name,'interpreter','none');
end

if  time_series ==3 
    tb=1; %time before stim to start STA
    ta=3; % first 3 seconds
else 
    tb=1;
    ta=10; %time after stim to end STA
end 

%% Data conditioning (cont.) 
% prevents errors based on discrepency between V1Ldata and
% lightstimdata length

for i=1:4
   for j=2:(length(index_stim)-4) 
       stas.(char(names(i)))=[stas.(char(names(i))); alldata.(char(names(i)))((index_stim(j)-fs*tb):(index_stim(j)+fs*ta))];
  
   end
end 

%% plot STAS

responseWindowEnd=0.4;

%figure
x2=1:length(stas.(char(names(1))));
x2=x2/fs-1; %time axis
%ylabels={'S1 (mV)';'A1 (mV)';'V1R (mV)'; 'V1L (mV)';'A1R (Hz)';'S1R (Hz)'};

minvalarray=zeros(length(foranalysis),1);
minidxarray=zeros(length(foranalysis),1);
maxvalarray=zeros(length(foranalysis),1);
maxidxarray=zeros(length(foranalysis),1);
RMSvalbarray=zeros(length(foranalysis),1);
RMSvalaarray=zeros(length(foranalysis),1);

%%
%collect all of the individual points of data
all_points(1).name=names(1);
d=stas.(char(names(1)));

%filter data
% d=filtfilt(bb,aa,d')';

if runningrms == 2 
    if time_series == 3 
        all_points(1).RMSvals_0point5=rms(d(:,fs*(tb+0.5-1):fs*(tb+0.5))');   
        all_points(1).RMSvals_1point5=rms(d(:,fs*(tb+1.5-1):fs*(tb+1.5))');   
        all_points(1).RMSvals_2point5=rms(d(:,fs*(tb+2.5-1):fs*(tb+2.5))');  
        for k=1:3 
           concat=['RMSvals_' num2str(k)];
    %        all_points(1).(concat)=rms(alldata.(char(names))(:,fs*(tb+k-1):fs*(tb+k))');
           all_points(1).(concat)=rms(d(:,fs*(tb+k-1):fs*(tb+k))');
        end 
        % % for 0.5 seconds increments   
    else 
       for k=1:10
           concat=['RMSvals_' num2str(k)];
    %        all_points(1).(concat)=rms(alldata.(char(names))(:,fs*(tb+k-1):fs*(tb+k))');
           all_points(1).(concat)=rms(d(:,fs*(tb+k-1):fs*(tb+k))');
           end
       end 
else
   for k=1:40
       concat=['RMSvals_' num2str(k)];
       all_points(1).(concat)=rms(d(:,fs*(tb+k*(0.25)-1):fs*(tb+k*(0.25)))');
   end     
end 



if runningrms == 2 
% first 3 sec
    if time_series == 3 
        matrix=[all_points(1).RMSvals_0point5; all_points(1).RMSvals_1; all_points(1).RMSvals_1point5; all_points(1).RMSvals_2; 
        all_points(1).RMSvals_2point5; all_points(1).RMSvals_3]; 
    else % 10 seconds 
        matrix=[all_points(1).RMSvals_1; all_points(1).RMSvals_2; all_points(1).RMSvals_3; all_points(1).RMSvals_4; all_points(1).RMSvals_5;
        all_points(1).RMSvals_6; all_points(1).RMSvals_7; all_points(1).RMSvals_8; all_points(1).RMSvals_9; all_points(1).RMSvals_10];
    matrix = movmean(matrix,4,2) ;
    end 
else 
% for running mean 
    matrix=[all_points(1).RMSvals_1; all_points(1).RMSvals_2; all_points(1).RMSvals_3; all_points(1).RMSvals_4; all_points(1).RMSvals_5;
    all_points(1).RMSvals_6; all_points(1).RMSvals_7; all_points(1).RMSvals_8; all_points(1).RMSvals_9; all_points(1).RMSvals_10; 
    all_points(1).RMSvals_11; all_points(1).RMSvals_12; all_points(1).RMSvals_13; all_points(1).RMSvals_14; all_points(1).RMSvals_15;
    all_points(1).RMSvals_16; all_points(1).RMSvals_17; all_points(1).RMSvals_18; all_points(1).RMSvals_19; all_points(1).RMSvals_20;
    all_points(1).RMSvals_21; all_points(1).RMSvals_22; all_points(1).RMSvals_23; all_points(1).RMSvals_24; all_points(1).RMSvals_25;
    all_points(1).RMSvals_26; all_points(1).RMSvals_27; all_points(1).RMSvals_28; all_points(1).RMSvals_29; all_points(1).RMSvals_30; 
    all_points(1).RMSvals_31; all_points(1).RMSvals_32; all_points(1).RMSvals_33; all_points(1).RMSvals_34; all_points(1).RMSvals_35;
    all_points(1).RMSvals_36; all_points(1).RMSvals_37; all_points(1).RMSvals_38; all_points(1).RMSvals_39; all_points(1).RMSvals_40];
    
    matrix = movmean(matrix,4,2) ; 
end 


%% ultrasmooth - for looking at running rms that is ultrasmoothened 
if runningrms == 3    
    % ultra smooth 
    for k=1:100
           concat=['RMSvals_' num2str(k)];
           all_points(1).(concat)=rms(d(:,fs*(tb+k*(0.1)-1):fs*(tb+k*(0.1)))');
    end 

    matrixtenth = zeros(100,length(all_points(1).RMSvals_1)) ;
    for index = 1:100 
        concat=['RMSvals_' num2str(index)];
        matrixtenth(index, :) = all_points(1).(concat); 
    end 
%     matrix = matrixtenth ;  
    matrix = movmean(matrixtenth,4,2);
%     matrix = movmean(matrixtenth,10,2) ; % uncomment this if non
    % runningrms and just 1/10 second blocks 
end 
%% normalize the data using the baseline RMS
matrix=matrix/rms_baseline;
% matrix = matrix(1:8,:); 
% matrix = matrix(1:100, :); % for ultrasmooth
% for storing waterfall matrices from each trial: 
imagesc_concat=['Trial_' num2str(z) 'matrix'];
imagesc_data.(imagesc_concat)= matrix ;

figure(1)
%imagesc plot
if z == 1
    S = 1;
end

if z == 3
    S = 2;
end

if z == 4
    S = 3;
end
subplot(1,3,S);
imagesc(matrix')
axis square
ylim=[0 0.5];
% ylim=[0 0.3];
colorbar
% caxis manual

% naming waterfall plots based on 'z'
names = {'1st Light Only', 'This shouldnt be plotted', 'Light + US', '2nd Light Only'} ;
title(names(z)) % z = 1:4 trials in loopy

% setting waterfall axes 
ylim=[0 0.3];
ylabel('Stimulus Event Number'); 
xlol2 = 1:1:10;
ticks = 0:5:60 ; 
set(gca,'XTickLabel',xlol2 );
yticks(ticks) ; 
xlabel('Time After Light Stimulus (s)') 

if runningrms == 1 
    ylabel('Stimulus Event Number', 'Fontsize', 14); 
    xlabel('Time After Light Stimulus (s)', 'Fontsize', 14) 
    xlol = 4:4:40;
    xlol2 = 1:1:10;
    set(gca,'XTick',xlol ); %This is going to be the only values affected. 
    set(gca,'XTickLabel',xlol2 );
elseif runningrms == 2 
    % for 3 second analysis 
    if time_series == 3
        set(gca,'XTick',[1 2 3 4 5 6] ); %This is going to be the only values affected. 
        set(gca,'XTickLabel',[0.5 1 1.5 2 2.5 3] ); %This is what it's going to appear in those places.
    else
        ticks = 0:1:10;
        xticks(ticks)
    end  
        set(gca,'XTickLabel',xlol2 ); %This is what it's going to appear in those places.
end  
% this is for 40 tile RMS: 
%     set(gca,'XTick',[4 8 12 16 20 24 28 32 36 40] ); %This is going to be the only values affected. 
%         set(gca,'XTickLabel',[1 2 3 4 5 6 7 8 9 10] ); %This is what it's going to appear in those places.
    
colorbar
%to set the magnitude for the color bar, change accordingly?????
% caxis([0.0104    0.233])

%% calculate z-scores
% uncertain if we are using this correctly 
% [z_scores,mu,sigma]=find_zscores(matrix, baseline_rms);

%% arrange data for statistical analysis

% reshape rms matrix into a vector to be used to statistical testing
s=size(matrix);
S=s(1)*s(2);
for_stats=reshape(matrix,1,S);
conc=['Trial_' num2str(z)];
for_stats_analysis.(conc)=for_stats;

%% additional hardcoded filtering 
% removes outlier data points 4 standard deviations from mean 

deviation=std(for_stats_analysis.(conc));
trialmean = mean(for_stats_analysis.(conc));
for_stats_analysis.(conc) = for_stats_analysis.(conc)(for_stats_analysis.(conc)<trialmean+4*deviation);

%% ISOLATING OUTLIERS

if outliersyn == 1 
    quarter = quantile (for_stats_analysis.(conc), [0.25, 0.75]);               
    IQR = quarter(2) - quarter (1);
    for_stats_outliershigh.(conc) = for_stats_analysis.(conc)(for_stats_analysis.(conc)>= quarter(2)+1.5*IQR);
    for_stats_outlierslow.(conc) = for_stats_analysis.(conc)(for_stats_analysis.(conc)<= quarter(1)-1.5*IQR);
    for_histogram_outliers.(conc)=[for_stats_outlierslow.(conc) for_stats_outliershigh.(conc)]; 
    
    for_stats_nonoutliers1.(conc) = for_stats_analysis.(conc)(for_stats_analysis.(conc)<quarter(2)+1.5*IQR) ;   
    for_stats_nonoutliers2.(conc) = for_stats_nonoutliers1.(conc)(for_stats_nonoutliers1.(conc)>quarter(1)-1.5*IQR) ;
    for_histogram_nonoutliers.(conc) = [for_stats_nonoutliers2.(conc)] ;
    
    figure
    
    histogram(for_histogram_outliers.(conc),'BinWidth', 0.003, 'Facecolor', 'r' );
    hold on
    histogram(for_histogram_nonoutliers.(conc),'BinWidth', 0.003, 'Facecolor', 'b' );
    legend('outliers data','nonoutliers data')
    
    histonames = {'1st LO Data', 'This shouldnt be plotted', 'L+US Data', '2nd LO Data'} ;
    title(histonames(z)) 
    xlabel('Normalized magnitude') 
    ylabel('# of data points') 

    % t = tiledlayout (1,3,'TileSpacing','compact');
    totaloutliers.(conc) = length(for_stats_outliershigh.(conc))+length(for_stats_outlierslow.(conc));% yay
    totalpoints.(conc) = length(for_stats_analysis.(conc));%yay2
    nonoutliers.(conc) = totalpoints.(conc)-totaloutliers.(conc);%yup

    % pie([yay yup1],{'Outliers', 'Trial'});
    % labels = {'Outliers', 'Trial'}
    % lgd = legend(labels);
    %  legend;
    % piee = pie([yay1 yup1],explode)
    % set(piee(1),'FaceColor','r')
end 