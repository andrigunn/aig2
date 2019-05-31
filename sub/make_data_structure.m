%% Make
function [mod, myd, mcd, mcd43] = make_data_structure(mod_data_dir, myd_data_dir, mcd43_data_dir)
% Find all hdf files in data directory
print_img = 0;
% Make a directory for TERRA data
    cd(mod_data_dir);
    mod = dir('*.hdf');                         % Read directory structure
    mod = dates2header(mod);                     % Make a master structure for data files
% Make a directory for AQUA data
    cd(myd_data_dir);
    myd = dir('*.hdf');                         % Read directory structure
    myd = dates2header(myd);                     % Make a master structure for data files
% Make a directory for MCD43 data
    cd(mcd43_data_dir);
    mcd43 = dir('*.hdf');                         % Read directory structure
    mcd43 = dates2header(mcd43);                     % Make a master structure for data files
    
%% Make a joint directory where Terra and Aqua data match. 
ki = 0;
for i = 1:max(length([mod.daten]),length(max(length([myd.daten]))));
   ix = find([mod(i).daten]==[myd.daten]);
   
   tf = isempty(ix);
   if tf == 0;
       ki = ki+1;
       mcd_ind(ki,1:2) = [i,ix];
   else
   end
      
end
%%
mcd.mod = mod(mcd_ind(:,1));
mcd.myd = myd(mcd_ind(:,2));
% Test that structure dates match
isum=sum([mcd.myd.daten] - [mcd.mod.daten]);
    if isum == 0;
        disp('MOD and MYD match')
    else
        disp('MOD and MYD mis-match')
    end

 disp([num2str(length(mod)), ' MOD10A1 dates found'])
 disp([num2str(length(myd)), ' MYD10A1 dates found'])
 disp([num2str(length(mcd43)), ' MCD43A3 dates found'])