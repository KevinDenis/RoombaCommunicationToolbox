function bytes = str2byte(str)
%bytes = str2byte(str)
bytes=zeros(1,1);
str=str(2:end-1);
i_start=1;
j=1;
for i=1:length(str)
    % all bytes except last one
    if str(i) == ','
        stringByte=str(i_start:i-1);
        newByte=str2double(stringByte);
        bytes(j)=newByte;
        i_start=i;
        j=j+1;
    end
end
% last byte
stringByte=str(i_start:end);
newByte=str2double(stringByte);
bytes(j)=newByte;
end
