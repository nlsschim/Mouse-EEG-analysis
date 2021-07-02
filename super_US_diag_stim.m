%Authors: Devon Griggs, John Kucewicz, Nels Schimek

fs=tickrate(1);
% time1=1:dataend(1);
time1=1:dataend(2);
time=time1/fs/60;

%Organize data into structure array
alldata=[]; %initialize structure array

alldata.V1Ldata=data(datastart(V1L):dataend(V1L));
alldata.S1Ldata=data(datastart(S1L):dataend(S1L));
alldata.S1Rdata=data(datastart(S1R):dataend(S1R));
alldata.V1Rdata=data(datastart(V1R):dataend(V1R));
alldata.lightstimdata=data(datastart(lightstim):dataend(lightstim));
% alldata.lightstimdata=data(datastart(5):dataend(5)); % for 5/29 


%create names to access fields of 'alldata' for plotting loops
names={'V1Ldata','S1Ldata','S1Rdata','V1Rdata','lightstimdata'}; 
foranalysis={'V1Ldata','S1Ldata','S1Rdata','V1Rdata'}; 

%Filter out noise
alldata.V1Ldata=alldata.V1Ldata(abs(alldata.V1Ldata)<0.02); %hardcoded filtering

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


%% Create STAs + Data conditioning 
for i=1:4 %initiate data array to hold STAs
stas.(char(names(i)))=[];
       % title(file_list(z).name,'interpreter','none');
end

% tb=1; %time before stim to start STA
% ta=9; %time after stim to end STA

tb=1; %time before stim to start STA
ta=10; %time after stim to end STA

%% making data conditioning into function calls (in progress) 
% for i = 1:4
%     data_conditioning
%     stas.(char(names(i)) = data_conditioning(index_stim, 
%     
for i=1:4  
    % prevents errors based on discrepency between V1Ldata and
    % lightstimdata length
    %inner_loop_size = 0;
%     if (fix(length(alldata.V1Ldata)/tickrate/10)) < length(index_stim)
%         inner_loop_size = (fix(length(alldata.V1Ldata)/tickrate/10)-1);
%     else
%         inner_loop_size = length(index_stim)-1;
%     end
%     
%     for j=2:inner_loop_size %(length(index_stim)-1) %cycle through stimuli
%       for j=2:(length(index_stim)-1)
%     for j=2:(length(index_stim)-2) % to compensate for data chopping so data vectors are long enough (supposed to be 60 entries) 
%     for j=2:(length(index_stim)-3) % for 6/25/20 mouse experiment 1
     for j=2:(length(index_stim)-5) % 6/24/20 experiment 3 
%     for j=2:(length(index_stim)-3) % 6/24/20 experiment 1  
        stas.(char(names(i)))=[stas.(char(names(i))); alldata.(char(names(i)))((index_stim(j)-fs*tb):(index_stim(j)+fs*ta))];

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
d=filtfilt(bb,aa,d')';

% max_rms=0;
for k=1:10
% for k=1:9
       concat=['RMSvals_' num2str(k)];
       all_points(1).(concat)=rms(d(:,fs*(tb+k-1):fs*(tb+k))');
%        maxrms=max(all_points(1).(concat));
%        if maxrms > max_rms
%            max_rms=maxrms;
%        end
   end
    
 % disp(max_rms);

% Create matrix of V1L RMS vals for plotting
% matrix=[all_points(1).RMSvals_9; all_points(1).RMSvals_8; all_points(1).RMSvals_7; all_points(1).RMSvals_6; all_points(1).RMSvals_5;
%     all_points(1).RMSvals_4; all_points(1).RMSvals_3; all_points(1).RMSvals_2; all_points(1).RMSvals_1];

matrix=[all_points(1).RMSvals_1; all_points(1).RMSvals_2; all_points(1).RMSvals_3; all_points(1).RMSvals_4; all_points(1).RMSvals_5;
    all_points(1).RMSvals_6; all_points(1).RMSvals_7; all_points(1).RMSvals_8; all_points(1).RMSvals_9; all_points(1).RMSvals_10];

%% Waterfall plotting 

%normalize the data using the baseline RMS
matrix=matrix/rms_baseline;

figure
%imagesc plot
%subplot(2,3,z);
imagesc(matrix')
% waterfall(matrix')

% naming waterfall plots based on 'z'
names = {'1st Light Only', 'This shouldnt be plotted', 'Light + US', '2nd Light Only'} ;
title(names(z)) % z = 1:4 trials in loopy

% setting waterfall axes 
ylim=[0 0.3];
ylabel('Stimulus event #'); 
ticks = 0:5:60 ; 
yticks(ticks) ; 
xlabel('Time after stimulus (s)') 
colorbar


%% calculate z-scores

[z_scores,mu,sigma]=find_zscores(matrix, baseline_rms);

%% arrange data for statistical analysis

% reshape rms matrix into a vector to be used to statistical testing
s=size(matrix);
S=s(1)*s(2);
for_stats=reshape(matrix,1,S);
conc=['Trial_' num2str(z)];
for_stats_analysis.(conc)=for_stats;

