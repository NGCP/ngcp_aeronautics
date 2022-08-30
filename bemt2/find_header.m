% finds specified line in a file and moves fgetline to that line
function flag_header_found = find_header(current_file,searchline)
    flag_readline = true;
    flag_header_found = false;
    while flag_readline == true
            current_line = fgetl(current_file);
        if (~ischar(current_line))&&(current_line == -1)
            flag_readline = false;
        else
            if(length(current_line) == length(searchline))&&(all(current_line == searchline))
                flag_header_found = true;
                flag_readline = false;
            end
        end
    end
end