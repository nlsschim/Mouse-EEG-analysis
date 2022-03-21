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
% old baseline 
%         SHAM_MATRIX = [0.00447886235105312,0,0.00435600796752600,0.00713109228237704;0.00841241164426916,0,-5.16885958017910e-05,-0.0286916774704259;0.00906470771595447,0,0.0133954508844230,-0.0105393137953733;0.0121460485214887,0,-0.0146888761776283,-0.0364842719945690;0.0200559914695149,0,-0.00765067809909513,-0.0126725453785824;0.00395859482863203,0,-0.0247286394644330,-0.000975316304337212;0.00892362449028233,0,-0.00707821064911673,-0.0152301517258112] ;
%         PEN_MATRIX = [0.0101320091346382,0,0.00932355090704318,0.0180555755962342;0.00827583129124937,0,0.0355006379032983,0.0289117712082711;0.0102484600620898,0,0.0105964449704316,0.00890424974541322;0.0109171220921352,0,0.0382527652138474,0.0283285886886979;0.0337258202950021,0,-0.000996088743718843,-0.00109136275373061;0.0267704375784809,0,-0.000107093776822434,0.00106106540426960;0.0139512076875862,0,0.000180722336327257,-0.000554426228727898] ; 
%         GEN_MATRIX = [0.00461092829284753,0,-0.00216903690829889,0.0157401784885035;0.00400152391543373,0,-0.00533501284119886,-0.0170182170965821;0.00727139375537472,0,-0.0284201249582408,-0.0566498478936813;0.00616758666332717,0,-0.00382477957074176,-0.00480633475035593;0.00446217098708201,0,-0.0804744010195484,-0.0332240621483618;0.00569279603806760,0,-0.00839983815283812,-0.0181853465935874;0.00512296495652707,0,-0.0387101708843783,-0.0489317590083913] ;
% new baseline 
%         ACTUAL_PEN_MATRIX = [0.00996826866760475,0,0.00947670110354453,0.0183521594515852;0.00882862296929438,0,0.0332778236455719,0.0271015083648227;0.00750657022473870,0,0.0144669616904266,0.0121566658033661;0.0106446711456137,0,0.0392318464147343,0.0290536599696594;0.00757623538011407,0,-0.00443411777195973,-0.00485823262900528;0.00750657022473870,0,-0.000381925408713048,0.00378404191532342;0.00776570973030168,0,0.000324670565465240,-0.000996036009422576];
%         SHAM_MATRIX = [0.00702801858001691,0,0.00277602542939978,0.00454454954417227;0.0106113762257161,0,-0.000843696031506844,-4.09776583579907e-05;0.00852714220250908,0,0.0142399230605259,-0.0112037300658262;0.0179286181340006,0,-0.00995122983143200,-0.0247168928143779;0.00975297935413086,0,-0.0157328267441196,-0.0260597761132421;0.0744636153594912,0,-0.00131461082437808,-5.18493191174882e-05;0.00896825660351166,0,-0.00704298517131856,-0.0151543582975117] ; 
% with new sham dates (2/15,2/24,2/25) included:         
        ACTUAL_SHAM_MATRIX = [0.00875645051057406,0,-0.0330087213676531,-0.0484536501199619;0.00797476232880989,0,-0.00450603279172629,-0.00825143075115475;0.00691050921472223,0,-0.0300537017201592,-0.0398764203331410;0.00478128097959782,0,0.00408048796891958,0.00668004668825176;0.00822190651829338,0,-0.00108889266000700,-5.28862428965382e-05;0.00997568780215539,0,-0.0153815894938395,-0.0254779887914068;0.00728096415499368,0,-0.00905069809001784,-0.0193997920630010];
