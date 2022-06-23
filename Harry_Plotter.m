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

if button1 == 1 
    % 7 by 4 matrix with (x, 1) = baseline rms value
    if button2 == 1
        % L+US and 2LO each - 1LO 
% updated 5/1/22 with 5-55Hz bandpass filtering
%         ACTUAL_SHAM_MATRIX = [0.00875645051057406,0,-0.0161320041862880,-0.0241793073671077;0.00797476232880989,0,-0.00535682662750674,-0.00559916439132274;0.00691050921472223,0,-0.00826481915892088,-0.00715374709284675;0.00478128097959782,0,-0.00355353450732417,-0.00696459688656752;0.00822190651829338,0,-0.00595987316292648,-0.0127733833609279;0.00997568780215539,0,0.00226901291182080,-0.00372841190101977;0.00728096415499368,0,-0.00822883305952320,-0.0163689771437286];
% updated 6/20/22 with new calc baseline rms 
        ACTUAL_SHAM_MATRIX = [0.00190362765214409,0,-0.0742052134694001,-0.111221807532355;0.00166537028793367,0,-0.0256516040309637,-0.0268120583057460;0.00118868795480588,0,-0.0480480253247480,-0.0415887407666911;0.00125565557976391,0,-0.0135311364231012,-0.0265197679689941;0.00138047748926393,0,-0.0354960659536683,-0.0760762596511954;0.00190669830129051,0,0.0118712878760441,-0.0195067426751471;0.000686553555400491,0,-0.0872675380857443,-0.173594521359483];

%         ACTUAL_GEN_MATRIX = [0.00473950079288317,0,-0.00211019545093086,0.0153131811631311;0.00966888404424071,0,-0.0213730895087010,-0.0426029877934497;0.00615812993332741,0,-0.00383065315231201,-0.00481371580855891;0.00442445677080744,0,-0.0811603673420479,-0.0335072648900061];
% updated 5/1/22 with 5-55Hz bandpass filtering
%         ACTUAL_PEN_MATRIX = [0.00882862296929438,0,0.0253098454079370,0.0195927909267431;0.00882076590369108,0,0.00983662079465671,0.00802901453594875;0.00757623538011407,0,-0.00334380190501276,-0.00384635329873213;0.0106446711456137,0,0.0315841777499344,0.0252143540140312;0.00880863172217986,0,0.0213409375453499,-0.0278449490174810;0.00657559271345368,0,0.0127011085472304,0.00812505635620006;0.00656479568898303,0,0.00913634129290152,0.00484899032880089]; 
% updated 6/20/22 with new calc baseline rms 
        ACTUAL_PEN_MATRIX = [0.000821087840520918,0,0.272140289370306,0.210668524696073;0.000943796929159172,0,0.0919334727973176,0.0750395084692976;0.000453539673913034,0,-0.0558571427242067,-0.0642521032280421;0.00251646673625169,0,0.133601283382525,0.106656886324764;0.00252767728244319,0,0.0743704351614566,-0.0970360824625468;0.00105887074746651,0,0.0788739485114485,0.0504566411906847;0.000762220053841559,0,0.0786888427173094,0.0417630455220868];
    end 
    if button2 == 2 
        % L+US and 2LO not (-) 1LO old baselines 
% updated 5/1/22 w 5-55Hz bandpass 
%         ACTUAL_SHAM_MATRIX = [0.00875645051057406,0.0905839146112109,0.0744519104249229,0.0664046072441032;0.00797476232880989,0.0884306676715121,0.0830738410440054,0.0828315032801894;0.00691050921472223,0.0809101694962482,0.0726453503373273,0.0737564224034015;0.00478128097959782,0.101672187402452,0.0981186528951274,0.0947075905158840;0.00822190651829338,0.115083590263629,0.109123717100703,0.102310206902702;0.00997568780215539,0.108792639455240,0.111061652367061,0.105064227554220;0.00728096415499368,0.0422761180062325,0.0340472849467093,0.0259071408625039];
% testing 6/20/22 with different rms_baseline 
        ACTUAL_SHAM_MATRIX = [0.00190362765214409,0.416674744377530,0.342469530908130,0.305452936845176;0.00166537028793367,0.423457511142033,0.397805907111069,0.396645452836287;0.00118868795480588,0.470376156844184,0.422328131519436,0.428787416077493;0.00125565557976391,0.387147004015902,0.373615867592801,0.360627236046908;0.00138047748926393,0.685419739398762,0.649923673445094,0.609343479747567;0.00190669830129051,0.569194090980925,0.581065378856969,0.549687348305778;0.000686553555400491,0.448342153928699,0.361074615842954,0.274747632569216];
        %             ACTUAL_GEN_MATRIX = [0.00473950079288317,0.152602273483868,0.150492078032938,0.167915454646999;0.00966888404424071,0.216017817362026,0.194644727853325,0.173414829568576;0.00615812993332741,0.0914060138674998,0.0875753607151878,0.0865922980589409;0.00442445677080744,0.202028342612542,0.120867975270494,0.168521077722536];
