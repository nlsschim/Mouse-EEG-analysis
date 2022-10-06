%% Authors: Kat Floerchinger, Hannah Mach, Henry Tan :) 
close all 
%% matrixes from median_x scripts

% concatenating the matrixes from median_x scripts
MATRIX = [PEN_MATRIX; SHAM_MATRIX] ;


%% all dates PLOTTING

figure(1) 
hold on 

% finding how many mice per cohort to automate numbers of mice in each
% cohort

[penrownum,pencolnum]=size(PEN_MATRIX);
[shamrownum,shamcolnum]=size(SHAM_MATRIX);
% [genrownum,gencolnum]=size(GEN_MATRIX);
b = 4 ; 
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

% if GEN_MATRIX ~= [] 
%     % GEN plotting 
%     for q = penrownum+shamrownum+1:(penrownum+shamrownum+genrownum) %9-12
%         row = MATRIX(q,:) ;
%         p2 = plot(1:b, MATRIX(q, :), 'g', 'DisplayName','GEN data') ;
%     end 
%     legend([p1 p2 p3],{'SHAM data','GEN data', 'PEN data'})
% else  
%     legend([p1 p3],{'SHAM data','PEN data'})
% end 

xlabel('Trial Type'), ylabel('Median Value')
title('All Mice Median Values L+US and 2LO vs. 1LO')
% if button1 == 1 
    set(gca,'XTick',[1 2 3 4] );
    % set(gca,'XTickLabel',['1st LO', 'L+US' ,'2nd LO'] );
    xticklabels({'baseline rms value','1st LO','L+US','2nd LO'});
% else 
%     set(gca,'XTick',[1 2 3] );
%     % set(gca,'XTickLabel',['1st LO', 'L+US' ,'2nd LO'] );
%     xticklabels({'1st LO','L+US','2nd LO'});
% end 
hold off 

%% setting up cohort medians - requires more parsimonious solution for automation 

% if button1==1 
    b = 4;
    names = ["rmsBL" "LO1" "LUS" "LO2", "median"] ;
% else 
%     b = 3;
%     names = ["LO1" "LUS" "LO2", "median"] ;
% end 

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

% if GEN_MATRIX ~= []
%         % GEN medians 
%     for i = 1:b 
%         for j = penrownum+shamrownum+1:(penrownum+shamrownum+genrownum) 
% %       for j = 15:21
%             GEN.(char(names(i))) = [GEN.(char(names(i))) MATRIX(j,i)];
%         end 
%         trialmedian = strcat(char(names(i)),names(b+1));
%         GEN.(trialmedian) = median(GEN.(char(names(i))));
%     end 
% end 

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
% if GEN_MATRIX ~= []
%     if button1 == 1
%         stderror(1, 1) = std(SHAM.rmsBL)/sqrt(length(SHAM.rmsBL)) ;
%         stderror(1, 2) = std(SHAM.LO1)/sqrt(length(SHAM.LO1)) ;
%         stderror(1, 3) = std(SHAM.LUS)/sqrt(length(SHAM.LUS)) ;
%         stderror(1, 4) = std(SHAM.LO2)/sqrt(length(SHAM.LO2)) ;
% 
%         stderror(2, 1) = std(GEN.rmsBL)/sqrt(length(GEN.rmsBL)) ;
%         stderror(2, 2) = std(GEN.LO1)/sqrt(length(GEN.LO1)) ;
%         stderror(2, 3) = std(GEN.LUS)/sqrt(length(GEN.LUS)) ;
%         stderror(2, 4) = std(GEN.LO2)/sqrt(length(GEN.LO2)) ;
% 
%         stderror(3, 1) = std(PEN.rmsBL)/sqrt(length(PEN.rmsBL)) ;
%         stderror(3, 2) = std(PEN.LO1)/sqrt(length(PEN.LO1)) ;
%         stderror(3, 3) = std(PEN.LUS)/sqrt(length(PEN.LUS)) ;
%         stderror(3, 4) = std(PEN.LO2)/sqrt(length(PEN.LO2)) ;
%     elseif button1 == 2 
%         stderror(1, 1) = std(SHAM.LO1)/sqrt(length(SHAM.LO1)) ;
%         stderror(1, 2) = std(SHAM.LUS)/sqrt(length(SHAM.LUS)) ;
%         stderror(1, 3) = std(SHAM.LO2)/sqrt(length(SHAM.LO2)) ;
% 
%         stderror(2, 1) = std(GEN.LO1)/sqrt(length(GEN.LO1)) ;
%         stderror(2, 2) = std(GEN.LUS)/sqrt(length(GEN.LUS)) ;
%         stderror(2, 3) = std(GEN.LO2)/sqrt(length(GEN.LO2)) ;
% 
%         stderror(3, 1) = std(PEN.LO1)/sqrt(length(PEN.LO1)) ;
%         stderror(3, 2) = std(PEN.LUS)/sqrt(length(PEN.LUS)) ;
%         stderror(3, 3) = std(PEN.LO2)/sqrt(length(PEN.LO2)) ;
%     end 
% else 
%     if button1 == 1
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
%     elseif button1 == 2 
%         stderror(1, 1) = std(SHAM.LO1)/sqrt(length(SHAM.LO1)) ;
%         stderror(1, 2) = std(SHAM.LUS)/sqrt(length(SHAM.LUS)) ;
%         stderror(1, 3) = std(SHAM.LO2)/sqrt(length(SHAM.LO2)) ;

