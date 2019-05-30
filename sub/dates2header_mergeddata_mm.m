function data= dates2header_mergeddata_mm(data)
% Read in data structure from dir function and add time and date
% information to the structure for NC merged data

%
for i = 1:length(data);
    mod_date = data(i).name;
    HDF_DATE = mod_date(end-9:end-3);
    
    date_on_graph = num2str(HDF_DATE);
    year = date_on_graph(1,1:4);
    month= date_on_graph(1,6:end);
           
    DateString = ['01-',month,'-',year];
    formatIn = 'dd-mm-yyyy';
    dv=datenum(DateString,formatIn);
    data_date = datestr(datenum(DateString,formatIn),'yyyy_mm');

    MOD_DATE_STR(i,:) = time_builder(dv);
    
    [data(i).year] = MOD_DATE_STR(i,1);
    [data(i).month] = MOD_DATE_STR(i,2);
    [data(i).day] = MOD_DATE_STR(i,3);
    [data(i).hour] = MOD_DATE_STR(i,4);
    [data(i).second] = MOD_DATE_STR(i,5);
    [data(i).doy] = MOD_DATE_STR(i,6);
    [data(i).daten] = MOD_DATE_STR(i,7);
        
 end

data = rmfield(data, 'date');
data = rmfield(data, 'isdir');
data = rmfield(data, 'datenum');
data = rmfield(data, 'bytes');

