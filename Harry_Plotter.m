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
ACTUAL_PEN_MATRIX = [];
ACTUAL_SHAM_MATRIX = [];
ACTUAL_GEN_MATRIX = [];

if button1 == 1 % 7 by 4 matrix with (x, 1) = baseline rms value
    if button2 == 1 % L+US and 2LO each - 1LO 
%         % updated 6/20/22 with new calc baseline rms 
%         ACTUAL_SHAM_MATRIX = [0.00875645051057406,0,-0.0161320041862880,-0.0241793073671077;0.00797476232880989,0,-0.00535682662750674,-0.00559916439132274;0.00691050921472223,0,-0.00826481915892088,-0.00715374709284675;0.00478128097959782,0,-0.00355353450732417,-0.00696459688656752;0.00822190651829338,0,-0.00595987316292648,-0.0127733833609279;0.00997568780215539,0,0.00226901291182080,-0.00372841190101977;0.00728096415499368,0,-0.00822883305952320,-0.0163689771437286];
%         % updated 6/20/22 with new calc baseline rms 
%         ACTUAL_PEN_MATRIX = [0.00882862296929438,0,0.0253098454079370,0.0195927909267431;0.00882076590369108,0,0.00983662079465671,0.00802901453594875;0.00757623538011407,0,-0.00334380190501276,-0.00384635329873213;0.0106446711456137,0,0.0315841777499344,0.0252143540140312;0.00880863172217986,0,0.0213409375453499,-0.0278449490174810;0.00657559271345368,0,0.0127011085472304,0.00812505635620006;0.00656479568898303,0,0.00913634129290152,0.00484899032880089];
% % % w baseline change 
%             ACTUAL_PEN_MATRIX = [0.000735063653914994,0.454462316231005,0.758451067855015,0.689785288720718;0.000852638916541341,0.484085930208540,0.585848267852015,0.567148122521108;0.000363578746916963,0.297520226594186,0.227842253083165,0.217370112778738;0.00206007395549735,0.519559785153593,0.682759356050305,0.649845644994799;0.00134005215165660,0.910997565881920,1.05127901627968,0.727962972105366;0.000810278836577289,0.740060013904429,0.843132330551300,0.805996650726775;0.000363233727732505,0.939675904131228,1.10479882459110,1.02731267455216];
%             ACTUAL_SHAM_MATRIX = [0.00126076709504886,0.629135681334068,0.517093499357443,0.461202278589421;0.000985119813790032,0.715865773265820,0.672501079354474,0.670539301667461;0.000641582195921992,0.871486888854603,0.782466168955012,0.794433573598765;0.000664337117424811,0.731741886808644,0.706166848918131,0.681617192958341;0.00100614648704945,0.940426203456627,0.891724030724140,0.836046209819864;0.00148212540131401,0.732246681296834,0.747518644389374,0.707151994241717;0.000608672341670400,0.505708701944508,0.407275054738867,0.309902308786698];
% w median baseline change 
%             ACTUAL_PEN_MATRIX = [0.000290357638414762,0,0.769571910481697,0.595738982286861;0.000264281219040559,0,0.328311370849741,0.267979911383971;0.000107159089713315,0,-0.236409532449610,-0.271940327453640;0.00149099822880412,0,0.225488655222828,0.180012626067114;0.000696061240968356,0,0.270068850811899,-0.352376898441633;0.000549534528401088,0,0.151978287986657,0.0972223920627511;0.000202285857390864,0,0.296502260248602,0.157364588988168];
%             ACTUAL_SHAM_MATRIX = [0.000477239562076051,0,-0.295992008037034,-0.443644922099517;0.000430606488667095,0,-0.0992075603023090,-0.103695616382723;0.000422893515408820,0,-0.135055532597898,-0.116899487468184;0.000325633983933779,0,-0.0521765165446269,-0.102261116060550;0.000674168318167143,0,-0.0726844004471867,-0.155779441254959;0.000919665603463880,0,0.0246121680990681,-0.0404423879531066;0.000171526360791896,0,-0.349298138590521,-0.694831600735681];
% w median baseline change + extra electrical filtering 
            ACTUAL_PEN_MATRIX = [0.000290357638414762,0,0.770413808702053,0.618555428713722;0.000264281219040559,0,0.330760827785594,0.238939447646966;0.000107159089713315,0,-0.237069121172216,-0.276691387198401;0.00149099822880412,0,0.228482126145637,0.192908223362363;0.000696061240968356,0,0.313270227706946,-0.365783115041496;0.000549534528401088,0,0.133282936452902,0.0853105336987945;0.000202285857390864,0,0.318323953293632,0.166759946425851];
            ACTUAL_SHAM_MATRIX = [0.000477239562076051,0,-0.288151727073906,-0.438640920820270;0.000430606488667095,0,-0.0758476360350504,-0.109052013802533;0.000422893515408820,0,-0.147781771108976,-0.103555311374796;0.000325633983933779,0,-0.0681930398795823,-0.0968534946655142;0.000674168318167143,0,-0.0501618238746999,-0.139628884519064;0.000919665603463880,0,0.0150440643321172,-0.0393634701872627;0.000171526360791896,0,-0.398834534355885,-0.727628397785041];
    end 
    if button2 == 2 % L+US and 2LO not (-) 1LO old baselines 