%         ACTUAL_GEN_MATRIX = [0.00473950079288317,0,-0.00211019545093086,0.0153131811631311;0.00966888404424071,0,-0.0213730895087010,-0.0426029877934497;0.00615812993332741,0,-0.00383065315231201,-0.00481371580855891;0.00442445677080744,0,-0.0811603673420479,-0.0335072648900061];
        % new pen 3/3 and 3/2/22
        ACTUAL_PEN_MATRIX = [0.00882862296929438,0,0.0332778159222843,0.0271015017498223;0.0263186866550599,0,0.000559873541251357,-0.000833316399134384;0.00757623538011407,0,-0.00443411645534570,-0.00485823133288435;0.00342365210546317,0,0.0695295575526666,0.0651248407373120;0.00880863172217986,0,0.0101059570250530,-0.0694656287713779;0.00657559271345368,0,0.0244802268179966,0.0271409090944090;0.00656479568898303,0,0.00408325546130633,0.00405392103845939];

    end 
    if button2 == 2 
        % L+US and 2LO not (-) 1LO old baselines 
%         SHAM_MATRIX = [0.00447886235105312,0.218626846387372,0.222982854354898,0.225757938669749;0.00841241164426916,0.149501732416761,0.149450043820960,0.120810054946336;0.00906470771595447,0.262382767141867,0.275778218026290,0.251843453346494;0.0121460485214887,0.105125039925450,0.0904361637478214,0.0686407679308807;0.0200559914695149,0.0702382032857516,0.0625875251866565,0.0575656579071692;0.00395859482863203,0.108706122975057,0.0839774835106236,0.107730806670719;0.00892362449028233,0.0431613563237806,0.0360831456746638,0.0279312045979694];
%         GEN_MATRIX = [0.00461092829284753,0.156857481389950,0.154688444481651,0.172597659878453;0.00400152391543373,0.317744558369515,0.312409545528316,0.300726341272933;0.00727139375537472,0.287242213387836,0.258822088429595,0.230592365494155;0.00616758666332717,0.0912658615559288,0.0874410819851871,0.0864595268055729;0.00446217098708201,0.200320802250603,0.119846401231054,0.167096740102241;0.00569279603806760,0.115935744096746,0.107535905943908,0.0977503975031584;0.00512296495652707,0.256205097945568,0.217494927061190,0.207273338937177] ;
%         PEN_MATRIX = [0.0101320091346382,0.0386834050600615,0.0480069559671047,0.0567389806562957;0.00827583129124937,0.0535058057233722,0.0890064436266705,0.0824175769316434;0.0102484600620898,0.0546066605598332,0.0652031055302648,0.0635109103052465;0.0109171220921352,0.129154114665111,0.167406879878959,0.157482703353809;0.0337258202950021,0.00493893591101879,0.00394284716729995,0.00384757315728818;0.0267704375784809,0.00678480243616181,0.00667770865933937,0.00784586784043141;0.0139512076875862,0.0155601986277157,0.0157409209640430,0.0150057723989878] ;
    % L+US and 2LO not (-) 1LO new baselines 
%             SHAM_MATRIX = [0.00702801858001691,0.139327968199647,0.142103993629047,0.143872517743820;0.0106113762257161,0.118520923239442,0.117677227207935,0.118479945581084;0.00852714220250908,0.278923819896199,0.293163742956724,0.267720089830372;0.0179286181340006,0.0712187529461195,0.0612675231146875,0.0465018601317416;0.00975297935413086,0.144437586439214,0.128704759695094,0.118377810325972;0.0744636153594912,0.00577897759747131,0.00446436677309323,0.00572712827835382;0.00896825660351166,0.0429465618045829,0.0359035766332644,0.0277922035070712] ; 
%             GEN_MATRIX = [0.00461092829284753,0.156857481389950,0.154688444481651,0.172597659878453;0.00400152391543373,0.317744558369515,0.312409545528316,0.300726341272933;0.00727139375537472,0.287242213387836,0.258822088429595,0.230592365494155;0.00616758666332717,0.0912658615559288,0.0874410819851871,0.0864595268055729;0.00446217098708201,0.200320802250603,0.119846401231054,0.167096740102241;0.00569279603806760,0.115935744096746,0.107535905943908,0.0977503975031584;0.00512296495652707,0.256205097945568,0.217494927061190,0.207273338937177] ;
%             PEN_MATRIX = [0.00996826866760475,0.0393188249628794,0.0487955260664240,0.0576709844144646;0.00882862296929438,0.0501556208561876,0.0834334445017595,0.0772571292210103;0.00750657022473870,0.0745525930582847,0.0890195547487113,0.0867092588616508;0.0106446711456137,0.132459820418990,0.171691666833725,0.161513480388650;0.00757623538011407,0.0219858115654082,0.0175516937934485,0.0171275789364029;0.00750657022473870,0.0241964232039595,0.0238144977952464,0.0279804651192829;0.00776570973030168,0.0279541211641252,0.0282787917295904,0.0269580851547026];
    % new 1 min baselines 
