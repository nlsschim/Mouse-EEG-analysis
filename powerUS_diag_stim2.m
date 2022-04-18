%% Authors: Kat Floerchinger, Hannah Mach, Henry Tan
% this code is meant to set the index_stim equal to 60 so that we can
% standardize the length to calculate reliable p values 
% compared to powerUS_diag_stim, this scipt:
% (1) has hardcoded electrical noise-targeted filtering before plotting AND statistical analysis (powerUS_diag_stim had it after plotting waterfalls)
% (2) has a method for quantificaition of brain responses to light stim per trial type 


fs=tickrate(1);
time1=1:dataend(1);
time=time1/fs/60;

%% change the bandpass for filtering pls
    % default done 
%     [bb,aa]=butter(3,[3,100]/(fs/2)); %trying to get the us noise out, 3 to 200
[bb,aa]=butter(2,[5,55]/(fs/2)); %trying to get the us noise out, 3 to 200
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
alldata=[]; %initialize structure array

alldata.V1Ldata=filtfilt(bb,aa,data(datastart(V1L):dataend(V1L))')';
alldata.S1Ldata=filtfilt(bb,aa,data(datastart(S1L):dataend(S1L))')';
alldata.S1Rdata=filtfilt(bb,aa,data(datastart(S1R):dataend(S1R))')';
alldata.V1Rdata=filtfilt(bb,aa,data(datastart(V1R):dataend(V1R))')';
alldata.lightstimdata=data(datastart(lightstim):dataend(lightstim));
alldata.lightstimdata=data(datastart(lightstim):dataend(lightstim));


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

    tb=1;
    ta=10; %time after stim to end STA


%% Data conditioning (cont.) 
% prevents errors based on discrepency between V1Ldata and
% lightstimdata length

for i=1:4
    try 
        for j =2:(length(index_stim)-1) 
            stas.(char(names(i)))=[stas.(char(names(i))); alldata.(char(names(i)))((index_stim(j)-fs*tb):(index_stim(j)+fs*ta))];
        end
    catch 
        warning('Index exceeds the number of array elements. Trying j=2:(length(index_stim)-1)') 
        for j =2:(length(index_stim)-2) 
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

%% Waterfall amtrix and collecting all of the individual points of data
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
% if normal == 2 
    matrix=matrix/rms_baseline;
% elseif normal == 1
%     med_1LO = median(fakefor_stats_analysis.Trial_1);
%     matrix=matrix/med_1LO;
% end

%% arrange data for statistical analysis
% ALL MOVED up from bottom of script 
        % values for for_stats_analysis are reset by normalized values 

        % % reshape rms matrix into a vector to be used to statistical testing
        s=size(matrix); % 10 by 60 matrix 
        S=s(1)*s(2); % S = 10*60 = 600 
        for_stats=reshape(matrix,1,S); % turns 10x60 matrix into 1 by 600 vector
        conc=['Trial_' num2str(z)];
        for_stats_analysis.(conc)=for_stats;


        %% additional hardcoded filtering
        % removes outlier data points 4 standard deviations from mean -- does this
        % happen too late after visualization?

        deviation=std(for_stats_analysis.(conc));
        trialmean = mean(for_stats_analysis.(conc));
        for_stats_analysis.(conc) = for_stats_analysis.(conc)(for_stats_analysis.(conc)<trialmean+3*deviation);

        %% reshaping filtered statistical analysis data vector back into matrix for plotting 
        
        forstatslength = length(for_stats_analysis.(conc)); 
        eventtotal = floor((forstatslength/10)) ; % round down 
        vector = for_stats_analysis.(conc)(1:10*eventtotal);
        matrix = reshape(vector, 10, eventtotal) ; 
        

        %% counting event-related potentials 
% first 5 secs vs second 5 secs 
%         for eventcount = 1:eventtotal %1-56
%              event_2nd_half_deviation = std(matrix(6:10,eventcount));
%              event_2nd_half_median = median(matrix(6:10,eventcount));
%              % ERPseconds = 1 second in in the first 5 secs after event that is greather than median+1std of snd 5 secs 
%              ERPseconds = 0 ; % how many seconds of the first 5 secs meet criteria
%              for eventsecond = 1:5 
%                  if matrix(eventsecond, eventcount) > (event_2nd_half_median+1*event_2nd_half_deviation) 
%                      ERPseconds = ERPseconds + 1;
%                  end
%              end 
%                 % ERP: event-related potential/brain response to stim  
%              if ERPseconds >= 1 
%                  ERPcount = ERPcount + 1 ;
%                  totaleventcount = totaleventcount + 1; 
%              else
%                  totaleventcount = totaleventcount + 1;
%              end
%         end

        for eventcount = 1:eventtotal %1-56
             event_2nd_half_deviation = std(matrix(2:10,eventcount));
             event_2nd_half_median = median(matrix(2:10,eventcount));
             % ERPseconds = 1 second in in the first 5 secs after event that is greather than median+1std of snd 5 secs 
             ERPseconds = 0 ; % how many seconds of the first 5 secs meet criteria
             for eventsecond = 1 
                 if matrix(eventsecond, eventcount) > (event_2nd_half_median+1*event_2nd_half_deviation) 
                     ERPseconds = ERPseconds + 1;
                 end
             end 
                % ERP: event-related potential/brain response to stim  
             if ERPseconds >= 1 
                 ERPcount = ERPcount + 1 ;
                 totaleventcount = totaleventcount + 1; 
             else
                 totaleventcount = totaleventcount + 1;
             end
        end


        %% in the works to quantify ERP for all cohorts 
        
        % eventresponsecounter.MouseXTrialX = [totaleventcount ERPcount responserate] 
%         if z == 1
            eventconcat2=['Mouse' num2str(f) 'Trial' num2str(z)];   
%             eventresponsecounter.(eventconcat2)= [] ;
            eventresponsecounter.(eventconcat2) = [totaleventcount ERPcount (ERPcount/totaleventcount)*100] ;
            eventresponsecounter.totalevents = eventresponsecounter.totalevents + totaleventcount;
            eventresponsecounter.totalERP = eventresponsecounter.totalERP + ERPcount;
            if z == 1
                eventresponsecounter.total1LOevents = eventresponsecounter.total1LOevents + totaleventcount;
                eventresponsecounter.total1LOERP = eventresponsecounter.total1LOERP + ERPcount;
            elseif z == 3 
                eventresponsecounter.totalLUSevents = eventresponsecounter.totalLUSevents + totaleventcount;
                eventresponsecounter.totalLUSERP = eventresponsecounter.totalLUSERP + ERPcount; 
            elseif z == 4
                eventresponsecounter.total2LOevents = eventresponsecounter.total2LOevents + totaleventcount;
                eventresponsecounter.total2LOERP = eventresponsecounter.total2LOERP + ERPcount;
            end 
       
%% plotting

% figure
% %imagesc plot
% % subplot(2,3,z);
% imagesc(matrix')
% ylim=[0 0.3];
% colorbar
% caxis manual

% % naming waterfall plots based on 'z'
% names = {'1st Light Only', 'This shouldnt be plotted', 'Light + US', '2nd Light Only'} ;
% title(names(z)) % z = 1:4 trials in loopy
% 
% % setting waterfall axes 
% ylim=[0 0.3];
% ylabel('Stimulus event #'); 
% ticks = 0:5:60 ; 
% yticks(ticks) ; 
% xlabel('Time after stimulus (s)') 
%     
% colorbar

%% for power 
% figure
% pmatrix = matrix'.^2 ;
% [rownum,colnum]=size(pmatrix);
% for i = 1:rownum 
%     plot(pmatrix(i,:)) 
%     hold on 
% end 
% title(names(z),' events')
% xlabel("seconds after stim") 
% ylabel("power")
% hold off 

% smatrix = [ 1 5 9 ; 2 6 10 ; 3 7 11  ;4 8 12] ; 
% for i = 1:3 
%     plot(1:3, smatrix') 
% end 
%% calculate z-scores
% [z_scores,mu,sigma]=find_zscores(matrix, baseline_rms);