%         stderror(2, 1) = std(GEN.LO1median)/sqrt(length(GEN.LO1)) ;
%         stderror(2, 2) = std(GEN.LUSmedian)/sqrt(length(GEN.LUS)) ;
%         stderror(2, 3) = std(GEN.LO2median)/sqrt(length(GEN.LO2)) ;

%         stderror(2, 1) = std(PEN.LO1)/sqrt(length(PEN.LO1)) ;
%         stderror(2, 2) = std(PEN.LUS)/sqrt(length(PEN.LUS)) ;
%         stderror(2, 3) = std(PEN.LO2)/sqrt(length(PEN.LO2)) ;
%     end
% end 

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
% if GEN_MATRIX ~= [] 
%     if button1 ==1 
%         SHAMY_median = [SHAM.rmsBLmedian SHAM.LO1median SHAM.LUSmedian SHAM.LO2median] ;
%         q1 = errorbar(1:4, SHAMY_median, stderror(1,:), 'o-b', 'DisplayName', 'SHAM data') ;
%         hold on 

%         GENY_median = [GEN.rmsBLmedian GEN.LO1median GEN.LUSmedian GEN.LO2median] ;
%         q2 = errorbar(1:4, GENY_median, stderror(2,:), 'o-g', 'DisplayName', 'GEN data') ;
%         hold on 

%         PENY_median = [PEN.rmsBLmedian PEN.LO1median PEN.LUSmedian PEN.LO2median] ;
%         q3 = errorbar(1:4, PENY_median, stderror(3,:), 'o-r', 'DisplayName', 'PEN data') ;
%     else 
%         SHAMY_median = [SHAM.LO1median SHAM.LUSmedian SHAM.LO2median] ;
%         q1 = errorbar(1:3, SHAMY_median, stderror(1,:), 'o-b', 'DisplayName', 'SHAM data') ;
%         hold on 
% 
%         GENY_median = [GEN.LO1median GEN.LUSmedian GEN.LO2median] ;
%         q2 = errorbar(1:3, GENY_median, stderror(2,:), 'o-g', 'DisplayName', 'GEN data') ;
%         hold on 
% 
%         PENY_median = [PEN.LO1median PEN.LUSmedian PEN.LO2median] ;
%         q3 = errorbar(1:3, PENY_median, stderror(3,:), 'o-r', 'DisplayName', 'PEN data') ;
%     end
% else
%     if button1 ==1 
        SHAMY_median = [SHAM.rmsBLmedian SHAM.LO1median SHAM.LUSmedian SHAM.LO2median] ;
        q1 = errorbar(1:4, SHAMY_median, stderror(1,:), 'o-b', 'DisplayName', 'SHAM data') ;
        hold on 

        PENY_median = [PEN.rmsBLmedian PEN.LO1median PEN.LUSmedian PEN.LO2median] ;
        q3 = errorbar(1:4, PENY_median, stderror(3,:), 'o-r', 'DisplayName', 'PEN data') ;
