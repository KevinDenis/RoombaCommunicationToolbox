close all
clear all
clc

startup_RoombaUDP
roombaName='Roomba#'; % # = nmbr of your Roomba
IP=getIPRoomba(roombaName);
comPort=initRoomba(IP);

% using the counter implemented in controlProgram1, 
% try reproducing the patern given in the excercise.

for i=0:$
    
    % set actuator for straight 
    while 
        % go straight
    end
    
    % set actuator for turn
    while 
        % turn
    end
    
    % repeat x times
end

% stop the roomba