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
    

%% variance 
% between cohorts 
firstLOpen = firstLOpen(~isnan(firstLOpen));% removing NaN entries 
var_1LOpen = var(firstLOpen);
firstLOsham = firstLOsham(~isnan(firstLOsham));% removing NaN entries 
var_1LOsham = var(firstLOsham);
var_MW_1LO = ranksum(var_1LOpen, var_1LOsham) ;

LUSpen = LUSpen(~isnan(LUSpen)); % removing NaN entries 
var_LUSpen = var(LUSpen);
LUSsham = LUSsham(~isnan(LUSsham)); % removing NaN entries 
var_LUSsham = var(LUSsham);
var_MW_LUS = ranksum(var_LUSpen, var_LUSsham) ;

secondLOpen = secondLOpen(~isnan(secondLOpen)); % removing NaN entries 
var_2LOpen = var(secondLOpen);
secondLOsham = secondLOsham(~isnan(secondLOsham)); % removing NaN entries 
var_2LOsham = var(secondLOsham);
var_MW_2LO = ranksum(var_2LOpen, var_2LOsham) ;

% plotting 
figure(7) 
var_y_pen = [var_1LOpen  var_LUSpen var_2LOpen] ;
var_y_sham = [var_1LOsham  var_LUSsham var_2LOsham] ;
var_1 = plot(1:3, var_y_pen, 'o-r') ; 
hold on 
var_2 = plot(1:3, var_y_sham, 'o-b') ;  
legend([var_1 var_2], {'PEN data', 'SHAM data'})
title('Variance by cohort vs. Trial Type')
ylabel('Variance') 
trialtype = {'1LO' '' '' '' '' 'L+US' '' '' '' '' '2LO'};
xticklabels(trialtype) ;

% % standard error for errorbars 
% var_stderror = zeros(2,3) ;
% var_stderror(1,1) = std(firstLOpen)/sqrt(length(firstLOpen)) ;
% var_stderror(1,2) = std(LUSpen)/sqrt(length(LUSpen)) ;
% var_stderror(1,3) = std(secondLOpen)/sqrt(length(secondLOpen)) ;
% 
% var_stderror(2,1) = std(firstLOsham)/sqrt(length(firstLOsham)) ;
% var_stderror(2,2) = std(LUSsham)/sqrt(length(LUSsham)) ;
% var_stderror(2,3) = std(secondLOsham)/sqrt(length(secondLOsham)) ;
% q1 = errorbar(1:3, peny, stderror(1,:), 'o-r') ;
% hold on 
% q2 = errorbar(1:3, shamy, stderror(2,:), 'o-b') ;


% intercohort variance MWs 
% pen 
normal_var_LUSpen = var_LUSpen / var_1LOpen ;
normal_var_2LOpen = var_2LOpen / var_1LOpen ;

var_MW_pen_1LOLUS = ranksum(var_1LOpen, var_LUSpen) ; 
var_MW_pen_LUS2LO = ranksum(normal_var_LUSpen, normal_var_2LOpen) ; 

% sham 
normal_var_LUSsham = var_LUSsham / var_1LOsham ;
normal_var_2LOsham = var_2LOsham / var_1LOsham ; 

var_MW_sham_1LOLUS = ranksum(var_1LOsham, var_LUSsham) ; 
var_MW_sham_LUS2LO = ranksum(normal_var_LUSsham, normal_var_2LOsham) ; 
  
%% intercohort median MWs 
% pen 
MWpen1LOLUS = ranksum(firstLOpen,LUSpen);
normal_LUSpen = LUSpen / median(firstLOpen) ;
normal_2LOpen = secondLOpen / median(firstLOpen) ; 
MWpenLUS2LO = ranksum(normal_LUSpen,normal_2LOpen); % was the normalization correct? 
MWpen1LO2LO = ranksum(firstLOpen,secondLOpen);

% sham 
MWsham1LOLUS = ranksum(firstLOsham,LUSsham);
normal_LUSsham = LUSsham / median(firstLOsham) ;
normal_2LOsham = secondLOsham / median(firstLOsham) ;  
MWshamLUS2LO = ranksum(normal_LUSsham,normal_2LOsham); % do both of these need to be normalized by 1LO? 
MWsham1LO2LO = ranksum(firstLOsham,secondLOsham);

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
 
 


 
 
 