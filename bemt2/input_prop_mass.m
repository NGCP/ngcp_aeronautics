%looking for mass in kg after find_header ran
function mass = input_prop_mass(current_file)
    current_line = fgetl(current_file); %skipping line
    current_line = fgetl(current_file); %skipping line(kg weight is second)
    key =  ' TOTAL WEIGHT (Kg) ';
    delim = ' =';
    word = [];
    current_line = fgetl(current_file);
    if((length(current_line) >= length(key))&&(all(current_line(1:length(key)) == key)))
        for i = length(key):length(current_line)
            current_char = current_line(i);
            if ((any(current_char == delim))||(i == length(current_line)))&&(~isempty(word))
                mass = str2double(word);
            else
                word = [word current_char];
            end
        end
    end
end
