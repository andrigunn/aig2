% HDF_DATA_PLOTTING

%% Plotting of TMS - Melt Season Mean values
clc
printer = 1;
img_name = 'MJJAS'
PLOT_Melt_Season_ts(TMS,img_dir,printer,img_name)

%% Plotting of TMM - Month Mean values
printer = 1;
img_name = 'MJJAS'
T = TMM;
months_remove = [1,2,3,4,10,11,12]
PLOT_Month_Mean_ts(T,img_dir,printer,img_name,months_remove)
%% Plotting of DMM Overlay Plots
years2plot = [2004 2010 2011 2015]
printer = 1;
data = DMM.Vatnajokull;
time = DMM(:,1:5);
img_name = 'Vatnajökull'
PLOT_Daily_Overlay_ts(data,time,img_dir,printer,img_name,years2plot)
%%
data = DMM.Langjokull;
img_name = 'Langjokull'
PLOT_Daily_Overlay_ts(data,time,img_dir,printer,img_name,years2plot)
%%
data = DMM.Hofsjokull;
img_name = 'Hofsjokull'
PLOT_Daily_Overlay_ts(data,time,img_dir,printer,img_name,years2plot)
%%

%% Plot daily timer series of albedo
printer = 1;
data = DMM.Vatnajokull;
time = DMM(:,1:5);
img_name = 'Vatnajökull'
PLOT_Daily_ts(time, data,img_dir,img_name,printer)

data = DMM.Hofsjokull;
img_name = 'Hofsjokull'
PLOT_Daily_ts(time, data,img_dir,img_name,printer)

data = DMM.Langjokull;
img_name = 'Langjokull'
PLOT_Daily_ts(time, data,img_dir,img_name,printer)