%         % testing 6/20/22 with different rms_baseline 
%         ACTUAL_SHAM_MATRIX = [0.00875645051057406,0.0905839146112109,0.0744519104249229,0.0664046072441032;0.00797476232880989,0.0884306676715121,0.0830738410440054,0.0828315032801894;0.00691050921472223,0.0809101694962482,0.0726453503373273,0.0737564224034015;0.00478128097959782,0.101672187402452,0.0981186528951274,0.0947075905158840;0.00822190651829338,0.115083590263629,0.109123717100703,0.102310206902702;0.00997568780215539,0.108792639455240,0.111061652367061,0.105064227554220;0.00728096415499368,0.0422761180062325,0.0340472849467093,0.0259071408625039];
%         ACTUAL_PEN_MATRIX = [0.00882862296929438,0.0378381466619741,0.0631479920699110,0.0574309375887171;0.00882076590369108,0.0467930458139921,0.0566296666086489,0.0548220603499409;0.00757623538011407,0.0142778076102932,0.0109340057052804,0.0104314543115611;0.0106446711456137,0.100550929857496,0.132135107607431,0.125765283871528;0.00880863172217986,0.138589543395270,0.159930480940620,0.110744594377789;0.00657559271345368,0.0911940555315960,0.103895164078826,0.0993191118877960;0.00656479568898303,0.0519927805355467,0.0611291218284482,0.0568417708643476];
%             ACTUAL_PEN_MATRIX = [0.000735063653914994,0,0.303988751624010,0.235322972489714;0.000852638916541341,0,0.101762337643475,0.0830621923125683;0.000363578746916963,0,-0.0696779735110215,-0.0801501138154488;0.00206007395549735,0,0.163199570896712,0.130285859841206;0.00134005215165660,0,0.140281450397761,-0.183034593776554;0.000810278836577289,0,0.103072316646871,0.0659366368223459;0.000363233727732505,0,0.165122920459873,0.0876367704209310];
%             ACTUAL_SHAM_MATRIX = [0.00126076709504886,0,-0.112042181976625,-0.167933402744646;0.000985119813790032,0,-0.0433646939113455,-0.0453264715983588;0.000641582195921992,0,-0.0890207198995902,-0.0770533152558375;0.000664337117424811,0,-0.0255750378905129,-0.0501246938503031;0.00100614648704945,0,-0.0487021727324866,-0.104379993636763;0.00148212540131401,0,0.0152719630925402,-0.0250946870551164;0.000608672341670400,0,-0.0984336472056410,-0.195806393157810];
% w median baseline change 
%             ACTUAL_PEN_MATRIX = [0.000290357638414762,1.15050781015875,1.92007972064045,1.74624679244561;0.000264281219040559,1.56178522463442,1.89009659548416,1.82976513601839;0.000107159089713315,1.00945268811970,0.773043155670086,0.737512360666056;0.00149099822880412,0.717862409921969,0.943351065144797,0.897875035989084;0.000696061240968356,1.75384603604081,2.02391488685271,1.40146913759917;0.000549534528401088,1.09120525840040,1.24318354638706,1.18842765046315;0.000202285857390864,1.68732498613822,1.98382724638682,1.84468957512639];
%             ACTUAL_SHAM_MATRIX = [0.000477239562076051,1.66204486882153,1.36605286078450,1.21839994672201;0.000430606488667095,1.63772162245211,1.53851406214980,1.53402600606939;0.000422893515408820,1.32215428115051,1.18709874855261,1.20525479368233;0.000325633983933779,1.49285185136053,1.44067533481590,1.39059073529998;0.000674168318167143,1.40351674120431,1.33083234075713,1.24773729994935;0.000919665603463880,1.18008263252454,1.20469480062361,1.13964024457143;0.000171526360791896,1.79453990858648,1.44524176999596,1.09970830785080];

% median baseline change + extra electrical filtering 
            ACTUAL_PEN_MATRIX = [0.000290357638414762,1.13378692096066,1.90420072966272,1.75234234967438;0.000264281219040559,1.60624620854929,1.93700703633488,1.84518565619625;0.000107159089713315,0.993111748779543,0.756042627607327,0.716420361581142;0.00149099822880412,0.722639366070267,0.951121492215904,0.915547589432630;0.000696061240968356,1.73502099177131,2.04829121947826,1.36923787672981;0.000549534528401088,1.10696369351664,1.24024662996954,1.19227422721544;0.000202285857390864,1.67484057709988,1.99316453039351,1.84160052352573];
            ACTUAL_SHAM_MATRIX = [0.000477239562076051,1.67009464287455,1.38194291580065,1.23145372205428;0.000430606488667095,1.65127122583500,1.57542358979995,1.54221921203246;0.000422893515408820,1.31937991561242,1.17159814450345,1.21582460423763;0.000325633983933779,1.50438010753268,1.43618706765309,1.40752661286716;0.000674168318167143,1.39421227112404,1.34405044724934,1.25458338660498;0.000919665603463880,1.18845065124827,1.20349471558038,1.14908718106100;0.000171526360791896,1.82203463015612,1.42320009580024,1.09440623237108];
    end 
end 


% bruh 
 PEN_MATRIX = ACTUAL_PEN_MATRIX ;
 SHAM_MATRIX = ACTUAL_SHAM_MATRIX ;
 GEN_MATRIX = ACTUAL_GEN_MATRIX ;
% concatenating the matrixes from median_x scripts
MATRIX = [PEN_MATRIX; SHAM_MATRIX; GEN_MATRIX] ;


