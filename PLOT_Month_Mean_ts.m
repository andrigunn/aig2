function PLOT_Month_Mean_ts(T,img_dir,printer,img_name,months_remove)
%% Plot melt season averages for all glaciers
% close all
% T = TMM;
% months_remove = [1,2,3,4,10,11,12]
% Filter months from stack
for i = 1:length(months_remove)
   
    ix = find([T.Month] == months_remove(i))
    T(ix,:)=[];
    
end

%%
h = figure('Position', [50, 100, 900, 1200]), hold on
sgtitle(['Month Mean Average Albedo (',img_name,')'])
%
C = [0.75 0.75 0.75];
lw = 1.2;

subplot(4,3,1)
plot(T.dn,T.Vatnajokull,'k','LineWidth',lw)
%xlabel('Year'), 
ylabel('Melt Season Average Albedo'), title('Vatnajökull')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
set(gca,'xticklabel',{[]})
 
subplot(4,3,2)
plot(T.dn,T.Hofsjokull,'k','LineWidth',lw)
%xlabel('Year'), ylabel('Melt Season Average Albedo'), 
title('Hofsjökull')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
set(gca,'xticklabel',{[]})

subplot(4,3,3)
plot(T.dn,T.Langjokull,'k','LineWidth',lw)
%xlabel('Year'), ylabel('Melt Season Average Albedo'), 
title('Langjökull')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
set(gca,'xticklabel',{[]})

subplot(4,3,4)
plot(T.dn,T.Myrdalsjokull,'k','LineWidth',lw)
%xlabel('Year'), 
ylabel('Melt Season Average Albedo'), title('Mýrdalsjökull')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
set(gca,'xticklabel',{[]})
 
subplot(4,3,5)
plot(T.dn,T.Eyjafjallajokull,'k','LineWidth',lw)
%xlabel('Year'), ylabel('Melt Season Average Albedo'), 
title('Eyjafjallajökull')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
set(gca,'xticklabel',{[]})

subplot(4,3,6)
plot(T.dn,T.Drangajokull,'k','LineWidth',lw)
%xlabel('Year')
%ylabel('Melt Season Average Albedo'), 
title('Drangajökull')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
set(gca,'xticklabel',{[]})

subplot(4,3,7), hold on
plot(T.dn,T.Eiriksjokull,'k','LineWidth',lw)
plot(T.dn,T.Torfajokull,'--k','LineWidth',lw)
plot(T.dn,T.Tungnafellsjokull	,'r','LineWidth',lw)
ylabel('Melt Season Average Albedo')
xlabel('Year')
title('EiJ ToJ TuJ')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);

subplot(4,3,8), hold on
plot(T.dn,T.Thrandarjokull	,'k','LineWidth',lw)
plot(T.dn,T.Hofsjokull_Eystri	,'--k','LineWidth',lw)
plot(T.dn,T.Snaefell	,'r','LineWidth',lw)
xlabel('Year')
%ylabel('Melt Season Average Albedo'), 
title('ÞrJ HofsjE Snæ')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);

subplot(4,3,9), hold on
plot(T.dn,T.N1,'Color',C,'LineWidth',lw)
plot(T.dn,T.N2,'Color',C,'LineWidth',lw)
plot(T.dn,T.N3,'Color',C,'LineWidth',lw)
plot(T.dn,T.N4,'Color',C,'LineWidth',lw)
plot(T.dn,T.N5,'Color',C,'LineWidth',lw)
plot(T.dn,T.N6,'Color',C,'LineWidth',lw)
plot(T.dn,T.N7,'Color',C,'LineWidth',lw)
plot(T.dn,T.N8,'Color',C,'LineWidth',lw)
plot(T.dn,T.N9,'Color',C,'LineWidth',lw)
plot(T.dn,T.N10,'Color',C,'LineWidth',lw)
plot(T.dn,T.N11,'Color',C,'LineWidth',lw)
plot(T.dn,T.N12,'Color',C,'LineWidth',lw)
plot(T.dn,T.N13,'Color',C,'LineWidth',lw)
plot(T.dn,T.N14,'Color',C,'LineWidth',lw)
plot(T.dn,T.N15,'Color',C,'LineWidth',lw)
plot(T.dn,T.N16,'Color',C,'LineWidth',lw)
plot(T.dn,T.N17,'Color',C,'LineWidth',lw)
plot(T.dn,T.N18,'Color',C,'LineWidth',lw)
plot(T.dn,T.N19,'Color',C,'LineWidth',lw)
plot(T.dn,T.N20,'Color',C,'LineWidth',lw)
plot(T.dn,T.N21,'Color',C,'LineWidth',lw)
plot(T.dn,T.N22,'Color',C,'LineWidth',lw)

Nmean = (T.N1+T.N2+T.N3+T.N4+T.N5+T.N6+T.N7+T.N8+T.N9+T.N10+T.N11+T.N12+T.N13+T.N14+T.N15+T.N16+T.N17+T.N18+T.N19+T.N20+T.N21+T.N22)/22;
plot(T.dn,Nmean,'k','LineWidth',lw)
xlabel('Year')
%ylabel('Melt Season Average Albedo'), 
title('Norðurlandsjöklar')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);

        
if printer == 1
   export_fig([img_dir,'/MM_ts_',img_name], '-pdf')
else 
end