%             ACTUAL_PEN_MATRIX = [0.00840098979843285,0.0527086780194353,0.0876804331643147,0.0811897266807290;0.00858512765732697,0.0651864826670063,0.0778359467405089,0.0758158954368637;0.0108582077110773,0.129854877147796,0.168315193493930,0.158337170375433;0.00741967162621099,0.0224497379175026,0.0179220550716959,0.0174889908948624];
%             ACTUAL_SHAM_MATRIX = [0.00478128097959782,0.204798578749390,0.208879066463807,0.211478625115738;0.00822190651829338,0.152965751229923,0.151876858283920,0.152912864548626;0.00997568780215540,0.141212999688881,0.125831410222502,0.115735011258769;0.00958317265816301,0.0401908428701839,0.0335997795006526,0.0260088826027903];
% 2_15_22 included
%             ACTUAL_SHAM_MATRIX = [0.00478128097959782,0.204798578749390,0.208879066463807,0.211478625115738;0.00822190651829338,0.152965751229923,0.151876858283920,0.152912864548626;0.00997568780215540,0.141212999688881,0.125831410222502,0.115735011258769;0.00958317265816301,0.0401908428701839,0.0335997795006526,0.0260088826027903;0.00878142896308465,0.157832394558873,0.124917565737201,0.109516569313443];
% all non asterisk mice on vis stim titration sheet: 
            ACTUAL_SHAM_MATRIX = [0.00875645051057406,0.158282624423851,0.125273903056198,0.109828974303889;0.00797476232880989,0.174525738045649,0.170019705253922,0.166274307294494;0.00691050921472223,0.145978340129792,0.115924638409633,0.106101919796651;0.00478128097959782,0.204798579248004,0.208879067216923,0.211478625936255;0.00822190651829338,0.152965752143121,0.151876859483114,0.152912865900225;0.00997568780215539,0.141213000433786,0.125831410939947,0.115735011642379;0.00728096415499368,0.0568926921604049,0.0478419940703871,0.0374929000974039];
%             ACTUAL_GEN_MATRIX = [0.00473950079288317,0.152602273483868,0.150492078032938,0.167915454646999;0.00966888404424071,0.216017817362026,0.194644727853325,0.173414829568576;0.00615812993332741,0.0914060138674998,0.0875753607151878,0.0865922980589409;0.00442445677080744,0.202028342612542,0.120867975270494,0.168521077722536];
%             ACTUAL_PEN_MATRIX = [0.00882862296929438,0.0501556157522020,0.0834334316744862,0.0772571175020242;0.0263186866550599,0.00805105531424652,0.00861092885549788,0.00721773891511214;0.00757623538011407,0.0219858091289983,0.0175516926736526,0.0171275777961140;0.00342365210546317,0.281465890376066,0.350995447928733,0.346590731113378;0.00880863172217986,0.264115218176519,0.274221175201572,0.194649589405141];
% 3/3/22, 3/2/22 mice included 
            ACTUAL_PEN_MATRIX = [0.00882862296929438,0.0501556157522020,0.0834334316744862,0.0772571175020242;0.0263186866550599,0.00805105531424652,0.00861092885549788,0.00721773891511214;0.00757623538011407,0.0219858091289983,0.0175516926736526,0.0171275777961140;0.00342365210546317,0.281465890376066,0.350995447928733,0.346590731113378;0.00880863172217986,0.264115218176519,0.274221175201572,0.194649589405141;0.00657559271345368,0.134083201797739,0.158563428615736,0.161224110892148;0.00656479568898303,0.0944141392916823,0.0984973947529887,0.0984680603301417];

            % normalized with median 1st LO 
