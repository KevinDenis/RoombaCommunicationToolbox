%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Template Routine to see if the Roomba is in good shape %%%
%%%%% Expected frequency = 10 Hz. Reboot Pi if much lower %%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
clear variables
close all
clc
if ~isempty(instrfindall);
    fclose(instrfindall);
    delete(instrfindall);
end
startup_RoombaUDP
%% Parameters
v=0.1;
r=inf;
roombaName='Roomba5'; % # = nmbr of your Roomba

n=50;
tElapsedRoomba=zeros(n,1);
tElapsedLidar=zeros(n,1);
IP=getIPRoomba(roombaName);
Roomba=initRoomba(IP);
Lidar=initLidar(IP); 

%% Begin test
setFwdVelRadius(Roomba,v,r)
h = waitbar2(0,'Please wait...');
for i=1:n
    % Roomba
    tStartRoomba=tic;
    [ds,dtheta]=getOdometry(Roomba,v,r);
    tElapsedRoomba(i)=toc(tStartRoomba);  
    
    % Lidar    
    tStartLidar=tic;
    scan = getLidarScan(Lidar);
    tElapsedLidar(i)=toc(tStartLidar);
    dist=(scan(:,1));
    angle=(scan(:,2));
    [x,y]=pol2cart(angle,dist);
    figure(1)
    scatter(x,y)
    axis(8*[-1,1,-1,1])
    grid on
    text(5,5,num2str(i));
    pause(0.01);
    
    waitbar2(i/n,h,'Please wait...');
end
close(h)

setFwdVelRadius(Roomba,0,inf)

figure(2)
hist(tElapsedRoomba)
title(['Mean frequency Roomba = ',num2str(1/mean(tElapsedRoomba))]) 

figure(3)
hist(tElapsedLidar)
title(['Mean frequency Lidar = ',num2str(1/mean(tElapsedLidar))]) 



catch ME % catching message error
    stopRoomba(Roomba) % stopping Roomba
    rethrow(ME) % throwing error back at the user ;)
end
    
    