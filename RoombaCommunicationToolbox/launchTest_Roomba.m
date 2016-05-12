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
n=30;
tElapsed=zeros(n,1);

roombaName='Roomba5'; % # = nmbr of your Roomba
IP=getIPRoomba(roombaName);
Roomba=initRoomba(IP);

%% Begin test
setFwdVelRadius(Roomba,v,r)
h = waitbar2(0,'Please wait...');
for i=1:n
    tic
    [ds,dtheta]=getOdometry(Roomba,v,r);
    tElapsed(i)=toc;
    waitbar2(i/n,h,'Please wait...');
end
close(h)
setFwdVelRadius(Roomba,0,inf)
hist(tElapsed)
title(['Mean frequency = ',num2str(1/mean(tElapsed))]) 
catch ME % catching message error
    stopRoomba(Roomba) % stopping Roomba
    rethrow(ME) % throwing error back at the user ;)
end
    
    