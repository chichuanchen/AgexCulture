clear
datadir = '/home/.bml/Data/Bank1/Age_Culture/Calibration/f_connectivity/first_level/derivatives_explicit_GW_mask';
Bfiledirs = dir(fullfile(datadir, '**/B.mat'));

Bfile = fullfile({Bfiledirs.folder}, 'B.mat');

% t0=tic();
% tic

% 2020/7/31 finished 24
% 2020/8/05 finished 96
% 2020/8/9 finished all 192 sessions
for bfile = 1:length(Bfiledirs) 
    
    
    load(Bfile{bfile})
    
    
    folder = B.p;
    Y      = B.Y;
    nv     = B.nv;
    In     = B.In;
    d      = B.d;
    n      = B.n;
    nvox   = size(Y,1); % No. of masked voxels to process
    clear B
    
    fprintf('>>>>>%dth/192\nLoaded %s, \nstart processing voxels at %s\n', bfile, folder, datestr(now, 'HH:MM:SS'))
    tic
    wholebrain_R = zeros(nvox, nvox);
    parfor i = 1:nvox
        
%         fprintf('processing voxel %d for %s\n', i, folder)
        
        X = repmat(Y(i,:),nvox,1);
        %tic
        wholebrain_R(:,i) = AXC_cor(X,Y);
        %toc
    end
    
    toc
    
    fprintf('Saving R in %s\n', folder)
    tic
    save(fullfile(folder, 'R.mat'), 'wholebrain_R', '-v7.3')
    toc
    
end

% dt=toc(t0);
% toc