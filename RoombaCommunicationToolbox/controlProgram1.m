close all
clear all
clc

startup_RoombaUDP
roombaName='Roomba#'; % # = nmbr of your Roomba
IP=getIPRoomba(roombaName);
comPort=initRoomba(IP);

% Parameters
s=0;            % Start distance is 0m
$$$             % Find the function to let the Roomba drive forward
while s < 2     % while the travelled distance is smaller as 2
    ds = $$$    % check the sensor distance, this is the small distance ds since last call             
    s=s+ds;     % add the small distance ds to the total distance s 
end
 $$$            % Find the function to let the Roomba stop

