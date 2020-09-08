function fisher_z_trans(data_root_dir)

if ~exist('data_root_dir','var');
data_root_dir = uigetdir(pwd,'Select root Data Folder for R.mat files...');
end

% datadir = '/home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/first_level/derivatives_explicit_GW_mask';

Rfiledirs = dir(fullfile(data_root_dir, '**/R.mat'));

% Fisher z transform R

for rfile = 1:length(Rfiledirs)
    
    f=fullfile(Rfiledirs(rfile).folder, 'R.mat');
    fprintf('>>>>>Now loading and processing file %d/%d at %s\nfile: %s\n', rfile, length(Rfiledirs), datestr(now, 'HH:MM:SS'), f)
    load(f)
   
    transformed_R = atanh(wholebrain_R);
    real_trans_R  = real(transformed_R);
    real_trans_R(find(real_trans_R>18))=NaN;
    
    R_Z = real_trans_R;
    
    fprintf('>>>>>Now saving R_Z file at %s\n', datestr(now, 'HH:MM:SS'))
    save(fullfile(Rfiledirs(rfile).folder, 'R_Z.mat'), 'R_Z', '-v7.3')

end

end