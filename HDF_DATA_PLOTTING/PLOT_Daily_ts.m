function PLOT_Daily_ts(time, data,img_dir,img_name,printer)
%%
% data = DMM.Vatnajokull;
% time = DMM(:,1:5);
uqM = unique(time.Month)
uqY = unique(time.Year)

figure, hold on
for i = 1:length(uqY)
    
    ix = find(time.Year==uqY(i) & (time.Month == 4 | time.Month == 5| time.Month == 6| time.Month == 7| time.Month == 8| time.Month == 9))
    
    plot(time.dn(ix),data(ix),'DisplayName',num2str(uqY(i)))
        
end

legend('Location','northeastoutside')
    grid on
    datetick('x','mm.yyyy')
    title(['Daily Mean Average Albedo (',img_name,')']);
    ylabel('Albedo');
    xlabel('Time');
    set(gcf,'color','w');
    
    box on
    set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);

%%
if printer == 1
   export_fig([img_dir,'/DM_ts_',img_name], '-pdf')
else 
end