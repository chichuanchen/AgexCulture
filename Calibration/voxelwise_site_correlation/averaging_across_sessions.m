% use ImCalc to get the mean and variance of the T values from 12 sessions 
% for each subject each task

PATH_from = '/bml/Data/Bank1/Age_Culture/Calibration/grey_masked/';
PATH_out = '/bml/Data/Bank1/Age_Culture/Calibration/across_sessions/';
for subj = 1:4
    
    % get visual files 
    subj_dir_v = [PATH_from 'sub-' num2str(subj) '/visual/'];
    % filter files by site
    v_TW_files = dir(fullfile([subj_dir_v], '*TW.nii'));
    v_US_files = dir(fullfile([subj_dir_v], '*US.nii'));
    
    % get motor files
    subj_dir_m = [PATH_from 'sub-' num2str(subj) '/motor/'];
    % filter files by site
    m_TW_files = dir(fullfile([subj_dir_m], '*TW.nii'));
    m_US_files = dir(fullfile([subj_dir_m], '*US.nii'));
    
    
    %% define input and output
    v_TW_input_files = fullfile([{v_TW_files(:).folder}]', [{v_TW_files(:).name}]');
    m_TW_input_files = fullfile([{m_TW_files(:).folder}]', [{m_TW_files(:).name}]');
    v_US_input_files = fullfile([{v_US_files(:).folder}]', [{v_US_files(:).name}]');
    m_US_input_files = fullfile([{m_US_files(:).folder}]', [{m_US_files(:).name}]');
    
    output_averaged_v_TW = ['greymasked_averaged_visual_TW_sub_' num2str(subj)];
    output_averaged_m_TW = ['greymasked_averaged_motor_TW_sub_' num2str(subj)]; 
    output_averaged_v_US = ['greymasked_averaged_visual_US_sub_' num2str(subj)]; 
    output_averaged_m_US = ['greymasked_averaged_motor_US_sub_' num2str(subj)]; 
    output_var_v_TW = ['greymasked_var_visual_TW_sub_' num2str(subj)];
    output_var_m_TW = ['greymasked_var_motor_TW_sub_' num2str(subj)]; 
    output_var_v_US = ['greymasked_var_visual_US_sub_' num2str(subj)]; 
    output_var_m_US = ['greymasked_var_motor_US_sub_' num2str(subj)]; 
    

