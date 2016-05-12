function wall = getWallSensor(Roomba)
%wall = getWallSensors(comPort)
%   This will return state of the IR sensor, at the front right side 
%   of the Roomba. This is a Boolean value, 1 if there is a wall at +/- 10cm,
%   0 if there is no wall
%   Created by Kevin Denis, KU Leuven, 2014-16

%Initialize preliminary return values
wall = nan;

try
    %% Create string of bytes to ask sensor data
    bytes=[142,8];  %[sensor list] [Packet ID]
    % OP code + bytes to string conversion
    data_send=bytes2str(bytes);

    %% Send / Receive via UDP
    bytes_received=getDataUDP(Roomba,data_send);
    wall=logical(bytes_received(1));

%% Failure
catch ME
    disp('WARNING:  getWallSensor did not terminate correctly.  Output may be unreliable.')
    stopRoomba(Roomba)
    rethrow(ME)
end
end