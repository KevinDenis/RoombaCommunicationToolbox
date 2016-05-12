clear all
close all
clc

if ~isempty(instrfindall)
    fclose(instrfindall);
    delete(instrfindall);
end

IP='192.168.0.102';
port=8080;
udpRoomba = udp(IP,port,'LocalPort',port);


n=10;
% n=1;
tElapsed=zeros(n,1);

fopen(udpRoomba);
for ii=1:n
    tic
%     fopen(udpRoomba);
    fprintf(udpRoomba,'149,2,43,44');
    fscanf(udpRoomba);
%     fclose(udpRoomba);
    tElapsed(ii)=toc;

end
fclose(udpRoomba);

hist(1/tElapsed)
title(['Mean frequency = ',num2str(1/mean(tElapsed))])  