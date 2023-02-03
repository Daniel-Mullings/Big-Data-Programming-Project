%% Function: Print our results
% Input: "AllDataMem" = Memory required to load all data, 
% "HourDataMem" = Memory required to load all data for a specified single hour, 
% "HourMem" = Greatest amount of memory required to load single hour of data
% Output: None
function[] = Reportresults_ver_1_2(AllDataMem, HourDataMem, HourMem)
    fprintf('\nResults:\n')
    fprintf('Memory used for all data: %.2f MB\n', AllDataMem)
    fprintf('Memory used for hourly data: %.2f MB\n', HourDataMem)
    fprintf('Maximum memory used hourly = %.2f MB\n', HourMem)
    fprintf('Hourly memory as fraction of all data = %.2f\n\n', HourMem / AllDataMem)
end