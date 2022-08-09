% Harry_Plotter2 creates box and whisker plots and performs statistical
% analysis on median_x script data formatted as a vector (1x~60) of the medians for
% each event of a given trial for each mouse, for both the PEN and SHAM
% cohorts (~60 points per mouse recorded per trial, per cohort) 

% this is different than Harry_plotter, which deals with median_x data
% formatted such that only 1 median value per each waterfall plot/trial per
% mouse per cohort is recorded (7 points per trial, per cohort) 
close all 
%% what to run automation 
% oneLOnormalized = input("Does the data have median(L+US) and median(2LO) each minus median(1LO)? ('1'=yes, '0'=no): ") ; 

%% data conditioning 
% cohort vectors are different (so boxplot wont work) because different number of events in the waterfalls 
% this attempts to expand the shorter vector by filling the vector with NaNs 
% that won't alter analysis (they are ommitted?) 

    firstLOpen = [penmedians.Mouse1Trial1 penmedians.Mouse2Trial1 penmedians.Mouse3Trial1 penmedians.Mouse4Trial1 penmedians.Mouse5Trial1 penmedians.Mouse6Trial1 penmedians.Mouse7Trial1 ]; 
    % 1x354
    firstLOsham = [shammedians.Mouse1Trial1 shammedians.Mouse2Trial1 shammedians.Mouse3Trial1 shammedians.Mouse4Trial1 shammedians.Mouse5Trial1 shammedians.Mouse6Trial1 shammedians.Mouse7Trial1 ];
    % 1x396
    filler = NaN(1,42) ;
    firstLOpen = [firstLOpen filler] ;
    
    LUSpen = [penmedians.Mouse1Trial3 penmedians.Mouse2Trial3 penmedians.Mouse3Trial3 penmedians.Mouse4Trial3 penmedians.Mouse5Trial3 penmedians.Mouse6Trial3 penmedians.Mouse7Trial3 ]; 
    % 1x389
    LUSsham = [shammedians.Mouse1Trial3 shammedians.Mouse2Trial3 shammedians.Mouse3Trial3 shammedians.Mouse4Trial3 shammedians.Mouse5Trial3 shammedians.Mouse6Trial3 shammedians.Mouse7Trial3 ];
    % 1x398
    filler = NaN(1,9) ;
    LUSpen = [LUSpen filler] ;
    
    secondLOpen = [penmedians.Mouse1Trial4 penmedians.Mouse2Trial4 penmedians.Mouse3Trial4 penmedians.Mouse4Trial4 penmedians.Mouse5Trial4 penmedians.Mouse6Trial4 penmedians.Mouse7Trial4 ]; 
    % 1x396
    secondLOsham = [shammedians.Mouse1Trial4 shammedians.Mouse2Trial4 shammedians.Mouse3Trial4 shammedians.Mouse4Trial4 shammedians.Mouse5Trial4 shammedians.Mouse6Trial4 shammedians.Mouse7Trial4 ];
    % 1x395
    secondLOsham = [secondLOsham NaN] ;
    
%% box and whisker plots + MW between cohorts 
% they like each box's data to be a column

% 1LO 
    figure(1)
    % boxplot (input vectors: 7 x~58 = 406)
    boxplot([firstLOpen',firstLOsham'],'Notch','on','Labels', {'PEN US', 'SHAM US'}) 
    hold on 
    %scatterplot; scatter(x,y) creates a scatter plot with circular markers at the locations specified by the vectors x and y.
    scatter(ones(length(firstLOpen)),firstLOpen,4,'r','filled')
    hold on 
    scatter(2.*ones(length(firstLOsham)),firstLOpen,4,'r','filled')
    title('1LO rms values by Cohort') 
    ylabel('rms values') 
    % MW 
    MW1LO = ranksum(firstLOpen,firstLOsham) ;
       
% L+US  
    figure(2)
    % boxplot (input vectors: 7 x~58 = 406)
    boxplot([LUSpen',LUSsham'],'Notch','on','Labels', {'PEN US', 'SHAM US'}) 
    hold on 
    %scatterplot
    scatter(ones(length(LUSpen)),LUSpen,3,'r','filled')
    hold on 
    scatter(2.*ones(length(LUSsham)),LUSpen,3,'r','filled')
    title('L+US rms values by Cohort') 
    ylabel('rms values') 
    % MW 
    MWLUS = ranksum(LUSpen,LUSsham) ;
 
% 2LO  
    figure(3)
    % boxplot (input vectors: 7 x~58 = 406)
    boxplot([secondLOpen',secondLOsham'],'Notch','on','Labels', {'PEN US', 'SHAM US'}) 
    hold on 
    %scatterplot
    scatter(ones(length(secondLOpen)),secondLOpen,3,'r','filled')
    hold on 
    scatter(2.*ones(length(secondLOsham)),secondLOsham,3,'r','filled')
    title('2LO rms values by Cohort') 
    ylabel('rms values') 
    % MW 
    MW2LO = ranksum(secondLOpen,secondLOsham) ;    
    
    
 %% QQ plots 
 figure(4) 
 firstLOqq = qqplot(firstLOpen,firstLOsham) ;
 title('QQ plot of pen vs sham 1LO event median rms values')
%  hold on 
%  plot(0:1:6, 0:1:6)

 figure(5) 
 LUSqq = qqplot(LUSpen,LUSsham) ;
 title('QQ plot of pen vs sham L+US event median rms values')
 
 figure(6) 
 secondLOqq = qqplot(secondLOpen,secondLOsham) ;
 title('QQ plot of pen vs sham 2LO event median rms values')