%         SHAM_MATRIX = [0.00447886235105312,0.998065950197267,0.00100190365232041,0.00101257342824456;0.00841241164426916,0.997930321310665,0.00125590030131046,0.00101497099787312;0.00906470771595447,0.996146938992283,0.00249499178275569,0.00229377163532312;0.0121460485214887,0.996045220167646,0.00110280337753486,0.000839316983457787;0.0200559914695149,0.994974077830467,0.00126159555229690,0.00115900597540881;0.00395859482863203,0.998460177253001,0.000332517908475596,0.000427120303730455;0.00892362449028233,0.999049639456098,0.000321432715537327,0.000250751473874718];
%         GEN_MATRIX = [0.00461092829284753,0.998898425570834,0.000717300541942395,0.000796713071960288;0.00400152391543373,0.998791176872608,0.00125219627532090,0.00120308248557243;0.00727139375537472,0.998919969994463,0.00188484107666900,0.00167807143117971;0.00616758666332717,0.998397348003207,0.000540166149436733,0.000533790565732225;0.00446217098708201,0.995890936322852,0.000536981626174811,0.000748690643247792;0.00569279603806760,0.996970051637202,0.000614040490285721,0.000560072566871697;0.00512296495652707,0.995421368192848,0.00111934395338500,0.00106673825349487];
%         PEN_MATRIX = [0.0101320091346382,0.994886486994144,0.000494073885885624,0.000577834635222092;0.00827583129124937,0.999042830435656,0.000724463807321196,0.000677184748325651;0.0102484600620898,0.992121562186242,0.000672084645406819,0.000647669599765619;0.0109171220921352,0.996662060407150,0.00183367545897138,0.00172350543165917;0.0337258202950021,0.996227622425086,0.000133625980675669,0.000130184298567389;0.0267704375784809,0.984084210135562,0.000181656387726718,0.000213434290590179;0.0139512076875862,0.986345619518033,0.000222725799645525,0.000213029603655619] ;
    end 
end 
if button1 == 2 
    if button2 == 1 
        % L+US and 2LO each - 1LO 
        ACTUAL_SHAM_MATRIX = [0,-0.0330087213676531,-0.0484536501199619;0,-0.00450603279172629,-0.00825143075115475;0,-0.0300537017201592,-0.0398764203331410;0,0.00408048796891958,0.00668004668825176;0,-0.00108889266000700,-5.28862428965382e-05;0,-0.0153815894938395,-0.0254779887914068;0,-0.00905069809001784,-0.0193997920630010];
        %         GEN_MATRIX = [0,-0.00216903690829889,0.0157401784885035;0,-0.00533501284119886,-0.0170182170965821;0,-0.0284201249582408,-0.0566498478936813;0,-0.00382477957074176,-0.00480633475035593;0,-0.0804744010195484,-0.0332240621483618;0,-0.00839983815283812,-0.0181853465935874;0,-0.0387101708843783,-0.0489317590083913];
        ACTUAL_PEN_MATRIX = [0,0.0332778159222843,0.0271015017498223;0,0.000559873541251357,-0.000833316399134384;0,-0.00443411645534570,-0.00485823133288435;0,0.0695295575526666,0.0651248407373120;0,0.0101059570250530,-0.0694656287713779;0,0.0244802268179966,0.0271409090944090;0,0.00408325546130633,0.00405392103845939] ; 
    end 
    if button2 == 2 
        % matrixes that are not minus the 1LO median 
        ACTUAL_SHAM_MATRIX = [0.158282624423851,0.125273903056198,0.109828974303889;0.174525738045649,0.170019705253922,0.166274307294494;0.145978340129792,0.115924638409633,0.106101919796651;0.204798579248004,0.208879067216923,0.211478625936255;0.152965752143121,0.151876859483114,0.152912865900225;0.141213000433786,0.125831410939947,0.115735011642379;0.0568926921604049,0.0478419940703871,0.0374929000974039];
        %         GEN_MATRIX =[0.156857481389950,0.154688444481651,0.172597659878453;0.317744558369515,0.312409545528316,0.300726341272933;0.287242213387836,0.258822088429595,0.230592365494155;0.0912658615559288,0.0874410819851871,0.0864595268055729;0.200320802250603,0.119846401231054,0.167096740102241;0.115935744096746,0.107535905943908,0.0977503975031584;0.256205097945568,0.217494927061190,0.207273338937177] ;
        ACTUAL_PEN_MATRIX = [0.0501556157522020,0.0834334316744862,0.0772571175020242;0.00805105531424652,0.00861092885549788,0.00721773891511214;0.0219858091289983,0.0175516926736526,0.0171275777961140;0.281465890376066,0.350995447928733,0.346590731113378;0.264115218176519,0.274221175201572,0.194649589405141;0.134083201797739,0.158563428615736,0.161224110892148;0.0944141392916823,0.0984973947529887,0.0984680603301417];
    end 
