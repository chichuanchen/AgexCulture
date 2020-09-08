% X and Y are each a 4D brain map in 2D form, with columns as time points
% and rows as voxels

function R = AXC_cor(X,Y)

% average signal across time for each voxel
EX  = sum(X,2)./size(X,2); 
EY  = sum(Y,2)./size(Y,2);
% standard deviation of signals across time for each voxel
SX  = sum((X - EX).^2,2)./(size(X,2)-1); % Scalar 
SY  = sum((Y - EY).^2,2)./(size(Y,2)-1); % Scalar
% covariance
sXY = sum((X - EX).*(Y - EY),2)./(size(X,2)-1);
SXY = cat(3,[SX sXY],[sXY SY]); % 2 x 2 Matrix

R = squeeze(SXY(:,1,2))./(sqrt(SX).*sqrt(SY));


end