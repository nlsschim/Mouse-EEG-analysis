% this script plots median analysis of running rms vis stim data
% trial type MW between cohorts versus the size/truncation of the rms matrix 
close all
%% former x seconds (inclusive) of matrix MW plot 
% 1LO 
% 10: 0.134265731083357
% 9: 0.148792557897400
% 8: 0.244590495754152
% 7: 0.380694846109813
% 6: 0.931796050501007
% 5: 0.445759886079422
% 4: 0.173697466512356
% 3: 0.018403654573477
% 2: 0.003185629065587
% 1: 0.134265731083357 % strange that it's same as 10 - investigate

% L+US
% 10: 2.151336828296751e-10
% 9: 3.702550456996742e-10
% 8: 2.841967252871422e-10
% 7: 9.193147300358310e-11
% 6: 9.603382971731306e-13
% 5: 5.661153204247716e-16
% 4: 3.533338085376043e-21
% 3: 1.711703714358799e-34
% 2: 1.252872198394431e-48
% 1: 2.334070013988254e-45

% 2LO
% 10: 2.164439045234344e-07
% 9: 3.592101194815607e-07
% 8: 1.951212340719025e-07
% 7: 7.640675584593862e-08
% 6: 1.110986819325268e-07
% 5: 3.329554599412862e-09
% 4: 4.018035011486707e-12
% 3: 6.183700771227577e-17
% 2: 2.949693213799599e-27
% 1: 5.318220244735748e-34

%% plotting non 1LO normalized data 
for i = 1 
    y1LO_former = [0.134265731083357 0.003185629065587 0.018403654573477 0.173697466512356 0.445759886079422 0.931796050501007 0.380694846109813 0.244590495754152 0.148792557897400 0.134265731083357];
    yLUS_former = [2.334070013988254e-45 1.252872198394431e-48 1.711703714358799e-34 3.533338085376043e-21 5.661153204247716e-16 9.603382971731306e-13 9.193147300358310e-11 2.841967252871422e-10 3.702550456996742e-10 2.151336828296751e-10]; 
    y2LO_former = [5.318220244735748e-34 2.949693213799599e-27 6.183700771227577e-17 4.018035011486707e-12 3.329554599412862e-09 1.110986819325268e-07 7.640675584593862e-08 1.951212340719025e-07 3.592101194815607e-07 2.164439045234344e-07]; 
    signif_line = [0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05];
    figure(1)
    tiledlayout(3,1)

    % 1st plot - 1LO 
    nexttile
    plot(1:10,y1LO_former, 'b-o')
    hold on 
    plot(0:10, signif_line, 'r')
    title('1LO Total Seconds Analyzed After Light Stimulus vs. MW p-value between PEN and SHAM median RMS values')
    ylabel("MW p-value") 
    xlabel('Total Seconds Analyzed After Light Stimulus') 

    % 2nd plot - L+US
    nexttile
    plot(1:10,yLUS_former, '-o')
    title('L+US Total Seconds Analyzed After Light Stimulus vs. MW p-value between PEN and SHAM median RMS values')
    ylabel("MW p-value") 
    xlabel('Total Seconds Analyzed After Light Stimulus') 

    % 3rd plot - 2LO
    nexttile
    plot(1:10,y2LO_former, '-o')
    title('L+US Total Seconds Analyzed After Light Stimulus vs. MW p-value between PEN and SHAM median RMS values')
    ylabel("MW p-value") 
    xlabel('Total Seconds Analyzed After Light Stimulus') 

    %% latter x seconds of matrix MW plot

    % 1LO 
    % 10: 0.134265731083357
    % 9-10: 
    % 8-10:
    % 7-10:
    % 6-10: 
    % 5-10:
    % 4-10:
    % 3-10:
    % 2-10: 

    % L+US
    % 10: 2.151336828296751e-10
    % 9-10: 
    % 8-10:
    % 7-10:
    % 6-10: 
    % 5-10:
    % 4-10:
    % 3-10:
    % 2-10: 

    % 2LO
    % 10: 2.164439045234344e-07
    % 9-10: 
    % 8-10:
    % 7-10:
    % 6-10: 
    % 5-10:
    % 4-10:
    % 3-10:
    % 2-10: 

    %% plotting 
    % 1-10, 2-10, 3-10s of matrix ... 
    y1LO_latter = [0.049914292467646 0.027492318953747 0.023664964882193 0.016053380126275 0.003797143078532 5.836240077610806e-04 6.921773200587714e-05 4.128181126443280e-08 0.010777375589379];
    yLUS_latter = [5.804391317081517e-09 2.865795374461144e-08 6.717638386899156e-09 3.170018676351928e-10 3.848100914876216e-11 2.541211262051164e-11 5.793603275759183e-11 4.794081145758327e-11 4.529846175640479e-08]; 
    y2LO_latter = [1.038006574704092e-06 3.750923585590967e-06 2.518661698289309e-07 4.002211869419819e-07 7.270001738452468e-07 2.391569511865276e-06 3.087602993488557e-05 4.128181126443280e-08 7.429696702840930e-11]; 
    signif_line = [0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05];
    figure(2)
    tiledlayout(3,1)

    % 1st plot - 1LO 
    nexttile
    plot(1:9,y1LO_latter, 'b-o')
    hold on 
    plot(0:10, signif_line, 'r')
    title('1LO latter fraction of matrix seconds vs. MW p-value')
    ylabel("MW p-value") 
    xlabel('x-10 (seconds) latter fraction of matrix') 

    % 2nd plot - L+US
    nexttile
    plot(1:9,yLUS_latter, '-o')
    title('L+US latter fraction of matrix seconds vs. MW p-value')
    ylabel("MW p-value") 
    xlabel('x-10 (seconds) latter fraction of matrix') 

    % 3rd plot - 2LO
    nexttile
    plot(1:9,y2LO_latter, '-o')
    title('2LO latter fraction of matrix seconds vs. MW p-value')
    ylabel("MW p-value") 
    xlabel('x-10 (seconds) latter fraction of matrix') 
