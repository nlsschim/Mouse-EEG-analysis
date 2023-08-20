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


%% sham light change over time 

%data  
    shamLight_y = [9.02E-06 3.60E-04 2.26E-03 9.01E-01 3.20E-03 1.18E-02 2.45E-01 2.89E-02 2.53E-01 1.21E-03]; 
    f2 = figure(2)

    % nonsignif points 
    x_nonsig = [4 7 9];
    nonsig = scatter(x_nonsig,shamLight_y(x_nonsig), 40, 'o', 'k');
    hold on 

    % sig points 
    sigs = [1 2 3 5 6 8 10];
    sig = scatter(sigs,shamLight_y(sigs), 65, 'k','diamond');
    hold on 

    % % yline(0.05, 'r')
    % xregion(1,4)
    % hold on 
    % xregion(5,7)
    % hold on 
    % xregion(8,9)
    % set(gca,'XTickLabel',[]);
    ylabel("MW p-value", 'Fontsize', 14) 
    

    grid on
    lgd = legend([nonsig sig], {'non-significant', 'significant'}, 'location', 'northeast');
    fontsize(lgd,12,'points')
    ax = gca;
    ax.FontSize = 12; 
    % xlabel('','FontSize',10)

    ylabel("MW p-value", 'Fontsize', 14) 
    xlabel('Time Analyzed After Light Events (seconds)', 'Fontsize', 14) 
    xlim([1 10])
