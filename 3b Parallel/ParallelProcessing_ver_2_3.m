%% Script: Allows you to open and process data in parallel
clear all
close all

FileName = 'o3_surface_20180701000000.nc';

% Using 12 processors (workers), process specific data sub-set size (5000), for hours (25), in dataset (FileName)
subParallelProcessing_ver_2_3(FileName, 5000, 25, 12);