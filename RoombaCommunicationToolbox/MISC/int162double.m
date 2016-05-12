function [data_double] = int162double(data_Byte)
%[data_double] = int162double(data_Byte)
data_Byte=flip(data_Byte); % receive big-endian, matlab wants little-endian
data_Int = typecast(uint8(data_Byte), 'int16');
data_double=double(data_Int);
end

