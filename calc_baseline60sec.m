% changes from calc_baseline: 

fs=tickrate(1);
time=1:dataend(1);
time=time/fs/60;

%Organize data into structure array
alldata=[]; %initialize structure array
baseline_data=[];

alldata.V1Ldata=data(datastart(V1L):dataend(V1L));
% alldata.S1Ldata=data(datastart(S1L):dataend(S1L));
% alldata.S1Rdata=data(datastart(S1R):dataend(S1R));
% alldata.V1Rdata=data(datastart(V1R):dataend(V1R));

% baseline_rms=[rms1 rms2 rms3 rms4 rms5 rms6 rms7 rms8 rms9];
% matrix = matrix/rms_baseline in US DIAG STIM 
rms_baseline=rms(alldata.V1Ldata);

[bb,aa]=butter(3,[5,55]/(fs/2)); %trying to get the us noise out, 3 to 200
baseline=filtfilt(bb,aa,alldata.V1Ldata')'; % used for the butter filter

% try 
%     for ii=0:58 % ideally 0-59 = 60 sec total. 0:58 = 59 sec total (some cut shorter than a full minute?
%         name=['sec_' num2str(ii+1)];
%         first=baseline(:,(ii*fs)+1:fs*(ii+1));
%         second=baseline(:,(1+ii)*fs+1:fs*(1+ii)+fs);
%         third=baseline(:,((2+ii)*fs+1):(fs*(2+ii)+fs));
%         fourth=baseline(:,(3+ii)*fs+1:fs*(3+ii)+fs);
%         fifth=baseline(:,(4+ii)*fs+1:fs*(4+ii)+fs);
%         sixth=baseline(:,(5+ii)*fs+1:fs*(5+ii)+fs);
%         baseline_data.(name)=[first second third fourth fifth sixth];
%         baseline_medians.(name) = median(baseline_data.(name)); 
%     end
% catch 
baseline_medians = zeros(1,54) ;
    for ii=0:53 % limit may be 54; so 0:53 = 54 sec 
            name=['sec_' num2str(ii+1)];
            first=baseline(:,(ii*fs)+1:fs*(ii+1));
            second=baseline(:,(1+ii)*fs+1:fs*(1+ii)+fs);
            third=baseline(:,((2+ii)*fs+1):(fs*(2+ii)+fs));
            fourth=baseline(:,(3+ii)*fs+1:fs*(3+ii)+fs);
            fifth=baseline(:,(4+ii)*fs+1:fs*(4+ii)+fs);
            sixth=baseline(:,(5+ii)*fs+1:fs*(5+ii)+fs);
            baseline_data.(name)=[first second third fourth fifth sixth];
%             baseline_medians(1, ii+1) = median(baseline_data.(name));




% DO WE STILL NEED TO RMS VALUE? 
% - this solved small rms values problem?



            baseline_medians(1, ii+1) = median(abs(baseline_data.(name)));
    end
    
baseline_medians_matrix = [baseline_medians_matrix ; baseline_medians] ;
%end 

rms1=rms(baseline_data.sec_1);
rms2=rms(baseline_data.sec_2);
rms3=rms(baseline_data.sec_3);
rms4=rms(baseline_data.sec_4);
rms5=rms(baseline_data.sec_5);
rms6=rms(baseline_data.sec_6);
rms7=rms(baseline_data.sec_7);
rms8=rms(baseline_data.sec_8);
rms9=rms(baseline_data.sec_9);

% % 6/19/22 test 
% rms_baseline=rms(baseline);
% rms_baseline = median(rms(baseline_medians));


% 6_24_22 change 
rms_baseline = median(baseline_medians);



% baseline_rms=[rms1 rms2 rms3 rms4 rms5 rms6 rms7 rms8 rms9];

% baseline_rms.sec_1=rms(baseline_data.sec_1);
% baseline_rms.sec_2=rms(baseline_data.sec_2);
% baseline_rms.sec_3=rms(baseline_data.sec_3);
% baseline_rms.sec_4=rms(baseline_data.sec_4);
% baseline_rms.sec_5=rms(baseline_data.sec_5);
% baseline_rms.sec_6=rms(baseline_data.sec_6);
% baseline_rms.sec_7=rms(baseline_data.sec_7);
% baseline_rms.sec_8=rms(baseline_data.sec_8);
% baseline_rms.sec_9=rms(baseline_data.sec_9);