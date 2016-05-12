clear all
close all
clc

if ~isempty(instrfindall)
    fclose(instrfindall);
    delete(instrfindall);
end


%% Define computer-specific variables
% Modify these values to be those of your first computer:
ipA = '192.168.0.101';   portA = 9090;
% Modify these values to be those of your second computer:
% ipB = '192.168.0.104';  portB = 9091;
ipB = 'LocalHost';  portB = 9091;  

%% Create UDP Object
udpB = udp(ipA,portA,'LocalPort',portB);
%% Connect to UDP Object
fopen(udpB)

pause()
% while true
    tic
    fread(udpB)
    toc
% end