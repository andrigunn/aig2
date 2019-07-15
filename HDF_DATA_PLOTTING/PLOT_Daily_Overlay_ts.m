function PLOT_Daily_Overlay_ts(data,time,img_dir,printer,img_name,years2plot)
%% Plot daily overlayed plots
% close all
% data = DMM.Vatnajokull;
% time = DMM(:,1:5);
% img_name = 'Vatnajokull'
% years2plot = [2004 2010 2011 2015]
%% Data prep to overlayed format
% Make empty matrix for data
% Find number of months and years in data
% uqM = unique(time.Month);
uqY = unique(time.Year);

t1 = datetime(2016,1,1,0,0,0);
t2 = datetime(2016,12,31,0,0,0);
t = t1:t2;

D.Time = datevec(t);
D.Time(:,4:6) = [];
D.daten = datenum(D.Time);

for i = 1:length(uqY);
    
    ix = find(time.Year==uqY(i));
    Tsub = [time(ix,:)];
    Tsub.data =  [data(ix,:)];
    Tsub.fTime = datenum([zeros(length(Tsub.Month),1)+2016,Tsub.Month,Tsub.Day]);
    
    DSYear(i) = uqY(i);
    
    for ii = 1:length(Tsub.fTime);
        
        ixx = find(D.daten(ii) == Tsub.fTime);
        
        if isempty(ixx) == 0;
            DS(ii,i) = Tsub.data(ixx);
        else
            DS(ii,i) = nan;
        end
    end
end
DS(DS<5)=nan;
%%
clear D.Year D.Data D.Dmax;
D.Year = DSYear;
D.Data = DS;
D.Dmax = max(D.Data,[],2);
D.Dmean = nanmean(D.Data,2);
D.Dmedian = nanmedian(D.Data,2);
D.Dmin = min(D.Data,[],2);
D.Dstd = std(D.Data,[],2);
D.Quan = quantile(D.Data,[0.25 0.5 0.75],2);

%%
close all
h = figure('Position', [50, 100, 450, 450]), hold on;
title(['Daily Mean Average Albedo (',img_name,')']);

bcolor = [192/255 192/255 192/255];

for i= 1:length(D.Year);
   h(1) = plot(D.daten, D.Data(:,i),'Color',bcolor,'DisplayName','All data');
end
%
if isempty(years2plot) == 0;
    cmap = cbrewer('qual','Set1',length(years2plot));
    for ii= 1:length(years2plot);
        
        find(years2plot(ii)==D.Year);
        
        h(ii) = plot(D.daten, D.Data(:,ii),'Color',cmap(ii,:),'LineWidth',1.5,'DisplayName',num2str(years2plot(ii)));
    end
else
end

    h(ii+1) = plot(D.daten, D.Dmedian,'k','LineWidth',1.6,'DisplayName','Median');
        
    datetick('x','mmm');
    grid on;
    xlim([datenum('01-Apr-2016','dd-mmm-yyyy'),datenum('01-Oct-2016','dd-mmm-yyyy')]);
    
    ylabel('Albedo');
    xlabel('Month of year');
    legend(h(1:end),'Location','northeastoutside' );
    set(gcf,'color','w');
    xtickangle(45);
    
    box on
    set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
%%
if printer == 1
   export_fig([img_dir,'/DM_overlay_ts_',img_name], '-pdf')
else 
end
