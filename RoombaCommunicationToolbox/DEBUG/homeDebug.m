close all
clear all
clc

startup_RoombaUDP

IP='192.168.0.102';
comPort=initRoomba(IP);

tElapsed=zeros(1,1);
theta=0;
s=0;
setDriveWheels(comPort,0.3,0.3)
for i=1:100
    tic
    ds=nan;
    while isnan(ds)    
        [ds,dth]=getOdometry(comPort,0.5,inf);
        if isnan(ds)
            disp('is nan !!!')
        end
    end
    %disp(dth*180/pi)
    tElapsed(i)=toc;
    theta=dth*180/pi+theta;
    s=s+ds;
end

freq=1/mean(tElapsed)


% hist(tElapsed)
setFwdVelRadius(comPort,0,inf)
