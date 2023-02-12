%% Function: Plotting graphs in MatLab
% Input: "x1Vals" = X-Axis values, 
% "y1Vals" = Y-Axis, Left side values, "y2Vals" = Y-Axis, Right side values
% Output: None
function[] = subGraphs_ver_2_5(x1Vals, y1Vals, y2Vals)
    x2Vals = x1Vals;
    
    %% Show two plots on different y-axes
    xlabel('Number of Processors')
    ylabel('Processing Time (Seconds)')
    title('Processing Time vs Number of Processors')
    figure(1)
    
    % 250 data processed
    yyaxis left
    plot(x1Vals, y1Vals, '-bd')
    
    % 5,000 data processed
    yyaxis right
    plot(x2Vals, y2Vals, '-rx')
    legend('250 Data', '5,000 Data')
    
    %% Show two plots on same y-axis
    % Mean processing time
    y1MeanVals = y1Vals / 250;
    y2MeanVals = y2Vals / 5000;
    
    figure(2)
    plot(x1Vals, y1MeanVals, '-bd')
    hold on
    plot(x2Vals, y2MeanVals, '-rx')
    xlabel('Number of Processors')
    ylabel('Processing Time (Seconds)')
    title('Mean Processing Time vs Number of Processors')
    legend('250 Data', '5,000 Data')
end