% updated 5/1/22
%         ACTUAL_PEN_MATRIX = [0.00882862296929438,0.0378381466619741,0.0631479920699110,0.0574309375887171;0.00882076590369108,0.0467930458139921,0.0566296666086489,0.0548220603499409;0.00757623538011407,0.0142778076102932,0.0109340057052804,0.0104314543115611;0.0106446711456137,0.100550929857496,0.132135107607431,0.125765283871528;0.00880863172217986,0.138589543395270,0.159930480940620,0.110744594377789;0.00657559271345368,0.0911940555315960,0.103895164078826,0.0993191118877960;0.00656479568898303,0.0519927805355467,0.0611291218284482,0.0568417708643476];           
% testing 6/20/22 with different rms_baseline 
           ACTUAL_PEN_MATRIX = [0.000821087840520918,0.406848956042874,0.678989245413180,0.617517480738948;0.000943796929159172,0.437329779631341,0.529263252428658,0.512369288100638;0.000453539673913034,0.238506215419441,0.182649072695234,0.174254112191399;0.00251646673625169,0.425331106626503,0.558932390009028,0.531987992951267;0.00252767728244319,0.482966815737654,0.557337250899111,0.385930733275108;0.00105887074746651,0.566315547481701,0.645189495993150,0.616772188672386;0.000762220053841559,0.447799791933771,0.526488634651081,0.489562837455858];
    end 
end 
if button1 == 2 % baseline not included 
    if button2 == 1 
        % L+US and 2LO each - 1LO 
        ACTUAL_SHAM_MATRIX = [0,-0.0330087213676531,-0.0484536501199619;0,-0.00450603279172629,-0.00825143075115475;0,-0.0300537017201592,-0.0398764203331410;0,0.00408048796891958,0.00668004668825176;0,-0.00108889266000700,-5.28862428965382e-05;0,-0.0153815894938395,-0.0254779887914068;0,-0.00905069809001784,-0.0193997920630010];
        %         GEN_MATRIX = [0,-0.00216903690829889,0.0157401784885035;0,-0.00533501284119886,-0.0170182170965821;0,-0.0284201249582408,-0.0566498478936813;0,-0.00382477957074176,-0.00480633475035593;0,-0.0804744010195484,-0.0332240621483618;0,-0.00839983815283812,-0.0181853465935874;0,-0.0387101708843783,-0.0489317590083913];
        ACTUAL_PEN_MATRIX = [0,0.0332778159222843,0.0271015017498223;0,0.0123115434946706,0.0103454562670748;0,-0.00443411645534570,-0.00485823133288435;0,0.0392318468545117,0.0290536604824880;0,0.0101059570250530,-0.0694656287713779;0,0.0244802268179966,0.0271409090944090;0,0.00408325546130633,0.00405392103845939] ; 
    end 
    if button2 == 2 % matrixes that are not minus the 1LO median 
        ACTUAL_SHAM_MATRIX = [0.158282624423851,0.125273903056198,0.109828974303889;0.174525738045649,0.170019705253922,0.166274307294494;0.145978340129792,0.115924638409633,0.106101919796651;0.204798579248004,0.208879067216923,0.211478625936255;0.152965752143121,0.151876859483114,0.152912865900225;0.141213000433786,0.125831410939947,0.115735011642379;0.0568926921604049,0.0478419940703871,0.0374929000974039];
        %         GEN_MATRIX =[0.156857481389950,0.154688444481651,0.172597659878453;0.317744558369515,0.312409545528316,0.300726341272933;0.287242213387836,0.258822088429595,0.230592365494155;0.0912658615559288,0.0874410819851871,0.0864595268055729;0.200320802250603,0.119846401231054,0.167096740102241;0.115935744096746,0.107535905943908,0.0977503975031584;0.256205097945568,0.217494927061190,0.207273338937177] ;
        ACTUAL_PEN_MATRIX = [0.0501556157522020,0.0834334316744862,0.0772571175020242;0.0634450778970749,0.0757566213917455,0.0737905341641497;0.0219858091289983,0.0175516926736526,0.0171275777961140;0.132459821370965,0.171691668225477,0.161513481853453;0.264115218176519,0.274221175201572,0.194649589405141;0.134083201797739,0.158563428615736,0.161224110892148;0.0944141392916823,0.0984973947529887,0.0984680603301417];
    end 
end 
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
% %

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
    if button2 == 1 % each trial type - 1LO 
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
    end 

    % 1 LO normalized 2LO  
    if button2 == 1 % each trial type - 1LO 
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
        else %baseline included in matrix 
            boxplot([PEN_MATRIX(:,3),SHAM_MATRIX(:,3)],'Labels', {'PEN US', 'SHAM US'}) 
            title('2LO rms values by Cohort') 
            ylabel('1LO normalized rms values') 
            MW2LO = ranksum(PEN_MATRIX(:,3),SHAM_MATRIX(:,3))
        end 
    end 


%% MW for baselines between PEN and SHAM 
% 
% if button1==1 %baseline included in matrix 
%     
%     
% end 

% %% individual Mann Whitney comparisons 
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