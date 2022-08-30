function airfoil_data = input_airfoil_data(current_file)
    current_line = fgetl(current_file); %skipping line
    flag_readline = true;
    j = 0;
    keyword = 'AIRFOIL';
    while flag_readline
        current_line = fgetl(current_file);
        j = j + 1; %row in the array;
        if ((~ischar(current_line))&&(current_line == -1))||(isempty(current_line)) %-1 or empty line(data part of the file ends with empty line)
            flag_readline = false;
        else
            %seperate into array.
            delim = ' ,'; %delimiter between words, counting several delimiters in a row as one
            word = [];
            number_of_words = 0;
            first_word_correct = false;
            for i = 1:length(current_line)
                current_char = current_line(i);
                if (any(current_char == delim))||(i == length(current_line))
                    if ~isempty(word)
                        number_of_words = number_of_words+1;
                        %If KEYWORD*, next word is the airfoil name, the number
                        %after that is the transition point
                        if (number_of_words == 1)&&(length(word) >=length(keyword))&&(all(word(1:length(keyword)) == keyword))
                            first_word_correct = true;
                            word = [];
                        end
                        
                        if first_word_correct&&(number_of_words == 2)
                            airfoil_data(j).transition_point = str2double(word);
                            word = [];
                        end
                        
                        if first_word_correct&&(number_of_words == 3)
                            airfoil_data(j).name = string(word);
                            word = [];
                            break
                        end
                    end
                else
                    word = [word current_char];
                end
            end
        end
   end
end