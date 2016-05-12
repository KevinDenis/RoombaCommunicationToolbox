function  [BumpRight,BumpLeft,BumpFront,WheDropRight,WheDropLeft]  = getSafetySensors(Roomba)
%[BumpRight,BumpLeft,BumpFront,WheDropRight,WheDropLeft]  = getSafetySensors(comPort)
%   Specifies the state of the bump and wheel drop sensors, either triggered
%   or not triggered.
%   By Joel Esposito, US Naval Academy, 2011
%
%   Changes by Kevin Denis, KU Leuven, 2014-16
%   * Addaptation for iRobot Roomba (no caster wheel drop)
%   * Send data over UDP, not to serial object

%Initialize preliminary return values
BumpRight=nan;
BumpLeft=nan;
BumpFront=nan;
WheDropRight=nan;
WheDropLeft=nan;

try
%% Create string of bytes to ask sensor data
bytes=[142,7];  %[sensor] [#packet]
% OP code + bytes to string conversion
data_send=bytes2str(bytes);

%% Send / Receive via UDP
bytes_received=getDataUDP(Roomba,data_send);
BmpWheDrps= dec2bin(bytes_received(1),8);
BumpRight = logical(bin2dec(BmpWheDrps(end)));
BumpLeft = logical(bin2dec(BmpWheDrps(end-1)));
BumpFront=logical((BumpRight*BumpLeft));
if BumpFront==1
    BumpRight = false;
    BumpLeft =false;
end
WheDropRight = logical(bin2dec(BmpWheDrps(end-2)));
WheDropLeft = logical(bin2dec(BmpWheDrps(end-3)));


%% Failure
catch ME
    disp('WARNING:  getSafetySensors did not terminate correctly.  Output may be unreliable.')
    stopRoomba(Roomba)
    rethrow(ME)
end