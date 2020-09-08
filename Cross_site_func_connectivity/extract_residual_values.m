%---------------------------------------------------------
% Extract_residual_values
% 
% This script extracts the residual values using spm_read_vols
% It turns all voxels in one volume into one row
%
% Created by Jess CC Hsing 2020/05/01
% 
%---------------------------------------------------------
%
%% 1. Specifiy all volumes that we would like to read and feed them into spm_read_vols
tic

% data_path = '/home/.bml/Data/Bank1/MIFC/Data/';
% subject = 'DM_ERPS003' ; % change this part only for each subject

%% trying out sub 1 sess 1 TW visual first
mypath = '/home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/first_level/derivatives_explicit_GW_mask/sub-1/ses-1/TW/visual';
n_vol = 192; %specify the number of volumes here
res_path = cell(1,n_vol); %pre_allocation

for i=1:n_vol
res_path(i) = {[mypath '/Res_' num2str(i,'%0.4d') '.nii']};
end
%res_path is a cell array that stores all residual path

data = spm_read_vols(spm_vol(char(res_path))); %data is a 4d (l*m*n*n_vol double array)
%% 2. Extract place and value information from the data

place_info = find(~isnan(data(:,:,:,1))); % for place information only extract the first volume
data_value = data(~isnan(data));
data_value = reshape(data_value,length(place_info),n_vol); % make the data into a 59578*180 matrix, as we want it to be

%% 3. Save the files 
cd(strcat(data_path,subject))
save('whole_brain_res.mat', 'data_value')
save('indicies.mat', 'place_info')

cd ..

toc
