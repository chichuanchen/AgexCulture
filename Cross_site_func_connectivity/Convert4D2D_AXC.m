% Convert 4D images to 2D arrays for AXC functional connectivity analysis.
% Outputs are saved in task specific folders.

datadir = '/home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/first_level/derivatives_explicit_GW_mask';

niifiledirs = dir(fullfile(datadir, '**/*.nii'));
niifilenames = {niifiledirs.name};

fileexp='(TW|US)_(visual|motor)_*'; % TW_visual_1_1.nii, US_motor_4_12.nii
regmatch = regexp(niifilenames, fileexp, 'match');

fileflag = find(~cellfun(@isempty,regmatch));

folderlist = {niifiledirs(fileflag).folder};
filelist = {niifiledirs(fileflag).name};



for i = 1:length(filelist)

  [B, mdatafn]  = format_whole_brain_AXC(fullfile(folderlist{i}, filelist{i})); % Reshape 4D nii to 2D in B structure.
  save(fullfile(folderlist{i}, 'B'),'B');

end
