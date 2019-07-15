close all
img_dir = 'C:\Users\andrigun\Dropbox\01 - Icelandic Snow Observatory - ISO\aig\04_img\albedo_overlays'
cd(img_dir)

[D R s] = overlay(DMM.dn,DMM.Vatnajokull);
PLOT_AIG_overlay_timeseries(s,'Vatnajökull',20,90);
export_fig('Vatnajökull', '-png');  

[D R s] = overlay(DMM.dn,DMM.Langjokull);
PLOT_AIG_overlay_timeseries(s,'Langjökull',20,90);
export_fig('Langjökull', '-png');  

[D R s] = overlay(DMM.dn,DMM.Hofsjokull);
PLOT_AIG_overlay_timeseries(s,'Hofsjökull',20,90);
export_fig('Hofsjökull', '-png');  

[D R s] = overlay(DMM.dn,DMM.Myrdalsjokull);
PLOT_AIG_overlay_timeseries(s,'Mýrdalsjökull',5,90);
export_fig('Mýrdalsjökull', '-png');  

[D R s] = overlay(DMM.dn,DMM.Eyjafjallajokull);
PLOT_AIG_overlay_timeseries(s,'Eyjafjallajökull',5,90);
export_fig('Eyjafjallajökull', '-png');  

[D R s] = overlay(DMM.dn,DMM.Drangajokull);
PLOT_AIG_overlay_timeseries(s,'Drangajökull',20,90);
export_fig('Drangajökull', '-png');  