%%
matlabbatch{1}.spm.util.imcalc.input = v_TW_input_files;
%%
matlabbatch{1}.spm.util.imcalc.output = output_averaged_v_TW;
matlabbatch{1}.spm.util.imcalc.outdir = {PATH_out};
matlabbatch{1}.spm.util.imcalc.expression = 'mean(X)';
matlabbatch{1}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{1}.spm.util.imcalc.options.dmtx = 1;
matlabbatch{1}.spm.util.imcalc.options.mask = 0;
matlabbatch{1}.spm.util.imcalc.options.interp = 1;
matlabbatch{1}.spm.util.imcalc.options.dtype = 4;
%%
matlabbatch{2}.spm.util.imcalc.input = m_TW_input_files;
%%
matlabbatch{2}.spm.util.imcalc.output = output_averaged_m_TW;
matlabbatch{2}.spm.util.imcalc.outdir = {PATH_out};
matlabbatch{2}.spm.util.imcalc.expression = 'mean(X)';
matlabbatch{2}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{2}.spm.util.imcalc.options.dmtx = 1;
matlabbatch{2}.spm.util.imcalc.options.mask = 0;
matlabbatch{2}.spm.util.imcalc.options.interp = 1;
matlabbatch{2}.spm.util.imcalc.options.dtype = 4;
%%
matlabbatch{3}.spm.util.imcalc.input = v_US_input_files;
%%
matlabbatch{3}.spm.util.imcalc.output = output_averaged_v_US;
matlabbatch{3}.spm.util.imcalc.outdir = {PATH_out};
matlabbatch{3}.spm.util.imcalc.expression = 'mean(X)';
matlabbatch{3}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{3}.spm.util.imcalc.options.dmtx = 1;
matlabbatch{3}.spm.util.imcalc.options.mask = 0;
matlabbatch{3}.spm.util.imcalc.options.interp = 1;
matlabbatch{3}.spm.util.imcalc.options.dtype = 4;
%%
matlabbatch{4}.spm.util.imcalc.input = m_US_input_files;
%%
matlabbatch{4}.spm.util.imcalc.output = output_averaged_m_US;
matlabbatch{4}.spm.util.imcalc.outdir = {PATH_out};
matlabbatch{4}.spm.util.imcalc.expression = 'mean(X)';
matlabbatch{4}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{4}.spm.util.imcalc.options.dmtx = 1;
matlabbatch{4}.spm.util.imcalc.options.mask = 0;
matlabbatch{4}.spm.util.imcalc.options.interp = 1;
matlabbatch{4}.spm.util.imcalc.options.dtype = 4;
%%
matlabbatch{5}.spm.util.imcalc.input = v_TW_input_files;
%%
matlabbatch{5}.spm.util.imcalc.output = output_var_v_TW;
matlabbatch{5}.spm.util.imcalc.outdir = {PATH_out};
matlabbatch{5}.spm.util.imcalc.expression = 'var(X)';
matlabbatch{5}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{5}.spm.util.imcalc.options.dmtx = 1;
matlabbatch{5}.spm.util.imcalc.options.mask = 0;
matlabbatch{5}.spm.util.imcalc.options.interp = 1;
matlabbatch{5}.spm.util.imcalc.options.dtype = 4;
%%
matlabbatch{6}.spm.util.imcalc.input = m_TW_input_files;
%%
matlabbatch{6}.spm.util.imcalc.output = output_var_m_TW;
matlabbatch{6}.spm.util.imcalc.outdir = {PATH_out};
matlabbatch{6}.spm.util.imcalc.expression = 'var(X)';
matlabbatch{6}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{6}.spm.util.imcalc.options.dmtx = 1;
matlabbatch{6}.spm.util.imcalc.options.mask = 0;
matlabbatch{6}.spm.util.imcalc.options.interp = 1;
matlabbatch{6}.spm.util.imcalc.options.dtype = 4;
%%
matlabbatch{7}.spm.util.imcalc.input = v_US_input_files;
%%
matlabbatch{7}.spm.util.imcalc.output = output_var_v_US;
matlabbatch{7}.spm.util.imcalc.outdir = {PATH_out};
matlabbatch{7}.spm.util.imcalc.expression = 'var(X)';
matlabbatch{7}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{7}.spm.util.imcalc.options.dmtx = 1;
matlabbatch{7}.spm.util.imcalc.options.mask = 0;
matlabbatch{7}.spm.util.imcalc.options.interp = 1;
matlabbatch{7}.spm.util.imcalc.options.dtype = 4;
%%
matlabbatch{8}.spm.util.imcalc.input = m_US_input_files;
%%
matlabbatch{8}.spm.util.imcalc.output = output_var_m_US;
matlabbatch{8}.spm.util.imcalc.outdir = {PATH_out};
matlabbatch{8}.spm.util.imcalc.expression = 'var(X)';
matlabbatch{8}.spm.util.imcalc.var = struct('name', {}, 'value', {});
matlabbatch{8}.spm.util.imcalc.options.dmtx = 1;
matlabbatch{8}.spm.util.imcalc.options.mask = 0;
matlabbatch{8}.spm.util.imcalc.options.interp = 1;
matlabbatch{8}.spm.util.imcalc.options.dtype = 4;

save(['across_sessions_mean_and_var_' num2str(subj) '.mat'], 'matlabbatch')
spm_jobman('run', matlabbatch)

end
