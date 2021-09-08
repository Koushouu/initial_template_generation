%Convert the TraceMaker cmm file to a Matlab matrix
function cmm_matrix = cmmread(cmmfile)
    coord = xml2struct(cmmfile);

% column : description
%	1   :   id
%	2   :   x
%	3   :   y
%	4   :   z
%   5   :   color r
%   6   :   color g
%   7   :   color b
%   8   :   radius

%Find the size of the matrix
    mat_size = size(coord.marker_set.marker);
    cmm_matrix = zeros(8, mat_size(2));
    for i = 1:mat_size(2)
        cmm_matrix(1,i) = str2double(coord.marker_set.marker{1,i}.Attributes.id);
        cmm_matrix(2,i) = str2double(coord.marker_set.marker{1,i}.Attributes.x);
        cmm_matrix(3,i) = str2double(coord.marker_set.marker{1,i}.Attributes.y);
        cmm_matrix(4,i) = str2double(coord.marker_set.marker{1,i}.Attributes.z);
        cmm_matrix(5,i) = str2double(coord.marker_set.marker{1,i}.Attributes.r);
        cmm_matrix(6,i) = str2double(coord.marker_set.marker{1,i}.Attributes.g);
        cmm_matrix(7,i) = str2double(coord.marker_set.marker{1,i}.Attributes.b);
        cmm_matrix(8,i) = str2double(coord.marker_set.marker{1,i}.Attributes.radius);
    end
end