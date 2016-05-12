function setDriveWheels(Roomba,rightWheelVel, leftWheelVel)
%setDriveWheels(comPort,rightWheelVel, leftWheelVel)
%  Specify wheel velocity in meters/sec [-0.5, 0.5].   
%  Negative velocity is backward.
%  Note that the wheel speeds are capped at .5 meters per second.  
%  So it is possible to specify speeds that cannot be acheived.
%  Warning is displayed.
%  By Joel Esposito, US Naval Academy, 2011
%
%   Changes by Kevin Denis, KU Leuven, 2014-16
%   * Addaptation for iRobot Roomba
%   * Scaling of wheels speed if exceeding 0.5m/s
%   * Send data over UDP, not to serial object

try
%% Function
% remember the sign of right and left
rightSign=sign(rightWheelVel);
leftSign=sign(leftWheelVel);
% conversion to absolute values and MM
rightWheelVel = abs(1000*rightWheelVel);
leftWheelVel  = abs(1000*leftWheelVel);
% checking speeds of wheels
if rightWheelVel > 500 ||  leftWheelVel > 500
    % scaling is needed
    disp('Warning: desired velocity combination exceeds limits') 
    disp('Warning: scaling for correct velocity is applied')
  	maxVel = max(rightWheelVel,leftWheelVel);
    rightWheelVel=rightSign*round(rightWheelVel/maxVel*500);
    leftWheelVel=leftSign*round(leftWheelVel/maxVel*500);
else
    % scaling is not needed
    rightWheelVel=rightSign*round(rightWheelVel);
    leftWheelVel=leftSign*round(leftWheelVel);
end

%% Send via UDP
% data to byte conversion (Big-endian) 
rightWheelVel_BHL=dataType2bytes(int16(rightWheelVel));
leftWheelVel_BHL=dataType2bytes(int16(leftWheelVel));
bytes=[145,rightWheelVel_BHL,leftWheelVel_BHL];  %[DriveDirect] [Right velocity high byte] [Right velocity low byte] [Left velocity high byte][Left velocity low byte]
% OP code + bytes to string conversion
data=bytes2str(bytes);
% send it
sendDataUDP(Roomba,data);

%% Failure
catch
    disp('WARNING:  setDriveWheels did not terminate correctly.  Output may be unreliable.')
end
