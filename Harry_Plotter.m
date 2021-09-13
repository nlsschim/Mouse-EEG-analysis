%% Authors: Kat Floerchinger, Hannah Mach, Henry Tan :) 

clc
clear all 
close all 

% median_SHAM
% median_GEN
% median_PEN 

% what to run automation 
button1 = input("Run data with baseline rms included? ('1'=yes, '2'=no): ") ;
button2 = input("Run data with median(L+US) and median(2LO) each minus median(1LO)? ('1'=yes, '2'=no): ") ; 

%% copied matrixes from commented out median_x scripts to reduce running time

if button1 == 1 
    % 7 by 4 matrix with (x, 1) = baseline rms value
    if button2 == 1
        % L+US and 2LO each - 1LO 
        SHAM_MATRIX = [0.00447886235105312,0,0.00435600796752600,0.00713109228237704;0.00841241164426916,0,-5.16885958017910e-05,-0.0286916774704259;0.00906470771595447,0,0.0133954508844230,-0.0105393137953733;0.0121460485214887,0,-0.0146888761776283,-0.0364842719945690;0.0200559914695149,0,-0.00765067809909513,-0.0126725453785824;0.00395859482863203,0,-0.0247286394644330,-0.000975316304337212;0.00892362449028233,0,-0.00707821064911673,-0.0152301517258112] ;
        GEN_MATRIX = [0.00461092829284753,0,-0.00216903690829889,0.0157401784885035;0.00400152391543373,0,-0.00533501284119886,-0.0170182170965821;0.00727139375537472,0,-0.0284201249582408,-0.0566498478936813;0.00616758666332717,0,-0.00382477957074176,-0.00480633475035593;0.00446217098708201,0,-0.0804744010195484,-0.0332240621483618;0.00569279603806760,0,-0.00839983815283812,-0.0181853465935874;0.00512296495652707,0,-0.0387101708843783,-0.0489317590083913] ;
        PEN_MATRIX = [0.0101320091346382,0,0.00932355090704318,0.0180555755962342;0.00827583129124937,0,0.0355006379032983,0.0289117712082711;0.0102484600620898,0,0.0105964449704316,0.00890424974541322;0.0109171220921352,0,0.0382527652138474,0.0283285886886979;0.0337258202950021,0,-0.000996088743718843,-0.00109136275373061;0.0267704375784809,0,-0.000107093776822434,0.00106106540426960;0.0139512076875862,0,0.000180722336327257,-0.000554426228727898] ; 
    end 
    if button2 == 2 
        % L+US and 2LO not (-) 1LO 
        SHAM_MATRIX = [0.00447886235105312,0.218626846387372,0.222982854354898,0.225757938669749;0.00841241164426916,0.149501732416761,0.149450043820960,0.120810054946336;0.00906470771595447,0.262382767141867,0.275778218026290,0.251843453346494;0.0121460485214887,0.105125039925450,0.0904361637478214,0.0686407679308807;0.0200559914695149,0.0702382032857516,0.0625875251866565,0.0575656579071692;0.00395859482863203,0.108706122975057,0.0839774835106236,0.107730806670719;0.00892362449028233,0.0431613563237806,0.0360831456746638,0.0279312045979694];
        GEN_MATRIX = [0.00461092829284753,0.156857481389950,0.154688444481651,0.172597659878453;0.00400152391543373,0.317744558369515,0.312409545528316,0.300726341272933;0.00727139375537472,0.287242213387836,0.258822088429595,0.230592365494155;0.00616758666332717,0.0912658615559288,0.0874410819851871,0.0864595268055729;0.00446217098708201,0.200320802250603,0.119846401231054,0.167096740102241;0.00569279603806760,0.115935744096746,0.107535905943908,0.0977503975031584;0.00512296495652707,0.256205097945568,0.217494927061190,0.207273338937177] ;
        PEN_MATRIX = [0.0101320091346382,0.0386834050600615,0.0480069559671047,0.0567389806562957;0.00827583129124937,0.0535058057233722,0.0890064436266705,0.0824175769316434;0.0102484600620898,0.0546066605598332,0.0652031055302648,0.0635109103052465;0.0109171220921352,0.129154114665111,0.167406879878959,0.157482703353809;0.0337258202950021,0.00493893591101879,0.00394284716729995,0.00384757315728818;0.0267704375784809,0.00678480243616181,0.00667770865933937,0.00784586784043141;0.0139512076875862,0.0155601986277157,0.0157409209640430,0.0150057723989878] ;
    end 
