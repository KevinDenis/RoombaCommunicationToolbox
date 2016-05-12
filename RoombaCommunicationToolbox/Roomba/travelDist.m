function travelDist(Roomba, speed, distance)
% travelDist(comPort, roombaSpeed, distance)
%   Moves the Roomba the distance entered in meters. Positive distances 
%   move the Roomba foward, negative distances move the Roomba backwards.
%   speed should be between 0.025 and 0.5 m/s and positive.
%
%   Created by Kevin Denis, KU Leuven, 2014-16

%% Parameters
s=0; % set  travelled distance to 0
updateEncoders(Roomba);
setFwdVelRadius(Roomba,0, inf); % stop the Roomba

try  
    % Speed given by user shouldn't be negative
    if (speed < 0) 
        disp('WARNING: Speed inputted is negative. Should be positive. Taking the absolute value');
        speed = abs(speed);
    end
    % Speed too low
    if (abs(speed) < .025)
        disp('WARNING: Speed inputted is too low. Setting speed to minimum, .025 m/s');
        speed = .025;
    end
    % If distance is negative, put roombaSpeed negative.
    if (distance < 0)
        speed = -1 * speed;
        distance=abs(distance); % taking abs so while loop is still ok
    end
    setFwdVelRadius(Roomba, speed, inf);   
    tStart=tic;
    while s < distance
        [ds,dtheta] = getOdometry(Roomba,speed,inf);
        s=s+abs(ds);
        if dtheta > 0.1
            disp('warning, Roomba is not going straight')
        end
    end
    tFinish=toc(tStart);
    setFwdVelRadius(Roomba, 0, inf);    % stop the Roomba

    %% User Display
    if speed < 0
        dir = '-';
    else
        dir = '';
    end

    disp(['Roomba just travelled ',dir,num2str(distance,3), 'm, in ',num2str(tFinish,3),' seconds'])
    updateEncoders(Roomba); % last update of the encoders
catch ME
    disp('WARNING:  travelDist did not terminate correctly.  Output may be unreliable.')
    stopRoomba(Roomba)
    rethrow(ME)
end