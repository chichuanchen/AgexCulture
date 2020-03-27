%% To assess SNR across sites
% first determine the regions to compare: one ROI in the brain and one
% outside the brain.
% use the peak voxel coordinate in site x task x subject interaction as 
% 6 mm radius ROI center: -9, -97, 11 
%% Step 1: make 6 mm radius sphere ROIs using marsbar, 
% one centered at -9, -97, 11 
% one for noise outside the brain (region free of phase-encode ghosts?): -23, -104, 69
% on for signal in the central ventricle: 0 12 8
% (one for signal within the brain (sinus regions or signal void): 3, 17,
% -39)
% one for signal in the posterior corpus cullosum at 0 -35 15
%% Step 2: 
% gather mask images, functional images (after getting in cell array, char() to make character array)
% then feed it into [Ym R info] = extract_voxel_values(mask,data,sp)
% to automate the process, make 'mask' and 'data' into variables
% save output extracted values and their info to variables: TW_v, TW_m US_v, US_m
% read these variables into R for further analyses and visualization
% -------> run SNR_ROI_extract_values.m


