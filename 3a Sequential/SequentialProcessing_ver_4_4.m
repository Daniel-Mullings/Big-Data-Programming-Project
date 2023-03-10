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

%% Plot results as graph
% Get data for plotting
x = Results(:, 1);                                                              % X-axis data sub-set size
y = Results(:, 2);                                                              % Y-axis processing time (Seconds)

% Plot results
plot(x, y, 'o-');                                                               % Plot x and y with points decorated with 'o'

% Add axis labels, title, and legend
xlabel('Data Sub-set');                                                         % X-axis label
ylabel('Processing Time (Seconds)');                                            % Y-axis label
title(sprintf('Processing Time vs Data Sub-set for %d Hours %d - %d', Hours));  % Graph title
legend('Results');                                                              % Legend, single line displaying results

%% Log results as logfile
% Open log file
LogFileName = 'SequentialProcessing_TestingLogfile.txt';
LogID = fopen(LogFileName, 'a');

% Write log to logfile
fprintf(LogID, '[%s] Sequential Processing: Processing Time vs Data Sub-set Size (Results Table):\n', datestr(now, 0));
fprintf(LogID, '[%s] Record Structure     : {[Data Sub-set Size], [Processing Time (Seconds)]}\n', datestr(now, 0));
for idx = 1:size(Results)
    fprintf(LogID, '# -------------------- %d, %.2f\n', Results(idx, 1), Results(idx, 2));
end
fprintf(LogID, '\n');