%% all dates PLOTTING

figure(1) 
hold on 

% for rms baseline included or not 
if button1 == 1 
    b = 4 ;
else 
    b = 3 ;
end 

% finding how many mice per cohort to automate numbers of mice in each
% cohort

[penrownum,pencolnum]=size(PEN_MATRIX);
[shamrownum,shamcolnum]=size(SHAM_MATRIX);
[genrownum,gencolnum]=size(GEN_MATRIX);

% PEN plotting 
for q = 1:penrownum %1-7
    row = MATRIX(q,:) ;
    p3 = plot(1:b, MATRIX(q, :), 'r', 'DisplayName','PEN data') ;
end
% SHAM plotting
for q = penrownum+1:(penrownum+shamrownum) % 5-8
    row = MATRIX(q,:) ;
    p1 = plot(1:b, MATRIX(q, :), 'b', 'DisplayName','SHAM data') ;
end 

if GEN_MATRIX ~= [] 
    % GEN plotting 
    for q = penrownum+shamrownum+1:(penrownum+shamrownum+genrownum) %9-12
        row = MATRIX(q,:) ;
        p2 = plot(1:b, MATRIX(q, :), 'g', 'DisplayName','GEN data') ;
    end 
    legend([p1 p2 p3],{'SHAM data','GEN data', 'PEN data'})
else  
    legend([p1 p3],{'SHAM data','PEN data'})
end 

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

    % PEN medians 
    for i = 1:b 
        for j = 1:penrownum %1-7
            PEN.(char(names(i))) = [PEN.(char(names(i))) MATRIX(j,i)];
        end 
        trialmedian = strcat(char(names(i)),names(b+1));
        PEN.(trialmedian) = median(PEN.(char(names(i))));
    end 
    
  % SHAM medians 
    for i = 1:b 
        for j = penrownum+1:(penrownum+shamrownum) % 8-14
            SHAM.(char(names(i))) = [SHAM.(char(names(i))) MATRIX(j,i)];
        end 
        trialmedian = strcat(char(names(i)),names(b+1));
        SHAM.(trialmedian) = median(SHAM.(char(names(i))));
    end 

if GEN_MATRIX ~= []
        % GEN medians 
    for i = 1:b 
        for j = penrownum+shamrownum+1:(penrownum+shamrownum+genrownum) 
