%% Plotting graphs in Matlab
clear all
close all

%% Show two plots on different y-axes
% 250 data processed
x1Vals = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
y1Vals = [58, 32, 23, 20, 18, 17, 16, 15, 15, 14, 15, 15];
figure(1)
yyaxis left
plot(x1Vals, y1Vals, '-bd')
xlabel('Number of Processors')
ylabel('Processing Time (Seconds)')
title('Processing Time vs Number of Processors')

% 5,000 data processed
x2Vals = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
y2Vals = [1624, 855, 606, 480, 407, 361, 325, 302, 282, 266, 257, 252];
figure(1)
yyaxis right
plot(x2Vals, y2Vals, '-rx')
xlabel('Number of Processors')
ylabel('Processing Time (Seconds)')
title('Processing Time vs Number of Processors')

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