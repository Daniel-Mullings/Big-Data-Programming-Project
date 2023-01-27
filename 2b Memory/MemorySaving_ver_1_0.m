%% Script: Allows you to open and explore the data in a *.nc file
clear all                                                                       % Clear all variables
close all                                                                       % Close all windows

FileName = 'o3_surface_20180701000000.nc';                                      % Define the name of the file to be used, 
                                                                                % the path is included

Contents = ncinfo(FileName);                                                    % Store the file content information in a variable


%% Section 2: Load all the model data together
for idx = 1: 8
    AllData(idx,:,:,:) = ncread(FileName, Contents.Variables(idx).Name);
    fprintf('Loading %s\n', Contents.Variables(idx).Name);                      % Display loading information
end

AllDataMem = whos('AllData').bytes/1000000;
fprintf('Memory used for all data: %.3f MB\n', AllDataMem)

%% Section 3: Loading all the data for a single hour from all the models
% We combine the aboce code to cycle through the names and load each model.
% We load the data into successive 'layers' using 'idx', and let the other
% two dimensions take care of themselves by using ':'
StartLat = 1;                                                                   % Starting latitude
NumLat = 400;                                                                   % Number of latitude positions
StartLon = 1;                                                                   % Starting longitude
NumLon = 700;                                                                   % Number of longitude positions
StartHour = 1;                                                                  % Starting time for analyses
NumHour = 1;                                                                    % Number of hours of data to load

% Loop through the models loading *ALL* the data into an array
Models2Load = [1, 2, 4, 5, 6, 7, 8];                                            % List of models to load
idxModel = 0;                                                                   % Current model
for idx = 1:7
    idxModel = idxModel + 1;                                                    % Move to next model index
    LoadModel = Models2Load(idx);                                               % Which model to load
    ModelData(idxModel,:,:,:) = ncread(FileName, Contents.Variables(LoadModel).Name,...
        [StartLon, StartLat, StartHour], [NumLon, NumLat, NumHour]);
    fprintf('Loading %s\n', Contents.Variables(LoadModel).Name);                % Display loading information
end

HourDataMem = whos('ModelData').bytes/1000000;
fprintf('Memory used for 1 hour of data: %.3f MB\n', HourDataMem)

%% Section 4: Cycle through the hours and load all the models for each hour and record memory use
% We use an index named 'StartHour' in our loop
HourMem = 0;                                                                    % Storage variable for the maximum memory 
                                                                                % in use by our data variable

StartLat = 1;                                                                   % Starting latitude
NumLat = 400;                                                                   % Number of latitude positions
StartLon = 1;                                                                   % Starting longitude
NumLon = 700;                                                                   % Number of longitude positions
% StartHour = 1;                                                                % Starting time for analyses
NumHour = 1;                                                                    % Number of hours of data to load

% Loop through the hours loading one at a time
for StartHour = 1:25
    Models2Load = [1, 2, 4, 5, 6, 7, 8];                                        % List of models to load
    idxModel = 0;                                                               % Current model
    for idx = 1:7
        idxModel = idxModel + 1;                                                % Move to next model index
        LoadModel = Models2Load(idx);                                           % Which model to load
        HourlyData(idxModel,:,:,:) = ncread(FileName, Contents.Variables(LoadModel).Name,...
            [StartLon, StartLat, StartHour], [NumLon, NumLat, NumHour]);
        fprintf('Loading %s\n', Contents.Variables(LoadModel).Name);            % Display loading information
    end
    
    % Record the maximum memory used by the data variable so far
    HourMem = max( [ HourMem, whos('HourlyData').bytes/1000000 ] );
    fprintf('Loaded Hour %i, memory used: %.3f MB\n', StartHour, HourMem);      % Display loading information
end

%% Section 5: Print our results
fprintf('\nResults:\n')
fprintf('Memory used for all data: %.2f MB\n', AllDataMem)
fprintf('Memory used for hourly data: %.2f MB\n', HourDataMem)
fprintf('Maximum memory used hourly = %.2f MB\n', HourMem)
fprintf('Hourly memory as fraction of all data = %.2f\n\n', HourMem / AllDataMem)