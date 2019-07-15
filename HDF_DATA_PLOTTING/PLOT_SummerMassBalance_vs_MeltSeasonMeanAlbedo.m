% Find MOD merged albedo to validate agains
cd('\\lvthrvinnsla\data\aig\data\mat_output_v2')
% Select dataset to load

close all
figure, hold on
scatter(TMS.Vatnajokull,va.bs,'k','filled')
text(TMS.Vatnajokull+0.1,va.bs+0.1, num2str(va.year));

    mdl = fitlm(TMS.Vatnajokull,va.bs);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    hText = text(0.01,0.94,['RMSE: ',num2str(rmse),'   R^2: ',num2str(r2),'   n: ',num2str(n), ' w. 2011'],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom');
    plot(TMS.Vatnajokull,mdl.Fitted,'-.k')
    
    TMS_wo_2011 = TMS.Vatnajokull; TMS_wo_2011(12,:)=[];
    VaBs_wo_2011 = va.bs; VaBs_wo_2011(12,:)=[]
    
    mdl = fitlm(TMS_wo_2011,VaBs_wo_2011);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    hText = text(0.01,0.89,['RMSE: ',num2str(rmse),'   R^2: ',num2str(r2),'   n: ',num2str(n), ' w.o. 2011'],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom');
    hold on
    plot(TMS_wo_2011,mdl.Fitted,'-.k')
    
    xlim([44 66]);
    ylim([-3.5 -1.2]);
    grid on
    xlabel('GAM - Melt Season Mean albedo','FontSize',12);
    ylabel('Summer balance (b_s)','FontSize',12);    
    title('Vatnajökull')
    
    set(gca,'TickDir','out');
    set(gca, ...
      'Box'         , 'off'     , ...
      'TickDir'     , 'out'     , ...
      'TickLength'  , [.02 .02] , ...
      'XMinorTick'  , 'on'      , ...
      'YMinorTick'  , 'on'      , ...
      'YGrid'       , 'on'      , ...
      'XColor'      , [.3 .3 .3], ...
      'YColor'      , [.3 .3 .3], ...
      'LineWidth'   , 1         );
  
  cd(img_dir)
  set(gcf,'color','w');
  export_fig 'SummerMassBalance_vs_MeltSeasonMeanAlbedo_va.pdf'
%
close all
figure, hold on
scatter(TMS.Langjokull,la.bs,'k','filled')
%
text(TMS.Langjokull+0.1,la.bs+0.1, num2str(va.year));

    mdl = fitlm(TMS.Langjokull,la.bs);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    hText = text(0.01,0.94,['RMSE: ',num2str(rmse),'   R^2: ',num2str(r2),'   n: ',num2str(n)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom');
    plot(TMS.Langjokull,mdl.Fitted,'-.k')
    
    %TMS_wo_2011 = TMS.Vatnajokull; TMS_wo_2011(12,:)=[];
    %VaBs_wo_2011 = va.bs; VaBs_wo_2011(12,:)=[]

    
    xlim([35 65]);
    ylim([-5 -1.5]);
    grid on
    xlabel('GAM - Melt Season Mean albedo','FontSize',12);
    ylabel('Summer balance (b_s)','FontSize',12);    
    title('Langjökull')
    
    set(gca,'TickDir','out');
    set(gca, ...
      'Box'         , 'off'     , ...
      'TickDir'     , 'out'     , ...
      'TickLength'  , [.02 .02] , ...
      'XMinorTick'  , 'on'      , ...
      'YMinorTick'  , 'on'      , ...
      'YGrid'       , 'on'      , ...
      'XColor'      , [.3 .3 .3], ...
      'YColor'      , [.3 .3 .3], ...
      'LineWidth'   , 1         );
    cd(img_dir)
	set(gcf,'color','w');
    export_fig 'SummerMassBalance_vs_MeltSeasonMeanAlbedo_la.pdf'
%
close all
figure, hold on
scatter(TMS.Hofsjokull(1:end-1),ho.bn,'k','filled')
text(TMS.Hofsjokull(1:end-1)+0.1,ho.bn+0.1, num2str(ho.year));
%
    mdl = fitlm(TMS.Hofsjokull(1:end-1),ho.bn);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    hText = text(0.01,0.94,['RMSE: ',num2str(rmse),'   R^2: ',num2str(r2),'   n: ',num2str(n)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom');
    plot(TMS.Hofsjokull(1:end-1),mdl.Fitted,'-.k')

    xlim([35 65]);
    ylim([-3.5 1]);
    grid on
    xlabel('GAM - Melt Season Mean albedo','FontSize',12);
    ylabel('Net balance (b_n)','FontSize',12);    
    title('Hofsjökull')
    
    set(gca,'TickDir','out');
    set(gca, ...
      'Box'         , 'off'     , ...
      'TickDir'     , 'out'     , ...
      'TickLength'  , [.02 .02] , ...
      'XMinorTick'  , 'on'      , ...
      'YMinorTick'  , 'on'      , ...
      'YGrid'       , 'on'      , ...
      'XColor'      , [.3 .3 .3], ...
      'YColor'      , [.3 .3 .3], ...
      'LineWidth'   , 1         );
  
    cd(img_dir)
    set(gcf,'color','w');
    export_fig 'SummerMassBalance_vs_MeltSeasonMeanAlbedo_ho.pdf'
    
%

MyrdA(1,1) = TMS.Myrdalsjokull(2)   %2001
MyrdA(2,1) = TMS.Myrdalsjokull(8)   %2007
MyrdA(3,1) = TMS.Myrdalsjokull(9)   %2008
MyrdA(4,1) = TMS.Myrdalsjokull(10)  %2009
MyrdA(5,1) = TMS.Myrdalsjokull(12)  %2011
MyrdA(6,1) = TMS.Myrdalsjokull(13)  %2012
MyrdA(7,1) = TMS.Myrdalsjokull(17)  %2016
%%
close all
figure, hold on
scatter(MyrdA,my.bs,'k','filled')
text(MyrdA+0.1,my.bs+0.1, num2str(my.year));
%%
    mdl = fitlm(MyrdA,my.bs);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    hText = text(0.01,0.94,['RMSE: ',num2str(rmse),'   R^2: ',num2str(r2),'   n: ',num2str(n)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom');
    plot(MyrdA,mdl.Fitted,'-.k')

    
    TMS_wo_2011 = MyrdA; TMS_wo_2011(5,:)=[];
    my_wo_2011 = my.bs; my_wo_2011(5,:)=[]
    
    mdl = fitlm(TMS_wo_2011,my_wo_2011);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    hText = text(0.01,0.89,['RMSE: ',num2str(rmse),'   R^2: ',num2str(r2),'   n: ',num2str(n), ' w.o. 2011'],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom');
    hold on
    plot(TMS_wo_2011,mdl.Fitted,'-.k')
    
    %xlim([35 65]);
    %ylim([-3.5 1]);
    grid on
    xlabel('GAM - Melt Season Mean albedo','FontSize',12);
    ylabel('Summer balance (b_s)','FontSize',12);    
    title('Mýrdalsjökull')
    
    set(gca,'TickDir','out');
    set(gca, ...
      'Box'         , 'off'     , ...
      'TickDir'     , 'out'     , ...
      'TickLength'  , [.02 .02] , ...
      'XMinorTick'  , 'on'      , ...
      'YMinorTick'  , 'on'      , ...
      'YGrid'       , 'on'      , ...
      'XColor'      , [.3 .3 .3], ...
      'YColor'      , [.3 .3 .3], ...
      'LineWidth'   , 1         );
  
    cd(img_dir)
    set(gcf,'color','w');
    export_fig 'SummerMassBalance_vs_MeltSeasonMeanAlbedo_my.pdf'
