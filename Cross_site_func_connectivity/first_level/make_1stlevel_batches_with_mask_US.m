%cd '/home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/'
clear
%%%% CHOOSE SITE
%site = 'TW';
site = 'US';

GW_mask='/home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/first_level/masks/Grey_and_White_mask_threshold_05.nii';
%%%%

PATH_Nifti = ['/home/.bml/Data/Bank1/Age_Culture/Calibration/' site '/Nifti/'];
PATH_FC_1st = ['/home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/first_level/derivatives_explicit_GW_mask/'];


NUM_SUBJ = 4;
NUM_SESS = 12;

NUM_VOL_v = 192;
NUM_VOL_m = 462;

for subj = 1:NUM_SUBJ
    for sess = 1:NUM_SESS
        
        
        % input dir
        input_dir = [PATH_Nifti 'sub-' num2str(subj) '/ses-' num2str(sess) '/func'];
                
        % output dir
        output_dir_v = [PATH_FC_1st 'sub-' num2str(subj) '/ses-' num2str(sess) '/' site '/visual/'];
        output_dir_m = [PATH_FC_1st 'sub-' num2str(subj) '/ses-' num2str(sess) '/' site '/motor/'];
        
        
        %% bandpassed no smooth EPI (bwabu)
        epi_v = {};
        epi_m = {};
      
        % should look something like this:
        % bwabusub-1_ses-1_task-visual_acq-EPI_bold.nii, 1 ...
        for vol_v = 1:NUM_VOL_v       
            epi_v = [epi_v; {[input_dir filesep 'bwabusub-' num2str(subj) '_ses-' num2str(sess) ...
            '_task-visual_acq-EPI_bold.nii,' num2str(vol_v)]}];        
        end
        for vol_m = 1:NUM_VOL_m       
            epi_m = [epi_m; {[input_dir filesep 'bwabusub-' num2str(subj) '_ses-' num2str(sess) ...
            '_task-motor_acq-EPI_bold.nii,' num2str(vol_m)]}];        
        end
        
        
             
       
        %% head movement regressor
        rp_v = {[input_dir filesep 'rp_sub-' num2str(subj) '_ses-' num2str(sess) ...
            '_task-visual_acq-EPI_bold.txt']};
        rp_m = {[input_dir filesep 'rp_sub-' num2str(subj) '_ses-' num2str(sess) ...
            '_task-motor_acq-EPI_bold.txt']};
        
        %% nuisance regressor (WM and CSF)
        % nuisance_WM_CSF_sub-4_ses-12_task-visual_acq-EPI_bold.txt
        nui_v = {[input_dir filesep 'nuisance_WM_CSF_sub-' num2str(subj) '_ses-' num2str(sess) ...
            '_task-visual_acq-EPI_bold.txt']};
        nui_m = {[input_dir filesep 'nuisance_WM_CSF_sub-' num2str(subj) '_ses-' num2str(sess) ...
            '_task-motor_acq-EPI_bold.txt']};



matlabbatch{1}.spm.stats.fmri_spec.dir = {output_dir_v};
matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 0.67;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 64;
matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
%%
matlabbatch{1}.spm.stats.fmri_spec.sess.scans = epi_v;
%%
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).name = 'fixation';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).onset = [0
                                                         40
                                                         80];
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).duration = 20;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(1).orth = 1;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).name = 'checkerboard';
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).onset = [20
                                                         60
                                                         100];
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).duration = 20;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.cond(2).orth = 1;
matlabbatch{1}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{1}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{1}.spm.stats.fmri_spec.sess.multi_reg = [rp_v nui_v]';
matlabbatch{1}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
matlabbatch{1}.spm.stats.fmri_spec.mthresh = -Inf;
matlabbatch{1}.spm.stats.fmri_spec.mask = {GW_mask};
matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 1;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;

matlabbatch{3}.spm.stats.fmri_spec.dir = {output_dir_m};
matlabbatch{3}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{3}.spm.stats.fmri_spec.timing.RT = 0.67;
matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t = 64;
matlabbatch{3}.spm.stats.fmri_spec.timing.fmri_t0 = 1;
%%
matlabbatch{3}.spm.stats.fmri_spec.sess.scans = epi_m;
%%
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(1).name = 'REST';
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(1).onset = [3
                                                         49
                                                         95
                                                         141
                                                         187
                                                         233
                                                         279];
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(1).duration = 20;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(1).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(1).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(1).orth = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(2).name = 'PRESS';
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(2).onset = [26
                                                         72
                                                         118
                                                         164
                                                         210
                                                         256];
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(2).duration = 20;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(2).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(2).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(2).orth = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(3).name = 'text_REST';
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(3).onset = [0
                                                         46
                                                         92
                                                         138
                                                         184
                                                         230
                                                         276];
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(3).duration = 3;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(3).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(3).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(3).orth = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(4).name = 'text_PRESS';
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(4).onset = [23
                                                         69
                                                         115
                                                         161
                                                         207
                                                         253];
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(4).duration = 3;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(4).tmod = 0;
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(4).pmod = struct('name', {}, 'param', {}, 'poly', {});
matlabbatch{3}.spm.stats.fmri_spec.sess.cond(4).orth = 1;
matlabbatch{3}.spm.stats.fmri_spec.sess.multi = {''};
matlabbatch{3}.spm.stats.fmri_spec.sess.regress = struct('name', {}, 'val', {});
matlabbatch{3}.spm.stats.fmri_spec.sess.multi_reg = [rp_m nui_m]';
matlabbatch{3}.spm.stats.fmri_spec.sess.hpf = 128;
matlabbatch{3}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{3}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{3}.spm.stats.fmri_spec.volt = 1;
matlabbatch{3}.spm.stats.fmri_spec.global = 'None';
matlabbatch{3}.spm.stats.fmri_spec.mthresh = -Inf;
matlabbatch{3}.spm.stats.fmri_spec.mask = {GW_mask};
matlabbatch{3}.spm.stats.fmri_spec.cvi = 'AR(1)';
matlabbatch{4}.spm.stats.fmri_est.spmmat(1) = cfg_dep('fMRI model specification: SPM.mat File', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{4}.spm.stats.fmri_est.write_residuals = 1;
matlabbatch{4}.spm.stats.fmri_est.method.Classical = 1;

save(['fc_firstlevel_masked_' site '_' num2str(subj) '_' num2str(sess) '.mat'], 'matlabbatch')

spm_jobman('run', matlabbatch)


    end
end