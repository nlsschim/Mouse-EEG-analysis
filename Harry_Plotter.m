%% Authors: Kat Floerchinger, Hannah Mach, Henry Tan :) 
 
% clc
% close all 
 
% median_SHAM
% median_GEN
% median_PEN 
 
% copied matrixes from commented median_x scripts to reduce running time 
SHAM_MATRIX = [0,0.00435600796752600,0.00713109228237704;0,-5.16885958017910e-05,-0.0286916774704259;0,0.0133954508844230,-0.0105393137953733;0,-0.0146888761776283,-0.0364842719945690;0,-0.00765067809909513,-0.0126725453785824;0,-0.0247286394644330,-0.000975316304337212;0,-0.00707821064911673,-0.0152301517258112];
GEN_MATRIX = [0,-0.00216903690829889,0.0157401784885035;0,-0.00533501284119886,-0.0170182170965821;0,-0.0284201249582408,-0.0566498478936813;0,-0.00382477957074176,-0.00480633475035593;0,-0.0804744010195484,-0.0332240621483618;0,-0.00839983815283812,-0.0181853465935874;0,-0.0387101708843783,-0.0489317590083913];
PEN_MATRIX = [0,0.00932355090704318,0.0180555755962342;0,0.0355006379032983,0.0289117712082711;0,0.0105964449704316,0.00890424974541322;0,0.0382527652138474,0.0283285886886979;0,-0.000996088743718843,-0.00109136275373061;0,-0.000107093776822434,0.00106106540426960;0,0.000180722336327257,-0.000554426228727898];
 
% concatenating the matrixes from median_x scripts
MATRIX = [SHAM_MATRIX; GEN_MATRIX; PEN_MATRIX] ;
% SHAM = 7 rows 
% GEN = 7 rows
% PEN = 8 rows 
 
%% all dates PLOTTING 
figure(1) 
hold on 
% SHAM plotting
for q = 1:7 
    row = MATRIX(q,:) ;
    p1 = plot(1:3, MATRIX(q, :), 'g', 'DisplayName','SHAM data') ;
end 
% GEN plotting 
for q = 8:14
    row = MATRIX(q,:) ;
    p2 = plot(1:3, MATRIX(q, :), 'b', 'DisplayName','GEN data') ;
end 
% PEN plotting 
for q = 14:21
    row = MATRIX(q,:) ;
    p3 = plot(1:3, MATRIX(q, :), 'r', 'DisplayName','PEN data') ;
end
legend([p1 p2 p3],{'SHAM data','GEN data', 'PEN data'})
xlabel('Trial Type'), ylabel('Median Value')
title('All Mice Median Values L+US and 2LO vs. 1LO')
set(gca,'XTick',[1 2 3] );
% set(gca,'XTickLabel',['1st LO', 'L+US' ,'2nd LO'] );
xticklabels({'1st LO','L+US','2nd LO'});
hold off 
 
%% setting up cohort medians 
 
% some more efficient loop in progress 
% for q = 1:3
%     for p = 1:7 
%         x = MATRIX(p, q)
 
% SHAM MEDIANS 
SHAM_1LO = [];
for q = 1:7
    SHAM_1LO = [SHAM_1LO MATRIX(q, 1)] ;
end 
SHAM_1LO_median = median(SHAM_1LO) ;
 
SHAM_LUS = [];
for q = 1:7
    SHAM_LUS = [SHAM_LUS MATRIX(q, 2)] ;
end 
SHAM_LUS_median = median(SHAM_LUS) ;
 
SHAM_2LO = [];
for q = 1:7
    SHAM_2LO = [SHAM_2LO MATRIX(q, 3)] ;
end 
SHAM_2LO_median = median(SHAM_2LO) ;
 
% GEN MEDIANS 
 
GEN_1LO = [];
for q = 8:14
    GEN_1LO = [GEN_1LO MATRIX(q, 1)] ;
end 
GEN_1LO_median = median(GEN_1LO) ;
 
GEN_LUS = [];
for q = 8:14
    GEN_LUS = [GEN_LUS MATRIX(q, 2)] ;
