%% goal: to plot 2 figures for each subject each task, both scatter plots of all (masked) voxels, 
% the first one with averaged T value (across 12 sessions) from each site as axises, 
% and the second one wtih variance of T values across 12 sessios from each
% site as axises.

%% step 1: make grey matter mask
% binary grey matter mask, made by ImCalc thresholding at 0.8 from tpm.nii,1 then resliced to match voxel size 
%% step 2: multiply mask with target T value maps thru ImCalc
% run create_grey_masking_batch.m
%% step 3: calculate mean and variance of each subject, each site across 12 sessions
% run averaging_across_sessions.m
%% step 4: read voxel values from .nii files, plot scatter plots
% for each subject, 4 plots: visual mean, visual var, motor mean, motor var
% run read_voxel_values_and_plot.m

