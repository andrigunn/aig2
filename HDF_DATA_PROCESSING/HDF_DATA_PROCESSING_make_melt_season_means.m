function HDF_DATA_PROCESSING_make_melt_season_means(data_write_dir,D,ncvar,months_in_mean,fname_months_in_mean)

% Make montly mean data stacks for ICeland based on NC output from Merger
% MM is for Montly mean in name

%% TESTING
% data_write_dir = 'D:\aig\02_data\mod_merge_MeltM\'
% D = data;
% ncvar = 'Month_Mean' % Variable to make stack from
% months_in_mean = [4,5,6,7,8,9]
% fname_months_in_mean = 'AMJJAS'
%% Input test
dt = length(months_in_mean)-length(fname_months_in_mean);

if dt == 0
%%
uqYears = unique([D.year]);  % Find all unique years in structure

for i = 1:length(uqYears)
    iy = find([D.year]==uqYears(i)); % Find all years in stack
    Dsub = D(iy);   % Make a substack with selected year
    disp(['Processing year: ',num2str(uqYears(i))])

    im = find([Dsub.month]>months_in_mean(1)-1 & [Dsub.month]< months_in_mean(end)+1 ); % Find all years in stack    
    Dsubsub = Dsub(im);
    ji = 0;

    for k = 1:length(Dsubsub)
        ncdata = ncread([Dsubsub(k).folder,'\',Dsubsub(k).name], ncvar);
        ji = ji+1;
        MS(:,:,ji) = ncdata;
    end
    
        meanstack = nanmean(MS,3);
        stdstack = std(MS,0,3,'omitnan');
     
     data_date = [num2str(uqYears(i)),'_',fname_months_in_mean];
     fname = [data_write_dir,'MOD_',ncvar,'_MSM_',data_date ,'.nc'];
%Delete NC file if it exists in the data write directory
            if exist(fname, 'file')==2;
                 delete(fname);
            end
            
     disp(['Writing data to ', fname])
             nccreate(fname,'Melt_Season_Mean','Dimensions', {'x',2400,'y',2400});
             ncwrite(fname,'Melt_Season_Mean',meanstack);
             
             nccreate(fname,'Melt_Season_STD','Dimensions', {'x',2400,'y',2400});
             ncwrite(fname,'Melt_Season_STD',stdstack);
end

else 
    disp('Names of Months and lenght of Month vector do not match!')
end
