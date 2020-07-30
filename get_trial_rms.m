
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here



fs=tickrate(1);
time1=1:dataend(1);
time=time1/fs/60;

%Organize data into structure array
alldata=[]; %initialize structure array

alldata.V1Ldata=data(datastart(V1L):dataend(V1L));

alldata.lightstimdata=data(datastart(lightstim):dataend(lightstim));

%create names to access fields of 'alldata' for plotting loops
names={'V1Ldata','lightstimdata'}; 
foranalysis={'V1Ldata'}; 

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

%% Create STAs
for i=1:2 %initiate data array to hold STAs
stas.(char(names(i)))=[];
       % title(file_list(z).name,'interpreter','none');
end

tb=1; %time before stim to start STA
ta=9; %time after stim to end STA

for i=1:2
    for j=2:(length(index_stim)-1) %cycle through stimuli
        %disp(j);
        stas.(char(names(i)))=[stas.(char(names(i))); alldata.(char(names(i)))((index_stim(j)-fs*tb):(index_stim(j)+fs*ta))];
    %title(file_list(z).name,'interpreter','none');
    end
end

%collect all of the individual points of data
all_points(1).name=names(1);
d=stas.(char(names(1)));

%filter data
d=filtfilt(bb,aa,d')';

% max_rms=0;
   for k=1:9
       concat=['RMSvals_' num2str(k)];
       all_points(1).(concat)=rms(d(:,fs*(tb+k-1):fs*(tb+k))');
   end

matrix=[all_points(1).RMSvals_1; all_points(1).RMSvals_2; all_points(1).RMSvals_3; all_points(1).RMSvals_4; all_points(1).RMSvals_5;
    all_points(1).RMSvals_6; all_points(1).RMSvals_7; all_points(1).RMSvals_8; all_points(1).RMSvals_9];


%normalize the data using the baseline RMS
matrix=matrix/rms_baseline;

% s=size(matrix);
% S=s(1)*s(2);
% for_stats=reshape(matrix,1,S);
% conc=['Trial_' num2str(z)];
% for_stats_analysis.(conc)=for_stats;