end 
GEN_LUS_median = median(GEN_LUS) ;
 
GEN_2LO = [];
for q = 8:14
    GEN_2LO = [GEN_2LO MATRIX(q, 3)] ;
end 
GEN_2LO_median = median(GEN_2LO) ;
 
% PEN MEDIANS 
 
PEN_1LO = [];
for q = 15:21
    PEN_1LO = [PEN_1LO MATRIX(q, 1)] ;
end 
PEN_1LO_median = median(PEN_1LO) ;
 
PEN_LUS = [];
for q = 15:21
    PEN_LUS = [PEN_LUS MATRIX(q, 2)] ;
end 
PEN_LUS_median = median(PEN_LUS) ;
 
PEN_2LO = [];
for q = 15:21
    PEN_2LO = [PEN_2LO MATRIX(q, 3)] ;
end 
PEN_2LO_median = median(PEN_2LO) ;
 
%% standard error matrix creation 
 
stderror(1, 1) = std(SHAM_1LO)/sqrt(length(SHAM_1LO)) ;
stderror(1, 2) = std(SHAM_LUS)/sqrt(length(SHAM_LUS)) ;
stderror(1, 3) = std(SHAM_2LO)/sqrt(length(SHAM_2LO)) ;
 
stderror(2, 1) = std(GEN_1LO)/sqrt(length(GEN_1LO)) ;
stderror(2, 2) = std(GEN_LUS)/sqrt(length(GEN_LUS)) ;
stderror(2, 3) = std(GEN_2LO)/sqrt(length(GEN_2LO)) ;
 
stderror(3, 1) = std(PEN_1LO)/sqrt(length(PEN_1LO)) ;
stderror(3, 2) = std(PEN_LUS)/sqrt(length(PEN_LUS)) ;
stderror(3, 3) = std(PEN_2LO)/sqrt(length(PEN_2LO)) ;
%% plotting cohort medians 
 
% stderror = std( data ) / sqrt( length( data ))
% errorbar(x,y,err)
 
% figure(2) 
% SHAMY_median = [SHAM_1LO_median SHAM_LUS_median SHAM_2LO_median] ;
% q1 = plot(1:3, SHAMY_median, 'o-g', 'DisplayName', 'SHAM data') ;
% hold on 
 
% GENY_median = [GEN_1LO_median GEN_LUS_median GEN_2LO_median] ;
% q2 = plot(1:3, GENY_median, 'o-b', 'DisplayName', 'GEN data') ;
% hold on 
 
% PENY_median = [PEN_1LO_median PEN_LUS_median PEN_2LO_median] ;
% q3 = plot(1:3, PENY_median, 'o-r', 'DisplayName', 'PEN data') ;
 
figure(2) 
SHAMY_median = [SHAM_1LO_median SHAM_LUS_median SHAM_2LO_median] ;
q1 = errorbar(1:3, SHAMY_median, stderror(1,:), 'o-g', 'DisplayName', 'SHAM Data') ;
hold on 
 
GENY_median = [GEN_1LO_median GEN_LUS_median GEN_2LO_median] ;
q2 = errorbar(1:3, GENY_median, stderror(2,:), 'o-b', 'DisplayName', 'GEN Data') ;
hold on 
 
PENY_median = [PEN_1LO_median PEN_LUS_median PEN_2LO_median] ;
q3 = errorbar(1:3, PENY_median, stderror(3,:), 'o-r', 'DisplayName', 'PEN Data') ;
 
legend([q1 q2 q3], 'SHAM DATA','GEN DATA','PEN DATA','Location','NorthWest')
xlabel('Trial Type'), ylabel('Median Value')
title('Cohort Median Value Trends L+US and 2LO vs. 1LO')
set(gca,'XTick',[1 2 3] );
% set(gca,'XTickLabel',['1st LO', 'L+US' ,'2nd LO'] );
xticklabels({'1st LO','L+US','2nd LO'});
 
%% data comparisons 
 
% SHAM vs. GEN vs. PEN L+US 
 
% SHAM_MATRIX = SHAM_MATRIX';
% GEN_MATRIX = GEN_MATRIX';
% PEN_MATRIX = PEN_MATRIX';
 
