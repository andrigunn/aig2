function data= dates2header_mergeddata_msm(data)
% Read in data structure from dir function and add time and date
%% information to the structure for NC merged data
clc

%
for i = 1:length(data);
    mod_date = data(i).name;
    HDF_DATE = mod_date(20:23);
    
    date_on_graph = num2str(HDF_DATE);
    year = date_on_graph(1,1:4);
        
    [data(i).year] = str2num(year);
    
    [data(i).month] = 1;
    [data(i).day] = 1;
    [data(i).hour] = 1;
    [data(i).second] =1;
    [data(i).doy] = 1;
    [data(i).daten] = 1;
    
            
 end

data = rmfield(data, 'date');
data = rmfield(data, 'isdir');
data = rmfield(data, 'datenum');
data = rmfield(data, 'bytes');

