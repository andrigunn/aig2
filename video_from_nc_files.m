% Make a video from nc data

cd('C:\Users\andrigun\Dropbox\01 - Icelandic Snow Observatory - ISO\aig\02_data\temp')
nc_data_dir = '\\lvthrvinnsla\data\aig\data\mod_merge_median'
[nc] = make_data_structure_nc(nc_data_dir)
%%
subnc = nc(end,:)
ncvar = '11day_median'
%parfor i = 1:length(subnc)
close all
i = 1
% READ HDF FILE
data = ncread(subnc(i).name, ncvar);
data = data.*geo.ins.glaciers;
FILE_NAME_short = datestr(subnc(i).daten);
%data(data==0)=nan;

    caxislim = [10 90];
    cbar_title = ncvar;
%     latlimit = [63.35 66.58];
%     lonlimit = [-24.6 -13.4];

    %latlimit = [63.35 66.58; 63.85 65; 63.4 63.85; 66.05 66.25; 65.31 66.25];
    %lonlimit = [-24.6 -13.4; -21 -15.0; -19.9 -18.7; -22.47 -22.01; -19.32 -18.17];
    
% VA LA HO
    latlimit = [63.85 65; ];
    lonlimit = [-21 -15.0;];
% Ísland    
    latlimit = [63.35 66.58; ];
    lonlimit = [-24.6 -13.;];
    
% MYR EYJ
    latlimit = [63.4 63.85; ];
    lonlimit = [-19.9 -18.7;];
        
% DRA
    latlimit = [66.05 66.25 ];
    lonlimit = [-22.47 -22.01];
    
% Norðurlang
    latlimit = [65.31 66.25];
    lonlimit = [-19.32 -18.17];
% Vatna    
    latlimit = [63.85 64.85];
    lonlimit = [-18.4 -15.0];
    
        
f = figure( 'visible','on','Position', [50, 100, 900, 600]);
    axesm('MapProjection','mercator','MapLatLimit',latlimit,'MapLonLimit',lonlimit);
    hold on 
    lw = 0.1;
        
            h = pcolorm(geo.lat,geo.lon,data);
            shading flat;
            %fillm([geo.shp.isl(4524).Y],[geo.shp.isl(4524).X], 'FaceColor',[224/255 224/255 224/255],'linewidth',lw);
            %fillm([geo.shp.va.Y],[geo.shp.va.X], 'w','linewidth',lw);
            %fillm([geo.shp.ho.Y],[geo.shp.ho.X], 'w','linewidth',lw);
            %fillm([geo.shp.la.Y],[geo.shp.la.X], 'w','linewidth',lw);
            uistack(h,'top');
            plotm([geo.shp.isl(4524).Y],[geo.shp.isl(4524).X], 'k','linewidth',lw);
            plotm([geo.shp.glaciers.Y],[geo.shp.glaciers.X], 'k','linewidth',lw);
                       
            caxis(caxislim);
            hb=colorbar;
            %cmap = cbrewer('seq','Blues',100);
            cmap = flipud(parula);
            colormap(cmap);
            ylabel(hb, cbar_title, 'Interpreter', 'none');
            set(hb,'FontSize',12);
            tightmap;
            box off;
            ax = gca;
            ax.Visible = 'off';
            set(gcf,'color','w');
            hText = text(0.01,1.0,[FILE_NAME_short,' Albedo // NC11'],'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom', 'Interpreter', 'none','FontSize',16);
            export_fig(['C:\Users\andrigun\Dropbox\01 - Icelandic Snow Observatory - ISO\aig\04_img\albedo_ts_gif\Albedo_',datestr(FILE_NAME_short,'yyyymmdd')],'-png')
            export_fig(['C:\Users\andrigun\Dropbox\01 - Icelandic Snow Observatory - ISO\aig\04_img\albedo_ts_gif\Albedo_',datestr(FILE_NAME_short,'yyyymmdd')],'-pdf')

%end

