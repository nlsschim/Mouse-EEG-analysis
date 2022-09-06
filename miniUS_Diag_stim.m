%% Authors: Kat Floerchinger, Hannah Mach, Henry Tan
% this code is meant to set the index_stim equal to 60 so that we can
% standardize the length to calculate reliable p values 
% designed to calculate the median rms value for each event of light, or
% the variance of each event 

fs=tickrate(1);
time1=1:dataend(1);
time=time1/fs/60;

%% change the bandpass for filtering pls

[bb,aa]=butter(3,[5,55]/(fs/2)); %trying to get the us noise out, 5-55Hz 
for i = 1 
%     low gamma 
%    [bb,aa]=butter(2,[30,59]/(fs/2)); 
    % beta
%   [bb,aa]=butter(2,[12,29]/(fs/2)); 
    % theta
%   [bb,aa]=butter(2,[4,7]/(fs/2));
    % alpha 
%     [bb,aa]=butter(2,[8,11]/(fs/2));

% bandpasses = [3, 100; 30, 59; 12, 29; 4, 7; 8, 11] ; 
%     [bb,aa]=butter(2,bandpasses(brain_wave,:)/(fs/2));

%Organize data into structure array
end % to hide code for other bandpasses 

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

%% notch filtering 

% % Design a filter with a Q-factor of Q=35 to remove a 0.2 Hz tone from 
% % system running at 10000 Hz.
% Wo = 0.2/(10000/2);  BW = Wo/35;
% [b,a] = iirnotch(Wo,BW); 
% alldata.V1Ldata = filter(b,a,alldata.V1Ldata);
% 
% Wo = 0.2/(10000/2);  BW = Wo/100;
% [b,a] = iirnotch(Wo,BW); 
% alldata.V1Ldata = filter(b,a,alldata.V1Ldata);
% 
% Wo = 0.25/(10000/2);  BW = Wo/35;
% [b,a] = iirnotch(Wo,BW); 
% alldata.V1Ldata = filter(b,a,alldata.V1Ldata);
% 
% Wo = 0.25/(10000/2);  BW = Wo/100;
% [b,a] = iirnotch(Wo,BW); 
% alldata.V1Ldata = filter(b,a,alldata.V1Ldata);

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

    tb=1;
    ta=10; %time after stim to end STA


%% Data conditioning (cont.) 
% prevents errors based on discrepency between V1Ldata and
% lightstimdata length

for i=1:4
%     try 
%         for j =2:(length(index_stim)-1) 
%             stas.(char(names(i)))=[stas.(char(names(i))); alldata.(char(names(i)))((index_stim(j)-fs*tb):(index_stim(j)+fs*ta))];
%         end
%     catch 
%         warning('Index exceeds the number of array elements. Trying j=2:(length(index_stim)-2)') 
%         clear stas.(char(names(i)))
        for j =2:(length(index_stim)-2) 
            stas.(char(names(i)))=[stas.(char(names(i))); alldata.(char(names(i)))((index_stim(j)-fs*tb):(index_stim(j)+fs*ta))];
        end
end 
% end 

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

%% collect all of the individual points of data
all_points(1).name=names(1);
d=stas.(char(names(1)));



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
 
    matrix=[all_points(1).RMSvals_1; all_points(1).RMSvals_2; all_points(1).RMSvals_3; all_points(1).RMSvals_4; all_points(1).RMSvals_5;
    all_points(1).RMSvals_6; all_points(1).RMSvals_7; all_points(1).RMSvals_8; all_points(1).RMSvals_9; all_points(1).RMSvals_10];

% duplicated here from "arrange data for statistical analysis"
% in order to normalize matrix by median of 1st LO (trial 1)
% matrix is unchanged 

fakes=size(matrix);
fakeS=fakes(1)*fakes(2);
fakefor_stats=reshape(matrix,1,fakeS);
fakeconc=['Trial_' num2str(z)];
fakefor_stats_analysis.(fakeconc)=fakefor_stats;


