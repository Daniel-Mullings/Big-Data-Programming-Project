%% Script: Allows you to open and explore the data in a *.nc file
clear all                                                                       % Clear all variables
close all                                                                       % Close all windows

FileName = 'o3_surface_20180701000000.nc';                                      % Define the name of the file to be used, 
                                                                                % the path is included
                                                                                
Contents = ncinfo(FileName);                                                    % Store the file content information in a variable


%% Section 2: Load all the model data together
LoadAllData_ver_1_1

%% Section 3: Loading all the data for a single hour from all the models
LoadHours_ver_1_1

%% Section 4: Cycle through the hours and load all the models for each hour and record memory use
LoadAllHours_ver_1_1

%% Section 5: Print our results
Reportresults_ver_1_1