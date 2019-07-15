%% RAV2_GAWS_make_TM_Stacks_paramter_montly_val
% Function makes stacks of all gaws sites used in a single marix. Plots
% temperature and sw_in as a function of month for all sites. 
img_dir = 'C:\Users\andrigun\Dropbox\01 - Icelandic Snow Observatory - ISO\aig\04_img\rav_gaws_val\per_parameter';
disp('Making a TM stack for selected GAWS')
clc
D = [];
for i = 1:3

    if i == 1
        data_r2 = rav.B10;
        data_gaws = gaws.B10;
    elseif i == 2
        data_r2 = rav.B13;
        data_gaws = gaws.B13;
    elseif i == 3
        data_r2 = rav.B16;
        data_gaws = gaws.B16;
    elseif i == 4
        data_r2 = rav.T01;
        data_gaws = gaws.T01;
    elseif i == 5
        data_r2 = rav.T03;
        data_gaws = gaws.T06;
    elseif i == 6
        data_r2 = rav.T06;
        data_gaws = gaws.T06;
    elseif i == 7
        data_r2 = rav.HSA09;
        data_gaws = gaws.HNA09;
    elseif i == 8
        data_r2 = rav.HSA13;
        data_gaws = gaws.HNA13;
    elseif i == 9
        data_r2 = rav.L01;
        data_gaws = gaws.L01;
    elseif i == 10
        data_r2 = rav.L05;
        data_gaws = gaws.L05;
    elseif i == 11
        data_r2 = rav.Br01;
        data_gaws = gaws.Br01;
    elseif i == 12
        data_r2 = rav.Br04;
        data_gaws = gaws.Br04;
    elseif i == 13
        data_r2 = rav.BR7;
        data_gaws = gaws.Br07;
    elseif i == 14
        data_r2 = rav.Hof01;
        data_gaws = gaws.Hoff;
    elseif i == 15
        data_r2 = rav.HOSP;
        data_gaws = gaws.Hosp;
    elseif i == 16
        data_r2 = rav.MyrA;
        data_gaws = gaws.MyrA;
    elseif i == 17
        data_r2 = rav.K06;
        data_gaws = gaws.Bard;
    elseif i == 18
        data_r2 = rav.K02;
        data_gaws = gaws.Kokv;
    elseif i == 19
        data_r2 = rav.GvTh;
        data_gaws = gaws.Gv_vh;
    end
    
    T1 = table2timetable(data_r2,'RowTimes',[data_r2.Date]);
    TT = synchronize(T1,data_gaws.HM);
    TT.daten = datevec(datenum(TT.Date));
    TT = retime(TT,'daily','mean');
    TM = retime(TT,'monthly','mean');

    TM.daten = datenum(TM.Date);
    TM.datev = datevec(TM.Date);
    
    ik = length(TM.daten);
    sname = ones(ik,1)*i;

    F = [TM.daten, TM.datev(:,1), TM.datev(:,2),TM.t_T1,TM.t_2,TM.sw_in_T1,TM.sw_in_2,sname];
    D = [D;F];
    
end
D = array2table(D,'VariableNames',{'daten','year','month','t_rav2','t_gaws','sw_in_rav2','sw_in_gaws','SiteNumber'});
D.bias_t = D.t_rav2-D.t_gaws
D.bias_sw_in = D.sw_in_rav2-D.sw_in_gaws;
%%
ix = find([D.bias_t] <-3)
D(ix,:) = [];

ix = find([D.bias_t] >3)
D(ix,:) = [];

ix = find([D.bias_sw_in] <-30)
D(ix,:) = [];

ix = find([D.bias_sw_in] >30)
D(ix,:) = [];


