function T = HDF_DATA_PROCESS_make_mean_ts(di,ncvar,file_type,geo)
% Make mean values based on the GID in goe.shp.glaciers.OBJECTID

%% TESTING
% data_write_dir = 'D:\aig\02_data\ts\'
% di = d;
% ncvar = 'Month_Mean' % Variable to make stack from
% file_type = 'nc4'
%%
no_glac = myUnique([geo.shp.glaciers.OBJECTID]);
ji = 0;

for i = 1:length(di)
    
    if file_type == 'nc4'
        data = ncread([di(i).folder,'\',di(i).name], ncvar);
        
    elseif file_type == 'hdf'
        
    elseif file_type == 'mat'
    
    end
    disp(di(i).name)
    ji = 0;
    
    for mi = 1:length(no_glac);
        ji = ji+1;
        ki = find(geo.ins.glacier_in_id==no_glac(mi));          % Index for name of glacier
        kn = find([geo.shp.glaciers.OBJECTID]==no_glac(mi));    % Data index for glacier
     
        gname = geo.shp.glaciers(kn).GName;
        total_no_pixels = numel(ki);                         % Count total no of pixels
        total_mean_a    = nanmean(data(ki));                 % nanMean of pixels
        total_mean_tmp  = sum(isnan(data(ki)));              % Count NaN pixel
        ID_glacier      = no_glac(mi);
    
        MM(i,mi) = total_mean_a;
               
        GID(1,mi) = ID_glacier;
        Gnames(1,mi) = gname;
        Time(i,1:5) = [di(i).year, di(i).month, di(i).day, di(i).doy, di(i).daten];
        
	end
    
end

%% Make the final data structure
DS = [Time,MM];
T = table(DS);
T = splitvars(T);

A = {'Year','Month','Day','Doy','dn','Eyjafjallajokull','Langjokull','Drangajokull','Myrdalsjokull','Eiriksjokull','Torfajokull','Hofsjokull','N21','N8','N19','N17','N12','N4','N2','N1','N3','N20','N22','N5','N14','N11','N6','N10','N9','Snaefell','N7','Hofsjokull_Eystri','Thrandarjokull','N18','Tungnafellsjokull','N16','N15','N13','Vatnajokull'};
T.Properties.VariableNames = A;





