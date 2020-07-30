function [set_channels] = assign_channel_titles(titles, ch_names)
%UNTITLED Summary of this function goes here

% Determine channel titles
possible_channel_titles_list = {'Left Vis', 'L Vis', 'Left vis', 'stim', 'input', 'Stim', 'Input'};



s = size(possible_channel_titles_list);


ss = size(titles);
for ii =1:s(2)
    pattern = possible_channel_titles_list{ii};
    %disp(pattern);
    for jj=1:ss(1)
        string = titles(jj,:); % need to do an ignore case thing below
        %disp(string);
        k = strfind(string, pattern);
        TF = isempty(k);
        if TF == 0
            if (strcmp(pattern, 'Left Vis')) || (strcmp(pattern, 'L Vis')) || (strcmp(pattern, 'Left vis'))
                ch_names{1} = jj;
                
            elseif (strcmp(pattern, 'input')) || (strcmp(pattern, 'Input')) || (strcmp(pattern, 'stim')) || (strcmp(pattern, 'Stim'))
                ch_names{2} = jj;
            end
        end
    end
end

set_channels = [ch_names(1) ch_names(2)];







end