disp('Stack Made')
%% Plot variables for each month
%Temperature
close all, clc
figure('Position', [50, 50, 1200, 600]), hold on
sgtitle('Month mean temperature')
for i = 4:11
    
    ix = find([D.month] == i);
    
    subplot(2,4,i-3),hold on
    
    scatter(D.t_gaws(ix),D.t_rav2(ix),'ok')
    title(num2str(i))
    
    b = num2str(D.SiteNumber(ix)); c = cellstr(b);
    dx = 0.1; dy = 0.1; % displacement so the text does not overlay the data points
    text(D.t_gaws(ix)+dx, D.t_rav2(ix)+dy, c);
    
    mdl = fitlm(D.t_gaws(ix),D.t_rav2(ix));
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    bias = nanmean(D.t_gaws(ix)-D.t_rav2(ix));
    bias = sprintf('%.2f',bias);

    hText = text(0.02,0.92,['RMSE: ',num2str(rmse)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.86,['Bias: ',num2str(bias)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.78,['R^2: ',num2str(r2)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.72,['n: ',num2str(n)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);

    plot(D.t_gaws(ix),mdl.Fitted ,'r','LineWidth',1.4)
    plot([-30 30],[-30 30],'--k','LineWidth',1.4);
    
    grid on
    %scatter(TM.t_2,TM.t_T1,'.k')
    xlabel('GAWS (t)')
    ylabel('RAV2 (t)')
    
    dmax = ceil(max(max(D.t_gaws(ix),D.t_rav2(ix))));
    dmin = floor(min(min(D.t_gaws(ix),D.t_rav2(ix))));
    if i == 4
        xlim([-10 0]);
        ylim([-10 0]);
    elseif i == 5
        xlim([-10 4 ]);
        ylim([-10 4]);
    elseif i == 6
        xlim([-5 6]);
        ylim([-5 6]);
    elseif i == 7
        xlim([-2 5]);
        ylim([-2 5]);
    elseif i == 8
        xlim([-2 4]);
        ylim([-2 4]);
    elseif i == 9
        xlim([-6 4]);
        ylim([-6 4]);
    elseif i == 10
        xlim([-10 3]);
        ylim([-10 3]);
    elseif i == 11
        xlim([-8 0]);
        ylim([-8 0]);
        else end
        
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
        
end

    filename = 'Month_mean_rav2_gaws_t_val'
    set(gcf, 'Color', 'w');
    cd(img_dir)
    export_fig(filename, '-pdf'); 
    
%% Short Wave in
close all, clc
figure('Position', [50, 50, 1200, 600]), hold on
sgtitle('Month mean Shortwave incoming radiation')
for i = 4:11
    
    ix = find([D.month] == i);
    
    subplot(2,4,i-3),hold on
    
    scatter(D.sw_in_gaws(ix),D.sw_in_rav2(ix),'ok')
    title(num2str(i))
    
    b = num2str(D.SiteNumber(ix)); c = cellstr(b);
    dx = 0.1; dy = 0.1; % displacement so the text does not overlay the data points
    text(D.sw_in_gaws(ix)+dx, D.sw_in_rav2(ix)+dy, c);
    
    mdl = fitlm(D.sw_in_gaws(ix),D.sw_in_rav2(ix));
    rmse = sprintf('%.2f',mdl.RMSE);
    r2 = sprintf('%.2f',mdl.Rsquared.Ordinary);
    n = sprintf('%.0f',mdl.NumObservations);
    bias = nanmean(D.sw_in_gaws(ix)-D.sw_in_rav2(ix));
    bias = sprintf('%.2f',bias);

    hText = text(0.02,0.92,['RMSE: ',num2str(rmse)],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.86,['Bias: ',num2str(bias)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.78,['R^2: ',num2str(r2)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);
    hText = text(0.02,0.72,['n: ',num2str(n)], 'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom','FontSize',8);

    plot(D.sw_in_gaws(ix),mdl.Fitted ,'r','LineWidth',1.4)
    plot([0 600],[0 600],'--k','LineWidth',1.4);
    
    grid on
    %scatter(TM.t_2,TM.t_T1,'.k')
    xlabel('GAWS (sw_i)')
    ylabel('RAV2 (sw_i)')
    
    
    if i == 4
        xlim([100 220]);
        ylim([100 220]);
    elseif i == 5
        xlim([200 350]);
        ylim([200 350]);
    elseif i == 6
        xlim([200 360]);
        ylim([200 360]);
    elseif i == 7
        xlim([150 300]);
        ylim([150 300]);
    elseif i == 8
        xlim([150 250]);
        ylim([150 250]);
    elseif i == 9
        xlim([70 160]);
        ylim([70 160]);
    elseif i == 10
        xlim([0 120]);
        ylim([0 120]);
    elseif i == 11
        xlim([0 25]);
        ylim([0 25]);
    else
    end
    
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
  

end
    filename = 'Month_mean_rav2_gaws_sw_in_val'
    set(gcf, 'Color', 'w');
    cd(img_dir)
    export_fig(filename, '-pdf'); 
  








