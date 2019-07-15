%% Merged MOD data
clear all, close all
master
%% Make the data structure for MOD, MYD and MCD data structures
clc
[mod, myd, mcd, mcd43] = make_data_structure(mod_data_dir, myd_data_dir,mcd43_data_dir);

%% TESTING
days2merge = 5; %=> Number of days to merge forward and backward (For a 10 day total merge select 5)
data_structure = mod;
GRID_NAME= 'MOD_Grid_Snow_500m'
DATAFIELD_NAME='Snow_Albedo_Daily_Tile'
   
%%
clear DATA_C R center_date
close all

ins_mask = geo.ins.glaciers;

for i = (1+days2merge):(length(data_structure)-days2merge); % Interval starts to allow for front and back merging
	ist = 0;
    disp(['Processing date: ',datestr(data_structure(i).daten),' for file ',FILE_NAME_short_C]);
    
    % Retrive center date data from MOD stack    
    [DATA_CMOD, DATA_NAME_C,HDF_DATE_C,FILE_NAME_short_C] = hdf_import([mod(i).folder,'\',mod(i).name], GRID_NAME, DATAFIELD_NAME); 
    ik = 0;
    % Write cloud cover of center date
    [cc, mv] = MOD_cc_mean(DATA_CMOD,ins_mask);
    ist = ist+1;
	R(ist).hdf_date = str2num(HDF_DATE_C);
    R(ist).cc = cc;
    R(ist).mv = mv;
    R(ist).dname = 'MOD_Center_Date';
    
    % Ckeck is a MYD data is available for the mod date
    ifmyd = find([myd.daten] == [mod(i).daten]);
    
    if ~isempty(ifmyd);
        % Retrive center date data from MYD stack  
        [DATA_CMYD, DATA_NAME_C,HDF_DATE_C,FILE_NAME_short_C] = hdf_import([myd(ifmyd).folder,'\',myd(ifmyd).name], GRID_NAME, DATAFIELD_NAME); 

        [cc, mv] = MOD_cc_mean(DATA_CMYD,ins_mask);
        ist = ist+1;
        R(ist).hdf_date = str2num(HDF_DATE_C);
        R(ist).cc = cc;
        R(ist).mv = mv;
        R(ist).dname = 'MYD_Center_Date';
        
        DATA_C = DATA_CMOD;
        [nans_c] = find(isnan(DATA_C));
        DATA_C(nans_c) = DATA_CMYD(nans_c);
        
        [cc, mv] = MOD_cc_mean(DATA_C,ins_mask);
        ist = ist+1;
        R(ist).hdf_date = str2num(HDF_DATE_C);
        R(ist).cc = cc;
        R(ist).mv = mv;
        R(ist).dname = 'MOD_MYD_Merged_Center_Date';
                
    else
        DATA_C = DATA_CMOD;
    end


    % Make the MOD merge stack
    ikk = 1;
    center_date(ikk,1) = mod(i).daten; 
    for ii = 1:days2merge;
        ik = ik+1;
        % Write merge data to stack 
        [DATA_f_MOD, DATA_NAME_f,HDF_DATE_f_MOD,FILE_NAME_short_f] = hdf_import([mod(i+ii).folder,'\',mod(i+ii).name], GRID_NAME, DATAFIELD_NAME);
        [DATA_b_MOD, DATA_NAME_b,HDF_DATE_b_MOD,FILE_NAME_short_b] = hdf_import([mod(i-ii).folder,'\',mod(i-ii).name], GRID_NAME, DATAFIELD_NAME); 
        %MOD_view(DATA_f,geo)
        %MOD_view(DATA_b,geo)
        Data_stack_MOD(:,:,ik) = DATA_f_MOD;
        ik = ik+1;
        Data_stack_MOD(:,:,ik) = DATA_b_MOD;
        
        [cc, mv] = MOD_cc_mean(DATA_f_MOD,ins_mask);
        ist = ist+1;
        R(ist).hdf_date = str2num(HDF_DATE_f_MOD);
        R(ist).cc = cc;
        R(ist).mv = mv;
        R(ist).dname = ['MOD_forward_d',num2str(ii)];
        
        [cc, mv] = MOD_cc_mean(DATA_b_MOD,ins_mask);
        ist = ist+1;
        R(ist).hdf_date = str2num(HDF_DATE_b_MOD);
        R(ist).cc = cc;
        R(ist).mv = mv;
        R(ist).dname = ['MOD_backward_d',num2str(ii)];
        
        ikk = ikk+1;
        center_date(ikk,1) = mod(i+ii).daten; 
        ikk = ikk+1;
        center_date(ikk,1) = mod(i-ii).daten; 
        
    end
    
	% Make the MYD merge stack
    % Check if the MYD dates are in the dataset
    ifmyd = find([myd.daten] == [mod(i).daten]);
    [tf,idx] = ismember([myd.daten],center_date);
    xs = size(find(tf==1));
    
    if xs(2) == (days2merge*2+1);
        im = find([myd.daten]==center_date(1)); 
        ik = 1;
        for ii = 1:days2merge;
             ik = ik+1;
             % Write merge data to stack 
             [DATA_f_MYD, DATA_NAME_f,HDF_DATE_f_MYD,FILE_NAME_short_f] = hdf_import([myd(im+ii).folder,'\',myd(im+ii).name], GRID_NAME, DATAFIELD_NAME);
             [DATA_b_MYD, DATA_NAME_b,HDF_DATE_b_MYD,FILE_NAME_short_b] = hdf_import([myd(im-ii).folder,'\',myd(im-ii).name], GRID_NAME, DATAFIELD_NAME); 
             %MOD_view(DATA_f,geo)
             %MOD_view(DATA_b,geo)
             Data_stack_MYD(:,:,ik) = DATA_f_MYD;
             ik = ik+1;
             Data_stack_MYD(:,:,ik) = DATA_b_MYD;
    %         
             [cc, mv] = MOD_cc_mean(DATA_f_MYD,ins_mask);
             ist = ist+1;
             R(ist).hdf_date = str2num(HDF_DATE_f_MYD);
             R(ist).cc = cc;
             R(ist).mv = mv;
             R(ist).dname = ['MYD_forward_d',num2str(ii)];
    %         
             [cc, mv] = MOD_cc_mean(DATA_b_MOD,ins_mask);
             ist = ist+1;
             R(ist).hdf_date = str2num(HDF_DATE_b_MYD);
             R(ist).cc = cc;
             R(ist).mv = mv;
             R(ist).dname = ['MYD_backward_d',num2str(ii)];
        end
    else
    end
   %%     
    % Delete NC file if it exists in the data write directory
       if exist([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc'], 'file')==2;
            delete([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc']);
       end
       
    % Find all nan data in the center date merged data   
    Merged_data = DATA_C;
    [nans_c] = find(isnan(Merged_data));
    
    ic = 0;
    for k = (2*days2merge):-1:1 % Counts from last day to first
        ic = ic+1;
        
        Dtemp1 = Data_stack_MOD(:,:,k);
        Merged_data(nans_c) = Dtemp1(nans_c);
        
        if xs(2) == (days2merge*2+1);
            Dtemp2 = Data_stack_MYD(:,:,k);
            [nans_c] = find(isnan(Merged_data));
            Merged_data(nans_c) = Dtemp2(nans_c);
        else
        end
        
        [nans_c] = find(isnan(Merged_data));
        
             [cc, mv] = MOD_cc_mean(Merged_data,ins_mask);
             ist = ist+1;
             R(ist).hdf_date = str2num(HDF_DATE_b_MYD);
             R(ist).cc = cc;
             R(ist).mv = mv;
             R(ist).dname = ['MOD_MYD__d',num2str(k)];
        
        
        % Create a NC variable for day 7 and 9 that is merged to the stack
        if ic == 5 || ic == 7 || ic == 9 || ic == 11
            disp(ic)
            nccreate([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc'],[num2str(ic),'d_merge'],'Dimensions', {'x',2400,'y',2400});
            ncwrite([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc'],[num2str(ic),'d_merge'],reshape(Merged_data,2400,2400));
        else
        end
        %MOD_view(reshape(Merged_data,2400,2400),geo)
    end
    rs_merged = reshape(Merged_data,2400,2400);
    
        % Create a NC variable to write orignal data to (Center date data)    
        nccreate([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc'],'MOD_Center_Date','Dimensions', {'x',2400,'y',2400});
        ncwrite([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc'],'MOD_Center_Date',DATA_C);
        % Create a NC variable to write full day merged data to
        nccreate([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc'],[num2str(days2merge*2+1),'d_merge'],'Dimensions', {'x',2400,'y',2400});
        ncwrite([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc'],[num2str(days2merge*2+1),'d_merge'],rs_merged);

        save([data_write_dir2,'MOD_',num2str(days2merge*2+1),'d_cc_mv_',HDF_DATE_C,'.mat'],'R');
        
        
        ncwriteatt([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc'],'/','Creation_date:',datestr(now));
        ncwriteatt([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc'],'/','Author:','Andri Gunnarsson andrigun@lv.is');
        ncwriteatt([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc'],'/','MODIS CENTER FILE:',FILE_NAME_short_C);
        ncwriteatt([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc'],'/','MODIS DATE:',datestr(data_structure(i).daten));
        ncwriteatt([data_write_dir,'MOD_',num2str(days2merge*2+1),'d_merge_',HDF_DATE_C,'.nc'],'/','Description','MOD_Center_Date is the unaltered center date data from MODIS CENTER FILE. Xd_merge file is the data merged to the center date where X is the number of day added to the center date');
end

disp('Done')


