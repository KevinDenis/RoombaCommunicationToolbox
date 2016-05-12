%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Template Routine to see if the Lidar is in good shape %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all
close all
clc
if ~isempty(instrfindall);
    fclose(instrfindall);
    delete(instrfindall);
end

startup_RoombaUDP
%% Parameters
roombaName='Roomba5';
IP=getIPRoomba(roombaName);
Lidar=initLidar(IP); 
n=10;
tElapsed=zeros(n,1);

%% Begin test
for i=1:n
    tStart=tic;
    scan = getLidarScan(Lidar);
    tElapsed(i)=toc(tStart);
    dist=(scan(:,1));
    angle=(scan(:,2));
    [x,y]=pol2cart(angle,dist);
    figure(1)
    scatter(x,y)
    axis(8*[-1,1,-1,1])
    grid on
    text(5,5,num2str(i));
    pause(0.01);
end

%% Plot some info
pd = fitdist(tElapsed,'Normal')
hist(tElapsed)
title(['Mean frequency = ',num2str(1/mean(tElapsed))])  