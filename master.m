%% Albedo of Icelandic Glaciers - AIG2
%   Andri Gunnarsson - andrigun@lv.is
%% MASTER mfile
clc, clear all, close all
disp('Master run initialized for AIG')
% Workflow
if ismac
    git_dir = '/Users/andrigun/Documents/GitHub/aig2';
% Add Project Paths   
    addpath(git_dir);
    addpath('/Users/andrigun/Documents/GitHub/aig/main/');
elseif ispc
    git_dir = 'C:\Users\andrigun\Documents\GitHub\aig2';
% Add Project Paths   
    addpath(git_dir);
    addpath('C:\Users\andrigun\Documents\GitHub\aig2\sub');
    addpath('C:\Users\andrigun\Documents\GitHub\aig2\HDF_DATA_PROCESSING\')
    addpath('C:\Users\andrigun\Documents\GitHub\aig2\HDF_DATA_PLOTTING\')
    addpath('C:\Users\andrigun\Documents\GitHub\matlab_main\export_fig')
    addpath('C:\Users\andrigun\Documents\GitHub\matlab_main\cbrewer\')
   
    proj_dir = 'C:\Users\andrigun\Dropbox\01 - Icelandic Snow Observatory - ISO\aig\';
    geo_data_dir = [proj_dir '02_data\geo\'];                 % Location of GEO data 
    mod_data_dir = [proj_dir '02_data\mod10a1\'];
    myd_data_dir = [proj_dir '02_data\myd10a1\'];
    mcd43_data_dir = [proj_dir '02_data\mcd43a3\'];%'D:\data\MCD43A3';
	rav_data_dir = 'D:\dm';
% Data and Project directories on storage disk   
    disk_proj_dir = 'D:\aig\02_data\';
    mod_merge_data_dir = [disk_proj_dir 'mod_merge\'];
    
    img_dir = [proj_dir '04_img\'];
    
    data_write_dir = 'D:\aig\data\mod_merge\';
    data_write_dir2 = 'D:\aig\data\mod_merge_cc\';
    
    data_write_dir_MM = 'D:\aig\02_data\mod_merge_MM\'
    data_write_dir_MeltM = 'D:\aig\02_data\mod_merge_MeltM\'

elseif isunix
    git_dir = '/home/user/Documents/Github/aig2';
    addpath(genpath(git_dir));
    addpath(genpath('/home/user/Documents/Github/matlab_main'));
    cd(git_dir)
    
    img_dir = '/run/media/user/brunnur/aig/img';
    
    geo_data_dir = '/run/media/user/DATA/geo/';                 % Location of GEO data 
    mod_data_dir = '/run/media/user/DATA/MOD10A1';
    myd_data_dir = '/run/media/user/DATA/MYD10A1';
    mcd43_data_dir = '/run/media/user/DATA/MCD43A3';%'D:\data\MCD43A3';
    
    data_write_dir = '/run/media/user/brunnur/aig/data/mod_merge/';
    data_write_dir2 = '/run/media/user/brunnur/aig/data/mod_merge_cc/';
    
    data_write_dir_MM = '/run/media/user/brunnur/aig/data/mod_merge_MM/';
    data_write_dir_MeltM = '/run/media/user/brunnur/aig/data/mod_merge_MeltM/';
    
    data_write_dir_mat_out = '/run/media/user/brunnur/aig/data/mat_output';

    
end
% Data and Project directories locally on PC    

    disp('Running geo')
    geo = make_geo_modis(geo_data_dir);
    disp('Geo made')
    disp('Master run done for AIG')
%% Code Overview
%% master.m 
% Main file to run for installation of paths, geo and other relevant
% features
%% 1. MODIS data processing
% HDF_DATA_MERGER.m => Merging of HDF files. Written to NC files
% HDF_DATA_PROCESS.m => MAster file for processing of output from MERGER

%% RAV data processing











