function [v,r]=getFwdVelRadius(Roomba)
% [v,r]=getFwdVelRadius(Roomba)
%   Returns
%   Created by Kevin Denis, KU Leuven, 2014-16

%Initialize preliminary return values
v = nan;
r = nan;

try
    %% Send via UDP
    bytes=[149,2,39,40];  %[query list] [#packets] [velocity] [radius]
    % OP code + bytes to string conversion
    data_send=bytes2str(bytes);

    %% Receive via UDP
    bytes_received = getDataUDP(Roomba,data_send);
    v_mm = int162double(bytes_received(1:2));
    r_mm = int162double(bytes_received(3:4));

    v=v_mm/1000;

    if r_mm == 32767
        r=inf; % no distiction yet between + and - inf (they are in practice the same)
    else
        r=-8*r_mm/1000; % this looks like a datatype error...but I solved it manually
    end

catch ME
    disp('WARNING:  getFwdVelRadius did not terminate correctly.  Output may be unreliable.')
    stopRoomba(Roomba)
    rethrow(ME)
end
end