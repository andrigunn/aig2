function PLOT_RAV2_GAWS_val(data, img_dir,filename,site_name)
%%
close all
figure('Position', [50, 50, 800, 600]), hold on
sgtitle(site_name)

subplot(2,3,1), hold on

Exist_Column = strcmp('t_2',data.Properties.VariableNames); val = Exist_Column(Exist_Column==1); 

if isempty(val) == 0

scatter(data.t_2,data.t_T1,'.k')

    mdl = fitlm(data.t_2,data.t_T1);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    bias = nanmean(data.t_2-data.t_T1);
    bias = sprintf('%.2f',bias);

    hText = text(0.02,0.92,['RMSE: ',num2str(rmse)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.86,['Bias: ',num2str(bias)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.78,['R^2: ',num2str(r2)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.72,['n: ',num2str(n)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);

    plot(data.t_2,mdl.Fitted ,'r','LineWidth',1.4)
    plot([-30 15],[-30 15],'--k','LineWidth',1.4);
    xlim([min(data.t_T1)-5 max(data.t_T1)]+5);
    ylim([min(data.t_T1)-5 max(data.t_T1)]+5);
    grid on
    %scatter(TM.t_2,TM.t_T1,'.k')
    xlabel('GAWS (t)')
    ylabel('RAV2 (t)')
    
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
else 
end
  
  subplot(2,3,2), hold on
  
  Exist_Column = strcmp('f_2',data.Properties.VariableNames); val = Exist_Column(Exist_Column==1); 

if isempty(val) == 0
    scatter(data.f_2,data.f_T1,'.k')

    mdl = fitlm(data.f_2,data.f_T1);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    bias = nanmean(data.f_2-data.f_T1);
    bias = sprintf('%.2f',bias);

    hText = text(0.02,0.92,['RMSE: ',num2str(rmse)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.86,['Bias: ',num2str(bias)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.78,['R^2: ',num2str(r2)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.72,['n: ',num2str(n)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
   
    plot(data.f_2,mdl.Fitted ,'r','LineWidth',1.4)
    plot([0 50],[0 50],'--k','LineWidth',1.4);
    xlim([0 max(data.f_T1)]+5);
    ylim([0 max(data.f_T1)]+5);
    grid on
    %scatter(TM.f_2,TM.f_T1,'.k')
	xlabel('GAWS (f)')
    ylabel('RAV2 (f)')
    
    
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
else
end
  
subplot(2,3,3), hold on

  Exist_Column = strcmp('sw_in_2',data.Properties.VariableNames); val = Exist_Column(Exist_Column==1); 

if isempty(val) == 0
    scatter(data.sw_in_2,data.sw_in_T1,'.k')

    mdl = fitlm(data.sw_in_2,data.sw_in_T1);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    bias = nanmean(data.sw_in_2-data.sw_in_T1);
    bias = sprintf('%.2f',bias);

    hText = text(0.02,0.92,['RMSE: ',num2str(rmse)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.86,['Bias: ',num2str(bias)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.78,['R^2: ',num2str(r2)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.72,['n: ',num2str(n)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    
    plot(data.sw_in_2,mdl.Fitted ,'r','LineWidth',1.4)
    plot([0 1000],[0 1000],'--k','LineWidth',1.4);
    xlim([min(data.sw_in_T1)-50 max(data.sw_in_T1)]+50);
    ylim([min(data.sw_in_T1)-50 max(data.sw_in_T1)]+50);
    grid on
    %scatter(TM.sw_in_2,TM.sw_in_T1,'.k')
    xlabel('GAWS (SW_i)')
    ylabel('RAV2 (SW_i)')
    
    
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
else
end
  
subplot(2,3,4), hold on

  Exist_Column = strcmp('lw_in_2',data.Properties.VariableNames); val = Exist_Column(Exist_Column==1); 

if isempty(val) == 0
    scatter(data.lw_in_2,data.lw_in_T1,'.k')

    mdl = fitlm(data.lw_in_2,data.lw_in_T1);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    bias = nanmean(data.lw_in_2-data.lw_in_T1);
    bias = sprintf('%.2f',bias);

    hText = text(0.02,0.92,['RMSE: ',num2str(rmse)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.86,['Bias: ',num2str(bias)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.78,['R^2: ',num2str(r2)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.72,['n: ',num2str(n)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    
    plot(data.lw_in_2,mdl.Fitted ,'r','LineWidth',1.4)
    plot([100 400],[0 400],'--k','LineWidth',1.4);
    xlim([min(data.lw_in_T1)-25 max(data.lw_in_T1)]+25);
    ylim([min(data.lw_in_T1)-25 max(data.lw_in_T1)]+25);
    grid on
    %scatter(TM.lw_in_2,TM.lw_in_T1,'.k')
    xlabel('GAWS (LW_i)')
    ylabel('RAV2 (LW_i)')
    
    
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
else
end
  
subplot(2,3,5), hold on
  Exist_Column = strcmp('rh_2',data.Properties.VariableNames); val = Exist_Column(Exist_Column==1); 

if isempty(val) == 0
    scatter(data.rh_2,data.rh_T1,'.k')

    mdl = fitlm(data.rh_2,data.rh_T1);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    bias = nanmean(data.rh_2-data.rh_T1);
    bias = sprintf('%.2f',bias);

    hText = text(0.02,0.92,['RMSE: ',num2str(rmse)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.86,['Bias: ',num2str(bias)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.78,['R^2: ',num2str(r2)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.72,['n: ',num2str(n)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    
    plot(data.rh_2,mdl.Fitted ,'r','LineWidth',1.4)
    plot([0 100],[0 100],'--k','LineWidth',1.4);
    xlim([40 100]);
    ylim([40 100]);
    grid on
    %scatter(TM.rh_2,TM.rh_T1,'.k')
    xlabel('GAWS (rh)')
    ylabel('RAV2 (rh)')
    
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
else
end

  set(gcf, 'Color', 'w');
  cd(img_dir)
  export_fig(filename, '-png'); 