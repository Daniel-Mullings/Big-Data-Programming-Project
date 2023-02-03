%% Script: Allows you to open and explore the data in a *.nc file
clear all                                                                       % Clear all variables
close all                                                                       % Close all windows

FileName = 'o3_surface_20180701000000.nc';                                      % Define the name of the file to be used, 
                                                                                % the path is included

%% Print our results
%Pass in function return values as arguments
Reportresults_ver_1_2(LoadAllData_ver_1_2(FileName), LoadHours_ver_1_2(FileName), LoadAllHours_ver_1_2(FileName));