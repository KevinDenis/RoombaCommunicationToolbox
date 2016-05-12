clear all
close all
clc
if ~isempty(instrfindall);
    fclose(instrfindall);
    delete(instrfindall);
end


IP='192.168.0.103';
port=8080;
Roomba=initRoomba(IP);
n=25;
tElapsed=zeros(1,1);
succes=0;
globalTime=tic;
for i=1:n
    tic
    sendDataUDP(Roomba,'149,2,43,44'); % ask for encoder data
    data_in=fscanf(Roomba); % read encoder data on port, '[]' if nothing received after udp time out
    if ~strcmp(data_in,'') % is not empty
        tElapsed(i)=toc; % time needed for a succesfull ask-get data
        succes=succes+1; % if I received something = succes +1
    end
end
toc(globalTime)
hist(tElapsed)
disp(['# errors : ', num2str(n-succes)])