function cmm2tbl(cmm_dir, cmm_prefix, tomoIDs, tilt, OutputTblName)
    %% main loop
    particle_size = [];
    final_tbl = [];
    for tomoID = tomoIDs
        % construct cmm name
        cmm_name = [cmm_dir '/' cmm_prefix num2str(tomoID) '.cmm'];
        % check existance of such cmm file
        if isfile(cmm_name)
            % if exists:
            msg = [cmm_name ' found'];
            disp(msg);
            % calculate table
            [~, tbl, dist] = cmm2av3(cmm_name,tomoID);
            %Fill the tbl with other necessary informations
            tbl(:,13) = tilt(3);
            tbl(:,14) = tilt(1);
            tbl(:,15) = tilt(2);
            % Insert tbl to final_tbl
            final_tbl = [final_tbl; tbl];
            particle_size = cat(2,particle_size,dist);
        else
            msg = [cmm_name ' not found'];
            disp(msg);
        end
    end
    %% Write the table
    % re-numerate the particle ID to descending order
    final_tbl(:,1) = 1:size(final_tbl,1);
    dwrite(final_tbl, OutputTblName);
    msg = [OutputTblName ' generated'];
    disp(msg)
    %% plot the length of particles, rough estimates
    histogram(particle_size);
    xlabel('Length [pixel]');
    ylabel('Count');
    meandist = num2str(mean(particle_size));
    title(['Distance between pairs of coordinates. Ave.=' meandist 'pxls']);