% normalize the data using the baseline RMS
    matrix=matrix/rms_baseline;    
  
%% finding waterfall matrix size and initializing 
s=size(matrix); % 10 by 60 matrix 
tmatrix = matrix'; % get matrix x to be seconds, y to be event number 
concat2=['Mouse' num2str(f) 'Trial' num2str(z)]; % to organize struct data

%% normalizing LUS and 2LO by 1LO median before variance calculation for each mouse 
if medians_or_variance == 2
    if normalize_by_1LOmed == 1  
        if z == 1 
            trialmedians = [];
            for i = 1:s(2) % 1 to ~60, to get a vector of median values (each from a single event) 
                eventmedian = median(tmatrix(i,:)) ; 
                trialmedians = [trialmedians eventmedian] ;
            end 
            median_of_medians = median(trialmedians); % median of 1LO medians 
            matrix = matrix/median_of_medians ; % normalize 1LO matrix by 1LO median median 

            trialvariances = [] ;
            for i = 1:s(2) % find variance for each event of normalized matrix 
                eventvariance = var(tmatrix(i,:)) ; 
                trialvariances = [trialvariances eventvariance] ;
            end
            variances.(concat2) = trialvariances ;
        elseif z == 3 || 4 
            matrix = matrix/median_of_medians ; % normalize LUS||2LO matrix by 1LO median median 
            for i = 1:s(2) % find variance for each event of normalized LUS||2LO matrix 
                eventvariance = var(tmatrix(i,:)) ; 
                trialvariances = [trialvariances eventvariance] ;
            end
            variances.(concat2) = trialvariances ;
        end 
    end 
end     
%% collect event medians/var in separate trial matrixes for median/var analysis 
if medians_or_variance == 1 
    trialmedians = [];
    for i = 1:s(2) % 1 to ~60 
        eventmedian = median(tmatrix(i,:)) ; 
        trialmedians = [trialmedians eventmedian] ;
    end 
    medians.(concat2) = trialmedians ; 
else 
    trialvariances = [];
    for i = 1:s(2) % 1 to ~60 
        eventvariance = var(tmatrix(i,:)) ; 
        trialvariances = [trialvariances eventvariance] ;
    end 
    variances.(concat2) = trialvariances ; 
end     

%% normalizing LUS and 2LO by 1LO median/variance for each mouse 
if normalize_by_1LOvar == 1 
    if medians_or_variance == 1
        if z == 1 
            firstLOmedian = median(medians.(concat2)) ;
            medians.(concat2) = (medians.(concat2))/firstLOmedian;
        end 
        if z == 3 
            medians.(concat2) = medians.(concat2)/firstLOmedian;
        end 
        if z == 4 
            medians.(concat2) = medians.(concat2)/firstLOmedian;
        end 
    else 
        if z == 1 
            firstLOmedian = median(variances.(concat2)) ;
            variances.(concat2) = variances.(concat2)/firstLOmedian;
        end 
        if z == 3 
            variances.(concat2) = variances.(concat2)/firstLOmedian;
        end 
        if z == 4 
            variances.(concat2) = variances.(concat2)/firstLOmedian;
        end 
    end 
end 

%% arrange data for statistical analysis
% values for for_stats_analysis are reset by normalized values 

% % reshape rms matrix into a vector to be used to statistical testing
s=size(matrix); % 10 by 60 matrix 
S=s(1)*s(2); % S = 10*60 = 600 
for_stats=reshape(matrix,1,S); % turns 10x60 matrix into 1 by 600 vector
conc=['Trial_' num2str(z)];
for_stats_analysis.(conc)=for_stats;

%% additional hardcoded filtering 
% removes outlier data points 4 standard deviations from mean (applies only to for_stats_analysis) 

deviation=std(for_stats_analysis.(conc));
trialmean = mean(for_stats_analysis.(conc));
for_stats_analysis.(conc) = for_stats_analysis.(conc)(abs(for_stats_analysis.(conc))<trialmean+4*deviation);
