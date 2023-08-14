close all
% clearvars -except former_mat runningrms_or_10sec secs simple_medians_or_variance shrink_matrix simple_median_analysis simple_median_analysis_normalize penran medians_or_variance normalize_by_1LOvar normalize_by_1LOmed penmedians penvariances PEN_MATRIX PEN_MATRIX_1LOnormalized shamLightmedians shamLightvariances shamLight_matrix shamLight_matrix_1LOnormalized sham_light
clearvars -except former_mat runningrms_or_10sec secs simple_medians_or_variance shrink_matrix simple_median_analysis simple_median_analysis_normalize penran medians_or_variance normalize_by_1LOvar normalize_by_1LOmed penmedians penvariances PEN_MATRIX PEN_MATRIX_1LOnormalized shamLightmedians shamLightvariances shamLight_matrix shamLight_matrix_1LOnormalized shammedians shamvariances SHAM_MATRIX SHAM_MATRIX_1LOnormalized sham_light


%% making medians 

% regular 
% firstLOpen = [penmedians.Mouse1Trial1 penmedians.Mouse2Trial1 penmedians.Mouse3Trial1 penmedians.Mouse4Trial1 penmedians.Mouse5Trial1 penmedians.Mouse6Trial1 penmedians.Mouse7Trial1 ]; 
% firstLOsham = [shammedians.Mouse1Trial1 shammedians.Mouse2Trial1 shammedians.Mouse3Trial1 shammedians.Mouse4Trial1 shammedians.Mouse5Trial1 shammedians.Mouse6Trial1 shammedians.Mouse7Trial1 ];   
% firstLOshamLight = [shamLightmedians.Mouse1Trial1 shamLightmedians.Mouse2Trial1 shamLightmedians.Mouse3Trial1 shamLightmedians.Mouse4Trial1 shamLightmedians.Mouse5Trial1 shamLightmedians.Mouse6Trial1 shamLightmedians.Mouse7Trial1 ];
% 
% LUSpen = [penmedians.Mouse1Trial3 penmedians.Mouse2Trial3 penmedians.Mouse3Trial3 penmedians.Mouse4Trial3 penmedians.Mouse5Trial3 penmedians.Mouse6Trial3 penmedians.Mouse7Trial3 ]; 
% LUSsham = [shammedians.Mouse1Trial3 shammedians.Mouse2Trial3 shammedians.Mouse3Trial3 shammedians.Mouse4Trial3 shammedians.Mouse5Trial3 shammedians.Mouse6Trial3 shammedians.Mouse7Trial3 ];
% LUSshamLight = [shamLightmedians.Mouse1Trial3 shamLightmedians.Mouse2Trial3 shamLightmedians.Mouse3Trial3 shamLightmedians.Mouse4Trial3 shamLightmedians.Mouse5Trial3 shamLightmedians.Mouse6Trial3 shamLightmedians.Mouse7Trial3 ];
% 
% secondLOpen = [penmedians.Mouse1Trial4 penmedians.Mouse2Trial4 penmedians.Mouse3Trial4 penmedians.Mouse4Trial4 penmedians.Mouse5Trial4 penmedians.Mouse6Trial4 penmedians.Mouse7Trial4 ]; 
% secondLOsham = [shammedians.Mouse1Trial4 shammedians.Mouse2Trial4 shammedians.Mouse3Trial4 shammedians.Mouse4Trial4 shammedians.Mouse5Trial4 shammedians.Mouse6Trial4 shammedians.Mouse7Trial4 ];
% secondLOshamLight = [shamLightmedians.Mouse1Trial4 shamLightmedians.Mouse2Trial4 shamLightmedians.Mouse3Trial4 shamLightmedians.Mouse4Trial4 shamLightmedians.Mouse5Trial4 shamLightmedians.Mouse6Trial4 shamLightmedians.Mouse7Trial4 ];
    
