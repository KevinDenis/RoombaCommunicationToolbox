close all
clear all
clc

startup_RoombaUDP
roombaName='Roomba#'; % # = nmbr of your Roomba
IP=getIPRoomba(roombaName);
comPort=initRoomba(IP);

% Parameters
v =$; % translation speed, m/s
w = $; % angular speed, rad/s
distance = $; % distance, m
angle = $; % degrees

for i=1:$
    travelDist($$$)
    turnAngle($$$)
end