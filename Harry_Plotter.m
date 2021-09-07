%% Authors: Kat Floerchinger, Hannah Mach, Henry Tan :) 
 
clc
close all 
 
% median_SHAM
% median_GEN
% median_PEN 
 
% copied matrixes from commented median_x scripts to reduce running time 
% SHAM_MATRIX = [0,0.00435600796752600,0.00713109228237704;0,-5.16885958017910e-05,-0.0286916774704259;0,0.0133954508844230,-0.0105393137953733;0,-0.0146888761776283,-0.0364842719945690;0,-0.00765067809909513,-0.0126725453785824;0,-0.0247286394644330,-0.000975316304337212;0,-0.00707821064911673,-0.0152301517258112];
% GEN_MATRIX = [0,-0.00216903690829889,0.0157401784885035;0,-0.00533501284119886,-0.0170182170965821;0,-0.0284201249582408,-0.0566498478936813;0,-0.00382477957074176,-0.00480633475035593;0,-0.0804744010195484,-0.0332240621483618;0,-0.00839983815283812,-0.0181853465935874;0,-0.0387101708843783,-0.0489317590083913];
% PEN_MATRIX = [0,0.00932355090704318,0.0180555755962342;0,0.0355006379032983,0.0289117712082711;0,0.0105964449704316,0.00890424974541322;0,0.0382527652138474,0.0283285886886979;0,-0.000996088743718843,-0.00109136275373061;0,-0.000107093776822434,0.00106106540426960;0,0.000180722336327257,-0.000554426228727898];
%%FOR VARIANCE
SHAM_MATRIX = [0,0.000651793605422940,0.00351423698804928;0,0.00195870342101505,0.00282495836064840;0,0.00229569943306705,0.0328712730299713;0,0.00415150639468666,0.00608743747952202;0,-4.10143066914810e-05,0.000381074207617581;0,-0.000753675232561845,0.0143026020700530;0,-0.000395088444663743,-0.000254390982802543];
GEN_MATRIX = [0,0.000147056079904678,-0.000107664675134410;0,0.00135447238533644,0.0176845808391583;0,0.00270295732300754,0.00423865514653214;0,7.89061353128657e-05,4.73994436278257e-05;0,-0.00720922236817418,0.00159971911763594;0,0.000514604907676740,-3.03418205146000e-05;0,0.00119856209903107,0.00180060336843801];
PEN_MATRIX = [0,0.00249220824028257,0.000714005721568463;0,0.00227047924981125,0.000554668335156980;0,0.00414589480879269,0.00186932469441971;0,0.0103562288243062,0.0119330399918491;0,-1.46275955826850e-05,5.89273426955684e-06;0,-1.35744905582141e-05,4.88065197918587e-05;0,-0.000860771124194627,-0.000881627352381173];

% concatenating the matrixes from median_x scripts
MATRIX = [SHAM_MATRIX; GEN_MATRIX; PEN_MATRIX] ;
% SHAM = 7 rows 
% GEN = 7 rows
% PEN = 7 rows 
 
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
for q = 15:21
    row = MATRIX(q,:) ;
    p3 = plot(1:3, MATRIX(q, :), 'r', 'DisplayName','PEN data') ;
end
legend([p1 p2 p3],{'SHAM data','GEN data', 'PEN data'})
xlabel('Trial Type'), ylabel('Variance Value') %%SHOULD BE LABELED MEDIAN VALUE
title('All Mice Variance Values L+US and 2LO vs. 1LO') %%SHOULD BE LABELED "ALL MICE VARIANCE VALUES..."
set(gca,'XTick',[1 2 3] );
% set(gca,'XTickLabel',['1st LO', 'L+US' ,'2nd LO'] );
xticklabels({'1st LO','L+US','2nd LO'});
hold off 
 
%% setting up cohort medians 
 
% some more efficient loop in progress 
% for q = 1:3
%     for p = 1:7 
%         x = MATRIX(p, q)
 
