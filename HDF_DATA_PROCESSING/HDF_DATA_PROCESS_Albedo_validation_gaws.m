function validation_gaws_albedo(data)

%% Load that needs to happen
clear all, clc, close all
    cd('\\lvthrvinnsla\data\aig\data\GAWS_MODS_TS_extraction')
    img_dir = '\\lvthrvinnsla\data\aig\img\gaws_val';
    MOD     = load('GAWS_MOD.mat');
    MYD     = load('GAWS_MYD.mat');
    MCD43   = load('GAWS_MCD43.mat');
    filename = 'F:\Þróunarsvið\Rannsóknir\Jöklarannsóknir\12_Veðurstöðvar\GAWS_overview\temp_backups\load_backup_07062019_1147.mat';
    load(filename);
%%
    dataset = 'GAWS_Median11.mat';
    NC11    = load(dataset);
%%    
         data = B13;
         site = 'B13';

TMOD = synchronize(MOD.TT,data.DM);
ix = find([TMOD.Month] > 4 & [TMOD.Month] < 11);
TMOD = TMOD(ix,:);
TMODM = retime(TMOD,'monthly','mean');

TMYD = synchronize(MYD.TT,data.DM);
ix = find([TMYD.Month] > 4 & [TMYD.Month] < 11);
TMYD = TMYD(ix,:);
TMYDM = retime(TMYD,'monthly','mean');

TMCD = synchronize(MCD43.TT,data.DM);
ix = find([TMCD.Month] > 4 & [TMCD.Month] < 11);
TMCD = TMCD(ix,:);
TMCDM = retime(TMCD,'monthly','mean');

TN11 = synchronize(NC11.TT,data.DM);
ix = find([TN11.Month] > 4 & [TN11.Month] < 11);
TN11 = TN11(ix,:);
TN11M = retime(TN11,'monthly','mean');
% Filters
    TMOD.B13(TMOD.B13>92)=nan;
    TMYD.B13(TMYD.B13>92)=nan;
    TMCD.B13(TMCD.B13>92)=nan;

close all
figure('Position', [50, 100, 900, 1200]),hold on
sgtitle(string(site)) ;

subplot(4,3,1), hold on;
f1 = scatter(TMOD.B13,TMOD.albedo_24hr_mav,'.k');

    mdl = fitlm(TMOD.B13,TMOD.albedo_24hr_mav);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    hText = text(0.01,1.0,['RMSE: ',num2str(rmse),'   R^2: ',num2str(r2),'   n: ',num2str(n)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom');

    plot([0,100],[0,100],'--k');
    xlim([0 100]);
    ylim([0 100]);
    grid on
    xlabel('MOD10A1','FontSize',12);
        
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

subplot(4,3,2), hold on
f1 = scatter(TMYD.B13,TMYD.albedo_24hr_mav,'.k');

    mdl = fitlm(TMYD.B13,TMYD.albedo_24hr_mav);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    hText = text(0.01,1.0,['RMSE: ',num2str(rmse),'   R^2: ',num2str(r2),'   n: ',num2str(n)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom');

    plot([0,100],[0,100],'--k');
    xlim([0 100]);
    ylim([0 100]);
    grid on
    xlabel('MYD10A1','FontSize',12);
        
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

subplot(4,3,3), hold on;
f1 = scatter(TMCD.B13*100,TMCD.albedo_24hr_mav,'.k')
mdl = fitlm(TMCD.B13*100,TMCD.albedo_24hr_mav);
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    hText = text(0.01,1.0,['RMSE: ',num2str(rmse),'   R^2: ',num2str(r2),'   n: ',num2str(n)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom');

    plot([0,100],[0,100],'--k');
    xlim([0 100]);
    ylim([0 100]);
    grid on
    xlabel('MCD43A3','FontSize',12);
        
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


      for i = 1:9
        
          cd('\\lvthrvinnsla\data\aig\data\GAWS_MODS_TS_extraction');
        
        if i == 1
                dataset = 'GAWS_MOD_Center_Date.mat';
                NC11    = load(dataset);
            elseif i == 2
                dataset = 'GAWS_Median11.mat';
                NC11    = load(dataset);
            elseif i == 3
                dataset = 'GAWS_7d_merge.mat';
                NC11    = load(dataset);
            elseif i == 4
                dataset = 'GAWS_9d_merge.mat';
                NC11    = load(dataset);
            elseif i == 5
                dataset = 'GAWS_11d_merge.mat';
                NC11    = load(dataset);
            elseif i == 6
                dataset = 'GAWS_11d_merge_ncdata_filter.mat';
                NC11    = load(dataset);
            elseif i == 7
                dataset = 'GAWS_11d_merge_ncdata_smoothn.mat';
                NC11    = load(dataset);
            elseif i == 8
                dataset = 'GAWS_11d_merge_ncmasked.mat';
                NC11    = load(dataset);
            elseif i == 9
                dataset = 'GAWS_11d_merge_gaussfilt_05.mat';
                NC11    = load(dataset);
            else
        end
        
            TMOD = synchronize(MOD.TT,data.DM);
            ix = find([TMOD.Month] > 4 & [TMOD.Month] < 11);
            TMOD = TMOD(ix,:);
            TMODM = retime(TMOD,'monthly','mean');

            TMYD = synchronize(MYD.TT,data.DM);
            ix = find([TMYD.Month] > 4 & [TMYD.Month] < 11);
            TMYD = TMYD(ix,:);
            TMYDM = retime(TMYD,'monthly','mean');

            TMCD = synchronize(MCD43.TT,data.DM);
            ix = find([TMCD.Month] > 4 & [TMCD.Month] < 11);
            TMCD = TMCD(ix,:);
            TMCDM = retime(TMCD,'monthly','mean');

            TN11 = synchronize(NC11.TT,data.DM);
            ix = find([TN11.Month] > 4 & [TN11.Month] < 11);
            TN11 = TN11(ix,:);
            TN11M = retime(TN11,'monthly','mean');

            TMOD.B13(TMOD.B13>92)=nan;
            TMYD.B13(TMYD.B13>92)=nan;
            TMCD.B13(TMCD.B13>92)=nan;
  
  
            subplot(4,3,i+3), hold on;
            TN11.B13(TN11.B13>90)=nan;
            TN11.B13(TN11.B13<10)=nan;
            
            f1 = scatter(TN11.B13,TN11.albedo_24hr_mav,'.k');
            mdl = fitlm(TN11.B13,TN11.albedo_24hr_mav);
                rmse = sprintf('%.2f',mdl.RMSE);
                r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
                n = sprintf('%.0f',mdl.NumObservations);
                hText = text(0.01,1.0,['RMSE: ',num2str(rmse),'   R^2: ',num2str(r2),'   n: ',num2str(n)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom');

                plot([0,100],[0,100],'--k');
                xlim([0 100]);
                ylim([0 100]);
                grid on;
                xname = dataset(6:end-4);
                xlabel(xname,'FontSize',12,'Interpreter','none');

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
                set(gcf,'color','w');
  
      end
        export_fig(['C:\Users\andrigun\Dropbox\01 - Icelandic Snow Observatory - ISO\aig\04_img\gaws_val','\',site],'-pdf');
        

  
%% Time series validation

  