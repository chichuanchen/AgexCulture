% Get preprocessed data (normalized but not smoothed: wabu-)
TW_PATH = '/home/.bml/Data/Bank1/Age_Culture/Calibration/TW/Nifti/';
%US_PATH = '/home/.bml/Data/Bank1/Age_Culture/Calibration/US/Nifti/';


%% TW Visual
clear BATCH

BATCH.filename='/home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/preprocessing/bp_TW_visual.mat';

BATCH.parallel.N=0;

BATCH.Setup.RT=0.67;
BATCH.Setup.nsubjects=4;
BATCH.Setup.voxelresolution=3; % same as functional volumes

BATCH.Setup.functionals = cell(1,4); % big cell containingg all data for all entry cells

for subj = 1:4
    for sess = 1:12
        %TW_PATH = '/home/.bml/Data/Bank1/Age_Culture/Calibration/TW/Nifti/';
        BATCH.Setup.functionals{1,subj}{1,sess} = [TW_PATH 'sub-' num2str(subj) '/ses-' num2str(sess) ...
            '/func/wabusub-' num2str(subj) '_ses-' num2str(sess) '_task-visual_acq-EPI_bold.nii'];      
    end
end

BATCH.Setup.conditions.missingdata=1;
BATCH.Setup.done=0;
BATCH.Setup.isnew=0;

%%
BATCH.Preprocessing.steps={'functional_bandpass'};
BATCH.Preprocessing.filter=[0.008, 0.09];
BATCH.Preprocessing.done=0;
%%
BATCH.Denoising=[];
BATCH.Analysis=[];
BATCH.Results=[];
BATCH.QA=[];

conn_batch(BATCH)