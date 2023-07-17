%% Authors: Kat Floerchinger, Hannah Mach, Henry Tan
% this code is meant to set the index_stim equal to 60 so that we can
% standardize the length to calculate reliable p values 
% designed to calculate the median rms value for each event of light, or
% the variance of each event 

fs=tickrate(1);
time1=1:dataend(1);
time=time1/fs/60; % in minutes?

%% change the bandpass for filtering pls

[bb,aa]=butter(3,[5,55]/(fs/2)); %trying to get the us noise out, 5-55Hz 

alldata=[]; %initialize structure array
alldata.V1Ldata=filtfilt(bb,aa,data(datastart(V1L):dataend(V1L))')';
alldata.S1Ldata=filtfilt(bb,aa,data(datastart(S1L):dataend(S1L))')';
alldata.S1Rdata=filtfilt(bb,aa,data(datastart(S1R):dataend(S1R))')';
alldata.V1Rdata=filtfilt(bb,aa,data(datastart(V1R):dataend(V1R))')';
alldata.lightstimdata=data(datastart(lightstim):dataend(lightstim));
alldata.lightstimdata=data(datastart(lightstim):dataend(lightstim));

% create names to access fields of 'alldata' for plotting loops
names={'V1Ldata','S1Ldata','S1Rdata','V1Rdata','lightstimdata'}; 
foranalysis={'V1Ldata','S1Ldata','S1Rdata','V1Rdata'};

%% additional filtering 
%Filter out noise
% alldata.V1Ldata=alldata.V1Ldata(abs(alldata.V1Ldata)<0.02); %hardcoded filtering

deviation=std(alldata.V1Ldata);
trialmean = mean(alldata.V1Ldata);
index = abs(alldata.V1Ldata)>trialmean+4*deviation;
% alldata.V1Ldata(index) = NaN; % doesnt work to ommit values or act as placeholder

% trying to remove 4std electrical noise from alldata, then fill gaps with
% median mV values of alldata (median calulated after 4*std noise removed):

% THIS SEEMS TO MAINTAIN POSITION of events in waterfall! 
% making all abs(values) >4*std = 0 
alldata.V1Ldata(index) = 0 ; 
% creating a copy of alldata with artifact removed 
tempV1Ldata = alldata.V1Ldata;
% finding the indexes where alldata = 0 
index2 = find(alldata.V1Ldata==0);
% replacing  indices with a value of '0' with the median of alldata 
alldata.V1Ldata(index2) = median(tempV1Ldata) ; 

% tempV1Ldata = alldata.V1Ldata(abs(alldata.V1Ldata)>trialmean+4*deviation) ;
% % replacing  indices with a value of '0' with the median of alldata 
% alldata.V1Ldata(index) = median(tempV1Ldata) ; 

%% detect stimuli

