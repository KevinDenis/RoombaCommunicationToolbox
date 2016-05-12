%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Template file, using try-catch statement %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear all
clc

startup_RoombaUDP
roombaName='Roomba#'; % # = nmbr of your Roomba
IP=getIPRoomba(roombaName);
comPort=initRoomba(IP);

try
    
    % your control file goes here
    
catch ME
    % If you make a syntax error, this will execute this code
    stopRoomba(comPort)
    rethrow(ME) % showing error to user
end