end 
if button1 == 2 
    if button2 == 1 
        % L+US and 2LO each - 1LO 
        SHAM_MATRIX = [0,0.00435600796752600,0.00713109228237704;0,-5.16885958017910e-05,-0.0286916774704259;0,0.0133954508844230,-0.0105393137953733;0,-0.0146888761776283,-0.0364842719945690;0,-0.00765067809909513,-0.0126725453785824;0,-0.0247286394644330,-0.000975316304337212;0,-0.00707821064911673,-0.0152301517258112];
        GEN_MATRIX = [0,-0.00216903690829889,0.0157401784885035;0,-0.00533501284119886,-0.0170182170965821;0,-0.0284201249582408,-0.0566498478936813;0,-0.00382477957074176,-0.00480633475035593;0,-0.0804744010195484,-0.0332240621483618;0,-0.00839983815283812,-0.0181853465935874;0,-0.0387101708843783,-0.0489317590083913];
        PEN_MATRIX = [0,0.00932355090704318,0.0180555755962342;0,0.0355006379032983,0.0289117712082711;0,0.0105964449704316,0.00890424974541322;0,0.0382527652138474,0.0283285886886979;0,-0.000996088743718843,-0.00109136275373061;0,-0.000107093776822434,0.00106106540426960;0,0.000180722336327257,-0.000554426228727898];
    end 
    if button2 == 2 
        % matrixes that are not minus the 1LO median 
        SHAM_MATRIX = [0.218626846387372,0.222982854354898,0.225757938669749;0.149501732416761,0.149450043820960,0.120810054946336;0.262382767141867,0.275778218026290,0.251843453346494;0.105125039925450,0.0904361637478214,0.0686407679308807;0.0702382032857516,0.0625875251866565,0.0575656579071692;0.108706122975057,0.0839774835106236,0.107730806670719;0.0431613563237806,0.0360831456746638,0.0279312045979694];
        GEN_MATRIX =[0.156857481389950,0.154688444481651,0.172597659878453;0.317744558369515,0.312409545528316,0.300726341272933;0.287242213387836,0.258822088429595,0.230592365494155;0.0912658615559288,0.0874410819851871,0.0864595268055729;0.200320802250603,0.119846401231054,0.167096740102241;0.115935744096746,0.107535905943908,0.0977503975031584;0.256205097945568,0.217494927061190,0.207273338937177] ;
        PEN_MATRIX = [0.0386834050600615,0.0480069559671047,0.0567389806562957;0.0535058057233722,0.0890064436266705,0.0824175769316434;0.0546066605598332,0.0652031055302648,0.0635109103052465;0.129154114665111,0.167406879878959,0.157482703353809;0.00493893591101879,0.00394284716729995,0.00384757315728818;0.00678480243616181,0.00667770865933937,0.00784586784043141;0.0155601986277157,0.0157409209640430,0.0150057723989878];
    end
end 

% concatenating the matrixes from median_x scripts
MATRIX = [SHAM_MATRIX; GEN_MATRIX; PEN_MATRIX] ;
% SHAM = 7 rows 
% GEN = 7 rows
% PEN = 7 rows 

%% all dates PLOTTING 
figure(1) 
hold on 

% for rms baseline included or not 
if button1 == 1 
    b = 4 ;
else 
    b = 3 ;
end 

