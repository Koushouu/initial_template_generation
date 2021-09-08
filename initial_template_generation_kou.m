%% Initial model generation script
%% User inputs field ======================================================
% Where are your cmm files?
cmm_dir = '/150T_NFS/kou/210220_PEDV_intermediate_data/bin4tomo_lowpass/postfusion_cmm';
% What's the prefix of your cmm file names?
cmm_prefix = 'PEDV_';
% Where are your tomograms?
tomogram_dir = '/150T_NFS/kou/210220_PEDV_intermediate_data/bin4tomo_lowpass';
% What's the prefix of your tomogram file names?
tomogram_prefix = 'PEDV_';
% What are your tomogram IDs? (just provide a range. Format = start:end)
tomoIDs = 1:91;
% Where is your project folder? 
project_dir = '/home2/kou/PEDV_cryoet/test';
subtom_dir = [project_dir '/postfusion_lp_subtom.Data'];
tomo_docName = [project_dir '/bin4tomo_lowpass.doc'];
% Subtomogram boxsize? (in pixels)
subtom_boxsize = 64;
% Other inputs ============================================================
% Tilt angle information? [min_tilt, max_tilt, tilt_axis]
tilt = [-60, 60, 1];
% Tbl name?
OutputTblName = [cmm_dir '/' cmm_prefix 'combinedTbl.tbl'];
%% Generate tbl file for particle coordinates =============================
cmm2tbl(cmm_dir, cmm_prefix, tomoIDs, tilt, OutputTblName);
%% Extract subtomograms ===================================================
create_tomodoc(tomogram_dir, tomogram_prefix, tomoIDs, tomo_docName);
dynamo_table_crop(tomo_docName, OutputTblName, subtom_dir, subtom_boxsize);
%% Change directory to the project folder and launch an alignment project
cd(project_dir)
dcp