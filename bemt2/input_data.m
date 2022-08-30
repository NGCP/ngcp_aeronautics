%After a header is found imports data from APC geometry format file
function datarray = input_data(currentfile)
    current_line = fgetl(currentfile); %skipping the line with units
    current_line = fgetl(currentfile); %skippping the empty line.
    flag_readline = true;
    j = 0;
    while flag_readline
        current_line = fgetl(currentfile);
        j = j + 1; %row in the array;
        if ((~ischar(current_line))&&(current_line == -1))||(isempty(current_line)) %-1 or empty line(data part of the file ends with empty line)
            flag_readline = false;
        else
            %seperate into array.
            delim = ' '; %delimiter between numbers, counting several delimiters in a row as one
            buffer = [];
            k = 0; %column in the array;
            for i = 1:length(current_line)
                current_char = current_line(i);
                if ((current_char == delim)||(i == length(current_line)))
                    if ~isempty(buffer)
                        k = k+1;
                        datarray(j,k) = str2double(buffer);
                        buffer = [];
                    end
                else
                    buffer = [buffer current_char];
                end
            end
        end
   end
end