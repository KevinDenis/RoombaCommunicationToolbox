function bytes_Bigendian = dataType2bytes(dataType)
%bytes = dataType2bytes(dataType)
bytes_Littleendian=typecast(dataType,'uint8');
bytes_Bigendian=flip(bytes_Littleendian);
end