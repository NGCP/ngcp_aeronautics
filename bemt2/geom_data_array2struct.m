%{
converting data array into structure, words in the header separated by
deilm are columns of the array
%}
function geom_data_struct = geom_data_array2struct(geom_data_array,struct_field_string)
    %Extracting names of the fields
    delim = ' ';
    word  = [];
    n = 0;
    for i = 1:length(struct_field_string)
        current_char = struct_field_string(i);
        if ((current_char == delim)&&(~isempty(word)))||(i == length(struct_field_string))
            n = n+1;
            geom_data_struct.(word) = geom_data_array(:,n);
            word = [];
        elseif current_char ~=delim 
            word = [word current_char];
        end
    end
end