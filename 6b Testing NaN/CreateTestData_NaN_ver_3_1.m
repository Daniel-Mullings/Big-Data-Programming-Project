%% Replaces one hours worth of data with NaN
clear all
close all

OriginalFileName = './Model/o3_surface_20180701000000.nc';
NewFileName = 'TestFileNaN.nc';
copyfile(OriginalFileName, NewFileName);

C = ncinfo(NewFileName);
ModelNames = {C.Variables(1:8).Name};

%% Change data to NaN
BadData = NaN(700,400,1);

%% Write to *.nc file
Hour2Replace1 = 1;
Hour2Replace2 = 2;
for idx = 1:8
    ncwrite(NewFileName, ModelNames{idx}, BadData, [1, 1, Hour2Replace1]);
    ncwrite(NewFileName, ModelNames{idx}, BadData, [1, 1, Hour2Replace2]);
end