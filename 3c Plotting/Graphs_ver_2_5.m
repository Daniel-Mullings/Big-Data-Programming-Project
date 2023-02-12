%% Plotting graphs in Matab
clear all
close all

% Generate graph with X-Axis 1-12 Processor Count, 
% Y-Axis Left 250 data sub-set and Y-Axis Right 5000 data sub-set processing time
subGraphs_ver_2_5([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], ...
                  [58, 32, 23, 20, 18, 17, 16, 15, 15, 14, 15, 15], ...
                  [1624, 855, 606, 480, 407, 361, 325, 302, 282, 266, 257, 252]);