% SHAM plotting
for q = 1:7 
    row = MATRIX(q,:) ;
    p1 = plot(1:b, MATRIX(q, :), 'g', 'DisplayName','SHAM data') ;
end 
% GEN plotting 
for q = 8:14
    row = MATRIX(q,:) ;
    p2 = plot(1:b, MATRIX(q, :), 'b', 'DisplayName','GEN data') ;
end 
% PEN plotting 
for q = 15:21
    row = MATRIX(q,:) ;
    p3 = plot(1:b, MATRIX(q, :), 'r', 'DisplayName','PEN data') ;
end

legend([p1 p2 p3],{'SHAM data','GEN data', 'PEN data'})
xlabel('Trial Type'), ylabel('Median Value')
title('All Mice Median Values L+US and 2LO vs. 1LO')
if button1 == 1 
    set(gca,'XTick',[1 2 3 4] );
    % set(gca,'XTickLabel',['1st LO', 'L+US' ,'2nd LO'] );
    xticklabels({'baseline rms value','1st LO','L+US','2nd LO'});
else 
    set(gca,'XTick',[1 2 3] );
    % set(gca,'XTickLabel',['1st LO', 'L+US' ,'2nd LO'] );
    xticklabels({'1st LO','L+US','2nd LO'});
end 
hold off 

%% setting up cohort medians - requires more parsimonious solution for automation 

if button1==1 
    b = 4;
    names = ["rmsBL" "LO1" "LUS" "LO2", "median"] ;
else 
    b = 3;
    names = ["LO1" "LUS" "LO2", "median"] ;
end 

    % initializing 
    for j = 1:b
        SHAM.(char(names(j))) = [];
        GEN.(char(names(j))) = [];
        PEN.(char(names(j))) = [];
    end 

    % SHAM medians 
    for i = 1:b 
        for j = 1:7 
            SHAM.(char(names(i))) = [SHAM.(char(names(i))) MATRIX(j,i)];
        end 
        trialmedian = strcat(char(names(i)),names(b+1));
        SHAM.(trialmedian) = median(SHAM.(char(names(i))));
    end 

    % GEN medians 
    for i = 1:b 
        for j = 8:14 
            GEN.(char(names(i))) = [GEN.(char(names(i))) MATRIX(j,i)];
        end 
        trialmedian = strcat(char(names(i)),names(b+1));
        GEN.(trialmedian) = median(GEN.(char(names(i))));
    end 

    % PEN medians 
    for i = 1:b 
        for j = 15:21 
            PEN.(char(names(i))) = [PEN.(char(names(i))) MATRIX(j,i)];
        end 
        trialmedian = strcat(char(names(i)),names(b+1));
        PEN.(trialmedian) = median(PEN.(char(names(i))));
    end 

%%

% IN PROGRESS - names(n) doesnt work for creating structure 
% names = ["GEN" "SHAM" "PEN"] ;
% names2 = ["rmsBL" "LO1" "LUS" "LO2"] ;
% for n = 1:3 
%     for i = 1:4 
%         for j = (n*7)-6:n*7
%                 names(n).(char(names2(i))) = [names(n).(char(names2(i))) MATRIX(j,i)];
%         end 
%     end    
% end 
%% needs to be compared to new method with all the diff parameters 

