% Normalise to MNI space via SST. For later voxel-wise manipulations, no
% smoothing (FWHM = 0)
% 2020/4/27 edited CC

%% Site of data: US
for subj = 1:4
    for sess = 1:12
        SST = {['/home/.bml/Data/Bank1/Age_Culture/Calibration/US/Nifti/sub-1/ses-1/anat/Calibration_2sites_4subjects_6.nii']};
        FlowField = {['/home/.bml/Data/Bank1/Age_Culture/Calibration/US/Nifti/sub-' num2str(subj) '/ses-1/anat/u_rc1sub-' num2str(subj) '_ses-1_T1W_Calibration_2sites_4subjects.nii']};
        Visual = ['/home/.bml/Data/Bank1/Age_Culture/Calibration/US/Nifti/sub-' num2str(subj) '/ses-' num2str(sess) '/func/abusub-' num2str(subj) '_ses-' num2str(sess) '_task-motor_acq-EPI_bold.nii'];
        Motor = ['/home/.bml/Data/Bank1/Age_Culture/Calibration/US/Nifti/sub-' num2str(subj) '/ses-' num2str(sess) '/func/abusub-' num2str(subj) '_ses-' num2str(sess) '_task-visual_acq-EPI_bold.nii'];
        matlabbatch{1}.spm.tools.dartel.mni_norm.template = SST;
        matlabbatch{1}.spm.tools.dartel.mni_norm.data.subj.flowfield = FlowField;
        matlabbatch{1}.spm.tools.dartel.mni_norm.data.subj.images = {
                                                                     Visual
                                                                     Motor
                                                                     };
        matlabbatch{1}.spm.tools.dartel.mni_norm.vox = [2.3 2.3 2.3];
        matlabbatch{1}.spm.tools.dartel.mni_norm.bb = [-78 -112 -70
                                                       78 76 85];
        matlabbatch{1}.spm.tools.dartel.mni_norm.preserve = 0;
        matlabbatch{1}.spm.tools.dartel.mni_norm.fwhm = [0 0 0];

        save(['fc_US_preprocess_NormaliseToMNI_' num2str(subj) '_' num2str(sess) '.mat'], 'matlabbatch')
        spm_jobman('run', matlabbatch)
    end
end