%     else 
%         SHAMY_median = [SHAM.LO1median SHAM.LUSmedian SHAM.LO2median] ;
%         q1 = errorbar(1:3, SHAMY_median, stderror(1,:), 'o-b', 'DisplayName', 'SHAM data') ;
%         hold on 
% 
%         PENY_median = [PEN.LO1median PEN.LUSmedian PEN.LO2median] ;
%         q3 = errorbar(1:3, PENY_median, stderror(2,:), 'o-r', 'DisplayName', 'PEN data') ;
%     end
% end 

% if GEN_MATRIX ~= [] 
%     legend([q1 q2 q3],'SHAM DATA','GEN DATA','PEN DATA','Location','NorthWest')
% else 
    legend([q1 q3],'SHAM DATA','PEN DATA','Location','NorthWest')
% end 

xlabel('Trial Type'), ylabel('Median Value')
title('Cohort Median Value Trends L+US and 2LO vs. 1LO')
% set(gca,'XTickLabel',['1st LO', 'L+US' ,'2nd LO'] );

% if button1 ==1 
    set(gca,'XTick',[1 2 3 4] );
    xticklabels({'rms Baseline','1st LO','L+US','2nd LO'});
% else
%     set(gca,'XTick',[1 2 3] );
%     xticklabels({'1st LO','L+US','2nd LO'}); 
% end 

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
% if GEN_MATRIX ~= []
%     strgen=strings(1,length(GEN_MATRIX(:,2)));
%     for ii=1:length(strgen)
%         strgen(ii)='GEN';
%     end
%     strdatagroups =[strpen strsham strgen];
% else 
    strdatagroups =[strpen strsham];