% % %this first one is a test--we should see all 0s 
% firstLO_matrix = [SHAM_MATRIX(:,1) GEN_MATRIX(:,1) PEN_MATRIX(:,1)] ;
% LUS_matrix = [SHAM_MATRIX(:,2) GEN_MATRIX(:,2) PEN_MATRIX(:,2)] ;
% secondLO_matrix = [SHAM_MATRIX(:,3) GEN_MATRIX(:,3) PEN_MATRIX(:,3)] ; 
 
%%Running statistics for all the data points in each cohort
%MUST RUN THROUGH MEDIAN SHAM SCRIPT TO HAVE ALL VECTORS IN THE WORK SPACE:(
 
firstLO_matrix = [Sham_1 Gen_1 Pen_1] ;
%NULL HYPOTHESIS: all pts in Sham 1st LO = all pts in Gen 1st LO = all pts in Pen 1st LO
 
str1=strings(1,length(Sham_2));
for ii=1:length(Sham_2)
    str1(ii)='SHAM-L+US';
end
 
str2=strings(1,length(Gen_2));
for ii=1:length(Gen_2)
    str2(ii)='GEN-L+US';
end
 
str3=strings(1,length(Pen_2));
for ii=1:length(Pen_2)
    str3(ii)='PEN-L+US';
end
all_points_LUS=[str1 str2 str3];
LUS_matrix = [Sham_2 Gen_2 Pen_2] ;
%NULL HYPOTHESIS: all pts in Sham L+US = all pts in Gen L+US = all pts in Pen L+US
 
str4=strings(1,length(Sham_3));
for ii=1:length(Sham_3)
    str4(ii)='SHAM-2nd LO';
end
 
str5=strings(1,length(Gen_3));
for ii=1:length(Gen_3)
    str5(ii)='GEN-2nd LO';
end
 
str6=strings(1,length(Pen_3));
for ii=1:length(Pen_3)
    str6(ii)='PEN-2nd LO';
end
all_points_2LO=[str4 str5 str6];
secondLO_matrix = [Sham_3 Gen_3 Pen_3] ; 
%NULL HYPOTHESIS: all pts in Sham 2nd LO = all pts in Gen 2nd LO = all pts in Pen 2nd LO
 
 
%% KW analysis 
% harry_plotter and the-
 
chamber_of_statistics(LUS_matrix, all_points_LUS); 
title('KW of L+US Medians Between Cohorts')
% hold on 
% set(gca, 'XTick', [1 2 3]) ; 
% set(gca, 'XTickLabel', [{'SHAM' 'GEN' 'PEN'}]) ; 
 
 
chamber_of_statistics(secondLO_matrix, all_points_2LO);  
title('KW of 2nd LO Medians Between Cohorts')
% hold on 
% set(gca, 'XTick', [1 2 3]) ; 
% set(gca, 'XTickLabel', [{'SHAM' 'GEN' 'PEN'}]) ; 
 
%% individual Mann Whitney comparisons 
 
 
SHAM_MATRIX = SHAM_MATRIX';
GEN_MATRIX = GEN_MATRIX';
PEN_MATRIX = PEN_MATRIX';
 
% for L+US 
MWp1 = ranksum(SHAM_MATRIX(2,:),GEN_MATRIX(2,:)); % SHAM L+US vs. GEN L+US 
MWp2 = ranksum(SHAM_MATRIX(2,:),PEN_MATRIX(2,:)); % SHAM L+US vs. PEN L+US 
MWp3 = ranksum(GEN_MATRIX(2,:),PEN_MATRIX(2,:)); % GEN L+US vs. PEN L+US 
 
% for 2nd LO
MWp4 = ranksum(SHAM_MATRIX(3,:),GEN_MATRIX(3,:)); % SHAM 2LO vs. GEN 2LO 
MWp5 = ranksum(SHAM_MATRIX(3,:),PEN_MATRIX(3,:)); % SHAM 2LO vs. PEN 2LO 
MWp6 = ranksum(GEN_MATRIX(3,:),PEN_MATRIX(3,:)); % GEN 2LO vs. PEN 2LO 
