function IP=getIPRoomba(roombaName)
%IP=getIPRoomba(roombaName)
%   Gives the IP of a specific Roomba, given a name
%   Created by Kevin Denis, KU Leuven, 2014-16
IP_pre='192.168.1.10';
%% BETER SOLUTION
IP_post=roombaName(end);
IP=strcat(IP_pre,IP_post);
end