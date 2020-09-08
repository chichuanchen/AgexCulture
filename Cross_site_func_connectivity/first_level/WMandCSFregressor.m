% For our first level GLM model, aside from HRF modeling of task events and
% motion regressors, we also need to regress out nuisance regressors such as
% white matter and CSF information.

% To do this, first mask volumes with TPM masks (2 for WM, 3 for CSF) then
% get the mean of all the voxels in a volume. Put the two variables into
% the same txt file with motions regressors. This txt file then can be used
% to be the "multiple regressor".

% TPM: copy file from spm12, then reslice voxel size to same as EPI images,
% then make binary masks using ImCal.


%% setup 
PATH_TW_Nifti = '/home/.bml/Data/Bank1/Age_Culture/Calibration/TW/Nifti/';
PATH_US_Nifti = '/home/.bml/Data/Bank1/Age_Culture/Calibration/US/Nifti/';
VOL_NUM_visual = 192;
VOL_NUM_motor = 462;
NUM_SESS = 12;

VISUAL_TW = {};
MOTOR_TW = {};
VISUAL_US = {};
MOTOR_US = {};
for subj = 1:4
    for sess = 1:12
        for v = 1:VOL_NUM_visual
            VISUAL_TW{1, subj}(v, sess)= {[PATH_TW_Nifti 'sub-' num2str(subj) '/ses-' num2str(sess) ...
                '/func/bwabusub-' num2str(subj) '_ses-' num2str(sess) '_task-visual_acq-EPI_bold.nii,' num2str(v)]};
            VISUAL_US{1, subj}(v, sess)= {[PATH_US_Nifti 'sub-' num2str(subj) '/ses-' num2str(sess) ...
                '/func/bwabusub-' num2str(subj) '_ses-' num2str(sess) '_task-visual_acq-EPI_bold.nii,' num2str(v)]};
        end
        
        for m = 1:VOL_NUM_motor        
            MOTOR_TW{1, subj}(m, sess)= {[PATH_TW_Nifti 'sub-' num2str(subj) '/ses-' num2str(sess) ...
                '/func/bwabusub-' num2str(subj) '_ses-' num2str(sess) '_task-motor_acq-EPI_bold.nii,' num2str(m)]};
            MOTOR_US{1, subj}(m, sess)= {[PATH_US_Nifti 'sub-' num2str(subj) '/ses-' num2str(sess) ...
                '/func/bwabusub-' num2str(subj) '_ses-' num2str(sess) '_task-motor_acq-EPI_bold.nii,' num2str(m)]};
        end
    end  
end

%% choose masks
mask = char(...
    '/home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/first_level/masks/WMmask_binary_threshould_05_roi.mat', ...
    '/home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/first_level/masks/CSFmask_binary_threshould_05_roi.mat');

%% choose data VISUAL{subj}(:,sess)
% data = char(VISUAL{1}(:,:)); % = character array of sub 1, first session
data_TW_visual = [];
data_TW_motor = [];
data_US_visual = [];
data_US_motor = [];

for subj = 1:4
    
    data_TW_visual = [data_TW_visual; char(VISUAL_TW{subj}(:,:))];
    data_TW_motor = [data_TW_motor; char(MOTOR_TW{subj}(:,:))];
    data_US_visual = [data_US_visual; char(VISUAL_US{subj}(:,:))];
    data_US_motor = [data_US_motor; char(MOTOR_US{subj}(:,:))];    
    
end


%%
sp = 'mni';

%% run function
data = data_TW_visual;
[Ym_TW_v R_TW_v info_TW_v] = extract_voxel_values(mask,data,sp);
save('TW_v', 'Ym_TW_v', 'R_TW_v', 'info_TW_v');


data = data_TW_motor;
[Ym_TW_m R_TW_m info_TW_m] = extract_voxel_values(mask,data,sp);
save('TW_m', 'Ym_TW_m', 'R_TW_m', 'info_TW_m');

data = data_US_visual;
[Ym_US_v R_US_v info_US_v] = extract_voxel_values(mask,data,sp);
save('US_v', 'Ym_US_v', 'R_US_v', 'info_US_v');

data = data_US_motor;
[Ym_US_m R_US_m info_US_m] = extract_voxel_values(mask,data,sp);
save('US_m', 'Ym_US_m', 'R_US_m', 'info_US_m');

%% save variables so can be read in R for further processing



