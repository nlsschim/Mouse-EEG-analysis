% Harry_Plotter2 creates box and whisker plots and performs statistical
% analysis on median_x script data formatted as a vector (1x~60) of the variances for
% each event of a given trial for each mouse, for both the PEN and SHAM
% cohorts (~60 points per mouse recorded per trial, per cohort) 

% this is different than Harry_plotter, which deals with median_x data
% formatted such that only 1 median value per each waterfall plot/trial per
% mouse per cohort is recorded (7 points per trial, per cohort) 

close all 

%% shamLight KW 
% firstLOshamLight = [shamLightmedians.Mouse1Trial1 shamLightmedians.Mouse2Trial1 shamLightmedians.Mouse3Trial1 shamLightmedians.Mouse4Trial1 shamLightmedians.Mouse5Trial1 shamLightmedians.Mouse6Trial1 shamLightmedians.Mouse7Trial1 ];
%     % 1 x 394
%     % making firstLO vector  same length as others 
%     nans4 = NaN(1,4) ;
%     firstLOshamLight = [firstLOshamLight nans4];
%     
% LUSshamLight = [shamLightmedians.Mouse1Trial3 shamLightmedians.Mouse2Trial3 shamLightmedians.Mouse3Trial3 shamLightmedians.Mouse4Trial3 shamLightmedians.Mouse5Trial3 shamLightmedians.Mouse6Trial3 shamLightmedians.Mouse7Trial3 ];
%     % 1 x 398 
% secondLOshamLight = [shamLightmedians.Mouse1Trial4 shamLightmedians.Mouse2Trial4 shamLightmedians.Mouse3Trial4 shamLightmedians.Mouse4Trial4 shamLightmedians.Mouse5Trial4 shamLightmedians.Mouse6Trial4 shamLightmedians.Mouse7Trial4 ];
%     % 1 x 398 
% 
% shamLightdataset = [firstLOshamLight;LUSshamLight;secondLOshamLight]';
% [p_shamLight,tbl_shamLight,stats_shamLight] = kruskalwallis(shamLightdataset);
% 
% % boxplot 
% figure
% boxplot([firstLOshamLight',LUSshamLight',secondLOshamLight'],'Notch','on','Labels', {'1st LO', 'L+US', '2nd LO'}) 
% title('Sham Light cohort medians','Fontsize', 13) 
% ylabel('Normalized RMS Brain Activity','FontWeight','bold', 'Fontsize', 14) 

%% shamLight MW 
% median_MWshamLight1LOLUS = ranksum(firstLOshamLight,LUSshamLight);
% median_MWshamLightLUS2LO = ranksum(LUSshamLight,secondLOshamLight); 
% median_MWshamLight1LO2LO = ranksum(firstLOshamLight,secondLOshamLight);

%% data conditioning + intercohort MWs 
% cohort vectors are different (so boxplot wont work) because different number of events in the waterfalls 
% this attempts to expand the shorter vector by filling the vector with NaNs 
% that won't alter analysis (they are ommitted?) 
if medians_or_variance == 1 
    firstLOpen = [penmedians.Mouse1Trial1 penmedians.Mouse2Trial1 penmedians.Mouse3Trial1 penmedians.Mouse4Trial1 penmedians.Mouse5Trial1 penmedians.Mouse6Trial1 penmedians.Mouse7Trial1 ]; 
    % 1x354
    filler = NaN(1,44) ;
    firstLOpen = [firstLOpen filler] ;
    
    firstLOsham = [shammedians.Mouse1Trial1 shammedians.Mouse2Trial1 shammedians.Mouse3Trial1 shammedians.Mouse4Trial1 shammedians.Mouse5Trial1 shammedians.Mouse6Trial1 shammedians.Mouse7Trial1 ];
    % 1x396
    filler = NaN(1,2) ;
    firstLOsham = [firstLOsham filler] ;
    
    firstLOshamLight = [shamLightmedians.Mouse1Trial1 shamLightmedians.Mouse2Trial1 shamLightmedians.Mouse3Trial1 shamLightmedians.Mouse4Trial1 shamLightmedians.Mouse5Trial1 shamLightmedians.Mouse6Trial1 shamLightmedians.Mouse7Trial1 ];
%     firstLOshamLight = [shamLightmedians.Mouse1Trial1 shamLightmedians.Mouse2Trial1 shamLightmedians.Mouse3Trial1 shamLightmedians.Mouse4Trial1 ];
    % 1x394
    % making firstLO vector  same length as others 
%     nans4 = NaN(1,4) ;
%     firstLOshamLight = [firstLOshamLight nans4];
    nans4 = NaN(1,211) ;
    firstLOshamLight = [firstLOshamLight nans4];
    
    
    LUSpen = [penmedians.Mouse1Trial3 penmedians.Mouse2Trial3 penmedians.Mouse3Trial3 penmedians.Mouse4Trial3 penmedians.Mouse5Trial3 penmedians.Mouse6Trial3 penmedians.Mouse7Trial3 ]; 
    % 1x389
    LUSsham = [shammedians.Mouse1Trial3 shammedians.Mouse2Trial3 shammedians.Mouse3Trial3 shammedians.Mouse4Trial3 shammedians.Mouse5Trial3 shammedians.Mouse6Trial3 shammedians.Mouse7Trial3 ];
    % 1x398
    LUSshamLight = [shamLightmedians.Mouse1Trial3 shamLightmedians.Mouse2Trial3 shamLightmedians.Mouse3Trial3 shamLightmedians.Mouse4Trial3 shamLightmedians.Mouse5Trial3 shamLightmedians.Mouse6Trial3 shamLightmedians.Mouse7Trial3 ];
    % LUSshamLight = [shamLightmedians.Mouse1Trial3 shamLightmedians.Mouse2Trial3 shamLightmedians.Mouse3Trial3 shamLightmedians.Mouse4Trial3];
% 1x398 
    filler = NaN(1,9) ;
    LUSpen = [LUSpen filler] ;
    
    filler = NaN(1,226) ;
    LUSshamLight = [LUSshamLight filler] ;
    
    
    secondLOpen = [penmedians.Mouse1Trial4 penmedians.Mouse2Trial4 penmedians.Mouse3Trial4 penmedians.Mouse4Trial4 penmedians.Mouse5Trial4 penmedians.Mouse6Trial4 penmedians.Mouse7Trial4 ]; 
    % 1x396
    secondLOsham = [shammedians.Mouse1Trial4 shammedians.Mouse2Trial4 shammedians.Mouse3Trial4 shammedians.Mouse4Trial4 shammedians.Mouse5Trial4 shammedians.Mouse6Trial4 shammedians.Mouse7Trial4 ];
    % 1x395
%     secondLOshamLight = [shamLightmedians.Mouse1Trial4 shamLightmedians.Mouse2Trial4 shamLightmedians.Mouse3Trial4 shamLightmedians.Mouse4Trial4 shamLightmedians.Mouse5Trial4 shamLightmedians.Mouse6Trial4 shamLightmedians.Mouse7Trial4 ];
%     secondLOshamLight = [shamLightmedians.Mouse1Trial4 shamLightmedians.Mouse2Trial4 shamLightmedians.Mouse3Trial4 shamLightmedians.Mouse4Trial4];
% 1x398 
    
    secondLOsham = [secondLOsham NaN NaN NaN] ;
    secondLOpen = [secondLOpen NaN NaN] ;   
    filler = NaN(1,225) ;
    secondLOshamLight = [secondLOshamLight filler]
    
else 
    firstLOpen = [penvariances.Mouse1Trial1 penvariances.Mouse2Trial1 penvariances.Mouse3Trial1 penvariances.Mouse4Trial1 penvariances.Mouse5Trial1 penvariances.Mouse6Trial1 penvariances.Mouse7Trial1 ]; 
    % 1x354
    firstLOsham = [shamvariances.Mouse1Trial1 shamvariances.Mouse2Trial1 shamvariances.Mouse3Trial1 shamvariances.Mouse4Trial1 shamvariances.Mouse5Trial1 shamvariances.Mouse6Trial1 shamvariances.Mouse7Trial1 ];
    % 1x396
    filler = NaN(1,42) ;
    firstLOpen = [firstLOpen filler] ;
    % MW 
    var_MW1LO = ranksum(firstLOpen,firstLOsham) ;
    
    LUSpen = [penvariances.Mouse1Trial3 penvariances.Mouse2Trial3 penvariances.Mouse3Trial3 penvariances.Mouse4Trial3 penvariances.Mouse5Trial3 penvariances.Mouse6Trial3 penvariances.Mouse7Trial3 ]; 
    % 1x389
    LUSsham = [shamvariances.Mouse1Trial3 shamvariances.Mouse2Trial3 shamvariances.Mouse3Trial3 shamvariances.Mouse4Trial3 shamvariances.Mouse5Trial3 shamvariances.Mouse6Trial3 shamvariances.Mouse7Trial3 ];
    % 1x398
    filler = NaN(1,9) ;
    LUSpen = [LUSpen filler] ;
    % MW 
    var_MWLUS = ranksum(LUSpen,LUSsham) ;
    
    secondLOpen = [penvariances.Mouse1Trial4 penvariances.Mouse2Trial4 penvariances.Mouse3Trial4 penvariances.Mouse4Trial4 penvariances.Mouse5Trial4 penvariances.Mouse6Trial4 penvariances.Mouse7Trial4 ]; 
    % 1x396
    secondLOsham = [shamvariances.Mouse1Trial4 shamvariances.Mouse2Trial4 shamvariances.Mouse3Trial4 shamvariances.Mouse4Trial4 shamvariances.Mouse5Trial4 shamvariances.Mouse6Trial4 shamvariances.Mouse7Trial4 ];
    % 1x395
    secondLOsham = [secondLOsham NaN] ;
    % MW 
    var_MW2LO = ranksum(secondLOpen,secondLOsham) ;
end 

%% kruskal-wallis test
% 6 data sets, sham and pen for each of 3 trial types
% 
max_length = max([length(firstLOpen), length(LUSpen),length(secondLOpen),length(firstLOsham),length(LUSsham),length(secondLOsham),length(firstLOshamLight),length(LUSshamLight),length(secondLOshamLight)]);

varNames = {'firstLOpen', 'LUSpen', 'secondLOpen', 'firstLOsham', 'LUSsham', 'secondLOsham','firstLOshamLight', 'LUSshamLight', 'secondLOshamLight'};
targetLength = max_length;

for i = 1:numel(varNames)
    var = eval(varNames{i}); % get variable value by name
    len = length(var);
    diff = targetLength - len;
    
    if diff > 0 % variable is shorter than target length
        var = [var, nan(1, diff)]; % add NaNs to reach target length
        assignin('base', varNames{i}, var); % save updated variable to workspace
    end
end

% cohorttrialdata.(concat) 
% datastings = {'firstLOpen' 'LUSpen' 'secondLOpen' 'firstLOsham' 'LUSsham' 'secondLOsham'} ;
% for i = 1:6
%     concat =
%     vec_length = length(datastrings{i});
%     diff = max_length - vec_length ;
%     filler = NaN(1,diff) ;
%     LUSpen = [LUSpen filler] ;
% end 

dataset = [firstLOpen; LUSpen; secondLOpen; firstLOsham; LUSsham; secondLOsham; firstLOshamLight; LUSshamLight; secondLOshamLight]';
KWp = kruskalwallis(dataset);

%% Mann Whitney Tests

% pen vs sham US 
    median_psMW1LO = ranksum(firstLOpen,firstLOsham) ;
    median_psMWLUS = ranksum(LUSpen,LUSsham) ;
    median_psMW2LO = ranksum(secondLOpen,secondLOsham) ; 

% pen vs sham light 
    median_pslMW1LO = ranksum(firstLOpen,firstLOshamLight) ;
    median_pslMWLUS = ranksum(LUSpen,LUSshamLight) ;
    median_pslMW2LO = ranksum(secondLOpen,secondLOshamLight) ; 

% Sham US vs sham light 
    median_sslMW1LO = ranksum(firstLOsham,firstLOshamLight) ;
    median_sslMWLUS = ranksum(LUSsham,LUSshamLight) ;
    median_sslMW2LO = ranksum(secondLOsham,secondLOshamLight) ; 

%% medians/variance box and whisker plots 
% they like each box's data to be a column
if medians_or_variance == 1
    
    % for whiskers 
    q3=norminv(.75);
    q95=norminv(0.95);
    w95=(q95-q3)/(2*q3);

%     x1 = subplot(1,3,1)
    tiledlayout(1,3)
    
    ax1 = nexttile;
    
%         % finding whisker length for boxplot 
%             % Calculate the percentiles
%         lower_percentile = prctile(firstLOsham, 2.5);
%         upper_percentile = prctile(firstLOsham, 97.5);
% 
%             % Find the whisker values
%         lower_whisker = min(firstLOsham(firstLOsham >= lower_percentile));
%         upper_whisker = max(firstLOsham(firstLOsham <= upper_percentile));
        
%       boxplot([firstLOpen',firstLOsham'],'Whisker',w95,'Notch','on','Labels', {'PEN US', 'SHAM US'}) 
%     boxplot([firstLOpen',firstLOsham'],'whiskers', [lower_whisker, upper_whisker],'Notch','on','Labels', {'PEN US', 'SHAM US'}) 
%     boxplot([firstLOpen',firstLOsham'],'Notch','on','Labels', {'PEN US', 'SHAM US'}) 
boxplot([firstLOpen',firstLOsham',firstLOshamLight'],'Symbol', '','Notch','on','Labels', {'PEN US', 'SHAM US', 'SHAM Light'}) 
%     hold on 
%     scatter(ones(length(firstLOpen)),firstLOpen,4,'r','filled')
%     hold on 
%     scatter(2.*ones(length(firstLOsham)),firstLOpen,4,'r','filled')
    title('1st LO','Fontsize', 13) 
    ylabel('Normalized RMS Brain Activity','FontWeight','bold', 'Fontsize', 14) 
    
%     x2 = subplot(1,3,2)
    ax2 = nexttile;
    
%     % finding whisker length for boxplot 
%             % Calculate the percentiles
%         lower_percentile = prctile(LUSsham, 2.5);
%         upper_percentile = prctile(LUSsham, 97.5);
% 
%             % Find the whisker values
%         lower_whisker = min(LUSsham(LUSsham >= lower_percentile));
%         upper_whisker = max(LUSsham(LUSsham <= upper_percentile));
%         boxplot([LUSpen',LUSsham'],'Whisker',w95,'Notch','on','Labels', {'PEN US', 'SHAM US'})
%     boxplot([LUSpen',LUSsham'],'whiskers', [lower_whisker, upper_whisker],'Notch','on','Labels', {'PEN US', 'SHAM US'})
%     boxplot([LUSpen',LUSsham'],'Notch','on','Labels', {'PEN US', 'SHAM US'})
 boxplot([LUSpen',LUSsham',LUSshamLight'],'Symbol', '','Notch','on','Labels', {'PEN US', 'SHAM US', 'SHAM Light'})
    set(gca,'YTickLabel',[]);
%     hold on 
%     scatter(ones(length(LUSpen)),LUSpen,3,'r','filled')
%     hold on 
%     scatter(2.*ones(length(LUSsham)),LUSpen,3,'r','filled')
    title('L+US','FontWeight','bold','Fontsize', 13) 
%     ylabel('Normalized RMS Brain Activity') 
    
%     x3 = subplot(1,3,3)
    ax3 = nexttile;
    
%     % finding whisker length for boxplot 
%             % Calculate the percentiles
%         lower_percentile = prctile(secondLOsham, 2.5);
%         upper_percentile = prctile(secondLOsham, 97.5);
% 
%             % Find the whisker values
%         lower_whisker = min(LUSsham(LUSsham >= lower_percentile));
%         upper_whisker = max(LUSsham(LUSsham <= upper_percentile));
        
%     boxplot([secondLOpen',secondLOsham'],'Whisker',w95,'Notch','on','Labels', {'PEN US', 'SHAM US'}) 
%     boxplot([secondLOpen',secondLOsham'],'whiskers', [lower_whisker, upper_whisker],'Notch','on','Labels', {'PEN US', 'SHAM US'}) 
%     boxplot([secondLOpen',secondLOsham'],'Notch','on','Labels', {'PEN US', 'SHAM US'}) 
boxplot([secondLOpen',secondLOsham',secondLOshamLight'],'Symbol', '','Notch','on','Labels', {'PEN US', 'SHAM US', 'SHAM Light'})
    set(gca,'YTickLabel',[]);
%     hold on 
%     scatter(ones(length(secondLOpen)),secondLOpen,3,'r','filled')
%     hold on
%     scatter(2.*ones(length(secondLOsham)),secondLOsham,3,'r','filled')
    title('2nd LO', 'Fontsize',13) % Normalized RMS Brain Activity by Cohort
%     ylabel('Normalized RMS Brain Activity') 
    
    linkaxes([ax1 ax2 ax3],'xy')
    
% 
% if normalize_by_1LOvar == 1 
% %     ax1.YLim = [0.2 2.6];
%     ax1.YLim = [0.3 2.0];
% else 
%     ax1.YLim = [0.5 3.7];
% end 
    
    %     for sharey x axis : 
%     p1 = get(x1, 'Position');
%     p2 = get(x2, 'Position');
%     p1(2) = p2(2)+p2(4);
%     set(x1, 'pos', p1);
end 
% % 1LO 
%     figure(1)
%     % boxplot (input vectors: 7 x~58 = 406)
%     boxplot([firstLOpen',firstLOsham'],'Notch','on','Labels', {'PEN US', 'SHAM US'}) 
%     hold on 
%     %scatterplot; scatter(x,y) creates a scatter plot with circular markers at the locations specified by the vectors x and y.
%     scatter(ones(length(firstLOpen)),firstLOpen,4,'r','filled')
%     hold on 
%     scatter(2.*ones(length(firstLOsham)),firstLOpen,4,'r','filled')
%     if medians_or_variance == 1
%         title('1LO rms values by Cohort') 
%         ylabel('rms values') 
%     else  
%         title('1LO rms variances by Cohort') 
%         ylabel('variance (rms^2?)') 
%     end 
%            
% % L+US  
%     figure(2)
%     % boxplot (input vectors: 7 x~58 = 406)
%     boxplot([LUSpen',LUSsham'],'Notch','on','Labels', {'PEN US', 'SHAM US'}) 
%     hold on 
%     %scatterplot
%     scatter(ones(length(LUSpen)),LUSpen,3,'r','filled')
%     hold on 
%     scatter(2.*ones(length(LUSsham)),LUSpen,3,'r','filled')
%     if medians_or_variance == 1
%         title('L+US rms values by Cohort') 
%         ylabel('rms values') 
%     else  
%         title('L+US variances by Cohort') 
%         ylabel('variance (rms^2?)') 
%     end 
%     
% % 2LO  
%     figure(3)
%     % boxplot (input vectors: 7 x~58 = 406)
%     boxplot([secondLOpen',secondLOsham'],'Notch','on','Labels', {'PEN US', 'SHAM US'}) 
%     hold on 
%     %scatterplot
%     scatter(ones(length(secondLOpen)),secondLOpen,3,'r','filled')
%     hold on 
%     scatter(2.*ones(length(secondLOsham)),secondLOsham,3,'r','filled')
%     if medians_or_variance == 1
%         title('2LO rms values by Cohort') 
%         ylabel('rms values') 
%     else  
%         title('2LO variances by Cohort') 
%         ylabel('variance (rms^2?)') 
%     end
    
%% Test for Equal Variances Using the Brown-Forsythe Test
% Test the null hypothesis that the variances are equal across each column of PEN/SHAM data in the 
% trial type matrix, using the Brown-Forsythe test. Suppress the display of the 
% summary table of statistics and the box plot.    

% trial vectors still have NaN entries so that they are same length 

% creating matrix for each cohort x trial type 
firstLO_matrix = [firstLOpen' firstLOsham'] ;
LUS_matrix = [LUSpen' LUSsham'];
secondLO_matrix = [secondLOpen' secondLOsham'];  

% BF test 
[BF_1LOp,bfstats1LO] = vartestn(firstLO_matrix,'TestType','BrownForsythe','Display','off');
[BF_LUSp,bfstatsLUS] = vartestn(LUS_matrix,'TestType','BrownForsythe','Display','off');
[BF_2LOp,bfstats2LO] = vartestn(secondLO_matrix,'TestType','BrownForsythe','Display','off');

%% variance by trial 

% removing NaN entries 
firstLOpen = firstLOpen(~isnan(firstLOpen));
firstLOsham = firstLOsham(~isnan(firstLOsham));
firstLOshamLight = firstLOshamLight(~isnan(firstLOshamLight));
LUSpen = LUSpen(~isnan(LUSpen));
LUSsham = LUSsham(~isnan(LUSsham));
LUSshamLight = LUSshamLight(~isnan(LUSshamLight));
secondLOpen = secondLOpen(~isnan(secondLOpen));
secondLOsham = secondLOsham(~isnan(secondLOsham));
secondLOshamLight = secondLOshamLight(~isnan(secondLOshamLight));

if medians_or_variance ~= 1
    
    % variance standard error for errorbars 
    var_stderror = zeros(2,3) ;
    var_stderror(1,1) = std(firstLOpen)/sqrt(length(firstLOpen)) ;
    var_stderror(1,2) = std(LUSpen)/sqrt(length(LUSpen)) ;
    var_stderror(1,3) = std(secondLOpen)/sqrt(length(secondLOpen)) ;
    
    var_stderror(2,1) = std(firstLOsham)/sqrt(length(firstLOsham)) ;
    var_stderror(2,2) = std(LUSsham)/sqrt(length(LUSsham)) ;
    var_stderror(2,3) = std(secondLOsham)/sqrt(length(secondLOsham)) ;
    
    % plotting 
    figure(7) 
    var_y_pen = [median(firstLOpen)  median(LUSpen) median(secondLOpen)] ;
    var_y_sham = [median(firstLOsham)  median(LUSsham) median(secondLOsham)] ;
    var_1 = errorbar(1:3, var_y_pen, var_stderror(1,:), 'o-r') ; 
    hold on 
    var_2 = errorbar(1:3, var_y_sham, var_stderror(2,:), 'o-b') ;  
%     xlim([-0.5, 2.5]);
    legend([var_1 var_2], {'PEN data', 'SHAM data'})
    title('Median Variance by cohort vs. Trial Type')
    ylabel('Variance') 
    trialtype = {'1LO' '' '' '' '' 'L+US' '' '' '' '' '2LO'};
    
    xticklabels(trialtype) ;
    
    
else 
    %% median of event median standard error for errorbars 
    median_stderror = zeros(2,3) ;
    median_stderror(1,1) = std(firstLOpen)/sqrt(length(firstLOpen)) ;
    median_stderror(1,2) = std(LUSpen)/sqrt(length(LUSpen)) ;
    median_stderror(1,3) = std(secondLOpen)/sqrt(length(secondLOpen)) ;
    
    median_stderror(2,1) = std(firstLOsham)/sqrt(length(firstLOsham)) ;
    median_stderror(2,2) = std(LUSsham)/sqrt(length(LUSsham)) ;
    median_stderror(2,3) = std(secondLOsham)/sqrt(length(secondLOsham)) ;
    
    median_stderror(3,1) = std(firstLOshamLight)/sqrt(length(firstLOshamLight)) ;
    median_stderror(3,2) = std(LUSshamLight)/sqrt(length(LUSshamLight)) ;
    median_stderror(3,3) = std(secondLOshamLight)/sqrt(length(secondLOshamLight)) ;
% % standard dev
%     median_stderror(1,1) = std(firstLOpen) ;
%     median_stderror(1,2) = std(LUSpen);
%     median_stderror(1,3) = std(secondLOpen) ;
%     
%     median_stderror(2,1) = std(firstLOsham);
%     median_stderror(2,2) = std(LUSsham) ;
%     median_stderror(2,3) = std(secondLOsham);

    
    % plotting 
    figure(7) 
    medmed_y_pen = [median(firstLOpen)  median(LUSpen) median(secondLOpen)] ;
    medmed_y_sham = [median(firstLOsham)  median(LUSsham) median(secondLOsham)] ;
    medmed_y_shamLight = [median(firstLOshamLight)  median(LUSshamLight) median(secondLOshamLight)] ;
 
    medmed_1 = errorbar(1:3, medmed_y_pen, median_stderror(1,:),'k-','LineWidth', 1.5) ; 
    hold on 
    medmed_1line = scatter(1:3, medmed_y_pen, 500, 'k.') ; 
    hold on 
    medmed_2 = errorbar(1:3, medmed_y_sham, median_stderror(2,:),'k--','LineWidth', 1.5) ; 
    hold on 
    medmed_2line = scatter(1:3, medmed_y_sham, 500, 'k.') ;
    hold on 
    medmed_3 = errorbar(1:3, medmed_y_shamLight, median_stderror(3,:),'k:','LineWidth', 3) ; 
    hold on 
    medmed_3line = scatter(1:3, medmed_y_shamLight, 500, 'k.') ;

    % for creating legend without errorbars 
% medmed_1 = plot(1:3, medmed_y_pen, 'k-', 'LineWidth', 1.5);
% medmed_2 = plot(1:3, medmed_y_sham, 'k--', 'LineWidth', 1.5);
% medmed_3 = plot(1:3, medmed_y_shamLight, 'k-.', 'LineWidth', 2.1);
% set(get(get(medmed_1,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(medmed_2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(medmed_3,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');

    legend([medmed_1 medmed_2 medmed_3], {'PEN US', 'SHAM US', 'SHAM Light'}, 'location', 'northwest')
    ylabel('Normalized RMS Brain Activity','Fontsize', 14) 
    
    labels = {'1st LO', 'L+tDUS', '2nd LO'};

    % Find the positions of the categorical labels
    labelPositions = find(~cellfun(@isempty, labels));

    % Set the x-tick positions and labels
    xticks(labelPositions);
    xticklabels(labels(labelPositions));

    % Adjust the x-axis limits if needed
    xlim([0, numel(labels)+1]);

    a = get(gca,'XTickLabel');
    set(gca,'XTickLabel',a,'fontsize',14)
    xlim([0.95 3.05]);
    
end 

%% intracohort median/variance MWs 

% if normalize_by_1LOvar == 1 
%     if medians_or_variance == 1 
%         median_MWpenLUS2LO = ranksum(LUSpen,secondLOpen); 
%         median_MWshamLUS2LO = ranksum(LUSsham,secondLOsham); 
%     else
%         var_MW_pen_LUS2LO = ranksum(LUSpen, secondLOpen) ; 
%         var_MW_sham_LUS2LO = ranksum(LUSsham, secondLOsham) ;
%     end 
% else 
    if medians_or_variance == 1 
        median_MWpen1LOLUS = ranksum(firstLOpen,LUSpen);
        median_MWpenLUS2LO = ranksum(LUSpen,secondLOpen); 
        median_MWpen1LO2LO = ranksum(firstLOpen,secondLOpen);

        median_MWsham1LOLUS = ranksum(firstLOsham,LUSsham);
        median_MWshamLUS2LO = ranksum(LUSsham,secondLOsham); 
        median_MWsham1LO2LO = ranksum(firstLOsham,secondLOsham); 
    else
        var_MW_pen_1LOLUS = ranksum(firstLOpen, LUSpen) ; 
        var_MW_pen_LUS2LO = ranksum(LUSpen, secondLOpen) ; 
        var_MWpen1LO2LO = ranksum(firstLOpen,secondLOpen);

        var_MW_sham_1LOLUS = ranksum(firstLOsham, LUSsham) ; 
        var_MW_sham_LUS2LO = ranksum(LUSsham, secondLOsham) ;
        var_MWsham1LO2LO = ranksum(firstLOsham,secondLOsham); 
    end 
% end 


