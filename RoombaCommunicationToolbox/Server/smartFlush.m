function smartFlush(obj)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
if  obj.BytesAvailable~= 0
    fclose(obj);
    fopen(obj);
end
end