%       for j = 15:21
            GEN.(char(names(i))) = [GEN.(char(names(i))) MATRIX(j,i)];
        end 
        trialmedian = strcat(char(names(i)),names(b+1));
        GEN.(trialmedian) = median(GEN.(char(names(i))));
    end 
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
%% alternative method for calculating medians (less concise)
for i = 1 % to hide code
% SHAM MEDIANS 
% if button1 == 1 
%     
%     % PEN MEDIANS 
% 
%     PEN_rmsBL = [] ;
%     for q = 1:penrownum
%         PEN_rmsBL = [PEN_rmsBL MATRIX(q, 1)] ;
%     end 
%     PEN_rmsBL = median(PEN_rmsBL) ;
% 
%     PEN_1LO = [];
%     for q = 1:penrownum
%         PEN_1LO = [PEN_1LO MATRIX(q, 2)] ;
%     end 
%     PEN_1LO_median = median(PEN_1LO) ;
% 
%     PEN_LUS = [];
%     for q = 1:penrownum
%         PEN_LUS = [PEN_LUS MATRIX(q, 3)] ;
%     end 
%     PEN_LUS_median = median(PEN_LUS) ;
% 
%     PEN_2LO = [];
%     for q = 1:penrownum
%         PEN_2LO = [PEN_2LO MATRIX(q, 4)] ;
%     end 
%     PEN_2LO_median = median(PEN_2LO) ;   
%     
%         SHAM_rmsBL = [] ;
%     for q = penrownum+1:(penrownum+shamrownum)
%         SHAM_rmsBL = [SHAM_rmsBL MATRIX(q, 1)] ;
%     end 
%     SHAM_rmsBL = median(SHAM_rmsBL) ;
% 
%     SHAM_1LO = [];
%     for q = penrownum+1:(penrownum+shamrownum)
%         SHAM_1LO = [SHAM_1LO MATRIX(q, 2)] ;
%     end 
%     SHAM_1LO_median = median(SHAM_1LO) ;
% 
%     SHAM_LUS = [];
%     for q = penrownum+1:(penrownum+shamrownum)
%         SHAM_LUS = [SHAM_LUS MATRIX(q, 3)] ;
%     end 
%     SHAM_LUS_median = median(SHAM_LUS) ;
% 
%     SHAM_2LO = [];
%     for q = penrownum+1:(penrownum+shamrownum)
%         SHAM_2LO = [SHAM_2LO MATRIX(q, 4)] ;
%     end 
%     SHAM_2LO_median = median(SHAM_2LO) ;
%     
%     % GEN MEDIANS 
%     if GEN_MATRIX ~= []
%         GEN_rmsBL = [] ;
%         for q = pencolnum+shamcolnum+1:(pencolnum+shamcolnum+gencolnum)
%             GEN_rmsBL = [GEN_rmsBL MATRIX(q, 1)] ;
%         end 
%         GEN_rmsBL = median(GEN_rmsBL) ;
% 
%         GEN_1LO = [];
%         for q = pencolnum+shamcolnum+1:(pencolnum+shamcolnum+gencolnum)
%             GEN_1LO = [GEN_1LO MATRIX(q, 2)] ;
%         end 
%         GEN_1LO_median = median(GEN_1LO) ;
% 
%         GEN_LUS = [];
%         for q = pencolnum+shamcolnum+1:(pencolnum+shamcolnum+gencolnum)
%             GEN_LUS = [GEN_LUS MATRIX(q, 3)] ;
%         end 
%         GEN_LUS_median = median(GEN_LUS) ;
% 
%         GEN_2LO = [];
%         for q = pencolnum+shamcolnum+1:(pencolnum+shamcolnum+gencolnum)
%             GEN_2LO = [GEN_2LO MATRIX(q, 4)] ;
%         end 
%         GEN_2LO_median = median(GEN_2LO) ;
%     end 
% 
% elseif button1 == 2 % baseline not included 
%     % PEN MEDIANS 
% %     PEN_rmsBL = [] ;
% %     for q = 15:21
% %         PEN_rmsBL = [PEN_rmsBL MATRIX(q, 1)] ;
% %     end 
% %     PEN_rmsBL = median(PEN_rmsBL) ;
% 
%     PEN_1LO = [];
%     for q = 1:penrownum
%         PEN_1LO = [PEN_1LO MATRIX(q, 1)] ;
%     end 
%     PEN_1LO_median = median(PEN_1LO) ;
% 
%     PEN_LUS = [];
%     for q = 1:penrownum
%         PEN_LUS = [PEN_LUS MATRIX(q, 2)] ;
%     end 
%     PEN_LUS_median = median(PEN_LUS) ;
% 
%     PEN_2LO = [];
%     for q = 1:penrownum
%         PEN_2LO = [PEN_2LO MATRIX(q, 3)] ;
%     end 
%     PEN_2LO_median = median(PEN_2LO) ;
%     %
% %     SHAM_rmsBL = [] ;
% %     for q = 1:7
% %         SHAM_rmsBL = [SHAM_rmsBL MATRIX(q, 1)] ;
% %     end 
% %     SHAM_rmsBL = median(SHAM_rmsBL) ;
% 
%     SHAM_1LO = [];
%     for q = penrownum+1:(penrownum+shamrownum)
%         SHAM_1LO = [SHAM_1LO MATRIX(q, 1)] ;
%     end 
%     SHAM_1LO_median = median(SHAM_1LO) ;
% 
%     SHAM_LUS = [];
%     for q = penrownum+1:(penrownum+shamrownum)
%         SHAM_LUS = [SHAM_LUS MATRIX(q, 2)] ;
%     end 
%     SHAM_LUS_median = median(SHAM_LUS) ;
% 
%     SHAM_2LO = [];
%     for q = penrownum+1:(penrownum+shamrownum)
%         SHAM_2LO = [SHAM_2LO MATRIX(q, 3)] ;
%     end 
%     SHAM_2LO_median = median(SHAM_2LO) ;
% 
%     % GEN MEDIANS 
%     if GEN_MATRIX ~= []
% %         GEN_rmsBL = [] ;
% %         for q = 8:14
% %             GEN_rmsBL = [GEN_rmsBL MATRIX(q, 1)] ;
% %         end 
% %         GEN_rmsBL = median(GEN_rmsBL) ;
% 
%         GEN_1LO = [];
%         for q = pencolnum+shamcolnum+1:(pencolnum+shamcolnum+gencolnum)
%             GEN_1LO = [GEN_1LO MATRIX(q, 1)] ;
%         end 
%         GEN_1LO_median = median(GEN_1LO) ;
% 
%         GEN_LUS = [];
%         for q = pencolnum+shamcolnum+1:(pencolnum+shamcolnum+gencolnum)
%             GEN_LUS = [GEN_LUS MATRIX(q, 2)] ;
%         end 
%         GEN_LUS_median = median(GEN_LUS) ;
% 
%         GEN_2LO = [];
%         for q = pencolnum+shamcolnum+1:(pencolnum+shamcolnum+gencolnum)
%             GEN_2LO = [GEN_2LO MATRIX(q, 3)] ;
%         end 
%         GEN_2LO_median = median(GEN_2LO) ;
%     end 
%     
% end
end

%% standard error matrix creation 
if GEN_MATRIX ~= []
    if button1 == 1
        stderror(1, 1) = std(SHAM.rmsBL)/sqrt(length(SHAM.rmsBL)) ;
        stderror(1, 2) = std(SHAM.LO1)/sqrt(length(SHAM.LO1)) ;
        stderror(1, 3) = std(SHAM.LUS)/sqrt(length(SHAM.LUS)) ;
        stderror(1, 4) = std(SHAM.LO2)/sqrt(length(SHAM.LO2)) ;

        stderror(2, 1) = std(GEN.rmsBL)/sqrt(length(GEN.rmsBL)) ;
        stderror(2, 2) = std(GEN.LO1)/sqrt(length(GEN.LO1)) ;
        stderror(2, 3) = std(GEN.LUS)/sqrt(length(GEN.LUS)) ;
        stderror(2, 4) = std(GEN.LO2)/sqrt(length(GEN.LO2)) ;

        stderror(3, 1) = std(PEN.rmsBL)/sqrt(length(PEN.rmsBL)) ;
        stderror(3, 2) = std(PEN.LO1)/sqrt(length(PEN.LO1)) ;
        stderror(3, 3) = std(PEN.LUS)/sqrt(length(PEN.LUS)) ;
        stderror(3, 4) = std(PEN.LO2)/sqrt(length(PEN.LO2)) ;
    elseif button1 == 2 
        stderror(1, 1) = std(SHAM.LO1)/sqrt(length(SHAM.LO1)) ;
        stderror(1, 2) = std(SHAM.LUS)/sqrt(length(SHAM.LUS)) ;
        stderror(1, 3) = std(SHAM.LO2)/sqrt(length(SHAM.LO2)) ;

        stderror(2, 1) = std(GEN.LO1)/sqrt(length(GEN.LO1)) ;
        stderror(2, 2) = std(GEN.LUS)/sqrt(length(GEN.LUS)) ;
        stderror(2, 3) = std(GEN.LO2)/sqrt(length(GEN.LO2)) ;

        stderror(3, 1) = std(PEN.LO1)/sqrt(length(PEN.LO1)) ;
        stderror(3, 2) = std(PEN.LUS)/sqrt(length(PEN.LUS)) ;
        stderror(3, 3) = std(PEN.LO2)/sqrt(length(PEN.LO2)) ;
    end 
