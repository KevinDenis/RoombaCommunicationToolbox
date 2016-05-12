function setFwdVelRadius(Roomba,FwdVel, Radius)
%SetFwdVelRadiusRoomba(comPort,FwdVel, Radius)
%  Moves Roomba by setting forward vel and turn radius.
%  FwdVel is forward vel in m/sec [-0.5, 0.5],
%  Radius in meters, postive turns left, negative turns right [-2,2].
%  Special cases: Straight = inf
%  Turn in place clockwise = -eps
%  Turn in place counter-clockwise = eps
%   By Joel Esposito, US Naval Academy, 2011
%
%   Changes by Kevin Denis, KU Leuven, 2014-16
%   * Send data over UDP, not to serial object
try
%% Function
FwdVelMM = min( max(FwdVel,-.5), .5)*1000;
if isinf(Radius)
    RadiusMM = 32768;
elseif Radius == eps
    RadiusMM = 1;
elseif Radius == -eps
    RadiusMM = -1;
else
    RadiusMM = min( max(Radius*1000,-2000), 2000);
end

%% send via UDP
% data to byte conversion (Big-endian) 
v_BHL=dataType2bytes(int16(FwdVelMM));
r_BHL=dataType2bytes(int16(RadiusMM));
bytes=[137,v_BHL,r_BHL]; %[Drive][Velocity high byte] [Velocity low byte] [Radius high byte] [Radius low byte]
% OP code + bytes to string conversion
data=bytes2str(bytes);
% send it
sendDataUDP(Roomba,data);

%% failure
catch
    disp('WARNING:  setFwdVelRadius did not terminate correctly.  Output may be unreliable.')
end

