function turnAngle(Roomba, wheelSpeed, angle)
% travelDistance(comPort, roombaSpeed, angle)
%   Turns the Roomba in radiands. Positive radiands move the
%   Roomba CCW, negative angle turns the Roomba CW.
%   speed should be between 0.025 and 0.5 m/s and positive.
%   negative values in speed will be converted.
%
%   By Kevin Denis, KU Leuven, 2014-16

%% Parameters
theta=0;
updateEncoders(Roomba);
setFwdVelRadius(Roomba,0, inf);   % stop

%% Function 
% Angular speed --> translation speed (wheels)

% Speed given by user shouldn't be negative
if (wheelSpeed < 0) 
    disp('WARNING: Speed inputted is negative. Should be positive. Taking the absolute value');
    wheelSpeed = abs(wheelSpeed);
end

%Speed too low
if (abs(wheelSpeed) < .025)
    disp('WARNING: Speed inputted is too low. Setting speed to minimum, .025 m/s');
    wheelSpeed = .025;
end

%Speed too high
if (abs(wheelSpeed) > .5)
    disp('WARNING: Speed inputted is too high. Setting speed to maximum, .5 m/s');
    wheelSpeed = .5;
end

%If distance is negative, put roombaSpeed negative.
if (angle < 0)
    wheelSpeed = -1 * wheelSpeed;
    angle=abs(angle); % taking abs so while loop is still ok
end
    
setFwdVelRadius(Roomba,wheelSpeed, eps);  

i=1;
tStart=tic;
while theta < angle
    if i == 1 %diry trick for innertia...
        pause(0.1)
        updateEncoders(Roomba);
    end
    [~,dtheta] = getOdometry(Roomba,wheelSpeed,eps);
    theta=theta+abs(dtheta);
    i=i+1;
end
tFinish=toc(tStart);

setFwdVelRadius(Roomba,0, 0);    % halt the Roomba !
updateEncoders(Roomba); % last update of the encoders
%% User Display
if wheelSpeed < 0
    dir = 'CW';
else
    dir = 'CCW';
end

disp(['Roomba just turned ',num2str(angle*180/pi,3), ' degrees ', dir,' in ',num2str(tFinish,3),' seconds'])

end