% end 

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
% if GEN_MATRIX ~= []
%     if button1 == 1 
%         % %this first one is a test--we should see all 0s if button2 ==1 
%         firstLO_matrix = [PEN_MATRIX(:,2)' SHAM_MATRIX(:,2)' GEN_MATRIX(:,2)'] ;
% 
%         LUS_matrix = [PEN_MATRIX(:,3)' SHAM_MATRIX(:,3)' GEN_MATRIX(:,3)' ] ;
%         secondLO_matrix = [PEN_MATRIX(:,4)' SHAM_MATRIX(:,4)' GEN_MATRIX(:,4)'] ;
%     else 
%         firstLO_matrix = [PEN_MATRIX(:,1)' SHAM_MATRIX(:,1)' GEN_MATRIX(:,1)'] ;
%         LUS_matrix = [PEN_MATRIX(:,2)' SHAM_MATRIX(:,2)' GEN_MATRIX(:,2)'] ;
%         secondLO_matrix = [ PEN_MATRIX(:,3)' SHAM_MATRIX(:,3)' GEN_MATRIX(:,3)'] ;
%     end 
% else 
%     if button1 == 1 
        % %this first one is a test--we should see all 0s if button2 ==1 
        firstLO_matrix = [PEN_MATRIX(:,2)' SHAM_MATRIX(:,2)'] ;
        LUS_matrix = [PEN_MATRIX(:,3)' SHAM_MATRIX(:,3)'] ;
        secondLO_matrix = [PEN_MATRIX(:,4)' SHAM_MATRIX(:,4)'] ;
%     else 
%         firstLO_matrix = [PEN_MATRIX(:,1)' SHAM_MATRIX(:,1)'] ;
%         LUS_matrix = [PEN_MATRIX(:,2)' SHAM_MATRIX(:,2)'] ;
%         secondLO_matrix = [ PEN_MATRIX(:,3)' SHAM_MATRIX(:,3)'] ;
%     end
% end 
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
        figure(3)
        boxplot([PEN_MATRIX(:,1),SHAM_MATRIX(:,1)],'Labels', {'PEN US', 'SHAM US'}) 
        title('Baseline rms values by Cohort (n=7 each)') 
        hold on 
        scatter(ones(length(PEN_MATRIX)),PEN_MATRIX(:,1),'r','filled')
        hold on 
        scatter(2.*ones(length(SHAM_MATRIX)),SHAM_MATRIX(:,1),'r','filled')
        MWbaseline = ranksum(PEN_MATRIX(:,1),SHAM_MATRIX(:,1)) ; 
    
    % 1LO normalized 1LO 
        figure(4)
            % box 
            boxplot([PEN_MATRIX_1LOnormalized(:,2),SHAM_MATRIX_1LOnormalized(:,2)],'Labels', {'PEN US', 'SHAM US'}) 
            hold on 
            %scatterplot 
            scatter(ones(length(PEN_MATRIX_1LOnormalized)),PEN_MATRIX_1LOnormalized(:,2),'r','filled')
            hold on 
            scatter(2.*ones(length(SHAM_MATRIX_1LOnormalized)),SHAM_MATRIX_1LOnormalized(:,2),'r','filled')
            
            title('1LO normalized 1LO rms values by Cohort (test)') 
            ylabel('rms values') 
            MW1LO_normal = ranksum(PEN_MATRIX_1LOnormalized(:,2),SHAM_MATRIX_1LOnormalized(:,2)) ;
            
    % non 1LO normalized 1LO 
        figure(5)
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

    % 1 LO normalized L+US 
        figure(6)
            %box 
            boxplot([PEN_MATRIX_1LOnormalized(:,3),SHAM_MATRIX_1LOnormalized(:,3)],'Labels', {'PEN US', 'SHAM US'}) 
            %scatterplot
            hold on
            scatter(ones(length(PEN_MATRIX_1LOnormalized)),PEN_MATRIX_1LOnormalized(:,3),'r','filled')
            hold on 
            scatter(2.*ones(length(SHAM_MATRIX_1LOnormalized)),SHAM_MATRIX_1LOnormalized(:,3),'r','filled')
            
            title('1LO normalized L+US rms values by Cohort') 
            ylabel('1LO normalized rms values') 
            MWLUS_normal = ranksum(PEN_MATRIX_1LOnormalized(:,3),SHAM_MATRIX_1LOnormalized(:,3)) ;
            
    % NON 1 LO normalized L+US 
        figure(7)
            %box 
            boxplot([PEN_MATRIX(:,3),SHAM_MATRIX(:,3)],'Labels', {'PEN US', 'SHAM US'}) 
            %scatterplot
            hold on
            scatter(ones(length(PEN_MATRIX)),PEN_MATRIX(:,3),'r','filled')
            hold on 
            scatter(2.*ones(length(SHAM_MATRIX)),SHAM_MATRIX(:,3),'r','filled')
            
            title('L+US rms values by Cohort') 
            ylabel('rms values') 
            MWLUS = ranksum(PEN_MATRIX(:,3),SHAM_MATRIX(:,3)) ;

    % 1 LO normalized 2LO  
        figure(8)
            %box 
            boxplot([PEN_MATRIX_1LOnormalized(:,4),SHAM_MATRIX_1LOnormalized(:,4)],'Labels', {'PEN US', 'SHAM US'}) 
            %scatter 
            hold on
            scatter(ones(length(PEN_MATRIX_1LOnormalized)),PEN_MATRIX_1LOnormalized(:,4),'r','filled')
            hold on 
            scatter(2.*ones(length(SHAM_MATRIX_1LOnormalized)),SHAM_MATRIX_1LOnormalized(:,4),'r','filled')
            
            title('1LO normalized 2LO rms values by Cohort') 
            ylabel('1LO normalized rms values') 
            MW2LO_normal = ranksum(PEN_MATRIX_1LOnormalized(:,4),SHAM_MATRIX_1LOnormalized(:,4));
            
      % NON 1 LO normalized 2LO  
        figure(9)
            %box 
            boxplot([PEN_MATRIX(:,4),SHAM_MATRIX(:,4)],'Labels', {'PEN US', 'SHAM US'}) 
            %scatter 
            hold on
            scatter(ones(length(PEN_MATRIX)),PEN_MATRIX(:,4),'r','filled')
            hold on 
            scatter(2.*ones(length(SHAM_MATRIX)),SHAM_MATRIX(:,4),'r','filled')
            
            title('2LO rms values by Cohort') 
            ylabel('rms values') 
            MW2LO = ranksum(PEN_MATRIX(:,4),SHAM_MATRIX(:,4));
        
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