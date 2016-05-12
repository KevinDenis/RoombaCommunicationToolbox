function Lidar=initLidar(IP)
%Lidar=initLidar(IP)
%   Gives the localPort, where the Pi will send the LIDAR-data
%   Initiate the communication between PC-Pi-Roomba
%   pause needed to avoid errors on the Pi
%   is error occurs : reboot Pi
%   Created by Kevin Denis, KU Leuven, 2014-16
localPort=7070; % fixed, port on PC
localPortPi=7071;   % Pi expext start signal at this port
Lidar = udp(IP,localPortPi,'LocalPort',localPort);
Lidar.Timeout=0.1;
Lidar.InputBufferSize=6000;
fopen(Lidar);
start='201';        % OPCODE for start
for i=1:5
    sendDataUDP(Lidar,start)
end
end

