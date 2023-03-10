%% Script: Allows you to open and process data in sequential
FileName = 'o3_surface_20180701000000.nc';

DataOptions = [50, 150, 1500];                                                  % Size of data sub-sets to process
Hours = 25;                                                                     % Hours to process
Results = [];                                                                   % Store list of results for processing 
                                                                                % each data sub-set

%% Process various data sub-sets across various hours
% Get results
for idx = 1:length(DataOptions)                                                 % Iterate through DataOptions
    DataParameter = DataOptions(idx);

    % Process specifc data sub-set size (LoopParameter), for hours (Hours), in dataset (FileName)
    RunTime = subSequentialProcessing_ver_4_0(FileName, ...
        Hours, DataParameter);
    Results(idx,:) = [DataParameter, round(RunTime, 2)];
end

%% Print results as table
% Create table
TableHeaders = {'Data Sub-set', ['Processing time (Seconds) for ' num2str(Hours) ' Hours']};
ResultsTable = table(Results(:,1), Results(:,2), 'VariableNames', TableHeaders);

% Print table
fprintf('----------------------------------------------------------------------------\n');
fprintf('Sequential Processing: Data Sub-set Size vs Processing Time (Results Table):\n');
fprintf('----------------------------------------------------------------------------\n\n');
disp(ResultsTable);
fprintf('----------------------------------------------------------------------------\n');