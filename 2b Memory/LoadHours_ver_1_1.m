%% Script: Loading all the data for a single hour from all the models
% We combine the above code to cycle through the names and load each model.
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