% this script plots median analysis of running rms vis stim data
% trial type MW between cohorts versus the size/truncation of the rms matrix 
close all
%% former x seconds (inclusive) of matrix MW plot 

%% plotting non 1LO normalized data 
 
    y1LO_former = [0.134265731083357 0.003185629065587 0.018403654573477 0.173697466512356 0.445759886079422 0.931796050501007 0.380694846109813 0.244590495754152 0.148792557897400 0.134265731083357];
    yLUS_former = [2.334070013988254e-45 1.252872198394431e-48 1.711703714358799e-34 3.533338085376043e-21 5.661153204247716e-16 9.603382971731306e-13 9.193147300358310e-11 2.841967252871422e-10 3.702550456996742e-10 2.151336828296751e-10]; 
    y2LO_former = [5.318220244735748e-34 2.949693213799599e-27 6.183700771227577e-17 4.018035011486707e-12 3.329554599412862e-09 1.110986819325268e-07 7.640675584593862e-08 1.951212340719025e-07 3.592101194815607e-07 2.164439045234344e-07]; 
    f = figure(1)
    tiledlayout(3,1)


%% 1st plot - 1LO 
    nexttile

    % signif points = 2,3 
    x_nonsig = [1 4 5 6 7 8 9 10];
    nonsig = scatter(x_nonsig,y1LO_former(x_nonsig), 40, 'o', 'k');
    hold on 

    % sig points 
    sigs = [2 3];
    sig = scatter(sigs,y1LO_former(sigs), 65, 'k','diamond');
    hold on 

    % yline(0.05, 'r')
    xregion(2,3)
    set(gca,'XTickLabel',[]);
%     title('A - 1st LO', 'Fontsize', 13)
    ylabel("MW p-value", 'Fontsize', 14) 
    xlim([1 10])
grid on
lgd = legend([nonsig sig], {'non-significant', 'significant'}, 'location', 'northeast');
fontsize(lgd,12,'points')
ax = gca;
ax.FontSize = 12; 
xlabel('','FontSize',10)

%% 2nd plot - L+US
    nexttile
    % adjust for axis
    yLUS_former = yLUS_former*10^(10);
    scatter(1:10,yLUS_former, 65, 'k','diamond')
    xregion(1,10)
    set(gca,'XTickLabel',[]);
%     title('B - L+US', 'Fontsize', 13)
    ylabel("MW p-value \times 10^{10}", 'Fontsize', 14) 
grid on 
ax = gca;
ax.FontSize = 12; 
xlabel('','FontSize',10)

%% 3rd plot - 2LO
    nexttile
    % adjust for axis
    y2LO_former = y2LO_former*10^(7);
    scatter(1:10,y2LO_former, 65,'k','diamond')
    xregion(1,10)
%     title('C - 2nd LO', 'Fontsize', 13)
    ylabel("MW p-value \times 10^7", 'Fontsize', 14) 
    xlabel('Time Analyzed After Light Events (seconds)', 'Fontsize', 14) 
grid on

ax = gca;
ax.FontSize = 12; 
xlabel('','FontSize',10)

% %% plotting 1LO normalized data 
% f2= figure(4)
% y1LO_former = [0.7256 0.5974 0.8709 0.9385 0.5281 0.9891 0.9947 0.7211 0.9807 0.7945];
% yLUS_former = [1.2889e-76 1.0020e-75 6.6013e-76 3.5982e-78 3.5846e-73 1.9268e-75 2.3183e-75 2.0278e-73 3.2067e-56 9.8312e-62]; 
% y2LO_former = [1.0048e-54 6.4579e-49 2.2744e-43 6.0473e-39 2.6903e-31 7.7682e-32 3.2296e-29 1.4230e-24 1.1708e-16 1.5671e-47]; 
% signif_line = [0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05 0.05];
% tiledlayout(3,1)
% 
% % 1st plot - 1LO 
% nexttile
% scatter(1:10,y1LO_former, 'filled')
% set(gca,'XTickLabel',[]);
% hold on 
% plot(0:10, signif_line, 'r')
% title('A - 1st LO', 'Fontsize', 13)
% % ylabel("MW p-value") 
% xlim([1 10])
% % xlabel('Total Seconds Analyzed After Light Stimulus') 
% grid on
% 
% % 2nd plot - L+US
% nexttile
% scatter(1:10,yLUS_former, 'filled')
% set(gca,'XTickLabel',[]);
% title('B - L+US', 'Fontsize', 13)
% ylabel("MW p-value",'Fontsize', 15) 
% % xlabel('Total Seconds Analyzed After Light Stimulus')
% grid on
% 
% % 3rd plot - 2LO
% nexttile
% scatter(1:10,y2LO_former, 'filled')
% title('C - 2nd LO', 'Fontsize', 13)
% % ylabel("MW p-value") 
% xlabel('Time Analyzed After Light Events (seconds)', 'Fontsize', 14) 
% grid on 
