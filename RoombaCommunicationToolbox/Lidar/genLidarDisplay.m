%% Clean matlab
clear all
close all
clc
% if ~isempty(instrfindall)
%     fclose(instrfindall);
%     delete(instrfindall);
% end

%% Parameters
n=500;
dt=zeros(n,1);
IP='192.168.1.105';
localPort=initLidar(IP);
%% read data
for i=1:n
    tic
    scan = getLidarScan(localPort);
    dt(i)=toc;
    dist=(scan(:,1));
    angle=(scan(:,2));
    [x,y]=pol2cart(angle,dist);
    figure(1)
    scatter(x,y)
    axis([-6,6,-6,6])
    text(5,5,num2str(i));
    drawnow
end

pd = fitdist(dt,'Normal')