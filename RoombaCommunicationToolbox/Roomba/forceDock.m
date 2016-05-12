function forceDock(Roomba)
%forceDock(Roomba)
% This function will force the Roomba in dock modus.
% Roomba will now search, and dock if found, on the docking station.
% Data is send over UDP
% Created by Kevin Denis, KU Leuven, 2014-16
Dock='143';
sendDataUDP(Roomba,Dock);  % puts the Roomba dock modus.
end