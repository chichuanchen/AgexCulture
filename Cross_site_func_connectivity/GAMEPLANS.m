%%%%% Game plan 1:

%% Preprocessing
% - Same preprocessing steps with original calibration data, EXCEPT no smoothing.
% - Bandpass filtered at [0.008 0.09] hz.

%% 1st level modeling
% - White matter and CSF were treated as nuisance regressors in first level model.
% - To extract WM and CSF signals across time-series, TPM from SPM12 were
% used (TPM.nii,2 for WM and TPM.nii,3 for CSF). TPMs were turned into
% binary masks using threshold at 0.5 and resliced to match functional voxel size.
% - Average signal across all voxels in masks were extracted using WMandCSFregressor.m
% The resulting variables were read thru R (make_nuisance_regressors.R), sliced and saved as txt files
% for each session per task. The txt files will be used in first level modeling as one of the multiple regressors.
% txt file names: nuisance_WM_CSF_sub-2_ses-8_task-visual_acq-EPI_bold.txt
% - make first level model and model estimation: f_connectivity/first_level/scripts/make_1stlevel_batches_with_mask_TW/US.m
% set implicit mask to -Inf and set explicit mask by
% making_combined_GMnWM_binary_threshold05.mat
% resulting derivatives (residual nifti files) are stored at
% /home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/first_level/derivatives_explicit_GW_mask/

%% Transforming volumns to formats that can be used to do correlations
% In function Convert4D2D_AXC.m, the inner function
% format_whole_brain_AXC.m transforms 4D images into 2D format, with each
% column as a time point and each row as a voxel, saved as var B.mat.
% ((In the original format_whole_brain_MI.m, it masks images first to reduce
% number of voxels to be processed. However in AXC project the 4D images 
% were already masked from 1st level. The unmasked voxels are NaNs, so in
% format_whole_brain_AXC.m we identify NaNs first then get rid of them to
% reduce number of voxels to be processed)) 
% (var nv = # of whole brain voxels, nvox = # of masked voxels).

%% Calculate voxel-wise time series correlation 
% AXC_calc_wholebraincorr.m calculates correlations between each voxels
% across time series. The resulting correlation matrix is symmetrical, with
% the diagonal being 1.


%% Transform correlation matrices into normalized Z maps
% Fishers Z transformation
% Transform