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

%% Plot results as graph
hold on;                                                                        % Keep current graph for new data entry

% Get data for plotting
for idxOuter = 1:length(DataOptions)                                            % Iterate through DataOptions
    DataParameter = DataOptions(idxOuter);
    subsetResults = Results(Results(:, 2) == DataParameter, :);                 % subsetResults contains results for single 
                                                                                % DataOptions across varying processors (Workers)
                                                                                
    plot(subsetResults(:, 1), subsetResults(:, 3), '-o');                       % Plot x (processor (Worker) count) and 
                                                                                % y (Processing time (Seconds)) 
                                                                                % with points decorated with 'o'
end

% X-axis only display whole numbers
xticks(min(WorkerOptions):max(WorkerOptions));

% Add axis labels, title, and legend
xlabel('Number of Processors');                                                 % X-axis label
ylabel('Processing Time (Seconds)');                                            % Y-axis label
title('Processing Time vs Number of Processors');                               % Graph title

% Generate legend labels
DataLabels = {};                                                                % Store list of data labels
for idx = 1:length(DataOptions)                                                 % Iterate through DataOptions
    DataLabels{idx} = strcat(num2str(DataOptions(idx)), " Data");               % Concatenate " Data" to DataOptions value and
                                                                                % store in DataLabels
end
legend(DataLabels);                                                             % Legend, multiple lines displaying results

hold off;                                                                       % Discard current graph for new data entry  

%% Log results as logfile
% Open log file
LogFileName = 'ParallelProcessing_TestingLogfile.txt';
LogID = fopen(LogFileName, 'a');

% Write log to logfile
fprintf(LogID, '[%s] Parallel Processing: Processing Time vs Data Sub-set Size w/ Dynamic Processor (Worker) Count (Results Table):\n', ...
    datestr(now, 0));
fprintf(LogID, '[%s] Record Structure   : {[Processor (Worker) Count)], [Data Sub-set Size], [Processing Time (Seconds)]}\n', ...
    datestr(now, 0));
for idx = 1:size(Results)
    fprintf(LogID, '# -------------------- %d, %d, %.2f\n', Results(idx, 1), Results(idx, 2), Results(idx, 3));
end
fprintf(LogID, '\n');