function HDF_DATA_PROCESS
%% Master script for processing of merged albedo NC files from HDF_DATA_MERGER.m
%   Run master.m first
%
%
%
% DM = Daily mean of data
% MM = Monthly mean of data
% MSM = Melt season mean of data
% YM = year mean of data
%
%%
%% Processing of Merged HDF files
% Make structur for merged data
    cd(mod_merge_data_dir);
    d = dir('*.nc');
    d = dates2header_mergeddata(d);
disp('Making stack...')
%% Make Monthly means 
    data_write_dir = 'D:\aig\02_data\mod_merge_MM\'
    ncvar = '11d_merge' % Variable to make stack from
HDF_DATA_PROCESSING_make_monthly_means(data_write_dir,d,ncvar)
%% Make Melt season means
    cd('D:\aig\02_data\mod_merge_MM\');
    d = dir('*.nc');
    d = dates2header_mergeddata_mm(d);
    data_write_dir = 'D:\aig\02_data\mod_merge_MeltM\'
    ncvar = 'Month_Mean' % Variable to make stack from
    months_in_mean = [5,6,7,8,9]
    fname_months_in_mean = 'MJJAS'
HDF_DATA_PROCESSING_make_melt_season_means(data_write_dir,d,ncvar,months_in_mean,fname_months_in_mean)
%% Calculate mean values for individual glaciers
%% Daily mean time series
    cd(mod_merge_data_dir);
    d = dir('*.nc');
    d = dates2header_mergeddata(d);
    ncvar = '11d_merge'; 
    file_type = 'nc4';
    DMM = HDF_DATA_PROCESS_make_mean_ts(d,ncvar,file_type,geo)
%% Monthly mean time series
    cd('D:\aig\02_data\mod_merge_MM\')
    d = dir('*.nc');
    d = dates2header_mergeddata_mm(d);
    ncvar = 'Month_Mean'; 
    file_type = 'nc4';
    TMM = HDF_DATA_PROCESS_make_mean_ts(d,ncvar,file_type,geo)
%% Melt season mean time series
    cd('D:\aig\02_data\mod_merge_MeltM\')
    d = dir('*_MJJAS.nc');
    d = dates2header_mergeddata_msm(d);
    ncvar = 'Melt_Season_Mean'; 
    file_type = 'nc4';
    TMS = HDF_DATA_PROCESS_make_mean_ts(d,ncvar,file_type,geo)








disp('HDF_DATA_PROCESS done')