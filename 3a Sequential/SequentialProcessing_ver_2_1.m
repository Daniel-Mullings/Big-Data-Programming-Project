%% Script: Allows you to open and process data in sequential
clear all
close all

FileName = 'o3_surface_20180701000000.nc';

% Process specifc data sub-set size (150), for hours (3), in dataset (FileName)
subSequentialProcessing_ver_2_1(FileName, 3, 150);