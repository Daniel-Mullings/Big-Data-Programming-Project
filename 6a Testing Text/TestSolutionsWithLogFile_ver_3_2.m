%% Script to examine NetCDF data formats and check for NaN
% Note, you would carry out this test each time you load data.
% You should NOT test the whole file at the start
clear all
close all

%% Get user write or append to log file preference
%Get user input
clearLogFile = input("Would you like to clear current log file (Y/N): ", 's');
%Set write to log file mode dependent on user input
if clearLogFile == 'Y' || clearLogFile == 'y'
    logFileWriteMode = 'w';
else
    logFileWriteMode = 'a';
end

%% Test file with Errors
NaNErrors = 0;

%% Set file to test
DataFileName = 'TestFileNaN.nc';                                                % Define our test file
DataFileName = 'o3_surface_20180701000000.nc';                                  % Un-rem this line to see what happens 
                                                                                % with good data

Contents = ncinfo(DataFileName);                                                % Store the file content information in a variable

%% Create and open log file
LogFileName = 'AnalysisLog.txt';

% Create new log file, 'w' replaces the file if present. To continually
% append, use 'a'
LogID = fopen('AnalysisLog.txt', logFileWriteMode);
fprintf(LogID, '%s: Starting analysis of %s\n', datestr(now, 0), DataFileName);

StartLat = 1;
StartLon = 1;

fprintf('Testing files: %s\n', DataFileName)
for idxHour = 1:25
    
    for idxModel = 1:8
        Data(idxModel,:,:) = ncread(DataFileName, Contents.Variables(idxModel).Name,...
            [StartLat, StartLon, idxHour], [inf, inf, 1]); % 'inf' reads all the data
    end
    
    % Check for NaNs
    if any(isnan(Data), 'All')
        NaNErrors = 1;

        %% Display warning
        fprintf('NaNs present\n')
        ErrorModel = find(isnan(Data), 1, 'first');
        
        %% Find first error:
        fprintf('Analysis for hour %i is invalid, NaN errors recorded in model %s\n',...
            idxHour, Contents.Variables(ErrorModel).Name)
        
        % Write to log file
        fprintf(LogID, '%s: %s processing data hour %i\n', datestr(now, 0), 'NaN Error', idxHour);
    else
        % Write to log file
        fprintf(LogID, '%s: %s processing data hour %i\n', datestr(now, 0), 'Success', idxHour);
    end
    
end
fprintf(LogID, '\n');                                                           %Insert newline between newly appended log entries
fclose(LogID);

if ~NaNErrors
    fprintf('No errors!\n')
end