function create_tomodoc(tomogram_dir, tomogram_prefix, tomoIDs, tomo_docName)
    fid = fopen(tomo_docName, 'wt');
    for tomoID = tomoIDs
        fprintf(fid, '%d    ',tomoID);
        tomoName = [tomogram_dir '/' tomogram_prefix num2str(tomoID) '.mrc\n'];
        fprintf(fid, tomoName);
    end