% From format_whole_brain_MI.m by Josh Goh
%
% Format whole-brain 4D data into masked arrays for AXC functional connectivity analysis.
%
% Usage: B = format_whole_brain_MI(maskfn,datafn,mt) * AXC calibration data
% are already masked
%
% maskfn - String of structural *.nii mask filename to apply. Nb: Highly
%          recommended to reduce no. of voxels. Otherwise, computation will
%          take very long and output file sizes too large.
% datafn - String of 4-d functional brain image *.nii filename.
% mt     - Masking threshold.
% B      - Output structure with the following fields.
%              V    : SPM nifti header.
%              Y    : SPM nifti data array with null voxels removed.
%              In   : Index of all non-zero elements in Y.
%              nvrd : No. of non-zero elements in Y.
%              d    : Size of original data array.
%              nv   : Product of d(1:3); total no. of voxels in original volume.
%              t    : d(4); no. of timepoints in time series.
% mdatafn - String of filename of masked 4-d functional brain *.nii image.
%
% Created by Joshua Goh 2020/05/16.
% Edited for AXC by Chi-Chuan Chen 2020/07/09



function [B datafn] = format_whole_brain_AXC(datafn)

    
	% Format brain time series volume
	% Apply structural mask on functional data
%  	spm_mask(maskfn,datafn,mt); % AXC data already masked
	[B.p B.n B.e] = fileparts(datafn);
%  	mdatafn  = [B.p '/m' B.n B.e];


	% Read masked functional volume
% 	B.V   = spm_vol(mdatafn);
    B.V   = spm_vol(datafn);
	B.Y   = spm_read_vols(B.V);
	B.d   = size(B.Y);
	B.nv  = prod(B.d(1:3)); % No. of voxels in volume.
	B.t   = B.d(4); % No. of timepoints in time series.

	% Format brain volume as source/destination arrays.
% 	disp('Reshaping the brain...');
    fprintf('Reshaping the brain %s ...\n', B.n);
	B.Y = reshape(B.Y,B.nv,B.t);

	% Reduce array redundancy
    % Identify voxels that have no signals (NaN) in every slice
%     B.I    = B.Y~=0;
    B.I    = ~isnan(B.Y);
    B.I    = all(B.I,2);
    B.In   = find(B.I);
    B.Y    = B.Y(B.I,:);
    B.VMI  = B.V(1); % temp holder for volume header info
    B.nvrd = size(B.Y,1);

	disp('Done!');

end % EOF
