%% Authors: Devon Griggs, John Kucewicz, Nels Schimek, Kat Floerchinger, Hannah Mach, Alissa Phutirat, Henry Tan
%this code is meant to set the index_stim equal to 60 so that we can
%standardize the length to calculate reliable p values 
fs=tickrate(1);
time1=1:dataend(1);
time=time1/fs/60;

%% change the bandpass for filtering pls

bandpasses = [3, 100; 30, 59; 12, 29; 4, 7; 8, 11] ; 
    [bb,aa]=butter(2,bandpasses(brain_wave,:)/(fs/2));

%Organize data into structure array
alldata=[]; %initialize structure array

alldata.V1Ldata=filtfilt(bb,aa,data(datastart(V1L):dataend(V1L))')';
alldata.S1Ldata=filtfilt(bb,aa,data(datastart(S1L):dataend(S1L))')';
alldata.S1Rdata=filtfilt(bb,aa,data(datastart(S1R):dataend(S1R))')';
alldata.V1Rdata=filtfilt(bb,aa,data(datastart(V1R):dataend(V1R))')';
% alldata.lightstimdata=filtfilt(bb,aa,data(datastart(lightstim):dataend(lightstim))')';
alldata.lightstimdata=data(datastart(lightstim):dataend(lightstim));
%  alldata.lightstimdata=filtfilt(bb,aa,data(datastart(5):dataend(5))')'; % for 5/29 Hypothesis:
% this works if not all channels are imported; channel 7 = channel 5 vs.
% channel 1... 5, 6, 7 => channel 1-4, channel 7 
% what changes in experiments is whether channels 5-6 are included in
% export

%create names to access fields of 'alldata' for plotting loops
names={'V1Ldata','S1Ldata','S1Rdata','V1Rdata','lightstimdata'}; 
foranalysis={'V1Ldata','S1Ldata','S1Rdata','V1Rdata'}; 

%Filter out noise
% alldata.V1Ldata=alldata.V1Ldata(abs(alldata.V1Ldata)<0.02); %hardcoded filtering
%% detect stimuli

X = alldata.lightstimdata;
X=X-min(X);
X=X/max(X);
Y=X>0.5;
Z=diff(Y);
index_allstim=find(Z>0.5);index_allstim=index_allstim+1;

%find first pulse of each train, if stimulation contains trains
index_trains=diff(index_allstim)>2*fs; 
index_allstim(1)=[];
index_stim=index_allstim(index_trains);


%% Create STAs
for i=1:4 %initiate data array to hold STAs
stas.(char(names(i)))=[];
       % title(file_list(z).name,'interpreter','none');
end

if  time_series ==3 
    tb=1; %time before stim to start STA
    ta = 3; % first 3 seconds
else 
    tb=1;
    ta=10; %time after stim to end STA
end 

%% Data conditioning (cont.) 
% prevents errors based on discrepency between V1Ldata and
% lightstimdata length

for i=1:4
    try 
        for j =2:(length(index_stim)-2) 
            stas.(char(names(i)))=[stas.(char(names(i))); alldata.(char(names(i)))((index_stim(j)-fs*tb):(index_stim(j)+fs*ta))];
        end
    catch 
        warning('Index exceeds the number of array elements. Trying j=2:(length(index_stim)-3)') 
        for j =2:(length(index_stim)-3) 
            stas.(char(names(i)))=[stas.(char(names(i))); alldata.(char(names(i)))((index_stim(j)-fs*tb):(index_stim(j)+fs*ta))];
        end
    end 
end 

%% plot STAS

responseWindowEnd=0.4;

%figure
x2=1:length(stas.(char(names(1))));
x2=x2/fs-1;%time axis
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

% max_rms=0;
if time_series == 3 
    for k=1:3 
       concat=['RMSvals_' num2str(k)];
%        all_points(1).(concat)=rms(alldata.(char(names))(:,fs*(tb+k-1):fs*(tb+k))');
       all_points(1).(concat)=rms(d(:,fs*(tb+k-1):fs*(tb+k))');
%        plot(d(:,fs*(tb+k-1):fs*(tb+k)))
%        maxrms=max(all_points(1).(concat));
%        if maxrms > max_rms
%            max_rms=maxrms;
%        end
 
    end 
    % % for 0.5 seconds increments 
    all_points(1).RMSvals_0point5=rms(d(:,fs*(tb+0.5-1):fs*(tb+0.5))');   
	all_points(1).RMSvals_1point5=rms(d(:,fs*(tb+1.5-1):fs*(tb+1.5))');   
    all_points(1).RMSvals_2point5=rms(d(:,fs*(tb+2.5-1):fs*(tb+2.5))');  
else 
   for k=1:10
       concat=['RMSvals_' num2str(k)];
%        all_points(1).(concat)=rms(alldata.(char(names))(:,fs*(tb+k-1):fs*(tb+k))');
       all_points(1).(concat)=rms(d(:,fs*(tb+k-1):fs*(tb+k))');
%        plot(d(:,fs*(tb+k-1):fs*(tb+k)))
%        maxrms=max(all_points(1).(concat));
%        if maxrms > max_rms
%            max_rms=maxrms;
%        end
   end 
end 

      
 % disp(max_rms);

% Create matrix of V1L RMS vals for plotting
% matrix=[all_points(1).RMSvals_9; all_points(1).RMSvals_8; all_points(1).RMSvals_7; all_points(1).RMSvals_6; all_points(1).RMSvals_5;
%     all_points(1).RMSvals_4; all_points(1).RMSvals_3; all_points(1).RMSvals_2; all_points(1).RMSvals_1];

% first 3 sec
if time_series == 3 
    matrix=[all_points(1).RMSvals_0point5; all_points(1).RMSvals_1; all_points(1).RMSvals_1point5; all_points(1).RMSvals_2; 
    all_points(1).RMSvals_2point5; all_points(1).RMSvals_3]; 
else 
    matrix=[all_points(1).RMSvals_1; all_points(1).RMSvals_2; all_points(1).RMSvals_3; all_points(1).RMSvals_4; all_points(1).RMSvals_5;
    all_points(1).RMSvals_6; all_points(1).RMSvals_7; all_points(1).RMSvals_8; all_points(1).RMSvals_9; all_points(1).RMSvals_10];
end 

%normalize the data using the baseline RMS
matrix=matrix/rms_baseline;

figure
%imagesc plot
% subplot(2,3,z);
imagesc(matrix')
ylim=[0 0.3];
colorbar
caxis manual


% naming waterfall plots based on 'z'
names = {'1st Light Only', 'This shouldnt be plotted', 'Light + US', '2nd Light Only'} ;
title(names(z)) % z = 1:4 trials in loopy

% setting waterfall axes 
ylim=[0 0.3];
ylabel('Stimulus event #'); 
ticks = 0:5:60 ; 
yticks(ticks) ; 
xlabel('Time after stimulus (s)') 

% for 3 second analysis 
if time_series == 3
    set(gca,'XTick',[1 2 3 4 5 6] ); %This is going to be the only values affected. 
    set(gca,'XTickLabel',[0.5 1 1.5 2 2.5 3] ); %This is what it's going to appear in those places.
else
    ticks = 0:1:10;
    xticks(ticks)
end  
    
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