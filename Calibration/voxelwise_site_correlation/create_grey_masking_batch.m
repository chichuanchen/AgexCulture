% input, first one being the grey matter binary mask


for subj = 1:4
    
    mkdir(['/home/.bml/Data/Bank1/Age_Culture/Calibration/grey_masked/sub-' num2str(subj) '/visual']);
    mkdir(['/home/.bml/Data/Bank1/Age_Culture/Calibration/grey_masked/sub-' num2str(subj) '/motor']);
    output_dir_visual = {['/home/.bml/Data/Bank1/Age_Culture/Calibration/grey_masked/sub-' num2str(subj) '/visual']};
    output_dir_motor = {['/home/.bml/Data/Bank1/Age_Culture/Calibration/grey_masked/sub-' num2str(subj) '/motor']};
    
    for sess = 1:12

        input_images_visual_TW = [
            {'/home/.bml/Data/Bank1/Age_Culture/Calibration/rgrey_mask_prob80.nii,1'} 
            {['/home/.bml/Data/Bank1/Age_Culture/Calibration/TW/Nifti/sub-' num2str(subj) '/ses-' num2str(sess) '/func/spmT_0007.nii,1']}
            ];
        input_images_motor_TW = [
            {'/home/.bml/Data/Bank1/Age_Culture/Calibration/rgrey_mask_prob80.nii,1'} 
            {['/home/.bml/Data/Bank1/Age_Culture/Calibration/TW/Nifti/sub-' num2str(subj) '/ses-' num2str(sess) '/func/spmT_0008.nii,1']}
            ];
        input_images_visual_US = [
            {'/home/.bml/Data/Bank1/Age_Culture/Calibration/rgrey_mask_prob80.nii,1'} 
            {['/home/.bml/Data/Bank1/Age_Culture/Calibration/US/Nifti/sub-' num2str(subj) '/ses-' num2str(sess) '/func/spmT_0007.nii,1']}
            ];
        input_images_motor_US = [
            {'/home/.bml/Data/Bank1/Age_Culture/Calibration/rgrey_mask_prob80.nii,1'} 
            {['/home/.bml/Data/Bank1/Age_Culture/Calibration/US/Nifti/sub-' num2str(subj) '/ses-' num2str(sess) '/func/spmT_0008.nii,1']}
            ];
              
            
        matlabbatch{1}.spm.util.imcalc.input = input_images_visual_TW;
        matlabbatch{1}.spm.util.imcalc.output = ['greymasked_' num2str(subj) '_' num2str(sess) '_visual_TW'];
        matlabbatch{1}.spm.util.imcalc.outdir = output_dir_visual;
        matlabbatch{1}.spm.util.imcalc.expression = 'i2.*i1';
        matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
        matlabbatch{1}.spm.util.imcalc.options.dmtx = 0;
        matlabbatch{1}.spm.util.imcalc.options.mask = 0;
        matlabbatch{1}.spm.util.imcalc.options.interp = 1;
        matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
        matlabbatch{2}.spm.util.imcalc.input = input_images_motor_TW;
        matlabbatch{2}.spm.util.imcalc.output = ['greymasked_' num2str(subj) '_' num2str(sess) '_motor_TW'];
        matlabbatch{2}.spm.util.imcalc.outdir = output_dir_motor;
        matlabbatch{2}.spm.util.imcalc.expression = 'i2.*i1';
        matlabbatch{2}.spm.util.imcalc.var = struct('name', {}, 'value', {});
        matlabbatch{2}.spm.util.imcalc.options.dmtx = 0;
        matlabbatch{2}.spm.util.imcalc.options.mask = 0;
        matlabbatch{2}.spm.util.imcalc.options.interp = 1;
        matlabbatch{2}.spm.util.imcalc.options.dtype = 4;
        matlabbatch{3}.spm.util.imcalc.input = input_images_visual_US;
        matlabbatch{3}.spm.util.imcalc.output = ['greymasked_' num2str(subj) '_' num2str(sess) '_visual_US'];
        matlabbatch{3}.spm.util.imcalc.outdir = output_dir_visual;
        matlabbatch{3}.spm.util.imcalc.expression = 'i2.*i1';
        matlabbatch{3}.spm.util.imcalc.var = struct('name', {}, 'value', {});
        matlabbatch{3}.spm.util.imcalc.options.dmtx = 0;
        matlabbatch{2}.spm.util.imcalc.options.mask = 0;
        matlabbatch{3}.spm.util.imcalc.options.interp = 1;
        matlabbatch{3}.spm.util.imcalc.options.dtype = 4;
        matlabbatch{4}.spm.util.imcalc.input = input_images_motor_US;
        matlabbatch{4}.spm.util.imcalc.output = ['greymasked_' num2str(subj) '_' num2str(sess) '_motor_US'];
        matlabbatch{4}.spm.util.imcalc.outdir = output_dir_motor;
        matlabbatch{4}.spm.util.imcalc.expression = 'i2.*i1';
        matlabbatch{4}.spm.util.imcalc.var = struct('name', {}, 'value', {});
        matlabbatch{4}.spm.util.imcalc.options.dmtx = 0;
        matlabbatch{4}.spm.util.imcalc.options.mask = 0;
        matlabbatch{4}.spm.util.imcalc.options.interp = 1;
        matlabbatch{4}.spm.util.imcalc.options.dtype = 4;


save(['grey_masking_' num2str(subj) '_' num2str(sess) '.mat'], 'matlabbatch')
spm_jobman('run', matlabbatch)

    end
end