end 
 PEN_MATRIX = ACTUAL_PEN_MATRIX ;
 SHAM_MATRIX = ACTUAL_SHAM_MATRIX ;
 GEN_MATRIX = ACTUAL_GEN_MATRIX ;
% concatenating the matrixes from median_x scripts
MATRIX = [PEN_MATRIX; SHAM_MATRIX; GEN_MATRIX] ;

% line __ is changed because GEN cohort is only 4 mice with new baselines 

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
%% KW analysis 

% harry_plotter and the-

if GEN_MATRIX ~= []
    chamber_of_statistics(firstLO_matrix, strdatagroups) 
    title('KW of 1st LO medians between cohorts')
    hold on 
    set(gca, 'XTick', [1 2 3]) ; 
    set(gca, 'XTickLabel', [{ 'PEN' 'SHAM' 'GEN'}]) ; 

    chamber_of_statistics( LUS_matrix, strdatagroups) 
    title('KW of L+US medians between cohorts')
    hold on 
    set(gca, 'XTick', [1 2 3]) ; 
    set(gca, 'XTickLabel', [{ 'Alsavec' 'control' 'competitor'}]) ; 

    chamber_of_statistics(secondLO_matrix, strdatagroups) 
    title('KW of 2nd LO medians between cohorts')
    hold on 
    set(gca, 'XTick', [1 2 3]) ; 
    set(gca, 'XTickLabel', [{ 'PEN' 'SHAM' 'GEN'}]) ; 
else 
        chamber_of_statistics(firstLO_matrix, strdatagroups) 
    title('KW of 1st LO medians between cohorts')
    hold on 
    set(gca, 'XTick', [1 2 3]) ; 
    set(gca, 'XTickLabel', [{ 'PEN' 'SHAM'}]) ; 

    chamber_of_statistics( LUS_matrix, strdatagroups) 
    title('KW of L+US medians between cohorts')
    hold on 
    set(gca, 'XTick', [1 2 3]) ; 
    set(gca, 'XTickLabel', [{ 'PEN' 'SHAM' }]) ; 

    chamber_of_statistics(secondLO_matrix, strdatagroups) 
    title('KW of 2nd LO medians between cohorts')
    hold on 
    set(gca, 'XTick', [1 2 3]) ; 
    set(gca, 'XTickLabel', [{ 'PEN' 'SHAM'}]) ;
end 

%% individual Mann Whitney comparisons 

SHAM_MATRIX = SHAM_MATRIX';
GEN_MATRIX = GEN_MATRIX';
PEN_MATRIX = PEN_MATRIX';

