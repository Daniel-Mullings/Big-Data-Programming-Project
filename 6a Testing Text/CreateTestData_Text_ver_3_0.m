%% Replaces one hours worth of data with empty strings
clear all
close all

FileIn = 'o3_surface_20180701000000.nc';
C = ncinfo(FileIn);
VarNames = {C.Variables.Name};

%% Move to new *.nc file
FileOut = 'TestyTest.nc';
nccreate(FileOut, 'lat', 'Dimensions', {'lat', 400}, 'DataType', 'single');
ncwrite(FileOut, 'lat', ncread(FileIn, 'lat'));
nccreate(FileOut, 'lon', 'Dimensions', {'lon', 700}, 'DataType', 'single');
ncwrite(FileOut, 'lon', ncread(FileIn, 'lon'));
nccreate(FileOut, 'hour', 'Dimensions', {'hour', 25}, 'DataType', 'single');
ncwrite(FileOut, 'hour', ncread(FileIn, 'hour'));

Model2Change1 = 1;                                                              % Select the model that will be 
                                                                                % overwritten with errors
Model2Change2 = 4;

for idx = 1:7
    if idx ~= Model2Change1 && idx ~= Model2Change2                             % If idx not equal to Model2Change1
                                                                                % and Model2Change2
        Var = ncread(FileIn, VarNames{idx});
        nccreate('TestyTest.nc', VarNames{idx},...
            'Dimensions', { 'lon', 700, 'lat', 400, 'hour', 25},...
            'DataType', 'single');
        ncwrite('TestyTest.nc', VarNames{idx}, Var);
    else
        Var = ncread(FileIn, VarNames{idx});
        nccreate('TestyTest.nc', VarNames{idx},...
            'Dimensions', { 'lon', 700, 'lat', 400, 'hour', 25},...
            'DataType', 'char');
        var = char(Var);
        ncwrite('TestyTest.nc', VarNames{idx}, var);
    end
end