% % SHAM MEDIANS 
% SHAM_rmsBL = [] ;
% for q = 1:7
%     SHAM_rmsBL = [SHAM_rmsBL MATRIX(q, 1)] ;
% end 
% SHAM_rmsBL = median(SHAM_rmsBL) ;
% 
% SHAM_1LO = [];
% for q = 1:7
%     SHAM_1LO = [SHAM_1LO MATRIX(q, 2)] ;
% end 
% SHAM_1LO_median = median(SHAM_1LO) ;
% 
% SHAM_LUS = [];
% for q = 1:7
%     SHAM_LUS = [SHAM_LUS MATRIX(q, 3)] ;
% end 
% SHAM_LUS_median = median(SHAM_LUS) ;
% 
% SHAM_2LO = [];
% for q = 1:7
%     SHAM_2LO = [SHAM_2LO MATRIX(q, 4)] ;
% end 
% SHAM_2LO_median = median(SHAM_2LO) ;
% 
% % GEN MEDIANS 
% 
% GEN_rmsBL = [] ;
% for q = 8:14
%     GEN_rmsBL = [GEN_rmsBL MATRIX(q, 1)] ;
% end 
% GEN_rmsBL = median(GEN_rmsBL) ;
% 
% GEN_1LO = [];
% for q = 8:14
%     GEN_1LO = [GEN_1LO MATRIX(q, 2)] ;
% end 
% GEN_1LO_median = median(GEN_1LO) ;
% 
% GEN_LUS = [];
% for q = 8:14
%     GEN_LUS = [GEN_LUS MATRIX(q, 3)] ;
% end 
% GEN_LUS_median = median(GEN_LUS) ;
% 
% GEN_2LO = [];
% for q = 8:14
%     GEN_2LO = [GEN_2LO MATRIX(q, 4)] ;
% end 
% GEN_2LO_median = median(GEN_2LO) ;
% 
% % PEN MEDIANS 
% 
% PEN_rmsBL = [] ;
% for q = 15:21
%     PEN_rmsBL = [PEN_rmsBL MATRIX(q, 1)] ;
% end 
% PEN_rmsBL = median(PEN_rmsBL) ;
% 
% PEN_1LO = [];
% for q = 15:21
%     PEN_1LO = [PEN_1LO MATRIX(q, 2)] ;
% end 
% PEN_1LO_median = median(PEN_1LO) ;
% 
% PEN_LUS = [];
% for q = 15:21
%     PEN_LUS = [PEN_LUS MATRIX(q, 3)] ;
% end 
% PEN_LUS_median = median(PEN_LUS) ;
% 
% PEN_2LO = [];
% for q = 15:21
%     PEN_2LO = [PEN_2LO MATRIX(q, 4)] ;
% end 
% PEN_2LO_median = median(PEN_2LO) ;

    

%% standard error matrix creation 

if button1 == 1
    stderror(1, 1) = std(SHAM.rmsBLmedian)/sqrt(length(SHAM.rmsBL)) ;
    stderror(1, 2) = std(SHAM.LO1median)/sqrt(length(SHAM.LO1)) ;
    stderror(1, 3) = std(SHAM.LUSmedian)/sqrt(length(SHAM.LUS)) ;
    stderror(1, 4) = std(SHAM.LO2median)/sqrt(length(SHAM.LO2)) ;

    stderror(2, 1) = std(GEN.rmsBLmedian)/sqrt(length(GEN.rmsBL)) ;
    stderror(2, 2) = std(GEN.LO1median)/sqrt(length(GEN.LO1)) ;
    stderror(2, 3) = std(GEN.LUSmedian)/sqrt(length(GEN.LUS)) ;
    stderror(2, 4) = std(GEN.LO2median)/sqrt(length(GEN.LO2)) ;

    stderror(3, 1) = std(PEN.rmsBLmedian)/sqrt(length(PEN.rmsBL)) ;
    stderror(3, 2) = std(PEN.LO1median)/sqrt(length(PEN.LO1)) ;
    stderror(3, 3) = std(PEN.LUSmedian)/sqrt(length(PEN.LUS)) ;
    stderror(3, 4) = std(PEN.LO2median)/sqrt(length(PEN.LO2)) ;
end 

