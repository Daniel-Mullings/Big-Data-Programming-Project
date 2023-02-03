%% Function: Load all the model data together
% Input: "FileName" = File containing data
% Output: "AllDataMem" = Value representing memory required to load all data
function[AllDataMem] = LoadAllData_ver_1_2(FileName)

    Contents = ncinfo(FileName);                                                % Store the file content information in a variable
    
    for idx = 1: 8
        AllData(idx,:,:,:) = ncread(FileName, Contents.Variables(idx).Name);
        fprintf('Loading %s\n', Contents.Variables(idx).Name);                  % Display loading information
    end
    
    AllDataMem = whos('AllData').bytes/1000000;
    fprintf('Memory used for all data: %.3f MB\n', AllDataMem)
end