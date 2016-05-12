function updateEncoders(comPort)
% [LeftEncoderCount,RightEncoderCount] = updateEncoders(comPort)
%   Returns the cumulative number of raw left and right encoder counts.
%   This number will roll over to 0 after it passes 65535. (2^16)-1
%   When driving backwards, this number will decrease.
%
%   Created by Kevin Denis, KU Leuven, 2014-15

global LeftEncoderCount RightEncoderCount
%Initialize preliminary return values
LeftEncoderCount = nan;
RightEncoderCount = nan;

try
    %% Send via UDP
    bytes=[149,2,43,44];  %[query list] [#packets] [leftEncoder] [rightEncoders]
    % OP code + bytes to string conversion
    data_send=bytes2str(bytes);

    %% Receive via UDP
    bytes_received = getDataUDP(comPort,data_send);
    LeftEncoderCount = uint162double(bytes_received(1:2));
    RightEncoderCount = uint162double(bytes_received(3:4));

catch
    disp('WARNING: updateEncoders did not terminate correctly.')
    disp(bytes_received)
end