if button1 == 2 
    stderror(1, 1) = std(SHAM.LO1median)/sqrt(length(SHAM.LO1)) ;
    stderror(1, 2) = std(SHAM.LUSmedian)/sqrt(length(SHAM.LUS)) ;
    stderror(1, 3) = std(SHAM.LO2median)/sqrt(length(SHAM.LO2)) ;

    stderror(2, 1) = std(GEN.LO1median)/sqrt(length(GEN.LO1)) ;
    stderror(2, 2) = std(GEN.LUSmedian)/sqrt(length(GEN.LUS)) ;
    stderror(2, 3) = std(GEN.LO2median)/sqrt(length(GEN.LO2)) ;

    stderror(3, 1) = std(PEN.LO1median)/sqrt(length(PEN.LO1)) ;
    stderror(3, 2) = std(PEN.LUSmedian)/sqrt(length(PEN.LUS)) ;
    stderror(3, 3) = std(PEN.LO2median)/sqrt(length(PEN.LO2)) ;
% stderror(1, 1) = std(SHAM_1LO)/sqrt(length(SHAM_1LO)) ;
% stderror(1, 2) = std(SHAM_LUS)/sqrt(length(SHAM_LUS)) ;
% stderror(1, 3) = std(SHAM_2LO)/sqrt(length(SHAM_2LO)) ;
% 
% stderror(2, 1) = std(GEN_1LO)/sqrt(length(GEN_1LO)) ;
% stderror(2, 2) = std(GEN_LUS)/sqrt(length(GEN_LUS)) ;
% stderror(2, 3) = std(GEN_2LO)/sqrt(length(GEN_2LO)) ;
% 
% stderror(3, 1) = std(PEN_1LO)/sqrt(length(PEN_1LO)) ;
% stderror(3, 2) = std(PEN_LUS)/sqrt(length(PEN_LUS)) ;
% stderror(3, 3) = std(PEN_2LO)/sqrt(length(PEN_2LO)) ;  
end 
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
if button1 ==1 
    SHAMY_median = [SHAM.rmsBLmedian SHAM.LO1median SHAM.LUSmedian SHAM.LO2median] ;
    q1 = errorbar(1:4, SHAMY_median, stderror(1,:), 'o-g', 'DisplayName', 'SHAM data') ;
    hold on 

    GENY_median = [GEN.rmsBLmedian GEN.LO1median GEN.LUSmedian GEN.LO2median] ;
    q2 = errorbar(1:4, GENY_median, stderror(2,:), 'o-b', 'DisplayName', 'GEN data') ;
    hold on 

    PENY_median = [PEN.rmsBLmedian PEN.LO1median PEN.LUSmedian PEN.LO2median] ;
    q3 = errorbar(1:4, PENY_median, stderror(3,:), 'o-r', 'DisplayName', 'PEN data') ;
else 
    SHAMY_median = [SHAM.LO1median SHAM.LUSmedian SHAM.LO2median] ;
    q1 = errorbar(1:3, SHAMY_median, stderror(1,:), 'o-g', 'DisplayName', 'SHAM data') ;
    hold on 

    GENY_median = [GEN.LO1median GEN.LUSmedian GEN.LO2median] ;
    q2 = errorbar(1:3, GENY_median, stderror(2,:), 'o-b', 'DisplayName', 'GEN data') ;
    hold on 

    PENY_median = [PEN.LO1median PEN.LUSmedian PEN.LO2median] ;
    q3 = errorbar(1:3, PENY_median, stderror(3,:), 'o-r', 'DisplayName', 'PEN data') ;
end 

legend([q1 q2 q3],'SHAM DATA','GEN DATA','PEN DATA','Location','NorthWest')
xlabel('Trial Type'), ylabel('Median Value')
title('Cohort Median Value Trends L+US and 2LO vs. 1LO')
% set(gca,'XTickLabel',['1st LO', 'L+US' ,'2nd LO'] );

if button1 ==1 
    set(gca,'XTick',[1 2 3 4] );
    xticklabels({'rms Baseline','1st LO','L+US','2nd LO'});
else
    set(gca,'XTick',[1 2 3] );
    xticklabels({'1st LO','L+US','2nd LO'}); 
end 

%% data comparisons 

% SHAM vs. GEN vs. PEN L+US 

