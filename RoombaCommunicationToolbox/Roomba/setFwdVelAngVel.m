function setFwdVelAngVel(Roomba,FwdVel,AngVel)
%setFwdVelAngVel(comPort,FwdVel,AngVel)
%  Specify forward velocity in meters/ sec [-0.5, 0.5].   
%  Specify angular velocity in rad/sec     [-4.2, 4.2].
%  Negative velocity is backward/clockwise.
%  Note that the wheel speeds are capped at .5 meters per second.  
%  So it is possible to specify speeds that cannot be acheived.
%  Warning is displayed.
%  By Joel Esposito, US Naval Academy, 2011
%
%   Changes by Kevin Denis, KU Leuven, 2014-16
%   * Addaptation for iRobot Roomba (baseline)
%   * Scaling of wheels speed if exceeding 0.5m/s
%   * Send data over UDP, not to serial object

%% Function
try
    b=0.233;  % wheel baseline
    wheelVel = inv([.5 .5; 1/b -1/b])*[FwdVel; AngVel];

    rightWheelVel = wheelVel(1);
    leftWheelVel  = wheelVel(2);

    setDriveWheels(Roomba,rightWheelVel, leftWheelVel)
catch
    disp('WARNING:  setFwdVelAngVel did not terminate correctly.  Output may be unreliable.')
end
end
