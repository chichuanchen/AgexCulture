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
                '/func/swabusub-' num2str(subj) '_ses-' num2str(sess) '_task-visual_acq-EPI_bold.nii,' num2str(v)]};
            VISUAL_US{1, subj}(v, sess)= {[PATH_US_Nifti 'sub-' num2str(subj) '/ses-' num2str(sess) ...
                '/func/swabusub-' num2str(subj) '_ses-' num2str(sess) '_task-visual_acq-EPI_bold.nii,' num2str(v)]};
        end
        
        for m = 1:VOL_NUM_motor        
            MOTOR_TW{1, subj}(m, sess)= {[PATH_TW_Nifti 'sub-' num2str(subj) '/ses-' num2str(sess) ...
                '/func/swabusub-' num2str(subj) '_ses-' num2str(sess) '_task-motor_acq-EPI_bold.nii,' num2str(m)]};
            MOTOR_US{1, subj}(m, sess)= {[PATH_US_Nifti 'sub-' num2str(subj) '/ses-' num2str(sess) ...
                '/func/swabusub-' num2str(subj) '_ses-' num2str(sess) '_task-motor_acq-EPI_bold.nii,' num2str(m)]};
        end
    end  
end

%% choose masks
mask = char(...
    '/home/.bml/Data/Bank1/Age_Culture/Calibration/SNR_site_comparison/ROI_mask/sphere_6mm_3interactionpeak_-9_-97_11_roi.mat', ...
    '/home/.bml/Data/Bank1/Age_Culture/Calibration/SNR_site_comparison/ROI_mask/sphere_6mm_outsidebrain_-23_-104_69_roi.mat  ', ...
    '/home/.bml/Data/Bank1/Age_Culture/Calibration/SNR_site_comparison/ROI_mask/sphere_6mm_postcorpuscallosum_0_-35_15_roi.mat', ...
    '/home/.bml/Data/Bank1/Age_Culture/Calibration/SNR_site_comparison/ROI_mask/sphere_6mm_central_ventricle_0_12_8_roi.mat', ...
    '/home/.bml/Data/Bank1/Age_Culture/Calibration/SNR_site_comparison/ROI_mask/sphere_6mm_sinus_3_17_-39_roi.mat            ');

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

data = data_TW_motor;
[Ym_TW_m R_TW_m info_TW_m] = extract_voxel_values(mask,data,sp);

data = data_US_visual;
[Ym_US_v R_US_v info_US_v] = extract_voxel_values(mask,data,sp);

data = data_US_motor;
[Ym_US_m R_US_m info_US_m] = extract_voxel_values(mask,data,sp);


%% save variables so can be read in R for further processing
save('TW_v', 'Ym_TW_v', 'R_TW_v', 'info_TW_v');
save('TW_m', 'Ym_TW_m', 'R_TW_m', 'info_TW_m');
save('US_v', 'Ym_US_v', 'R_US_v', 'info_US_v');
save('US_m', 'Ym_US_m', 'R_US_m', 'info_US_m');