if GEN_MATRIX ~= []
    if button1 == 1 %data has baseline included 
        % for 1st LO 
        MWp7 = ranksum(SHAM_MATRIX(2,:),GEN_MATRIX(2,:)); % SHAM 1LO vs. GEN 1LO
        MWp8 = ranksum(SHAM_MATRIX(2,:),PEN_MATRIX(2,:)); % SHAM 1LO vs. PEN 1LO 
        MWp9 = ranksum(GEN_MATRIX(2,:),PEN_MATRIX(2,:)); % GEN 1LO vs. PEN 1LO

        % for L+US 
        MWp1 = ranksum(SHAM_MATRIX(3,:),GEN_MATRIX(3,:)); % SHAM L+US vs. GEN L+US 
        MWp2 = ranksum(SHAM_MATRIX(3,:),PEN_MATRIX(3,:)); % SHAM L+US vs. PEN L+US 
        MWp3 = ranksum(GEN_MATRIX(3,:),PEN_MATRIX(3,:)); % GEN L+US vs. PEN L+US 

        % for 2nd LO
        MWp4 = ranksum(SHAM_MATRIX(4,:),GEN_MATRIX(4,:)); % SHAM 2LO vs. GEN 2LO 
        MWp5= ranksum(SHAM_MATRIX(4,:),PEN_MATRIX(4,:)); % SHAM 2LO vs. PEN 2LO 
        MWp6 = ranksum(GEN_MATRIX(4,:),PEN_MATRIX(4,:)); % GEN 2LO vs. PEN 2LO 
    else %data doesn't have baseline included 
        
        MWp7 = ranksum(SHAM_MATRIX(1,:),GEN_MATRIX(1,:)); % SHAM L+US vs. GEN L+US 
        MWp8 = ranksum(SHAM_MATRIX(1,:),PEN_MATRIX(1,:)); % SHAM L+US vs. PEN L+US 
        MWp9 = ranksum(GEN_MATRIX(1,:),PEN_MATRIX(1,:)); % GEN L+US vs. PEN L+US 
        
        MWp1 = ranksum(SHAM_MATRIX(2,:),GEN_MATRIX(2,:)); % SHAM L+US vs. GEN L+US 
        MWp2 = ranksum(SHAM_MATRIX(2,:),PEN_MATRIX(2,:)); % SHAM L+US vs. PEN L+US 
        MWp3 = ranksum(GEN_MATRIX(2,:),PEN_MATRIX(2,:)); % GEN L+US vs. PEN L+US 

        % for 2nd LO
        MWp4 = ranksum(SHAM_MATRIX(3,:),GEN_MATRIX(3,:)); % SHAM 2LO vs. GEN 2LO 
        MWp5 = ranksum(SHAM_MATRIX(3,:),PEN_MATRIX(3,:)); % SHAM 2LO vs. PEN 2LO 
        MWp6 = ranksum(GEN_MATRIX(3,:),PEN_MATRIX(3,:)); % GEN 2LO vs. PEN 2LO 
    end 
else 
    if button1 == 1 %data has baseline included 
        MWp1 = ranksum(SHAM_MATRIX(2,:),PEN_MATRIX(2,:)); % SHAM 1LO vs. PEN 1LO 
        MWp2 = ranksum(SHAM_MATRIX(3,:),PEN_MATRIX(3,:)); % SHAM L+US vs. PEN L+US 
        MWp3 = ranksum(SHAM_MATRIX(4,:),PEN_MATRIX(4,:)); % SHAM 2LO vs. PEN 2LO 
    else %data doesn't have baseline included 
        MWp4 = ranksum(SHAM_MATRIX(1,:),PEN_MATRIX(1,:)); % SHAM 1LO vs. PEN 1LO 
        MWp5 = ranksum(SHAM_MATRIX(2,:),PEN_MATRIX(2,:)); % SHAM L+US vs. PEN L+US 
        MWp6 = ranksum(SHAM_MATRIX(3,:),PEN_MATRIX(3,:)); % SHAM 2LO vs. PEN 2LO 
    end 
end 