else 
    if button1 == 1
        stderror(1, 1) = std(SHAM.rmsBL)/sqrt(length(SHAM.rmsBL)) ;
        stderror(1, 2) = std(SHAM.LO1)/sqrt(length(SHAM.LO1)) ;
        stderror(1, 3) = std(SHAM.LUS)/sqrt(length(SHAM.LUS)) ;
        stderror(1, 4) = std(SHAM.LO2)/sqrt(length(SHAM.LO2)) ;

%         stderror(2, 1) = std(GEN.rmsBLmedian)/sqrt(length(GEN.rmsBL)) ;
%         stderror(2, 2) = std(GEN.LO1median)/sqrt(length(GEN.LO1)) ;
%         stderror(2, 3) = std(GEN.LUSmedian)/sqrt(length(GEN.LUS)) ;
%         stderror(2, 4) = std(GEN.LO2median)/sqrt(length(GEN.LO2)) ;

        stderror(3, 1) = std(PEN.rmsBL)/sqrt(length(PEN.rmsBL)) ;
        stderror(3, 2) = std(PEN.LO1)/sqrt(length(PEN.LO1)) ;
        stderror(3, 3) = std(PEN.LUS)/sqrt(length(PEN.LUS)) ;
        stderror(3, 4) = std(PEN.LO2)/sqrt(length(PEN.LO2)) ;
    elseif button1 == 2 
        stderror(1, 1) = std(SHAM.LO1)/sqrt(length(SHAM.LO1)) ;
        stderror(1, 2) = std(SHAM.LUS)/sqrt(length(SHAM.LUS)) ;
        stderror(1, 3) = std(SHAM.LO2)/sqrt(length(SHAM.LO2)) ;

%         stderror(2, 1) = std(GEN.LO1median)/sqrt(length(GEN.LO1)) ;
%         stderror(2, 2) = std(GEN.LUSmedian)/sqrt(length(GEN.LUS)) ;
%         stderror(2, 3) = std(GEN.LO2median)/sqrt(length(GEN.LO2)) ;

        stderror(2, 1) = std(PEN.LO1)/sqrt(length(PEN.LO1)) ;
        stderror(2, 2) = std(PEN.LUS)/sqrt(length(PEN.LUS)) ;
        stderror(2, 3) = std(PEN.LO2)/sqrt(length(PEN.LO2)) ;
    end
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
if GEN_MATRIX ~= [] 
    if button1 ==1 
        SHAMY_median = [SHAM.rmsBLmedian SHAM.LO1median SHAM.LUSmedian SHAM.LO2median] ;
        q1 = errorbar(1:4, SHAMY_median, stderror(1,:), 'o-b', 'DisplayName', 'SHAM data') ;
        hold on 

        GENY_median = [GEN.rmsBLmedian GEN.LO1median GEN.LUSmedian GEN.LO2median] ;
        q2 = errorbar(1:4, GENY_median, stderror(2,:), 'o-g', 'DisplayName', 'GEN data') ;
        hold on 

        PENY_median = [PEN.rmsBLmedian PEN.LO1median PEN.LUSmedian PEN.LO2median] ;
        q3 = errorbar(1:4, PENY_median, stderror(3,:), 'o-r', 'DisplayName', 'PEN data') ;
    else 
        SHAMY_median = [SHAM.LO1median SHAM.LUSmedian SHAM.LO2median] ;
        q1 = errorbar(1:3, SHAMY_median, stderror(1,:), 'o-b', 'DisplayName', 'SHAM data') ;
        hold on 

        GENY_median = [GEN.LO1median GEN.LUSmedian GEN.LO2median] ;
        q2 = errorbar(1:3, GENY_median, stderror(2,:), 'o-g', 'DisplayName', 'GEN data') ;
        hold on 

        PENY_median = [PEN.LO1median PEN.LUSmedian PEN.LO2median] ;
        q3 = errorbar(1:3, PENY_median, stderror(3,:), 'o-r', 'DisplayName', 'PEN data') ;
    end
