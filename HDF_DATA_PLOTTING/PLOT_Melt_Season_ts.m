function PLOT_Melt_Season_ts(T,img_dir,printer,img_name)
% Plot melt season averages for all glaciers
close all
%T = TMS;
h = figure('Position', [50, 100, 900, 1200]), hold on
sgtitle(['Melt Season Average Albedo (',img_name,')'])

C = [0.75 0.75 0.75];
lw = 1.2;

subplot(4,3,1)
plot(T.Year,T.Vatnajokull,'k','LineWidth',lw)
%xlabel('Year'), 
ylabel('Melt Season Average Albedo'), title('Vatnajökull')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
set(gca,'xticklabel',{[]})
 
subplot(4,3,2)
plot(T.Year,T.Hofsjokull,'k','LineWidth',lw)
%xlabel('Year'), ylabel('Melt Season Average Albedo'), 
title('Hofsjökull')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
set(gca,'xticklabel',{[]})

subplot(4,3,3)
plot(T.Year,T.Langjokull,'k','LineWidth',lw)
%xlabel('Year'), ylabel('Melt Season Average Albedo'), 
title('Langjökull')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
set(gca,'xticklabel',{[]})

subplot(4,3,4)
plot(T.Year,T.Myrdalsjokull,'k','LineWidth',lw)
%xlabel('Year'), 
ylabel('Melt Season Average Albedo'), title('Mýrdalsjökull')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
set(gca,'xticklabel',{[]})
 
subplot(4,3,5)
plot(T.Year,T.Eyjafjallajokull,'k','LineWidth',lw)
%xlabel('Year'), ylabel('Melt Season Average Albedo'), 
title('Eyjafjallajökull')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
set(gca,'xticklabel',{[]})

subplot(4,3,6)
plot(T.Year,T.Drangajokull,'k','LineWidth',lw)
%xlabel('Year')
%ylabel('Melt Season Average Albedo'), 
title('Drangajökull')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);
set(gca,'xticklabel',{[]})

subplot(4,3,7), hold on
plot(T.Year,T.Eiriksjokull,'k','LineWidth',lw)
plot(T.Year,T.Torfajokull,'--k','LineWidth',lw)
plot(T.Year,T.Tungnafellsjokull	,'r','LineWidth',lw)
ylabel('Melt Season Average Albedo')
xlabel('Year')
title('EiJ ToJ TuJ')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);

subplot(4,3,8), hold on
plot(T.Year,T.Thrandarjokull	,'k','LineWidth',lw)
plot(T.Year,T.Hofsjokull_Eystri	,'--k','LineWidth',lw)
plot(T.Year,T.Snaefell	,'r','LineWidth',lw)
xlabel('Year')
%ylabel('Melt Season Average Albedo'), 
title('ÞrJ HofsjE Snæ')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);

subplot(4,3,9), hold on
plot(T.Year,T.N1,'Color',C,'LineWidth',lw)
plot(T.Year,T.N2,'Color',C,'LineWidth',lw)
plot(T.Year,T.N3,'Color',C,'LineWidth',lw)
plot(T.Year,T.N4,'Color',C,'LineWidth',lw)
plot(T.Year,T.N5,'Color',C,'LineWidth',lw)
plot(T.Year,T.N6,'Color',C,'LineWidth',lw)
plot(T.Year,T.N7,'Color',C,'LineWidth',lw)
plot(T.Year,T.N8,'Color',C,'LineWidth',lw)
plot(T.Year,T.N9,'Color',C,'LineWidth',lw)
plot(T.Year,T.N10,'Color',C,'LineWidth',lw)
plot(T.Year,T.N11,'Color',C,'LineWidth',lw)
plot(T.Year,T.N12,'Color',C,'LineWidth',lw)
plot(T.Year,T.N13,'Color',C,'LineWidth',lw)
plot(T.Year,T.N14,'Color',C,'LineWidth',lw)
plot(T.Year,T.N15,'Color',C,'LineWidth',lw)
plot(T.Year,T.N16,'Color',C,'LineWidth',lw)
plot(T.Year,T.N17,'Color',C,'LineWidth',lw)
plot(T.Year,T.N18,'Color',C,'LineWidth',lw)
plot(T.Year,T.N19,'Color',C,'LineWidth',lw)
plot(T.Year,T.N20,'Color',C,'LineWidth',lw)
plot(T.Year,T.N21,'Color',C,'LineWidth',lw)
plot(T.Year,T.N22,'Color',C,'LineWidth',lw)

Nmean = (T.N1+T.N2+T.N3+T.N4+T.N5+T.N6+T.N7+T.N8+T.N9+T.N10+T.N11+T.N12+T.N13+T.N14+T.N15+T.N16+T.N17+T.N18+T.N19+T.N20+T.N21+T.N22)/22;
plot(T.Year,Nmean,'k','LineWidth',lw)
xlabel('Year')
%ylabel('Melt Season Average Albedo'), 
title('Norðurlandsjöklar')
set(gcf,'color','w');
xtickangle(45);
box on
set(gca,'Box','off','TickDir','out','TickLength',[.02 .02],'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','XColor',[.3 .3 .3],'YColor',[.3 .3 .3],'LineWidth',1);

        
if printer == 1
   export_fig([img_dir,'\MSM_ts_',img_name], '-pdf')
else 
end
