% Overlay data stack and plot generator. This version of overlay is
% intended for use with time series data for overlay ploting. 
%
%RELEASE NOTES
%   Written by Andri Gunnarsson (andrigun@lv.is).
%   Version 1.0 Released on xxxxx X xx
%
%SYNTAX
%   [TIME, modelSWE, outflow] = snow17(T,P,yr_i, month_i, day_i, hr_i ,elevation, dtt, dtp, S, RvS);
%   [TIME, modelSWE, outflow] = snow17(T,P,yr_i, month_i, day_i, hr_i ,elevation, dtt, dtp, S, RvS, UADJ, MBASE, MFMAX, MFMIN, TIPM, NMF, PLWHC);
%
%INPUTS
%   1) T - Lx1 array of air temperature data (deg C)
%   2) P - Lx1 array of incremental precipitation data (mm/timestep)
%   3) yr_i = 1x1 value of starting year (i.e. 2003)
%   4) month_i = 1x1 value of starting month (i.e. 10)
%   5) day_i = 1x1 value of starting day (i.e. 1)
%   6) hr_i = 1x1 value of starting hour (0-23)
%   7) elevation = 1x1 value of station elevation (m MSL)
%   8) dtt = 1x1 value of time step for temperature (should be the same as precipitation time step, dtp)
%   9) dtp = 1x1 value of time step for temperature (should be the same as temperature time step, dtt)
%   10) S = 1x1 value of SCF
%   11) RvS = control of how rain and snow are divided.
%         Enter 0 if you want a single temperature (PXTEMP) that divides rain and snow
%         Enter 1 if you want a linear transition between 2 temperatures (PXTEMP1 and PXTEMP2)
%         Enter 2 if you want no adjustments made to the precipitation data.  All precipitation is considered snowfall.
%         Enter 3 if you want to use an S-shaped transition [Kienzle 2008]
%   12) (optional) params = seven sets of 1x1 values of model parameters
%       Note: The default model calibration will be used if (UADJ, MBASE,
%       MFMAX, MFMIN, TIPM, NMF, PLWHC) are not used as input
%
%OUTPUTS
%   1) TIME = Lx7 matrix of time values (see timebuilder.m for column designation)
%   2) modelSWE = Lx1 array of modelSWE (mm)
%   3) outflow = Lx1 array of outflow from the snowpack (snowmelt, or rain
%   percolating through the snowpack).  Note: Outflow is zero during times
%   when it is raining on bare ground (no snowpack exists).

function [D R s] = overlay(t,d)
% time is datenum on input
% data is same lnght as time
%% TESTING
% t = DMM.dn;
% t = datenum(t);
% d = DMM.Vatnajokull;


clc
disp('############# Making time series structure #############')
disp(['## Proccess started at ',datestr(now)])

% Checks
% Check that inputs are of the same length

% Check for timestep of input data

% Make a datastack with time and data properties
    D = splitvars(timetable([datevec(t),t,d],'RowTimes',datetime(t,'ConvertFrom','datenum')));
    D.Properties.VariableNames = {'Year','Month','Day','HH','MM','SS','daten','data'};
   
   % Check where to start timestructure
first_date = datevec(D.daten(1));
disp(['## First data in input time series data ', datestr(first_date)])

    if first_date(2) < 10 ;
       start_year = first_date(1)-1;
    else
       start_year = first_date(1);
    end

DateNumber = datenum(start_year,10,1,00,00,00);
disp(['## Starting hydrological time structure at ', datestr(DateNumber)])

% Find all unique time steps
    dt = unique(diff(D.Time));
    disp(['## Data has ',num2str(length(dt)),' unique timesteps'])
% Resample to shortest timestep of data
    ts = min(dt); %Timestep of data to resample to
    tv = [datetime(start_year,10,1):ts:datetime(now,'ConvertFrom','datenum')]; % Make the time vector
    RT = retime(D,tv,'mean'); % Resample to new timestructure
    disp(['## Resampling data minimum timestep'])

%
RT = removevars(RT, {'Year','Month','Day','HH','MM','SS'});
RT.daten = datenum(RT.Time);
RT.dv = datevec(RT.daten);
uqY = unique(RT.dv(:,1));
% Determine current hydrological
cdate = datevec(datestr(now));
disp(['## Curent date: ', datestr(cdate)])
%
if cdate(2) > 9;
    hy_cyear = cdate(1);
elseif cdate(2) < 10;
    hy_cyear = cdate(1)-1;
end

disp(['## Curent hydrological year: ', num2str(hy_cyear),'-',num2str(hy_cyear+1)])

% Make fake dates for current hydrological year
iy = find([RT.dv(:,2)]==10 | [RT.dv(:,2)]==11 | [RT.dv(:,2)]==12);
RT.dv(iy,1) = hy_cyear; 

iy = find([RT.dv(:,2)]<10);
RT.dv(iy,1) = hy_cyear+1; 
RT.fdaten = datenum(RT.dv);

% Make HY time structure
S = [datenum(['01-Oct-',num2str(hy_cyear)],'dd-mmm-yyyy'):(hours(ts)/24):datenum(['30-Sep-',num2str(hy_cyear+1)],'dd-mmm-yyyy')]';

uqHY = start_year:1:hy_cyear;

ST = nan(length(S),length(uqHY));

for i = 1:length(S);
   
    ii = find(S(i)==[RT.fdaten]);
    
    ST(i,1:length(ii)) = RT.data(ii);
    
end

%Write results to R structure
clear R
disp(['## Writing Stack to R'])
ST = ST(:,1:length(uqHY));
R = splitvars(timetable(datetime(S,'ConvertFrom','datenum'),...
        mean(ST,2,'omitnan'),...
        max(ST,[],2,'omitnan'),...
        min(ST,[],2,'omitnan'),...
        median(ST,2,'omitnan'),...
        quantile(ST,[0.05,0.1,0.25,0.50,0.75,0.9,0.95],2)));

R.Properties.VariableNames = {'Mean','Max','Min','Median','Q05','Q10','Q25','Q50','Q75','Q90','Q95'};

%
A = splitvars(timetable(datetime(S,'ConvertFrom','datenum'),ST));

STATS_DM = retime(R,'daily');
HIST_DM = retime(A,'daily');

STATS_MM = retime(R,'monthly');
HIST_MM = retime(A,'monthly');

s = struct;

s.STATS_DM = STATS_DM;
s.HIST_DM = HIST_DM;

s.STATS_MM = STATS_MM;
s.HIST_MM = HIST_MM;

s.years = uqHY;

disp('#############             DONE             #############')




