% cmm2av3 function
% assume in cmm file, the data pont goes like this:
% (head_1, toe_1, head_2, toe_2 ... head_n, toe_n)
% INPUT:
%   cmm_matrix
%   tomo_id    : tomogram ID
% Output:
%   em: coordinates in av3 format
%   tbl: coordinates in dynamo table format
%   dist: head to toe distance in pxl
%==========================================================================
% Note: *.cmm format:
% column : description
%       1   :   id
%       2   :   x
%       3   :   y
%       4   :   z
%   5   :   color r
%   6   :   color g
%   7   :   color b
%   8   :   radius
%==========================================================================
% Note: *.em av3 format:
%   column
%       1         : Cross-Correlation Coefficient
%       2         : x-coordinate in full tomogram
%       3         : y-coordinate in full tomogram
%       4         : particle number
%       5         : running number of tomogram - used for wedgelist
%       6         : index of feature in tomogram (optional)
%       8         : x-coordinate in full tomogram
%       9         : y-coordinate in full tomogram
%       10        : z-coordinate in full tomogram
%       11        : x-shift in subvolume - AFTER rotation of template
%       12        : y-shift in subvolume - AFTER rotation of template
%       13        : z-shift in subvolume - AFTER rotation of template
%     ( 14        : x-shift in subvolume - BEFORE rotation of template )
%     ( 15        : y-shift in subvolume - BEFORE rotation of template )
%     ( 16        : z-shift in subvolume - BEFORE rotation of template )
%       17        : Phi (in deg) (in axis rotation)
%       18        : Psi
%       19        : Theta (angle to z axis)
%       20        : class no
%==========================================================================
function [em, tbl, dist] = cmm2av3(cmmfile, tomo_id)
    cmm_matrix = cmmread(cmmfile);
    cmm_size = size(cmm_matrix);
    nptl = cmm_size(2)/2; %Number of subtomograms
    em_matrix = zeros(20,nptl);
    %Get the head and toe cmm
    head_cmm = zeros(8,nptl);
    toe_cmm = zeros(8,nptl);

    head_i = 1;
    toe_i = 2;
    for i= 1:nptl
        head_cmm(:,i) = cmm_matrix(:,head_i);
        toe_cmm(:,i) = cmm_matrix(:,toe_i);
        head_i = head_i + 2;
        toe_i = toe_i + 2;
    end
    %Give particle number to each subtomogram
    em_matrix(4,:) = (1:nptl);
    %Give the tomogram ID:
    em_matrix(5,:) = tomo_id;
    %Calculate the x y z of the subtomograms:
    em_matrix(8:10,1:nptl) = (head_cmm(2:4, 1:nptl) + toe_cmm(2:4, 1:nptl))./2;
    %Calculate the orientation of the subtomograms:
    % Psi = arctan2(dy/dx)
    % Theta = arctan2(sqrt(dx^2+dy^2)/dz)
    dx = head_cmm(2,:)-toe_cmm(2,:);
    dy = head_cmm(3,:)-toe_cmm(3,:);
    dz = head_cmm(4,:)-toe_cmm(4,:);
    psi = rad2deg(atan2(-dx,dy));
    theta = -rad2deg(atan2(sqrt(dx.^2 + dy.^2),dz));
    em_matrix(18,:) = psi;
    em_matrix(19,:) = theta;
    %Give a random angle to phi (in axis rotation)
    em_matrix(17,:) = rand(1,nptl).*360 - 180;
    %Write an em file
    em = em_matrix;
    tbl = dynamo__motl2table(em_matrix);
    % Plot head to toe distance histogram
    dist = sqrt(dx.^2 + dy.^2 + dz.^2);
end