function [leftCliff,leftFrontCliff, rightFrontCliff,rightCliff] = getCliffSensors(Roomba)
%[leftCliff,leftFrontCliff, rightFrontCliff,rightCliff] = getCliffSensors(Roomba)
%   Returns states of the 4 cliff sensors of the iRobot Roomba.
%   Either triggered (1) or not (0).
%   This data is send over UDP
%   Created by Kevin Denis, KU Leuven, 2014-16

%Initialize preliminary return values
leftCliff = nan;
leftFrontCliff = nan;
rightFrontCliff = nan;
rightCliff = nan;

try
    %% Create string of bytes to ask sensor data
    bytes=[149,4,9,10,11,12];  %[query list] [#packets] [leftCliff] [leftFrontCliff] [rightFrontCliff] [rightCliff]
    % OP code + bytes to string conversion
    data_send=bytes2str(bytes);

    %% Send / Receive via UDP
    bytes_received = getDataUDP(Roomba,data_send);
    leftCliff=logical(bytes_received(1));
    leftFrontCliff=logical(bytes_received(2));
    rightFrontCliff=logical(bytes_received(3));
    rightCliff=logical(bytes_received(4));

catch ME
    disp('WARNING:  getCliffSensors did not terminate correctly.  Output may be unreliable.')
    stopRoomba(Roomba)
    rethrow(ME)
end