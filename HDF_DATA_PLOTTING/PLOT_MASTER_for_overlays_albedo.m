close all
img_dir = 'C:\Users\andrigun\Dropbox\01 - Icelandic Snow Observatory - ISO\aig\04_img\albedo_overlays'
cd(img_dir)

[D R s] = overlay(DMM.dn,DMM.Vatnajokull);
PLOT_AIG_overlay_timeseries(s,'Vatnaj�kull',20,90);
export_fig('Vatnaj�kull', '-png');  

[D R s] = overlay(DMM.dn,DMM.Langjokull);
PLOT_AIG_overlay_timeseries(s,'Langj�kull',20,90);
export_fig('Langj�kull', '-png');  

[D R s] = overlay(DMM.dn,DMM.Hofsjokull);
PLOT_AIG_overlay_timeseries(s,'Hofsj�kull',20,90);
export_fig('Hofsj�kull', '-png');  

[D R s] = overlay(DMM.dn,DMM.Myrdalsjokull);
PLOT_AIG_overlay_timeseries(s,'M�rdalsj�kull',5,90);
export_fig('M�rdalsj�kull', '-png');  

[D R s] = overlay(DMM.dn,DMM.Eyjafjallajokull);
PLOT_AIG_overlay_timeseries(s,'Eyjafjallaj�kull',5,90);
export_fig('Eyjafjallaj�kull', '-png');  

[D R s] = overlay(DMM.dn,DMM.Drangajokull);
PLOT_AIG_overlay_timeseries(s,'Drangaj�kull',20,90);
export_fig('Drangaj�kull', '-png');  