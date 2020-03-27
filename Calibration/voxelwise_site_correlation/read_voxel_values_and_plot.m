PATH_input_dir = '/bml/Data/Bank1/Age_Culture/Calibration/voxelwise_site_correlation/across_sessions/';

for subj = 1:4
    
    % x and y for plot 1 visual mean
    US_V_mean = spm_read_vols(spm_vol([PATH_input_dir 'greymasked_averaged_visual_US_sub_' num2str(subj) '.nii']));
    US_V_mean_vec = US_V_mean(:);
    
    TW_V_mean = spm_read_vols(spm_vol([PATH_input_dir 'greymasked_averaged_visual_TW_sub_' num2str(subj) '.nii']));
    TW_V_mean_vec = TW_V_mean(:);
    
    % x and y for plot 2 visual variance
    US_V_var = spm_read_vols(spm_vol([PATH_input_dir 'greymasked_var_visual_US_sub_' num2str(subj) '.nii']));
    US_V_var_vec = US_V_var(:);    
    
    TW_V_var = spm_read_vols(spm_vol([PATH_input_dir 'greymasked_var_visual_TW_sub_' num2str(subj) '.nii']));
    TW_V_var_vec = TW_V_var(:);
    
    % x and y for plot 3 motor mean
    US_M_mean = spm_read_vols(spm_vol([PATH_input_dir 'greymasked_averaged_motor_US_sub_' num2str(subj) '.nii']));
    US_M_mean_vec = US_M_mean(:);
    
    TW_M_mean = spm_read_vols(spm_vol([PATH_input_dir 'greymasked_averaged_motor_TW_sub_' num2str(subj) '.nii']));
    TW_M_mean_vec = TW_M_mean(:);
    
    % x and y for plot 4 motor variance
    US_M_var = spm_read_vols(spm_vol([PATH_input_dir 'greymasked_var_motor_US_sub_' num2str(subj) '.nii']));
    US_M_var_vec = US_M_var(:);
    
    TW_M_var = spm_read_vols(spm_vol([PATH_input_dir 'greymasked_var_motor_TW_sub_' num2str(subj) '.nii']));
    TW_M_var_vec = TW_M_var(:);
    
    
    %% save variables so can be read in R for further processing
    save(['v_mean_' num2str(subj)], 'US_V_mean_vec', 'TW_V_mean_vec');   
    save(['v_variance_' num2str(subj)], 'US_V_var_vec', 'TW_V_var_vec');
    save(['m_mean_' num2str(subj)], 'US_M_mean_vec', 'TW_M_mean_vec');
    save(['m_variance_' num2str(subj)], 'US_M_var_vec', 'TW_M_var_vec');
    

    
%     %% plots
%     
%     %fig1
%     fig1_empty = figure('Color', [1 1 1]);
%     
%     fig1 = plot(US_V_mean(:), TW_V_mean(:), 'o');
%     title(['Subject ' num2str(subj) ' mean voxel T values across 12 visual sessions']);
%     xlabel('US');
%     ylabel('TW');
%     refline(1,0);
%     
%     %saveas(fig1, fullfile(['/home/.bml/Data/Bank1/Age_Culture/Calibration/plots_correlation_between_sites/subject_', num2str(subj), '_V_mean.jpg']));
%     
%     %fig2
%     fig2_empty = figure('Color', [1 1 1]);
%     
%     fig2 = plot(US_V_var(:), TW_V_var(:), 'o');
%     title(['Subject ' num2str(subj) ' variances of voxel T values across 12 visual sessions']);
%     xlabel('US');
%     ylabel('TW');
%     refline(1,0);
%     
%     %saveas(fig2, fullfile(['/home/.bml/Data/Bank1/Age_Culture/Calibration/plots_correlation_between_sites/subject_', num2str(subj), '_V_var.jpg']));
%     
%     %fig3
%     fig3_empty = figure('Color', [1 1 1]);
%     
%     fig3 = plot(US_M_mean(:), TW_M_mean(:), 'o');
%     title(['Subject ' num2str(subj) ' mean voxel T values across 12 motor sessions']);
%     xlabel('US');
%     ylabel('TW');
%     refline(1,0);
%     
%     %saveas(fig3, fullfile(['/home/.bml/Data/Bank1/Age_Culture/Calibration/plots_correlation_between_sites/subject_', num2str(subj), '_M_mean.jpg']));
%     %     %% plots
%     
%     %fig1
%     fig1_empty = figure('Color', [1 1 1]);
%     
%     fig1 = plot(US_V_mean(:), TW_V_mean(:), 'o');
%     title(['Subject ' num2str(subj) ' mean voxel T values across 12 visual sessions']);
%     xlabel('US');
%     ylabel('TW');
%     refline(1,0);
%     
%     %saveas(fig1, fullfile(['/home/.bml/Data/Bank1/Age_Culture/Calibration/plots_correlation_between_sites/subject_', num2str(subj), '_V_mean.jpg']));
%     
%     %fig2
%     fig2_empty = figure('Color', [1 1 1]);
%     
%     fig2 = plot(US_V_var(:), TW_V_var(:), 'o');
%     title(['Subject ' num2str(subj) ' variances of voxel T values across 12 visual sessions']);
%     xlabel('US');
%     ylabel('TW');
%     refline(1,0);
%     
%     %saveas(fig2, fullfile(['/home/.bml/Data/Bank1/Age_Culture/Calibration/plots_correlation_between_sites/subject_', num2str(subj), '_V_var.jpg']));
%     
%     %fig3
%     fig3_empty = figure('Color', [1 1 1]);
%     
%     fig3 = plot(US_M_mean(:), TW_M_mean(:), 'o');
%     title(['Subject ' num2str(subj) ' mean voxel T values across 12 motor sessions']);
%     xlabel('US');
%     ylabel('TW');
%     refline(1,0);
%     
%     %saveas(fig3, fullfile(['/home/.bml/Data/Bank1/Age_Culture/Calibration/plots_correlation_between_sites/subject_', num2str(subj), '_M_mean.jpg']));
%     
%     %fig4
%     fig4_empty = figure('Color', [1 1 1]);
%     
%     fig4 = plot(US_M_var(:), TW_M_var(:), 'o');
%     title(['Subject ' num2str(subj) ' variances of voxel T values across 12 motor sessions']);
%     xlabel('US');
%     ylabel('TW');
%     refline(1,0);

%     %fig4
%     fig4_empty = figure('Color', [1 1 1]);
%     
%     fig4 = plot(US_M_var(:), TW_M_var(:), 'o');
%     title(['Subject ' num2str(subj) ' variances of voxel T values across 12 motor sessions']);
%     xlabel('US');
%     ylabel('TW');
%     refline(1,0);
    
    %saveas(fig4, fullfile(['/home/.bml/Data/Bank1/Age_Culture/Calibration/plots_correlation_between_sites/subject_', num2str(subj), '_M_var.jpg']));
    
end