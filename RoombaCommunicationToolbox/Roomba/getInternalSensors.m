function [chargeState,voltage,current,temp,pCharge] = getInternalSensors(Roomba)
%[chargeState,voltage,current,temp,pCharge] = getInternalSensors(Roomba)
%   Returns all the internal sensor information of the iRobot Roomba :
%   Voltage 0 65535 mV
%   Current -32768 - 32767 mA
%   Temperature -128 - 127 degrees celsius
%   pCharge 0 - 100 %
%   Send data over UDP, not to serial object
%
%   Created by Kevin Denis, KU Leuven, 2014-16

%Initialize preliminary return values
chargeState=nan;
voltage=nan;
current=nan;
temp=nan;
pCharge=nan;

try
%% Create string of bytes to ask sensor data
bytes=[149,6,21,22,23,24,25,26];  %[sensor list] [Packet ID]
% OP code + bytes to string conversion
data_send=bytes2str(bytes);

%% Send / Receive via UDP
bytes_received = getDataUDP(Roomba,data_send);

chargeState=bytes_received(1);
voltage=uint162double(bytes_received(2:3));
current=int162double(bytes_received(4:5));
temp=double(typecast(uint8(bytes_received(6)),'int8'));
currentCapacity=uint162double(bytes_received(7:8)); 
totalCapacity=uint162double(bytes_received(9:10));
pCharge=currentCapacity/totalCapacity*100;

%% Failure
catch
    disp('WARNING:  getInternalSensors did not terminate correctly.  Output may be unreliable.')
end
end