else
    if button1 ==1 
        SHAMY_median = [SHAM.rmsBLmedian SHAM.LO1median SHAM.LUSmedian SHAM.LO2median] ;
        q1 = errorbar(1:4, SHAMY_median, stderror(1,:), 'o-b', 'DisplayName', 'SHAM data') ;
        hold on 

        PENY_median = [PEN.rmsBLmedian PEN.LO1median PEN.LUSmedian PEN.LO2median] ;
        q3 = errorbar(1:4, PENY_median, stderror(3,:), 'o-r', 'DisplayName', 'PEN data') ;
    else 
        SHAMY_median = [SHAM.LO1median SHAM.LUSmedian SHAM.LO2median] ;
        q1 = errorbar(1:3, SHAMY_median, stderror(1,:), 'o-b', 'DisplayName', 'SHAM data') ;
        hold on 

        PENY_median = [PEN.LO1median PEN.LUSmedian PEN.LO2median] ;
        q3 = errorbar(1:3, PENY_median, stderror(2,:), 'o-r', 'DisplayName', 'PEN data') ;
    end
end 

if GEN_MATRIX ~= [] 
    legend([q1 q2 q3],'SHAM DATA','GEN DATA','PEN DATA','Location','NorthWest')
else 
    legend([q1 q3],'SHAM DATA','PEN DATA','Location','NorthWest')
end 

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
strpen=strings(1,length(PEN_MATRIX(:,2)));
for ii=1:length(strpen)
    strpen(ii)='PEN';
end
strsham=strings(1,length(SHAM_MATRIX(:,2)));
for ii=1:length(strsham)
    strsham(ii)='SHAM';
end
if GEN_MATRIX ~= []
    strgen=strings(1,length(GEN_MATRIX(:,2)));
    for ii=1:length(strgen)
        strgen(ii)='GEN';
    end
    strdatagroups =[strpen strsham strgen];
else 
    strdatagroups =[strpen strsham];
end 

% matrix for KW but only if columns for each cohort are same length 
% if button1 == 1 
%     % %this first one is a test--we should see all 0s if button2 ==1 
%     firstLO_matrix = [PEN_MATRIX(:,2) SHAM_MATRIX(:,2) GEN_MATRIX(:,2) ] ;
% 
%     LUS_matrix = [PEN_MATRIX(:,3) SHAM_MATRIX(:,3) GEN_MATRIX(:,3) ] ;
%     secondLO_matrix = [PEN_MATRIX(:,4) SHAM_MATRIX(:,4) GEN_MATRIX(:,4) ] ;
% else 
%     firstLO_matrix = [PEN_MATRIX(:,1) SHAM_MATRIX(:,1) GEN_MATRIX(:,1)] ;
%     LUS_matrix = [PEN_MATRIX(:,2) SHAM_MATRIX(:,2) GEN_MATRIX(:,2)] ;
%     secondLO_matrix = [ PEN_MATRIX(:,3) SHAM_MATRIX(:,3) GEN_MATRIX(:,3)] ;
% end 


