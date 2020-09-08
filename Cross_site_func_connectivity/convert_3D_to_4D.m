%%

res_main_dir = '/home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/first_level/derivatives_explicit_GW_mask/';
n_subj = 4;
n_sess = 12;
sites = {'TW', 'US'};
tasks = {'visual', 'motor'};
vol_visual = 192;
vol_motor = 462;

for subj = 1:n_subj
    for site = 1:length(sites)
        for t = 1:length(tasks)
            for sess = 1:n_sess
                
                res_3d = {};
                fprintf('epi (res_3d) emptied\n')
                
                
                
                switch tasks{t}
                    case {'visual'}
                        n_vol = vol_visual;
                    case {'motor'}
                        n_vol = vol_motor;
                end
                
                fprintf('number of volumn = %d\n', n_vol)
                
                for v = 1:n_vol
                    % /home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/first_level/derivatives_explicit_GW_mask/sub-1/ses-1/TW/motor
                    res_3d(1, v) = {[res_main_dir 'sub-' num2str(subj) '/ses-' num2str(sess) '/' sites{site} '/' tasks{t} '/Res_' num2str(v, '%0.4d') '.nii']};
                end
                
                %%
                matlabbatch{sess}.spm.util.cat.vols = res_3d';
                %%
                matlabbatch{sess}.spm.util.cat.name = [sites{site} '_' tasks{t} '_' num2str(subj) '_' num2str(sess) '.nii'];
                matlabbatch{sess}.spm.util.cat.dtype = 0;
                matlabbatch{sess}.spm.util.cat.RT = 0.67;
                
                save(['convert_3D_to_4D_' sites{site} '_' tasks{t} '_' num2str(subj) '.mat'], 'matlabbatch')
                spm_jobman('run', matlabbatch)
                
            end         
        end
    end
end