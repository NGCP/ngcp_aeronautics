function prop = import_props_from_directory(importconfig)
    inputDir            = importconfig.inputDir;
    inertia_header      = importconfig.inertia_header;
    airfoil_header      = importconfig.airfoil_header;
    geom_header         = importconfig.geom_header;
    struct_field_string = importconfig.struct_field_string;
    file_list_raw = dir(inputDir);
    file_list = {};
    for i = 3:length(file_list_raw)
        file_list{i-2} = file_list_raw(i).name;
    end

    n = 0;
    for i = 1:length(file_list)
        current_file = fopen([inputDir '\' file_list{i}]);
        %Finding header
        flag_header_found = find_header(current_file,geom_header);
        if flag_header_found
            n = n+1;
            prop(n).global.filename = file_list{i};
            %Reading all lines one line after the header into an array
            geom_data_array = input_data(current_file); %extracting geometry data
            %Assigning to structure
            prop(n).geom = geom_data_array2struct(geom_data_array,struct_field_string);
            %extracting mass
            if find_header(current_file,inertia_header)
                prop(n).global.mass = input_prop_mass(current_file);
            end

            %extracting airfoil data
            if find_header(current_file,airfoil_header)
                airfoil_data = input_airfoil_data(current_file);
                % copying to prop structure
                for j = 1:length(airfoil_data)
                    prop(n).aero(j).aifoil_name = airfoil_data(j).name;
                    prop(n).aero(j).trans_point = airfoil_data(j).transition_point;
                end
            end
        end
        fclose(current_file);
    end
end