% SHAM_MATRIX = SHAM_MATRIX';
% GEN_MATRIX = GEN_MATRIX';
% PEN_MATRIX = PEN_MATRIX';

if button1 == 1 
    % %this first one is a test--we should see all 0s if button2 ==1 
    firstLO_matrix = [SHAM_MATRIX(:,2) GEN_MATRIX(:,2) PEN_MATRIX(:,2)] ;

    LUS_matrix = [SHAM_MATRIX(:,3) GEN_MATRIX(:,3) PEN_MATRIX(:,3)] ;
    secondLO_matrix = [SHAM_MATRIX(:,4) GEN_MATRIX(:,4) PEN_MATRIX(:,4)] ;
else 
    firstLO_matrix = [SHAM_MATRIX(:,1) GEN_MATRIX(:,1) PEN_MATRIX(:,1)] ;
    LUS_matrix = [SHAM_MATRIX(:,2) GEN_MATRIX(:,2) PEN_MATRIX(:,2)] ;
    secondLO_matrix = [SHAM_MATRIX(:,3) GEN_MATRIX(:,3) PEN_MATRIX(:,3)] ;
end 

%% KW analysis 

% harry_plotter and the-
chamber_of_statistics( LUS_matrix) 
title('KW of L+US medians between cohorts')
hold on 
set(gca, 'XTick', [1 2 3]) ; 
set(gca, 'XTickLabel', [{'SHAM' 'GEN' 'PEN'}]) ; 

chamber_of_statistics(secondLO_matrix) 
title('KW of 2nd LO medians between cohorts')
hold on 
set(gca, 'XTick', [1 2 3]) ; 
set(gca, 'XTickLabel', [{'SHAM' 'GEN' 'PEN'}]) ; 

%% individual Mann Whitney comparisons 

SHAM_MATRIX = SHAM_MATRIX';
GEN_MATRIX = GEN_MATRIX';
PEN_MATRIX = PEN_MATRIX';

if button1 == 1 
    % for L+US 
    MWp1 = ranksum(SHAM_MATRIX(3,:),GEN_MATRIX(3,:)); % SHAM L+US vs. GEN L+US 
    MWp2 = ranksum(SHAM_MATRIX(3,:),PEN_MATRIX(3,:)); % SHAM L+US vs. PEN L+US 
    MWp3 = ranksum(GEN_MATRIX(3,:),PEN_MATRIX(3,:)); % GEN L+US vs. PEN L+US 

    % for 2nd LO
    MWp4 = ranksum(SHAM_MATRIX(4,:),GEN_MATRIX(4,:)); % SHAM 2LO vs. GEN 2LO 
    MWp5 = ranksum(SHAM_MATRIX(4,:),PEN_MATRIX(4,:)); % SHAM 2LO vs. PEN 2LO 
    MWp6 = ranksum(GEN_MATRIX(4,:),PEN_MATRIX(4,:)); % GEN 2LO vs. PEN 2LO 
else 
    MWp1 = ranksum(SHAM_MATRIX(2,:),GEN_MATRIX(2,:)); % SHAM L+US vs. GEN L+US 
    MWp2 = ranksum(SHAM_MATRIX(2,:),PEN_MATRIX(2,:)); % SHAM L+US vs. PEN L+US 
    MWp3 = ranksum(GEN_MATRIX(2,:),PEN_MATRIX(2,:)); % GEN L+US vs. PEN L+US 

    % for 2nd LO
    MWp4 = ranksum(SHAM_MATRIX(3,:),GEN_MATRIX(3,:)); % SHAM 2LO vs. GEN 2LO 
    MWp5 = ranksum(SHAM_MATRIX(3,:),PEN_MATRIX(3,:)); % SHAM 2LO vs. PEN 2LO 
    MWp6 = ranksum(GEN_MATRIX(3,:),PEN_MATRIX(3,:)); % GEN 2LO vs. PEN 2LO 
end 