% % SHAM MEDIANS 
% SHAM_1LO = [];
% for q = 1:7
%     SHAM_1LO = [SHAM_1LO MATRIX(q, 1)] ;
% end 
% SHAM_1LO_median = median(SHAM_1LO) ;
%  
% SHAM_LUS = [];
% for q = 1:7
%     SHAM_LUS = [SHAM_LUS MATRIX(q, 2)] ;
% end 
% SHAM_LUS_median = median(SHAM_LUS) ;
%  
% SHAM_2LO = [];
% for q = 1:7
%     SHAM_2LO = [SHAM_2LO MATRIX(q, 3)] ;
% end 
% SHAM_2LO_median = median(SHAM_2LO) ;
%  
% % GEN MEDIANS 
%  
% GEN_1LO = [];
% for q = 8:14
%     GEN_1LO = [GEN_1LO MATRIX(q, 1)] ;
% end 
% GEN_1LO_median = median(GEN_1LO) ;
%  
% GEN_LUS = [];
% for q = 8:14
%     GEN_LUS = [GEN_LUS MATRIX(q, 2)] ;
% end 
% GEN_LUS_median = median(GEN_LUS) ;
%  
% GEN_2LO = [];
% for q = 8:14
%     GEN_2LO = [GEN_2LO MATRIX(q, 3)] ;
% end 
% GEN_2LO_median = median(GEN_2LO) ;
%  
% % PEN MEDIANS 
%  
% PEN_1LO = [];
% for q = 15:21
%     PEN_1LO = [PEN_1LO MATRIX(q, 1)] ;
% end 
% PEN_1LO_median = median(PEN_1LO) ;
%  
% PEN_LUS = [];
% for q = 15:21
%     PEN_LUS = [PEN_LUS MATRIX(q, 2)] ;
% end 
% PEN_LUS_median = median(PEN_LUS) ;
%  
% PEN_2LO = [];
% for q = 15:21
%     PEN_2LO = [PEN_2LO MATRIX(q, 3)] ;
% end 
% PEN_2LO_median = median(PEN_2LO) ;

%%setting up cohort variance

% SHAM VARIANCE
SHAM_1LO = [];
for q = 1:7
    SHAM_1LO = [SHAM_1LO MATRIX(q, 1)] ;
end 
SHAM_1LO_variance = var(SHAM_1LO) ;
 
SHAM_LUS = [];
for q = 1:7
    SHAM_LUS = [SHAM_LUS MATRIX(q, 2)] ;
end 
SHAM_LUS_variance = var(SHAM_LUS) ;
 
SHAM_2LO = [];
for q = 1:7
    SHAM_2LO = [SHAM_2LO MATRIX(q, 3)] ;
end 
SHAM_2LO_variance = var(SHAM_2LO) ;
 
% GEN VARIANCE
 
GEN_1LO = [];
for q = 8:14
    GEN_1LO = [GEN_1LO MATRIX(q, 1)] ;
end 
GEN_1LO_variance = var(GEN_1LO) ;
 
GEN_LUS = [];
for q = 8:14
    GEN_LUS = [GEN_LUS MATRIX(q, 2)] ;
end 
GEN_LUS_variance = var(GEN_LUS) ;
 
GEN_2LO = [];
for q = 8:14
    GEN_2LO = [GEN_2LO MATRIX(q, 3)] ;
end 
GEN_2LO_variance = var(GEN_2LO) ;
 
% PEN VARIANCE
 
PEN_1LO = [];
for q = 15:21
    PEN_1LO = [PEN_1LO MATRIX(q, 1)] ;
end 
PEN_1LO_variance = var(PEN_1LO) ;
 
PEN_LUS = [];
for q = 15:21
    PEN_LUS = [PEN_LUS MATRIX(q, 2)] ;
end 
PEN_LUS_variance = var(PEN_LUS) ;
 
PEN_2LO = [];
for q = 15:21
    PEN_2LO = [PEN_2LO MATRIX(q, 3)] ;
