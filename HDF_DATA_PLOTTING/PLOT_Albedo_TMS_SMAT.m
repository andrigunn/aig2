cd('C:\Users\andrigun\Dropbox\01 - Icelandic Snow Observatory - ISO\aig\02_data\mat_output_v2')
load('HDF_DATA_PROCESS_TMS_TMM11d_merge_ncmasked.mat')
%%

%%
clc
data = TMS(:,6:end);
data = table2array(data);
year = repmat(TMS.Year,1,34);
num = repmat(1:34,20,1);

data_mean = mean(data,1)

data_norm = data-data_mean


%%
clc
close all
f = figure('Position', [50, 100, 900, 300]);
he = pcolor(year,num,data_norm);   
caxis([-25 25])
cmap = cbrewer('div','RdBu',20)
colorbar
colormap(cmap)
%%


