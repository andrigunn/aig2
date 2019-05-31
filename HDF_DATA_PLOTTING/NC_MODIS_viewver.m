function NC_MODIS_viewver(FILE_NAME,ncvar,geo,FILE_NAME_short)   

%% TESTING
FILE_NAME = '/run/media/user/brunnur/aig/data/mod_merge_MeltM/MOD_Month_Mean_MSM_2004_MJJAS.nc'
ncdisp(FILE_NAME)
ncvar='Melt_Season_Mean';
FILE_NAME_short = 'MOD_Month_Mean_MSM_2004_MJJAS';

%% READ HDF FILE
data = ncread(FILE_NAME, ncvar);
data = data.*geo.ins.glaciers;
%data(data==0)=nan;
%%
    caxislim = [10 90];
    cbar_title = ncvar;
    latlimit = [63.35 66.58];
    lonlimit = [-24.6 -13.4];
        
f = figure( 'visible','on','Position', [50, 100, 900, 600]);
    axesm('MapProjection','mercator','MapLatLimit',latlimit,'MapLonLimit',lonlimit);
    hold on 
    lw = 0.1;
        
            h = pcolorm(geo.lat,geo.lon,data);
            shading flat;
            fillm([geo.shp.isl(4524).Y],[geo.shp.isl(4524).X], 'FaceColor',[224/255 224/255 224/255],'linewidth',lw);
            fillm([geo.shp.va.Y],[geo.shp.va.X], 'w','linewidth',lw);
            fillm([geo.shp.ho.Y],[geo.shp.ho.X], 'w','linewidth',lw);
            fillm([geo.shp.la.Y],[geo.shp.la.X], 'w','linewidth',lw);
            uistack(h,'top');
            plotm([geo.shp.isl(4524).Y],[geo.shp.isl(4524).X], 'k','linewidth',lw);
            plotm([geo.shp.va.Y],[geo.shp.va.X], 'k','linewidth',lw);
            plotm([geo.shp.ho.Y],[geo.shp.ho.X], 'k','linewidth',lw);
            plotm([geo.shp.la.Y],[geo.shp.la.X], 'k','linewidth',lw);
            caxis(caxislim);
            hb=colorbar;
            cmap = cbrewer('seq','Blues',100);
            cmap = flipud(cmap);
            colormap(cmap);
            ylabel(hb, cbar_title, 'Interpreter', 'none');
            set(hb,'FontSize',12);
            tightmap;
            box off;
            ax = gca;
            ax.Visible = 'off';
            hText = text(0.01,1.0,FILE_NAME_short,'Units','normalized','HorizontalAlignment','left','VerticalAlignment','bottom', 'Interpreter', 'none');
            



