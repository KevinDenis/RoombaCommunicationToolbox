function str = bytes2str(bytes)
%str = bytes2str(bytes)
n=numel(bytes);
str=[];
for i=1:n
    if i == n
        % no , at end
        byte_i=bytes(i);
        byte_i_str=int2str(byte_i);
        str=strcat(str,byte_i_str);
    else
        % , between each byte
        byte_i=bytes(i);
        byte_i_str=int2str(byte_i);
        byte_i_str_comma=strcat(byte_i_str, ', ');
        str=strcat(str,byte_i_str_comma);
    end
end
end