% reg + gabe sham light mouse
% firstLOpen = [penmedians.Mouse1Trial1 penmedians.Mouse2Trial1 penmedians.Mouse3Trial1 penmedians.Mouse4Trial1 penmedians.Mouse5Trial1 penmedians.Mouse6Trial1 penmedians.Mouse7Trial1 ]; 
% firstLOsham = [shammedians.Mouse1Trial1 shammedians.Mouse2Trial1 shammedians.Mouse3Trial1 shammedians.Mouse4Trial1 shammedians.Mouse5Trial1 shammedians.Mouse6Trial1 shammedians.Mouse7Trial1 ];   
% firstLOshamLight = [shamLightmedians.Mouse1Trial1 shamLightmedians.Mouse2Trial1 shamLightmedians.Mouse3Trial1 shamLightmedians.Mouse4Trial1 shamLightmedians.Mouse5Trial1 shamLightmedians.Mouse6Trial1 shamLightmedians.Mouse7Trial1 shamLightmedians.Mouse8Trial1];
% 
% LUSpen = [penmedians.Mouse1Trial3 penmedians.Mouse2Trial3 penmedians.Mouse3Trial3 penmedians.Mouse4Trial3 penmedians.Mouse5Trial3 penmedians.Mouse6Trial3 penmedians.Mouse7Trial3 ]; 
% LUSsham = [shammedians.Mouse1Trial3 shammedians.Mouse2Trial3 shammedians.Mouse3Trial3 shammedians.Mouse4Trial3 shammedians.Mouse5Trial3 shammedians.Mouse6Trial3 shammedians.Mouse7Trial3 ];
% LUSshamLight = [shamLightmedians.Mouse1Trial3 shamLightmedians.Mouse2Trial3 shamLightmedians.Mouse3Trial3 shamLightmedians.Mouse4Trial3 shamLightmedians.Mouse5Trial3 shamLightmedians.Mouse6Trial3 shamLightmedians.Mouse7Trial3 shamLightmedians.Mouse8Trial3];
% 
% secondLOpen = [penmedians.Mouse1Trial4 penmedians.Mouse2Trial4 penmedians.Mouse3Trial4 penmedians.Mouse4Trial4 penmedians.Mouse5Trial4 penmedians.Mouse6Trial4 penmedians.Mouse7Trial4 ]; 
% secondLOsham = [shammedians.Mouse1Trial4 shammedians.Mouse2Trial4 shammedians.Mouse3Trial4 shammedians.Mouse4Trial4 shammedians.Mouse5Trial4 shammedians.Mouse6Trial4 shammedians.Mouse7Trial4 ];
% secondLOshamLight = [shamLightmedians.Mouse1Trial4 shamLightmedians.Mouse2Trial4 shamLightmedians.Mouse3Trial4 shamLightmedians.Mouse4Trial4 shamLightmedians.Mouse5Trial4 shamLightmedians.Mouse6Trial4 shamLightmedians.Mouse7Trial4 shamLightmedians.Mouse8Trial4];
 
