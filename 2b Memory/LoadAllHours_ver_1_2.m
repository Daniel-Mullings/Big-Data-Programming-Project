%% Function: Cycle through the hours and load all the models for each hour and record memory use
% Input: "FileName" = File containing data
% Output: "HourMem" = Value representing greatest amount of memory required to load single hour of data
function[HourMem] = LoadAllHours_ver_1_2(FileName)

    Contents = ncinfo(FileName);                                                % Store the file content information in a variable

    % We use an index named 'StartHour' in our loop
    HourMem = 0;                                                                % Storage variable for the maximum memory 
                                                                                % in use by our data variable

    StartLat = 1;                                                               % Starting latitude
    NumLat = 400;                                                               % Number of latitude positions
    StartLon = 1;                                                               % Starting longitude
    NumLon = 700;                                                               % Number of longitude positions
    % StartHour = 1;                                                            % Starting time for analyses
    NumHour = 1;                                                                % Number of hours of data to load
    
    % Loop through the hours loading one at a time
    for StartHour = 1:25
        Models2Load = [1, 2, 4, 5, 6, 7, 8];                                    % List of models to load
        idxModel = 0;                                                           % Current model
        for idx = 1:7
            idxModel = idxModel + 1;                                            % Move to next model index
            LoadModel = Models2Load(idx);                                       % Which model to load
            HourlyData(idxModel,:,:,:) = ncread(FileName, Contents.Variables(LoadModel).Name,...
                [StartLon, StartLat, StartHour], [NumLon, NumLat, NumHour]);
            fprintf('Loading %s\n', Contents.Variables(LoadModel).Name);        % Display loading information
        end
        
        % Record the maximum memory used by the data variable so far
        HourMem = max( [ HourMem, whos('HourlyData').bytes/1000000 ] );
        fprintf('Loaded Hour %i, memory used: %.3f MB\n', StartHour, HourMem);  % Display loading information
    end
end