function stopRoomba(Roomba)
%stopRoomba(comPort)
% This function will stop the roomba and put it in "start" modus (default)
% Data is send over UDP
%
% Created by Kevin Denis, KU Leuven, 2014-16
%% Parameters
v = 0;
r = inf;
Start='128';
setFwdVelRadius(Roomba,v,r)
sendDataUDP(Roomba,Start);  % puts the Roomba in start/default modus.
pause(.1)
end