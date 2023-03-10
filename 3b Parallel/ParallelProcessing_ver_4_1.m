%% Script: Allows you to open and process data in parallel
FileName = 'o3_surface_20180701000000.nc';

DataOptions = [50, 150, 1500];                                                  % Size of data sub-sets to process
WorkerOptions = [2, 4, 6, 8, 10, 12];                                           % Number of processors (Workers) to use in parallel
Hours = 25;                                                                     % Number of hours to process
Results = [];                                                                   % Store list of results for processing 
                                                                                % each data sub-set

%% Process various data sub-sets using various processors (workers)
% Get results
for idxOuter = 1:length(DataOptions)                                            % Iterate through DataOptions
    DataParameter = DataOptions(idxOuter);

    for idxInner = 1:length(WorkerOptions)                                      % Iterate through WorkerOptions 
                                                                                % (i.e Processor (Worker) count)
        WorkerParameter = WorkerOptions(idxInner);
        
        % Using (WorkerParameter) processors (workers), process specifc data sub-set size (5000), 
        % for hours (25), in dataset (FileName)
        RunTime = subParallelProcessing_ver_4_1(FileName, Hours, DataParameter, WorkerParameter);
        Results = [Results; WorkerParameter, DataParameter, round(RunTime, 2)];
    end
end

%% Print results as table
% Create table
TableHeaders = {'Processor (Worker) Count', 'Data Sub-set', ['Processing time (Seconds) for ' num2str(Hours) ' Hours']};
ResultsTable = table(Results(:,1), Results(:,2), Results(:,3), 'VariableNames', TableHeaders);

% Print table
fprintf('------------------------------------------------------------------------------------------\n');
fprintf('Parallel Processing: Data Sub-set Size vs Processing Time (Results Table):\n');
fprintf('------------------------------------------------------------------------------------------\n\n');
disp(ResultsTable);
fprintf('------------------------------------------------------------------------------------------\n');