end %hidden

%% plotting 1LO normalized data 
% former data notes
for i =1 
%     former 
% 
%     format: 
%     1LO
%     2LO 
%     LUS 
% 
%     1s
%     0.7256
%     1.0048e-54
%     1.2889e-76
% 
%     2s
%     0.5974
%     6.4579e-49
%     1.0020e-75
% 
%     3 s
%     0.8709
%     2.2744e-43
%     6.6013e-76
% 
%     4s
%     0.9385
%     6.0473e-39
%     3.5982e-78
% 
%     5s 
%     0.5281
%     2.6903e-31
%     3.5846e-73
% 
%     6s 
%     0.9891
%     7.7682e-32
%     1.9268e-75
% 
%     7s 
%     0.9947
%     3.2296e-29
%     2.3183e-75
% 
%     8s 
%     0.7211
%     1.4230e-24
%     2.0278e-73
% 
%     9s 
%     0.9807
%     1.1708e-16
%     3.2067e-56
% 
%     10s 
%     0.7945
%     1.5671e-47
%     9.8312e-62
end % hidden
figure(2)
y1LO_former = [0.7256 0.5974 0.8709 0.9385 0.5281 0.9891 0.9947 0.7211 0.9807 0.7945];
yLUS_former = [1.2889e-76 1.0020e-75 6.6013e-76 3.5982e-78 3.5846e-73 1.9268e-75 2.3183e-75 2.0278e-73 3.2067e-56 9.8312e-62]; 
y2LO_former = [1.0048e-54 6.4579e-49 2.2744e-43 6.0473e-39 2.6903e-31 7.7682e-32 3.2296e-29 1.4230e-24 1.1708e-16 1.5671e-47]; 
signif_line = [0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05];
figure(1)
tiledlayout(3,1)

% 1st plot - 1LO 
nexttile
plot(1:10,y1LO_former, 'b-o')
hold on 
plot(0:10, signif_line, 'r')
title('1LO Total Seconds Analyzed After Light Stimulus vs. MW p-value between PEN and SHAM median RMS values')
ylabel("MW p-value") 
xlabel('Total Seconds Analyzed After Light Stimulus') 

% 2nd plot - L+US
nexttile
plot(1:10,yLUS_former, '-o')
title('L+US Total Seconds Analyzed After Light Stimulus vs. MW p-value between PEN and SHAM median RMS values')
ylabel("MW p-value") 
xlabel('Total Seconds Analyzed After Light Stimulus') 

% 3rd plot - 2LO
nexttile
plot(1:10,y2LO_former, '-o')
title('2LO Total Seconds Analyzed After Light Stimulus vs. MW p-value between PEN and SHAM median RMS values')
ylabel("MW p-value") 
xlabel('Total Seconds Analyzed After Light Stimulus') 

%% plotting 
% latter data notes 
for i = 1
% format: 
% 1LO
% 2LO 
% LUS 
% 
% 1s
% 0.5523
% 2.1459e-48
% 9.3798e-61
% 
% 2s
% 0.6692
% 2.4547e-49
% 3.0497e-59
% 
% 3 s
% 0.9767
% 1.7477e-50
% 1.6339e-59
% 
% 4s
% 0.8217
% 1.8623e-48
% 3.1774e-62
% 
% 5s 
% 0.8428
% 1.6309e-48
% 2.5377e-64
% 
% 6s 
% 0.9969
% 3.0503e-48
% 6.5123e-66
% 
% 7s 
% 0.8581
% 2.9805e-44
% 2.1331e-62
% 
% 8s 
% 0.7570
% 4.3306e-47
% 1.3825e-60
% 
% 9s 
% 0.2832
% 8.8184e-34
% 5.4989e-40

  
end 
figure(3)
% 1-10, 2-10, 3-10s of matrix ... 
y1LO_latter = [0.5523 0.6692 0.9767 0.8217 0.8428 0.9969 0.8581 0.7570 0.2832];
yLUS_latter = [9.3798e-61 3.0497e-59 1.6339e-59 3.1774e-62 2.5377e-64 6.5123e-66 2.1331e-62 1.3825e-60 5.4989e-40]; 
y2LO_latter = [2.1459e-48 2.4547e-49 1.7477e-50 1.8623e-48 1.6309e-48 3.0503e-48 2.9805e-44 4.3306e-47 8.8184e-34]; 
signif_line = [0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05];
figure(2)
tiledlayout(3,1)

% 1st plot - 1LO 
nexttile
plot(1:9,y1LO_latter, 'b-o')
hold on 
plot(0:10, signif_line, 'r')
title('1LO latter fraction of matrix seconds vs. MW p-value')
ylabel("MW p-value") 
xlabel('x-10 (seconds) latter fraction of matrix') 

% 2nd plot - L+US
nexttile
plot(1:9,yLUS_latter, '-o')
title('L+US latter fraction of matrix seconds vs. MW p-value')
ylabel("MW p-value") 
xlabel('x-10 (seconds) latter fraction of matrix') 

% 3rd plot - 2LO
nexttile
plot(1:9,y2LO_latter, '-o')
title('2LO latter fraction of matrix seconds vs. MW p-value')
ylabel("MW p-value") 
xlabel('x-10 (seconds) latter fraction of matrix') 
