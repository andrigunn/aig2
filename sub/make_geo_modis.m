%% Make geo files for plotting MODIS data

function geo = make_geo_modis(geo_data_dir)
%% Data structure
% Structure:
%       lat, lon is Modis coordinate info
%       shp are shape files
%       masks are nans within areas and 1 out of areas
%       in are 1 within areas and nan out of areas
%       index are indecies for shapefiles 1 x mm
%% Updates
% 08032019 Added support for 1 km Modis data
%%
current_dir = pwd;
if ismac
    
elseif isunix
    cd(geo_data_dir);
    %% Lat and Lon data for MOD v2 h17
    load('geo_hv17.mat');
    geo.lat = lat;
    geo.lon = lon;
    
    load('geo_hv17_1km.mat');
    geo.lat_1km = lat_1km;
    geo.lon_1km = lon_1km;
    
    %% Load Lat and Lon for RAVII
    load('geo_rav2.mat');
    geo.lat_rav = XLAT;
    geo.lon_rav = XLONG;
    geo.dem.rav_z = HGT;
    %% SHP
    geo.shp.isl = shaperead('is50v_strandlina_flakar_ll');
    geo.shp.va = shaperead('VATNAJ__UTLINA');
    geo.shp.ho = shaperead('HOFSJ_UTLINA_nn');
    geo.shp.la = shaperead('LANGJ_UTLINA');
    geo.shp.glaciers = shaperead([geo_data_dir 'glacier_mask_larger_2km2.shp']);
        
    %% MASKS
    load('geoMasks.mat');
    load('masks/island.mat'); 
    t(t==1)=100; t(isnan(t))=0; t(t==100)=nan;
    geo.masks.glaciers = geoMasks.glaciers_isl;     % All galciers from LMI mask
    geo.masks.waterbodies = geoMasks.waterbodies_isl;        % All waterbodies from LMI mask
    geo.masks.island = t;



    %% DEM
    % Read DEM for ICELAND from GDAL output
    [Zdem,Rdem] = arcgridread([geo_data_dir,'isl_dem_500m_wgs.txt']);     % Read in DEM for ICELAND
    [Zasp,Rasp] = arcgridread([geo_data_dir,'isl_aspect_500m_wgs.txt']);  % Read in ASPECT for ICELAND
    % Map elevation to Lat and Lon from MODIS
    X = geo.lat(:);                                                     % Latitudes for MODIS              
    Y = geo.lon(:);                                                     % Longitudes for MODIS  
    Z = ltln2val(Zdem,Rdem,X,Y);                                    % Map elevation from isl_dem_500m_wgs   
    A = ltln2val(Zasp,Rasp,X,Y);                                    % Map elevation from isl_dem_500m_wgs   
    Zr = reshape(Z,2400,2400);
    Ar = reshape(A,2400,2400);
    
    geo.dem.z = Zr;
    geo.dem.a = Ar;
    %% INS
    shape_file_glacier_boundary = [geo_data_dir 'glacier_mask_larger_2km2.shp'];
    shp_file = shaperead(shape_file_glacier_boundary);                                                   % Read shapefile
    [~,index] = sortrows([shp_file.SHAPE_Area].'); shp_file = shp_file(index(end:-1:1)); clear index    % Sort files acc. to area

    load('ins/in_ice_glacier_shp_id.mat');
    in_gl_mask = in;
    in_gl_mask(in_gl_mask>0)= 1;
    geo.ins.glacier_in_id = in;
    geo.ins.glaciers = in_gl_mask;
    load('ins/isl.mat');
    geo.ins.island = double(in);
    geo.ins.island( geo.ins.island ==0)= nan; 
    %% INS
    
    %geo.ins.island = double(in);
    %load('masks\central_highlands.mat')
    %geo.masks.centrahighlands = in;
%     load('ins\isl.mat')
%     load('ins\oas.mat')
%     load('ins\oat.mat')
%     load('ins\oal.mat')
%     load('ins\oak.mat')
%     load('ins\oab.mat')
    
    %% INDEX
    %geo.index.island = find(geo.masks.island==1);
    
    %% ID names
    geo.name.ID_glacier = [37379,36825,16486,16488,16487,16315,37221,37244,37240,19871,37257,19983,...
      37099,37098,37131,37092,37185,37207,37231,36991,37220,37216,37199,37058,...
      37260,37198,37259,37258,37031,37255,37026,37134,36957,37157]';
    
    geo.name.Name_glacier = [{'Vatnaj�kull'},'Hofsj�kull','Langj�kull','M�rdalsj�kukll','Drangaj�kull','Eyjafjallaj�kull',...
        'Sn�fell','�r�ndarj�kull','Hofsj�kull Eystri','Eir�ksj�kul','Tungnafellsj�kull','Torfaj�kull']'    ;
    
%%
names = [{'N1'},'N2','N3','Eir�ksj�kull','N4','N5','N6','N7','�r�ndarj�kull','Hofsj�kull','N8','Drangaj�kull','Sn�fell','Langj�kull','N9','Vatnaj�kull','Hofsj�kull Eystri','N10','Eyjafjallaj�kull','N11','N12','N13','N14','Tungnafellsj�kull','N15','N16','Torfaj�kull','M�rdalsj�kull','N17','N18','N19','N20','N21','N22']';
for i = 1:34;
    geo.shp.glaciers(i).GName = names(i);
    
end
    
elseif ispc
    cd(geo_data_dir);
    %% Lat and Lon data for MOD v2 h17
    load('geo_hv17.mat');
    geo.lat = lat;
    geo.lon = lon;
    
    load('geo_hv17_1km.mat');
    geo.lat_1km = lat_1km;
    geo.lon_1km = lon_1km;
    
    %% Load Lat and Lon for RAVII
    load('geo_rav2.mat');
    geo.lat_rav = XLAT;
    geo.lon_rav = XLONG;
    geo.dem.rav_z = HGT;
    %% SHP
    geo.shp.isl = shaperead('is50v_strandlina_flakar_ll');
    geo.shp.va = shaperead('VATNAJ__UTLINA');
    geo.shp.ho = shaperead('HOFSJ_UTLINA_nn');
    geo.shp.la = shaperead('LANGJ_UTLINA');
    geo.shp.glaciers = shaperead([geo_data_dir 'glacier_mask_larger_2km2.shp']);
        
    %% MASKS
    load('geoMasks.mat');
    load('masks\island.mat'); 
    t(t==1)=100; t(isnan(t))=0; t(t==100)=nan;
    geo.masks.glaciers = geoMasks.glaciers_isl;     % All galciers from LMI mask
    geo.masks.waterbodies = geoMasks.waterbodies_isl;        % All waterbodies from LMI mask
    geo.masks.island = t;



    %% DEM
    % Read DEM for ICELAND from GDAL output
    [Zdem,Rdem] = arcgridread([geo_data_dir,'isl_dem_500m_wgs.txt']);     % Read in DEM for ICELAND
    [Zasp,Rasp] = arcgridread([geo_data_dir,'isl_aspect_500m_wgs.txt']);  % Read in ASPECT for ICELAND
    % Map elevation to Lat and Lon from MODIS
    X = geo.lat(:);                                                     % Latitudes for MODIS              
    Y = geo.lon(:);                                                     % Longitudes for MODIS  
    Z = ltln2val(Zdem,Rdem,X,Y);                                    % Map elevation from isl_dem_500m_wgs   
    A = ltln2val(Zasp,Rasp,X,Y);                                    % Map elevation from isl_dem_500m_wgs   
    Zr = reshape(Z,2400,2400);
    Ar = reshape(A,2400,2400);
    
    geo.dem.z = Zr;
    geo.dem.a = Ar;
    %% INS
    shape_file_glacier_boundary = [geo_data_dir 'glacier_mask_larger_2km2.shp'];
    shp_file = shaperead(shape_file_glacier_boundary);                                                   % Read shapefile
    [~,index] = sortrows([shp_file.SHAPE_Area].'); shp_file = shp_file(index(end:-1:1)); clear index    % Sort files acc. to area

    load('ins\in_ice_glacier_shp_id.mat');
    in_gl_mask = in;
    in_gl_mask(in_gl_mask>0)= 1;
    geo.ins.glacier_in_id = in;
    geo.ins.glaciers = in_gl_mask;
    load('ins\isl.mat');
    geo.ins.island = double(in);
    geo.ins.island( geo.ins.island ==0)= nan; 
    %% INS
    
    %geo.ins.island = double(in);
    %load('masks\central_highlands.mat')
    %geo.masks.centrahighlands = in;
%     load('ins\isl.mat')
%     load('ins\oas.mat')
%     load('ins\oat.mat')
%     load('ins\oal.mat')
%     load('ins\oak.mat')
%     load('ins\oab.mat')
    
    %% INDEX
    %geo.index.island = find(geo.masks.island==1);
    
    %% ID names
    geo.name.ID_glacier = [37379,36825,16486,16488,16487,16315,37221,37244,37240,19871,37257,19983,...
      37099,37098,37131,37092,37185,37207,37231,36991,37220,37216,37199,37058,...
      37260,37198,37259,37258,37031,37255,37026,37134,36957,37157]';
    
    geo.name.Name_glacier = [{'Vatnaj�kull'},'Hofsj�kull','Langj�kull','M�rdalsj�kukll','Drangaj�kull','Eyjafjallaj�kull',...
        'Sn�fell','�r�ndarj�kull','Hofsj�kull Eystri','Eir�ksj�kul','Tungnafellsj�kull','Torfaj�kull']'    ;
    
%%
names = [{'N1'},'N2','N3','Eir�ksj�kull','N4','N5','N6','N7','�r�ndarj�kull','Hofsj�kull','N8','Drangaj�kull','Sn�fell','Langj�kull','N9','Vatnaj�kull','Hofsj�kull Eystri','N10','Eyjafjallaj�kull','N11','N12','N13','N14','Tungnafellsj�kull','N15','N16','Torfaj�kull','M�rdalsj�kull','N17','N18','N19','N20','N21','N22']';
for i = 1:34;
    geo.shp.glaciers(i).GName = names(i);
    
end
    
  %%  
    
%     
%     %Nor�urlandssj�klar
%     37099
%     37098
%     37131
%     37092
%     37185
%     37207
%     37231
%     36991
%     37220
%     37216
%     37199
%     37058
%     37260
%     37198
%     37259
%     37258
%     37031
%     37255
%     37026
%     37134
%     36957
%     37157
%     
    
    
    
     
    
    
else
    
end


cd(current_dir);
