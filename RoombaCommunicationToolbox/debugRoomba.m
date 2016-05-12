clear variables
close all
clc
if ~isempty(instrfindall);
    fclose(instrfindall);
    delete(instrfindall);
end

startup_RoombaUDP

IP='192.168.0.103';

Roomba=initRoomba(IP);

n=100;
tElapsed=zeros(n,1);

% for i=1:n
%     tic
    [leftCliff,leftFrontCliff, rightFrontCliff,rightCliff] = getCliffSensors(Roomba);
%     tElapsed(i)=toc;
% end
% 
% hist(tElapsed)
% title(['Mean frequency = ',num2str(1/mean(tElapsed))]) 

% turnAngle(Roomba,0.5,pi)

% 
% setFwdVelRadius(Roomba,0.1,inf);
% pause(1)
% setFwdVelRadius(Roomba,0,0);