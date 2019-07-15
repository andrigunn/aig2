function HDF_DATA_PROCESSING_make_monthly_means(data_write_dir,D,ncvar)

% Make montly mean data stacks for ICeland based on NC output from Merger
% MM is for Montly mean in name

%%TESTING
% data_write_dir = 'D:\aig\02_data\mod_merge_MM\'
% D = d;
% ncvar = '11d_merge' % Variable to make stack from
%% F

uqYears = unique([D.year])  % Find all unique years in structure

for i = 1:length(uqYears)
    iy = find([D.year]==uqYears(i)); % Find all years in stack
    Dsub = D(iy);   % Make a substack with selected year
    disp(['Processing year: ',num2str(uqYears(i))])
    uqMonths = unique([Dsub.month]);
    
    for k = 1:length(uqMonths); % Find unique moths in substack
        im = find([Dsub.month]==uqMonths(k));
        Dsubsub = Dsub(im);
        disp(['Processing year: ',num2str(uqYears(i)),' Month: ',num2str(uqMonths(k))])

        ji = 0;
        for j = 1:length(Dsubsub); % Open individual files in subsubstack, ie for each month
            disp(['Processing year: ',num2str(uqYears(i)),' Month: ',num2str(uqMonths(k)),' Day: ',num2str(Dsubsub(j).day)])
            if ispc
            ncdata = ncread([Dsubsub(j).folder,'\',Dsubsub(j).name], ncvar);
            elseif isunix
            ncdata = ncread([Dsubsub(j).folder,'/',Dsubsub(j).name], ncvar);
            end
            
            ji = ji+1;
            MS(:,:,ji) = ncdata;

        end
%%
        meanstack = nanmean(MS,3);
        stdstack = std(MS,0,3,'omitnan');
%%
        DateString = ['01-',num2str(uqMonths(k)),'-',num2str(uqYears(i))];
        formatIn = 'dd-mm-yyyy';
        datenum(DateString,formatIn);
        data_date = datestr(datenum(DateString,formatIn),'yyyy_mm');
        fname = [data_write_dir,'MOD_',ncvar,'_MM_',data_date ,'.nc'];
        % Delete NC file if it exists in the data write directory
           if exist(fname, 'file')==2;
                delete(fname);
           end
           
        disp(['Writing data to ', fname])
            nccreate(fname,'Month_Mean','Dimensions', {'x',2400,'y',2400});
            ncwrite(fname,'Month_Mean',meanstack);
            
            nccreate(fname,'Month_STD','Dimensions', {'x',2400,'y',2400});
            ncwrite(fname,'Month_STD',stdstack);
            
    end
end