end 
PEN_2LO_variance = var(PEN_2LO) ;
 
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
 
% figure(2) 
% SHAMY_median = [SHAM_1LO_median SHAM_LUS_median SHAM_2LO_median] ;
% q1 = errorbar(1:3, SHAMY_median, stderror(1,:), 'o-g', 'DisplayName', 'SHAM Data') ;
% hold on 
%  
% GENY_median = [GEN_1LO_median GEN_LUS_median GEN_2LO_median] ;
% q2 = errorbar(1:3, GENY_median, stderror(2,:), 'o-b', 'DisplayName', 'GEN Data') ;
% hold on 
%  
% PENY_median = [PEN_1LO_median PEN_LUS_median PEN_2LO_median] ;
% q3 = errorbar(1:3, PENY_median, stderror(3,:), 'o-r', 'DisplayName', 'PEN Data') ;
%  
% legend([q1 q2 q3], 'SHAM DATA','GEN DATA','PEN DATA','Location','NorthWest')
% xlabel('Trial Type'), ylabel('Median Value')
% title('Cohort Median Value Trends L+US and 2LO vs. 1LO')
% set(gca,'XTick',[1 2 3] );
% % set(gca,'XTickLabel',['1st LO', 'L+US' ,'2nd LO'] );
% xticklabels({'1st LO','L+US','2nd LO'});

%% plotting cohort variance
 
figure(2) 
SHAMY_variance = [SHAM_1LO_variance SHAM_LUS_variance SHAM_2LO_variance] ;
q1 = errorbar(1:3, SHAMY_variance, stderror(1,:), 'o-g', 'DisplayName', 'SHAM Data') ;
hold on 
 
GENY_variance = [GEN_1LO_variance GEN_LUS_variance GEN_2LO_variance] ;
q2 = errorbar(1:3, GENY_variance, stderror(2,:), 'o-b', 'DisplayName', 'GEN Data') ;
hold on 
 
PENY_variance = [PEN_1LO_variance PEN_LUS_variance PEN_2LO_variance] ;
q3 = errorbar(1:3, PENY_variance, stderror(3,:), 'o-r', 'DisplayName', 'PEN Data') ;
 
legend([q1 q2 q3], 'SHAM DATA','GEN DATA','PEN DATA','Location','NorthWest')
xlabel('Trial Type'), ylabel('Variance Value')
title('Cohort Variance Value Trends L+US and 2LO vs. 1LO')
set(gca,'XTick',[1 2 3] );
% set(gca,'XTickLabel',['1st LO', 'L+US' ,'2nd LO'] );
xticklabels({'1st LO','L+US','2nd LO'});
 
%% data comparisons 

% SHAM vs. GEN vs. PEN L+US 

% SHAM_MATRIX = SHAM_MATRIX';
% GEN_MATRIX = GEN_MATRIX';
% PEN_MATRIX = PEN_MATRIX';

% %this first one is a test--we should see all 0s 
firstLO_matrix = [SHAM_MATRIX(:,1) GEN_MATRIX(:,1) PEN_MATRIX(:,1)] ;
LUS_matrix = [SHAM_MATRIX(:,2) GEN_MATRIX(:,2) PEN_MATRIX(:,2)] ;
secondLO_matrix = [SHAM_MATRIX(:,3) GEN_MATRIX(:,3) PEN_MATRIX(:,3)] ; 

%% KW analysis 

% harry_plotter and the-
chamber_of_statistics(LUS_matrix) 
title('KW of L+US Variance between cohorts')
hold on 
set(gca, 'XTick', [1 2 3]) ; 
set(gca, 'XTickLabel', [{'SHAM' 'GEN' 'PEN'}]) ; 

chamber_of_statistics(secondLO_matrix) 
title('KW of 2nd LO Variance between cohorts')
hold on 
set(gca, 'XTick', [1 2 3]) ; 
set(gca, 'XTickLabel', [{'SHAM' 'GEN' 'PEN'}]) ; 

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