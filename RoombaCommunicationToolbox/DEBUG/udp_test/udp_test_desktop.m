clear all
close all
clc

if ~isempty(instrfindall)
    fclose(instrfindall);
    delete(instrfindall);
end

%% Define computer-specific variables
ipA = '192.168.0.101';   portA = 9090;   % Modify these values to be those of your first computer.
ipB = '192.168.0.104';  portB = 9091;  % Modify these values to be those of your second computer.
%% Create UDP Object
udpA = udp(ipB,portB,'LocalPort',portA);
%% Connect to UDP Object
fopen(udpA)

pause()


fwrite(udpA,158)