% vectors for KW if cohorts are uneven lengths 
if GEN_MATRIX ~= []
    if button1 == 1 
        % %this first one is a test--we should see all 0s if button2 ==1 
        firstLO_matrix = [PEN_MATRIX(:,2)' SHAM_MATRIX(:,2)' GEN_MATRIX(:,2)'] ;

        LUS_matrix = [PEN_MATRIX(:,3)' SHAM_MATRIX(:,3)' GEN_MATRIX(:,3)' ] ;
        secondLO_matrix = [PEN_MATRIX(:,4)' SHAM_MATRIX(:,4)' GEN_MATRIX(:,4)'] ;
    else 
        firstLO_matrix = [PEN_MATRIX(:,1)' SHAM_MATRIX(:,1)' GEN_MATRIX(:,1)'] ;
        LUS_matrix = [PEN_MATRIX(:,2)' SHAM_MATRIX(:,2)' GEN_MATRIX(:,2)'] ;
        secondLO_matrix = [ PEN_MATRIX(:,3)' SHAM_MATRIX(:,3)' GEN_MATRIX(:,3)'] ;
    end 
else 
    if button1 == 1 
        % %this first one is a test--we should see all 0s if button2 ==1 
        firstLO_matrix = [PEN_MATRIX(:,2)' SHAM_MATRIX(:,2)'] ;
        LUS_matrix = [PEN_MATRIX(:,3)' SHAM_MATRIX(:,3)'] ;
        secondLO_matrix = [PEN_MATRIX(:,4)' SHAM_MATRIX(:,4)'] ;
    else 
        firstLO_matrix = [PEN_MATRIX(:,1)' SHAM_MATRIX(:,1)'] ;
        LUS_matrix = [PEN_MATRIX(:,2)' SHAM_MATRIX(:,2)'] ;
        secondLO_matrix = [ PEN_MATRIX(:,3)' SHAM_MATRIX(:,3)'] ;
    end
end 
% %% KW analysis 
% 
% % harry_plotter and the-
% 
% if GEN_MATRIX ~= []
%     chamber_of_statistics(firstLO_matrix, strdatagroups) 
%     title('KW of 1st LO medians between cohorts')
%     hold on 
%     set(gca, 'XTick', [1 2 3]) ; 
%     set(gca, 'XTickLabel', [{ 'PEN' 'SHAM' 'GEN'}]) ; 
% 
%     chamber_of_statistics( LUS_matrix, strdatagroups) 
%     title('KW of L+US medians between cohorts')
%     hold on 
%     set(gca, 'XTick', [1 2 3]) ; 
%     set(gca, 'XTickLabel', [{ 'Alsavec' 'control' 'competitor'}]) ; 
% 
%     chamber_of_statistics(secondLO_matrix, strdatagroups) 
%     title('KW of 2nd LO medians between cohorts')
%     hold on 
%     set(gca, 'XTick', [1 2 3]) ; 
%     set(gca, 'XTickLabel', [{ 'PEN' 'SHAM' 'GEN'}]) ; 
% else 
%         chamber_of_statistics(firstLO_matrix, strdatagroups) 
%     title('KW of 1st LO medians between cohorts')
%     hold on 
%     set(gca, 'XTick', [1 2 3]) ; 
%     set(gca, 'XTickLabel', [{ 'PEN' 'SHAM'}]) ; 
% 
%     chamber_of_statistics( LUS_matrix, strdatagroups) 
%     title('KW of L+US medians between cohorts')
%     hold on 
%     set(gca, 'XTick', [1 2 3]) ; 
%     set(gca, 'XTickLabel', [{ 'PEN' 'SHAM' }]) ; 
% 
%     chamber_of_statistics(secondLO_matrix, strdatagroups) 
%     title('KW of 2nd LO medians between cohorts')
%     hold on 
%     set(gca, 'XTick', [1 2 3]) ; 
%     set(gca, 'XTickLabel', [{ 'PEN' 'SHAM'}]) ;
% end 

%% box and whisker plots + MW between cohorts 
% they like each box to be a column

    % PEN and SHAM baselines
    if button1 == 1 % baseline included in matrixes 
        figure(3)
        boxplot([PEN_MATRIX(:,1),SHAM_MATRIX(:,1)],'Labels', {'PEN US', 'SHAM US'}) 
        title('Baseline rms values by Cohort (n=7 each)') 
        hold on 
        scatter(ones(length(PEN_MATRIX)),PEN_MATRIX(:,1),'r','filled')
        hold on 
        scatter(2.*ones(length(SHAM_MATRIX)),SHAM_MATRIX(:,1),'r','filled')
        MWbaseline = ranksum(PEN_MATRIX(:,1),SHAM_MATRIX(:,1)) ;
    end 
    
    % non 1LO normalized 1LO 
    if button2 == 2 
        figure(4)
        if button1 == 1 
            % box 
            boxplot([PEN_MATRIX(:,2),SHAM_MATRIX(:,2)],'Labels', {'PEN US', 'SHAM US'}) 
            hold on 
            %scatterplot 
            scatter(ones(length(PEN_MATRIX)),PEN_MATRIX(:,2),'r','filled')
            hold on 
            scatter(2.*ones(length(SHAM_MATRIX)),SHAM_MATRIX(:,2),'r','filled')
            
            title('1LO rms values by Cohort') 
            ylabel('rms values') 
            MW1LO = ranksum(PEN_MATRIX(:,2),SHAM_MATRIX(:,2)) ;
        else 
            boxplot([PEN_MATRIX(:,1),SHAM_MATRIX(:,1)],'Labels', {'PEN US', 'SHAM US'}) 
            title('1LO rms values by Cohort') 
            ylabel('rms values') 
            MW1LO = ranksum(PEN_MATRIX(:,1),SHAM_MATRIX(:,1)) ;
        end
    end 

    % 1 LO normalized L+US 
%     if button2 == 1 % each trial type - 1LO % lol u idiot (each trial
%     type - 1LO or not will be the same) 
        figure(5)
        if button1 == 1 %baseline included in matrix
            %box 
            boxplot([PEN_MATRIX(:,3),SHAM_MATRIX(:,3)],'Labels', {'PEN US', 'SHAM US'}) 
            %scatterplot
            hold on
            scatter(ones(length(PEN_MATRIX)),PEN_MATRIX(:,3),'r','filled')
            hold on 
            scatter(2.*ones(length(SHAM_MATRIX)),SHAM_MATRIX(:,3),'r','filled')
            
            title('L+US rms values by Cohort') 
            ylabel('1LO normalized rms values') 
            MWLUS = ranksum(PEN_MATRIX(:,3),SHAM_MATRIX(:,3)) ;
        else %baseline not included in matrix 
            boxplot([PEN_MATRIX(:,2),SHAM_MATRIX(:,2)],'Labels', {'PEN US', 'SHAM US'}) 
            title('L+US rms values by Cohort') 
            ylabel('1LO normalized rms values') 
            MWLUS = ranksum(PEN_MATRIX(:,2),SHAM_MATRIX(:,2)) ;
        end 
%     end 

    % 1 LO normalized 2LO  
%     if button2 == 1 % each trial type - 1LO 
        figure(6)
        if button1 == 1 %baseline included in matrix 
            %box 
            boxplot([PEN_MATRIX(:,4),SHAM_MATRIX(:,4)],'Labels', {'PEN US', 'SHAM US'}) 
            %scatter 
            hold on
            scatter(ones(length(PEN_MATRIX)),PEN_MATRIX(:,4),'r','filled')
            hold on 
            scatter(2.*ones(length(SHAM_MATRIX)),SHAM_MATRIX(:,4),'r','filled')
            
            title('2LO rms values by Cohort') 
            ylabel('1LO normalized rms values') 
            MW2LO = ranksum(PEN_MATRIX(:,4),SHAM_MATRIX(:,4))
        else %baseline not included in matrix 
            boxplot([PEN_MATRIX(:,3),SHAM_MATRIX(:,3)],'Labels', {'PEN US', 'SHAM US'}) 
            title('2LO rms values by Cohort') 
            ylabel('1LO normalized rms values') 
            MW2LO = ranksum(PEN_MATRIX(:,3),SHAM_MATRIX(:,3))
        end 
%     else
%         figure(6)
%         if button1 == 1 %baseline included in matrix 
%             %box 
%             boxplot([PEN_MATRIX(:,4),SHAM_MATRIX(:,4)],'Labels', {'PEN US', 'SHAM US'}) 
%             %scatter 
%             hold on
%             scatter(ones(length(PEN_MATRIX)),PEN_MATRIX(:,4),'r','filled')
%             hold on 
%             scatter(2.*ones(length(SHAM_MATRIX)),SHAM_MATRIX(:,4),'r','filled')
%             
%             title('2LO rms values by Cohort') 
%             ylabel('1LO normalized rms values') 
%             MW2LO = ranksum(PEN_MATRIX(:,4),SHAM_MATRIX(:,4))
%         end 
        
%% MW for baselines between PEN and SHAM 
% 
% if button1==1 %baseline included in matrix 
%     
% end 

for i = 1  %% individual Mann Whitney comparisons 
% 
% SHAM_MATRIX = SHAM_MATRIX';
% GEN_MATRIX = GEN_MATRIX';
% PEN_MATRIX = PEN_MATRIX';
% 
% if GEN_MATRIX ~= []
%     if button1 == 1 %data has baseline included 
%         % for 1st LO 
%         MWp7 = ranksum(SHAM_MATRIX(2,:),GEN_MATRIX(2,:)); % SHAM 1LO vs. GEN 1LO
%         MWp8 = ranksum(SHAM_MATRIX(2,:),PEN_MATRIX(2,:)); % SHAM 1LO vs. PEN 1LO 
%         MWp9 = ranksum(GEN_MATRIX(2,:),PEN_MATRIX(2,:)); % GEN 1LO vs. PEN 1LO
% 
%         % for L+US 
%         MWp1 = ranksum(SHAM_MATRIX(3,:),GEN_MATRIX(3,:)); % SHAM L+US vs. GEN L+US 
%         MWp2 = ranksum(SHAM_MATRIX(3,:),PEN_MATRIX(3,:)); % SHAM L+US vs. PEN L+US 
%         MWp3 = ranksum(GEN_MATRIX(3,:),PEN_MATRIX(3,:)); % GEN L+US vs. PEN L+US 
% 
%         % for 2nd LO
%         MWp4 = ranksum(SHAM_MATRIX(4,:),GEN_MATRIX(4,:)); % SHAM 2LO vs. GEN 2LO 
%         MWp5= ranksum(SHAM_MATRIX(4,:),PEN_MATRIX(4,:)); % SHAM 2LO vs. PEN 2LO 
%         MWp6 = ranksum(GEN_MATRIX(4,:),PEN_MATRIX(4,:)); % GEN 2LO vs. PEN 2LO 
%     else %data doesn't have baseline included 
%         
%         MWp7 = ranksum(SHAM_MATRIX(1,:),GEN_MATRIX(1,:)); % SHAM L+US vs. GEN L+US 
%         MWp8 = ranksum(SHAM_MATRIX(1,:),PEN_MATRIX(1,:)); % SHAM L+US vs. PEN L+US 
%         MWp9 = ranksum(GEN_MATRIX(1,:),PEN_MATRIX(1,:)); % GEN L+US vs. PEN L+US 
%         
%         MWp1 = ranksum(SHAM_MATRIX(2,:),GEN_MATRIX(2,:)); % SHAM L+US vs. GEN L+US 
%         MWp2 = ranksum(SHAM_MATRIX(2,:),PEN_MATRIX(2,:)); % SHAM L+US vs. PEN L+US 
%         MWp3 = ranksum(GEN_MATRIX(2,:),PEN_MATRIX(2,:)); % GEN L+US vs. PEN L+US 
% 
%         % for 2nd LO
%         MWp4 = ranksum(SHAM_MATRIX(3,:),GEN_MATRIX(3,:)); % SHAM 2LO vs. GEN 2LO 
%         MWp5 = ranksum(SHAM_MATRIX(3,:),PEN_MATRIX(3,:)); % SHAM 2LO vs. PEN 2LO 
%         MWp6 = ranksum(GEN_MATRIX(3,:),PEN_MATRIX(3,:)); % GEN 2LO vs. PEN 2LO 
%     end 
% else 
%     if button1 == 1 %data has baseline included 
%         MWp1 = ranksum(SHAM_MATRIX(2,:),PEN_MATRIX(2,:)); % SHAM 1LO vs. PEN 1LO 
%         MWp2 = ranksum(SHAM_MATRIX(3,:),PEN_MATRIX(3,:)); % SHAM L+US vs. PEN L+US 
%         MWp3 = ranksum(SHAM_MATRIX(4,:),PEN_MATRIX(4,:)); % SHAM 2LO vs. PEN 2LO 
%     else %data doesn't have baseline included 
%         MWp4 = ranksum(SHAM_MATRIX(1,:),PEN_MATRIX(1,:)); % SHAM 1LO vs. PEN 1LO 
%         MWp5 = ranksum(SHAM_MATRIX(2,:),PEN_MATRIX(2,:)); % SHAM L+US vs. PEN L+US 
%         MWp6 = ranksum(SHAM_MATRIX(3,:),PEN_MATRIX(3,:)); % SHAM 2LO vs. PEN 2LO 
%     end 
% end 
end