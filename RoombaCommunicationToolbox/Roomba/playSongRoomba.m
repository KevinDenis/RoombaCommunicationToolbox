function playSongRoomba(Roomba)
%playSongRoomba(comPort)
% Plays a song made by RoombaInit or SetSongRoomba command.
% By; Joel Esposito, US Naval Academy, 2011
%
%   Changes by Kevin Denis, KU Leuven, 2014-16
%   * Send data over UDP, not to serial object
try  

    %% Send via UDP
    % data to byte conversion (Big-endian) 
    bytes=[141,1];  %[Play] [Song Number]
    % OP code + bytes to string conversion
    data=bytes2str(bytes);
    % send it
    sendDataUDP(Roomba,data);

%% Failure
catch ME
    disp('WARNING:  playSongRoomba did not terminate correctly.  Output may be unreliable.')
    stopRoomba(Roomba)
    rethrow(ME)
end