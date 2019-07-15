%% RAV2 validtion to GAWS
clear all, close all, clc
%Load RAV time series data
cd('C:\Users\andrigun\Dropbox\01 - Icelandic Snow Observatory - ISO\aig\02_data\stations-lv-1979-2108.tar\staion_ts_merge')
rav = load('rav2_gaws.mat')
%Load GAWS data
filename = 'F:\Þróunarsvið\Rannsóknir\Jöklarannsóknir\12_Veðurstöðvar\GAWS_overview\temp_backups\load_backup_20062019_1600.mat';
gaws = load(filename);
img_dir='C:\Users\andrigun\Dropbox\01 - Icelandic Snow Observatory - ISO\aig\04_img\rav_gaws_val\per_site';
%% Validation per site and variables   
RAV2_GAWS_Validation(rav.B10,gaws.B10,'B10',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
RAV2_GAWS_Validation(rav.B13,gaws.B13,'B13',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
RAV2_GAWS_Validation(rav.B16,gaws.B16,'B16',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
% 
RAV2_GAWS_Validation(rav.T01,gaws.T01,'T01',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
RAV2_GAWS_Validation(rav.T03,gaws.T03,'T03',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
RAV2_GAWS_Validation(rav.T06,gaws.T06,'T06',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
%
RAV2_GAWS_Validation(rav.HSA09,gaws.HNA09,'HSA09',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
RAV2_GAWS_Validation(rav.HSA13,gaws.HNA13,'HNA13',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)

RAV2_GAWS_Validation(rav.L01,gaws.L01,'L01',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
RAV2_GAWS_Validation(rav.L05,gaws.L05,'L05',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)

RAV2_GAWS_Validation(rav.Br01,gaws.Br01,'Br01',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
RAV2_GAWS_Validation(rav.Br04,gaws.Br04,'Br04',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
RAV2_GAWS_Validation(rav.BR7,gaws.Br07,'Br07',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)

RAV2_GAWS_Validation(rav.Hof01,gaws.Hoff,'HOFF',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
RAV2_GAWS_Validation(rav.HOSP,gaws.Hosp,'HOSP',[datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
%
RAV2_GAWS_Validation(rav.MyrA,gaws.MyrA,'MyrA',[datetime(2014,5,1) : datetime(2018,12,31)],img_dir)

RAV2_GAWS_Validation(rav.K06,gaws.Bard,'K06', [datetime(1995,5,1) : datetime(2018,12,31)],img_dir)
RAV2_GAWS_Validation(rav.K02,gaws.Kokv,'K02', [datetime(1995,5,1) : datetime(2018,12,31)],img_dir)

RAV2_GAWS_Validation(rav.GvTh,gaws.Gv_vh,'GV', [datetime(1995,5,1) : datetime(2018,12,31)],img_dir)

%% Validation per variable for all sites
RAV2_GAWS_make_TM_Stacks_paramter_montly_val



