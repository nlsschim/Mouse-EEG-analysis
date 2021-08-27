%sham medians
med1 = median(SHAM_FIRST_LIGHT);
med2 = median(SHAM_LIGHT_ULTRASOUND);
med3 = median(SHAM_SECOND_LIGHT);
%gen medians
med4 = median(GEN_FIRST_LIGHT);
med5 = median(GEN_LIGHT_ULTRASOUND);
med6 = median(GEN_SECOND_LIGHT);
%pen medians
med7 = median(PEN_FIRST_LIGHT);
med8 = median(PEN_LIGHT_ULTRASOUND);
med9 = median(PEN_SECOND_LIGHT);



Ymedian_set_sham = [med1-med1 , med2-med1 , med3-med1];
Xmedian_set_sham = [1 , 2 , 3];
plot(Xmedian_set_sham,Ymedian_set_sham,'o-','DisplayName','SHAM DATA')
hold on
Ymedian_set_gen = [med4-med4 , med5-med4 , med6-med4];
Xmedian_set_gen = [1 , 2 , 3];
plot(Xmedian_set_gen,Ymedian_set_gen,'o-','DisplayName','GEN DATA')
hold on
Ymedian_set_pen= [med7-med7 , med8-med7 , med9-med7];
Xmedian_set_pen = [1 , 2 , 3];
plot(Xmedian_set_pen,Ymedian_set_pen,'o-','DisplayName','PEN DATA')
hold on
legend('SHAM DATA','GEN DATA','PEN DATA','Location','NorthWest')
xlabel('Trial Type'), ylabel('Median Value')
title('Median Value Trends for Light Stimulation Over Multiple Trials')
set(gca,'XTick',[1 2 3] );
% set(gca,'XTickLabel',['1st LO', 'L+US' ,'2nd LO'] );
xticklabels({'1st LO','L+US','2nd LO'});