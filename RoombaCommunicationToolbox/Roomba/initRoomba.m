function Roomba=initRoomba(IP)
%Roomba=initRoomba(IP)
%   initializes serial port for use with Roomba
%   COMMport is the number of the comm port 
%   ex. RoombaInit('COM1') sets port = 'COM1' (Windows Machine)
%   note that it sets baudrate to a default of 115200
%   can be changed (see OI).  
%   An optional time delay can be added after all commands
%   if your code crashes frequently.  15 ms is recommended by irobot
%   By Joel Esposito, US Naval Academy, 2011
%
%   Changes by  by Kevin Denis, KU Leuven, 2014-16
%   * Baudrate for Roomba 620
%   * The non very user friendly LED display, just kept the BeepTone
%   * Multiplatform adaptation (Windows and linux)
%   * UDP implementation
%   * Fixed port, just IP input
%   * update encoders at start to avoid bug
%   * Use of MATLAB udp object in stead off python code (ON PC)

global comDelay sensorSkip
port=8080;
comDelay = 0;
sensorSkip = false;

disp('Establishing connection to Roomba...');
Roomba = udp(IP,port,'LocalPort',port);
Roomba.Timeout=0.1;
fopen(Roomba);

% This code puts the robot in FULL(132) mode, which means does NOT stop 
% when cliff sensors or wheel drops are true; can also run while plugged into charger
Start='128';
Control = '130';
Full = '132';

%% Confirm two way connumication
disp('Setting Roomba to Control Mode...');
% Start! and see if its alive
sendDataUDP(Roomba,Start);   pause(.1);
sendDataUDP(Roomba,Control); pause(.1);
sendDataUDP(Roomba,Full);    pause(.1);

% set song
%[140] [Song Number] [Song Length] [Note Number 1] [Note Duration 1]
sendDataUDP(Roomba,'140, 1, 1, 72, 40');
pause(0.1)

% sing it
%py_udp_send(IP,port,'141, 1, 0, 0, 0');
sendDataUDP(Roomba,'141, 1');
disp('I am alive if you just heard me beep')
pause(.1)
updateEncoders(Roomba);

[~,~,~,~,pCharge] = getInternalSensors(Roomba);

if pCharge < 30
    disp(['Warning, battery level low: ', num2str(pCharge),'%']);
end

end