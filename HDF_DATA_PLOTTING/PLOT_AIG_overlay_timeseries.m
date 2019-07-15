function PLOT_AIG_overlay_timeseries(s, fig_title, ymin, ymax)

%% SETTINGS
% Set Colors for plotting
c_hist =  [0.5 0.5 0.5];
c_25_75 = [0 0.5 0];
c_10_25 = [1 0 0];
c_75_90 = [0.9290, 0.6940, 0.1250];
p_all_years = 1
p_years2plot = 1
p_mean = 1
%fig_title= 'Vatnajökull'
% NOTE: Years to plot are HYDROLOGICAL YEARS not CALANDER YEARS
years2plot = [2003 2009 2010 2014 2018]
p_startTime = datetime(2019,04,01);
p_endTime = datetime(2019,9,31);
%%
figure('Position', [50, 100, 400, 400]), hold on
xs = width(s.HIST_DM);

iplot = 1;
% Plot overlayed all years
if p_all_years == 1
    for i = 1:xs;
        h(iplot) = plot(s.HIST_DM.Time,s.HIST_DM{:,i},'Color',c_hist,'Displayname','All years');
    end
    iplot = 1;
else end

if p_mean == 1
    iplot = iplot+1;
        h(iplot) = plot(s.STATS_DM.Time,s.STATS_DM.Median,'Color','k','Displayname','Median','Linewidth',2);
    
else end

if p_years2plot == 1
    cmap = cbrewer('qual','Set1',length(years2plot))
    for i = 1:length(years2plot)
        iplot=iplot+1;
        ix = find([s.years] == years2plot(i))
        h(iplot) = plot(s.HIST_DM.Time,s.HIST_DM{:,ix},'Color',cmap(i,:),'Displayname',num2str(years2plot(i)+1),'Linewidth',1.2);
    end    
else end
    
    legend([h(1) h(2:end)],'Position',[0.145833330567678 0.132833326991399 0.243500002765655 0.283500006341934])
    
    grid on

    %xlim([min(data.t_T1)-5 max(data.t_T1)]+5);
    ylim([ymin ymax]);
    grid on
    %scatter(TM.t_2,TM.t_T1,'.k')
    %xlabel('GAWS (t)')
    %ylabel('RAV2 (t)')
    ax = gca;
    ax.XAxis.Limits = [p_startTime p_endTime];  
    title(fig_title)
    
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
  
  set(gcf, 'Color', 'w');