% unnnoisy mice for sham light file1={'5_18_23 M1 RECUT\', '5_18_23 M2
% RECUT\', '5_18_23 M3 RECUT\', '5_25_23 M1 RECUT\', '5_25_23 M2 RECUT\','5_26_23 M2 RECUT\', '5_26_23 M3 RECUT\', '5_26_23 m1 Gabe\'}; 1 4 7 8 
% firstLOpen = [penmedians.Mouse1Trial1 penmedians.Mouse2Trial1 penmedians.Mouse3Trial1 penmedians.Mouse4Trial1 penmedians.Mouse5Trial1 penmedians.Mouse6Trial1 penmedians.Mouse7Trial1 ]; 
% firstLOsham = [shammedians.Mouse1Trial1 shammedians.Mouse2Trial1 shammedians.Mouse3Trial1 shammedians.Mouse4Trial1 shammedians.Mouse5Trial1 shammedians.Mouse6Trial1 shammedians.Mouse7Trial1 ];   
% firstLOshamLight = [shamLightmedians.Mouse1Trial1 shamLightmedians.Mouse4Trial1 shamLightmedians.Mouse7Trial1 shamLightmedians.Mouse8Trial1];
% 
% LUSpen = [penmedians.Mouse1Trial3 penmedians.Mouse2Trial3 penmedians.Mouse3Trial3 penmedians.Mouse4Trial3 penmedians.Mouse5Trial3 penmedians.Mouse6Trial3 penmedians.Mouse7Trial3 ]; 
% LUSsham = [shammedians.Mouse1Trial3 shammedians.Mouse2Trial3 shammedians.Mouse3Trial3 shammedians.Mouse4Trial3 shammedians.Mouse5Trial3 shammedians.Mouse6Trial3 shammedians.Mouse7Trial3 ];
% LUSshamLight = [shamLightmedians.Mouse1Trial3 shamLightmedians.Mouse4Trial3 shamLightmedians.Mouse7Trial3 shamLightmedians.Mouse8Trial3];
% 
% secondLOpen = [penmedians.Mouse1Trial4 penmedians.Mouse2Trial4 penmedians.Mouse3Trial4 penmedians.Mouse4Trial4 penmedians.Mouse5Trial4 penmedians.Mouse6Trial4 penmedians.Mouse7Trial4 ]; 
% secondLOsham = [shammedians.Mouse1Trial4 shammedians.Mouse2Trial4 shammedians.Mouse3Trial4 shammedians.Mouse4Trial4 shammedians.Mouse5Trial4 shammedians.Mouse6Trial4 shammedians.Mouse7Trial4 ];
% secondLOshamLight = [shamLightmedians.Mouse1Trial4 shamLightmedians.Mouse4Trial4 shamLightmedians.Mouse7Trial4 shamLightmedians.Mouse8Trial4];

% unnoisy plus 3 
% 
% firstLOpen = [penmedians.Mouse1Trial1 penmedians.Mouse2Trial1 penmedians.Mouse3Trial1 penmedians.Mouse4Trial1 penmedians.Mouse5Trial1 penmedians.Mouse6Trial1 penmedians.Mouse7Trial1 ]; 
% firstLOsham = [shammedians.Mouse1Trial1 shammedians.Mouse2Trial1 shammedians.Mouse3Trial1 shammedians.Mouse4Trial1 shammedians.Mouse5Trial1 shammedians.Mouse6Trial1 shammedians.Mouse7Trial1 ];   
% firstLOshamLight = [shamLightmedians.Mouse1Trial1 shamLightmedians.Mouse3Trial1 shamLightmedians.Mouse4Trial1 shamLightmedians.Mouse7Trial1 shamLightmedians.Mouse8Trial1];
% 
% LUSpen = [penmedians.Mouse1Trial3 penmedians.Mouse2Trial3 penmedians.Mouse3Trial3 penmedians.Mouse4Trial3 penmedians.Mouse5Trial3 penmedians.Mouse6Trial3 penmedians.Mouse7Trial3 ]; 
% LUSsham = [shammedians.Mouse1Trial3 shammedians.Mouse2Trial3 shammedians.Mouse3Trial3 shammedians.Mouse4Trial3 shammedians.Mouse5Trial3 shammedians.Mouse6Trial3 shammedians.Mouse7Trial3 ];
% LUSshamLight = [shamLightmedians.Mouse1Trial3 shamLightmedians.Mouse3Trial3 shamLightmedians.Mouse4Trial3 shamLightmedians.Mouse7Trial3 shamLightmedians.Mouse8Trial3];
% 
% secondLOpen = [penmedians.Mouse1Trial4 penmedians.Mouse2Trial4 penmedians.Mouse3Trial4 penmedians.Mouse4Trial4 penmedians.Mouse5Trial4 penmedians.Mouse6Trial4 penmedians.Mouse7Trial4 ]; 
% secondLOsham = [shammedians.Mouse1Trial4 shammedians.Mouse2Trial4 shammedians.Mouse3Trial4 shammedians.Mouse4Trial4 shammedians.Mouse5Trial4 shammedians.Mouse6Trial4 shammedians.Mouse7Trial4 ];
% secondLOshamLight = [shamLightmedians.Mouse1Trial4 shamLightmedians.Mouse3Trial4 shamLightmedians.Mouse4Trial4 shamLightmedians.Mouse7Trial4 shamLightmedians.Mouse8Trial4];
% 

% % 5+6 most moisy removed 
% 
firstLOpen = [penmedians.Mouse1Trial1 penmedians.Mouse2Trial1 penmedians.Mouse3Trial1 penmedians.Mouse4Trial1 penmedians.Mouse5Trial1 penmedians.Mouse6Trial1 penmedians.Mouse7Trial1 ]; 
firstLOsham = [shammedians.Mouse1Trial1 shammedians.Mouse2Trial1 shammedians.Mouse3Trial1 shammedians.Mouse4Trial1 shammedians.Mouse5Trial1 shammedians.Mouse6Trial1 shammedians.Mouse7Trial1 ];   
firstLOshamLight = [shamLightmedians.Mouse1Trial1 shamLightmedians.Mouse2Trial1 shamLightmedians.Mouse3Trial1 shamLightmedians.Mouse4Trial1 shamLightmedians.Mouse7Trial1 shamLightmedians.Mouse8Trial1];

LUSpen = [penmedians.Mouse1Trial3 penmedians.Mouse2Trial3 penmedians.Mouse3Trial3 penmedians.Mouse4Trial3 penmedians.Mouse5Trial3 penmedians.Mouse6Trial3 penmedians.Mouse7Trial3 ]; 
LUSsham = [shammedians.Mouse1Trial3 shammedians.Mouse2Trial3 shammedians.Mouse3Trial3 shammedians.Mouse4Trial3 shammedians.Mouse5Trial3 shammedians.Mouse6Trial3 shammedians.Mouse7Trial3 ];
LUSshamLight = [shamLightmedians.Mouse1Trial3 shamLightmedians.Mouse2Trial3 shamLightmedians.Mouse3Trial3 shamLightmedians.Mouse4Trial3 shamLightmedians.Mouse7Trial3 shamLightmedians.Mouse8Trial3];

secondLOpen = [penmedians.Mouse1Trial4 penmedians.Mouse2Trial4 penmedians.Mouse3Trial4 penmedians.Mouse4Trial4 penmedians.Mouse5Trial4 penmedians.Mouse6Trial4 penmedians.Mouse7Trial4 ]; 
secondLOsham = [shammedians.Mouse1Trial4 shammedians.Mouse2Trial4 shammedians.Mouse3Trial4 shammedians.Mouse4Trial4 shammedians.Mouse5Trial4 shammedians.Mouse6Trial4 shammedians.Mouse7Trial4 ];
secondLOshamLight = [shamLightmedians.Mouse1Trial4 shamLightmedians.Mouse2Trial4 shamLightmedians.Mouse3Trial4 shamLightmedians.Mouse4Trial4 shamLightmedians.Mouse7Trial4 shamLightmedians.Mouse8Trial4];
% 

% 6 removed 
% 
% firstLOpen = [penmedians.Mouse1Trial1 penmedians.Mouse2Trial1 penmedians.Mouse3Trial1 penmedians.Mouse4Trial1 penmedians.Mouse5Trial1 penmedians.Mouse6Trial1 penmedians.Mouse7Trial1 ]; 
% firstLOsham = [shammedians.Mouse1Trial1 shammedians.Mouse2Trial1 shammedians.Mouse3Trial1 shammedians.Mouse4Trial1 shammedians.Mouse5Trial1 shammedians.Mouse6Trial1 shammedians.Mouse7Trial1 ];   
% firstLOshamLight = [shamLightmedians.Mouse1Trial1 shamLightmedians.Mouse2Trial1 shamLightmedians.Mouse3Trial1 shamLightmedians.Mouse4Trial1 shamLightmedians.Mouse5Trial1 shamLightmedians.Mouse7Trial1 shamLightmedians.Mouse8Trial1];
% 
% LUSpen = [penmedians.Mouse1Trial3 penmedians.Mouse2Trial3 penmedians.Mouse3Trial3 penmedians.Mouse4Trial3 penmedians.Mouse5Trial3 penmedians.Mouse6Trial3 penmedians.Mouse7Trial3 ]; 
% LUSsham = [shammedians.Mouse1Trial3 shammedians.Mouse2Trial3 shammedians.Mouse3Trial3 shammedians.Mouse4Trial3 shammedians.Mouse5Trial3 shammedians.Mouse6Trial3 shammedians.Mouse7Trial3 ];
% LUSshamLight = [shamLightmedians.Mouse1Trial3 shamLightmedians.Mouse2Trial3 shamLightmedians.Mouse3Trial3 shamLightmedians.Mouse4Trial3 shamLightmedians.Mouse5Trial3 shamLightmedians.Mouse7Trial3 shamLightmedians.Mouse8Trial3];
% 
% secondLOpen = [penmedians.Mouse1Trial4 penmedians.Mouse2Trial4 penmedians.Mouse3Trial4 penmedians.Mouse4Trial4 penmedians.Mouse5Trial4 penmedians.Mouse6Trial4 penmedians.Mouse7Trial4 ]; 
% secondLOsham = [shammedians.Mouse1Trial4 shammedians.Mouse2Trial4 shammedians.Mouse3Trial4 shammedians.Mouse4Trial4 shammedians.Mouse5Trial4 shammedians.Mouse6Trial4 shammedians.Mouse7Trial4 ];
% secondLOshamLight = [shamLightmedians.Mouse1Trial4 shamLightmedians.Mouse2Trial4 shamLightmedians.Mouse3Trial4 shamLightmedians.Mouse4Trial4 shamLightmedians.Mouse5Trial4 shamLightmedians.Mouse7Trial4 shamLightmedians.Mouse8Trial4];

% 5 removed 
% 6 removed 

% firstLOpen = [penmedians.Mouse1Trial1 penmedians.Mouse2Trial1 penmedians.Mouse3Trial1 penmedians.Mouse4Trial1 penmedians.Mouse5Trial1 penmedians.Mouse6Trial1 penmedians.Mouse7Trial1 ]; 
% firstLOsham = [shammedians.Mouse1Trial1 shammedians.Mouse2Trial1 shammedians.Mouse3Trial1 shammedians.Mouse4Trial1 shammedians.Mouse5Trial1 shammedians.Mouse6Trial1 shammedians.Mouse7Trial1 ];   
% firstLOshamLight = [shamLightmedians.Mouse1Trial1 shamLightmedians.Mouse2Trial1 shamLightmedians.Mouse3Trial1 shamLightmedians.Mouse4Trial1 shamLightmedians.Mouse6Trial1 shamLightmedians.Mouse7Trial1 shamLightmedians.Mouse8Trial1];
% 
% LUSpen = [penmedians.Mouse1Trial3 penmedians.Mouse2Trial3 penmedians.Mouse3Trial3 penmedians.Mouse4Trial3 penmedians.Mouse5Trial3 penmedians.Mouse6Trial3 penmedians.Mouse7Trial3 ]; 
% LUSsham = [shammedians.Mouse1Trial3 shammedians.Mouse2Trial3 shammedians.Mouse3Trial3 shammedians.Mouse4Trial3 shammedians.Mouse5Trial3 shammedians.Mouse6Trial3 shammedians.Mouse7Trial3 ];
% LUSshamLight = [shamLightmedians.Mouse1Trial3 shamLightmedians.Mouse2Trial3 shamLightmedians.Mouse3Trial3 shamLightmedians.Mouse4Trial3 shamLightmedians.Mouse6Trial3 shamLightmedians.Mouse7Trial3 shamLightmedians.Mouse8Trial3];
% 
% secondLOpen = [penmedians.Mouse1Trial4 penmedians.Mouse2Trial4 penmedians.Mouse3Trial4 penmedians.Mouse4Trial4 penmedians.Mouse5Trial4 penmedians.Mouse6Trial4 penmedians.Mouse7Trial4 ]; 
% secondLOsham = [shammedians.Mouse1Trial4 shammedians.Mouse2Trial4 shammedians.Mouse3Trial4 shammedians.Mouse4Trial4 shammedians.Mouse5Trial4 shammedians.Mouse6Trial4 shammedians.Mouse7Trial4 ];
% secondLOshamLight = [shamLightmedians.Mouse1Trial4 shamLightmedians.Mouse2Trial4 shamLightmedians.Mouse3Trial4 shamLightmedians.Mouse4Trial4 shamLightmedians.Mouse6Trial4 shamLightmedians.Mouse7Trial4 shamLightmedians.Mouse8Trial4];
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

% KW with all three cohorts 
% dataset = [firstLOpen; LUSpen; secondLOpen; firstLOsham; LUSsham; secondLOsham; firstLOshamLight; LUSshamLight; secondLOshamLight]';
% KWp = kruskalwallis(dataset);

% KW with pen and sham 
dataset = [firstLOpen; LUSpen; secondLOpen; firstLOsham; LUSsham; secondLOsham]';
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
% %% medians/variance box and whisker plots 
% % they like each box's data to be a column
% 
%     % for whiskers 
%     q3=norminv(.75);
%     q95=norminv(0.95);
%     w95=(q95-q3)/(2*q3);
% 
% %     x1 = subplot(1,3,1)
%     tiledlayout(1,3)
% 
%     ax1 = nexttile;
% 
% %         % finding whisker length for boxplot 
% %            
% boxplot([firstLOpen',firstLOsham',firstLOshamLight'],'Symbol', '','Notch','on','Labels', {'PEN US', 'SHAM US', 'SHAM Light'}) 
% %     hold on 
% %     scatter(ones(length(firstLOpen)),firstLOpen,4,'r','filled')
% %     hold on 
% %     scatter(2.*ones(length(firstLOsham)),firstLOpen,4,'r','filled')
%     title('1st LO','Fontsize', 13) 
%     ylabel('Normalized RMS Brain Activity','FontWeight','bold', 'Fontsize', 14) 
% 
% %     x2 = subplot(1,3,2)
%     ax2 = nexttile;
% 
% %
%  boxplot([LUSpen',LUSsham',LUSshamLight'],'Symbol', '','Notch','on','Labels', {'PEN US', 'SHAM US', 'SHAM Light'})
%     set(gca,'YTickLabel',[]);
% %     hold on 
% %     scatter(ones(length(LUSpen)),LUSpen,3,'r','filled')
% %     hold on 
% %     scatter(2.*ones(length(LUSsham)),LUSpen,3,'r','filled')
%     title('L+US','FontWeight','bold','Fontsize', 13) 
% %     ylabel('Normalized RMS Brain Activity') 
% 
% %     x3 = subplot(1,3,3)
%     ax3 = nexttile;
% 
% 
% boxplot([secondLOpen',secondLOsham',secondLOshamLight'],'Symbol', '','Notch','on','Labels', {'PEN US', 'SHAM US', 'SHAM Light'})
%     set(gca,'YTickLabel',[]);
% %     hold on 
% %     scatter(ones(length(secondLOpen)),secondLOpen,3,'r','filled')
% %     hold on
% %     scatter(2.*ones(length(secondLOsham)),secondLOsham,3,'r','filled')
%     title('2nd LO', 'Fontsize',13) % Normalized RMS Brain Activity by Cohort
% %     ylabel('Normalized RMS Brain Activity') 
% 
%     linkaxes([ax1 ax2 ax3],'xy')
%% medians/variance box and whisker plots 
% they like each box's data to be a column
    
    % for whiskers 
    q3=norminv(.75);
    q95=norminv(0.95);
    w95=(q95-q3)/(2*q3);

%     tiledlayout(1,3)
%     
%     ax1 = nexttile;
%     boxplot([firstLOpen',firstLOsham',firstLOshamLight'],'Symbol', '','Notch','on','Labels', {'PEN US', 'SHAM US', 'SHAM Light'}) 
%     title('1st LO','Fontsize', 13) 
%     ylabel('Normalized RMS Brain Activity','FontWeight','bold', 'Fontsize', 14) 
%     
%     ax2 = nexttile;
%     boxplot([LUSpen',LUSsham',LUSshamLight'],'Symbol', '','Notch','on','Labels', {'PEN US', 'SHAM US', 'SHAM Light'})
%     set(gca,'YTickLabel',[]);
%     title('L+tDUS','FontWeight','bold','Fontsize', 13) 
% 
%     ax3 = nexttile;
%     boxplot([secondLOpen',secondLOsham',secondLOshamLight'],'Symbol', '','Notch','on','Labels', {'PEN US', 'SHAM US', 'SHAM Light'})
%     set(gca,'YTickLabel',[]);
%     title('2nd LO', 'Fontsize',13) % Normalized RMS Brain Activity by Cohort
% 
%     linkaxes([ax1 ax2 ax3],'xy')

% just pen and sham 
    tiledlayout(1,3)
    
    ax1 = nexttile;
    boxplot([firstLOpen',firstLOsham'],'Symbol', '','Notch','on','Labels', {'PEN US', 'SHAM US'}) 
    title('1st LO','Fontsize', 13) 
    ylabel('Normalized RMS Brain Activity','FontWeight','bold', 'Fontsize', 14) 
    
    ax2 = nexttile;
    boxplot([LUSpen',LUSsham'],'Symbol', '','Notch','on','Labels', {'PEN US', 'SHAM US'})
    set(gca,'YTickLabel',[]);
    title('L+tDUS','FontWeight','bold','Fontsize', 13) 

    ax3 = nexttile;
    boxplot([secondLOpen',secondLOsham'],'Symbol', '','Notch','on','Labels', {'PEN US', 'SHAM US'})
    set(gca,'YTickLabel',[]);
    title('2nd LO', 'Fontsize',13) % Normalized RMS Brain Activity by Cohort

    linkaxes([ax1 ax2],'xy')
%     ax1.YLim = [0.1 1.7];
%     ax2.YLim = [0.1 1.7];
%     ax3.YLim = [0.1 1.7];
    ax1.YLim = [0.35 1.95];
    ax2.YLim = [0.35 1.95];
    ax3.YLim = [0.35 1.95];

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
%% removing NaN entries 
firstLOpen = firstLOpen(~isnan(firstLOpen));
firstLOsham = firstLOsham(~isnan(firstLOsham));
firstLOshamLight = firstLOshamLight(~isnan(firstLOshamLight));
LUSpen = LUSpen(~isnan(LUSpen));
LUSsham = LUSsham(~isnan(LUSsham));
LUSshamLight = LUSshamLight(~isnan(LUSshamLight));
secondLOpen = secondLOpen(~isnan(secondLOpen));
secondLOsham = secondLOsham(~isnan(secondLOsham));
secondLOshamLight = secondLOshamLight(~isnan(secondLOshamLight));

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
    % median_stderror(1,1) = std(firstLOpen) ;
    % median_stderror(1,2) = std(LUSpen) ;
    % median_stderror(1,3) = std(secondLOpen) ;
    % 
    % median_stderror(2,1) = std(firstLOsham) ;
    % median_stderror(2,2) = std(LUSsham) ;
    % median_stderror(2,3) = std(secondLOsham) ;
    % 
    % median_stderror(3,1) = std(firstLOshamLight) ;
    % median_stderror(3,2) = std(LUSshamLight) ;
    % median_stderror(3,3) = std(secondLOshamLight) ;
    % 
%% line plotting 

    
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
    medmed_3 = errorbar(1:3, medmed_y_shamLight, median_stderror(3,:),'k:','LineWidth', 2) ; 
    hold on 
    medmed_3line = scatter(1:3, medmed_y_shamLight, 500, 'k.') ;
    hold on 
    % estimating projected value if US did not activate brain 
    projectedValue = (medmed_y_shamLight(1,1)+medmed_y_shamLight(1,3))/2;
%     projectedPoint = scatter(2, projectedValue, 200, "pentagram") ;
    projectedPoint = scatter(2, projectedValue, 150, "pentagram",'k') ;
    projectedLine = [median(firstLOshamLight)  projectedValue median(secondLOshamLight)] ;
    
    % for creating legend without errorbars 
medmed_1 = plot(1:3, medmed_y_pen, 'k-', 'LineWidth', 1.5);
medmed_2 = plot(1:3, medmed_y_sham, 'k--', 'LineWidth', 1.5);
medmed_3 = plot(1:3, medmed_y_shamLight, 'k:', 'LineWidth', 2);
medmed_4 = plot(1:3, projectedLine, 'k-.', 'LineWidth', 1.3);
set(get(get(medmed_1,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(medmed_2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(medmed_3,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');

    legend([medmed_1 medmed_2 medmed_3 medmed_4], {'PEN US & light', 'Light Only', 'PEN US Only','PEN US projection'}, 'location', 'northwest')
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
    
%% second line plot 

figure(8) 
    medmed_y_pen = [median(firstLOpen)  median(LUSpen) median(secondLOpen)] ;
    medmed_y_sham = [median(firstLOsham)  median(LUSsham) median(secondLOsham)] ;
 
    medmed_1 = errorbar(1:3, medmed_y_pen, median_stderror(1,:),'k-','LineWidth', 1.5) ; 
    hold on 
    medmed_1line = scatter(1:3, medmed_y_pen, 500, 'k.') ; 
    hold on 
    medmed_2 = errorbar(1:3, medmed_y_sham, median_stderror(2,:),'k--','LineWidth', 1.5) ; 
    hold on 
    medmed_2line = scatter(1:3, medmed_y_sham, 500, 'k.') ;    
    hold on 
    
    % for creating legend without errorbars 
medmed_1 = plot(1:3, medmed_y_pen, 'k-', 'LineWidth', 1.5);
medmed_2 = plot(1:3, medmed_y_sham, 'k--', 'LineWidth', 1.5);

set(get(get(medmed_1,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
set(get(get(medmed_2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');

    legend([medmed_1 medmed_2], {'PEN US', 'SHAM US'}, 'location', 'northwest')
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
    
%% MW between projected point and actual point for sham light at L+tDUS 
    
    LUS_SL_length = length(LUSshamLight) ;
    projectedValue_matrix = zeros(1,LUS_SL_length) ;
    for i = 1:LUS_SL_length
        projectedValue_matrix(1,i) = projectedValue ;
    end 
        
    MW_shamlight_vs_projection = ranksum(LUSshamLight, projectedValue_matrix) ;
    
    % new method
    diff = abs(median(LUSshamLight) - projectedValue);
    LUSshamLight_projected = LUSshamLight - diff; 
    disp(['LUSshamLight_projected median: ' num2str(median(LUSshamLight_projected)) ' projected value: ' string(projectedValue)])
    MW_shamlight_vs_projection2 = ranksum(LUSshamLight, LUSshamLight_projected) ;
    
    %% Wilcoxon signed-rank test
    
    % Example data (replace these with your actual data)
    observed_data = [LUSshamLight]; % Replace with your data
    projected_data = [projectedValue]; % Replace with your data

    % Perform the Wilcoxon signed-rank test
    [p_value, h, stats] = signrank(observed_data, projected_data);

    % Display the p-value and the test result
    fprintf('p-value: %f\n', p_value);
    if h == 1
        fprintf('Reject the null hypothesis. There is a significant difference.\n');
    else
        fprintf('Fail to reject the null hypothesis. No significant difference.\n');
    end
