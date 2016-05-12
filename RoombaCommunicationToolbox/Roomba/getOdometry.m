function [ds,dtheta] = getOdometry(Roomba,varargin)
%[ds,dtheta] = getOdometry(comPort,(v,r))
%   The function uses the odometry to approximate the relative displacement 
%   and rotation since last call of this function, or travelDist and 
%   turnAngle. Call this function regularly to avoid saturation 
%   (max distance = 32m and max rotation = 571 rad).
%   added a variable input
%   Created by Kevin Denis, KU Leuven, 2014-16
try
    %% variable input check up
    if nargin == 1 % velocity and radius needed
        [v,r]=getFwdVelRadius(Roomba);
    elseif nargin == 3 % velocity and radius given
        v=varargin{1};
        r=varargin{2};
    else % wrong inputs, doing same as varargin == 0
        disp('Wrong number of inputs, this functions expects 1 or 3 inputs')
        disp('Ignoring wrong inputs')
        [v,r]=getFwdVelRadius(Roomba);
    end

    %% Robot constants 
    b=0.235;            % wheel baseline
    circ=0.232;         % m/revolution (circumference)
    revTic=508;         %
    overflowTic=65535;  %
    ticDist=circ/revTic;%    
    maxdTic=2000;       % max tic diff between two cals == 4 rotations == 1m, should be as small as possible

    minZone=maxdTic;            %
    maxZone=overflowTic-maxdTic;%

    ds=nan;
    dtheta=nan;

    %% Global
    global sensorSkip LeftEncoderCount RightEncoderCount
    startLeftTic=LeftEncoderCount;
    startRightTic=RightEncoderCount;
    % get current encoder values
    updateEncoders(Roomba);
    endLeftTicOrg=LeftEncoderCount;
    endRightTicOrg=RightEncoderCount;
    if isnan(endLeftTicOrg) || isnan(endRightTicOrg)
        endLeftTic = startLeftTic;
        endRightTic = startRightTic;
        endLeftTicOrg = endLeftTic;
        endRightTicOrg = endRightTic;
    end
    endLeftTic=endLeftTicOrg;
    endRightTic=endRightTicOrg;

    if  (abs(startLeftTic-endLeftTic) < 10 || abs(startRightTic-endRightTic) < 10) && ~sensorSkip
        % end = start (no change can be measured when end-start < 10 (just one
        % time with sensorSkip
        ds=0;
        dtheta=0;
        LeftEncoderCount=startLeftTic;
        RightEncoderCount=startRightTic;
        sensorSkip=true;
    else
        sensorSkip = false;
        if     v >= 0 && r~=eps
            % GOING FORWARD
            % check if overflow happend between k-1 and k
            if endLeftTic < startLeftTic && endLeftTic<minZone && startLeftTic > maxZone
                endLeftTic=endLeftTic+overflowTic;
                %disp('I just overflowed left')
            end
            if endRightTic < startRightTic && endRightTic<minZone && startRightTic > maxZone
                endRightTic=endRightTic+overflowTic;
                %disp('I just overflowed right')
            end

        elseif v<0 && r~=eps
            % GOING BACKWARDS
            % check if overflow happend between k-1 and k
            if endLeftTic > startLeftTic && endLeftTic>maxZone && startLeftTic < minZone
                startLeftTic=startLeftTic+overflowTic;
                %disp('I just overflowed left')
            end
            if endRightTic > startRightTic  && endRightTic>maxZone && startRightTic < minZone
                startRightTic=startRightTic+overflowTic;
                disp('I just overflowed right')
            end

        elseif r==eps && v >= 0
            % CCW on the spot turn
            if endLeftTic > startLeftTic && endLeftTic>maxZone && startLeftTic<minZone
                startLeftTic=startLeftTic+overflowTic;
                %disp('I just overflowed left')         
            end
            if endRightTic < startRightTic && endRightTic<minZone && startRightTic>maxZone
                endRightTic=endRightTic+overflowTic;
                %disp('I just overflowed right')
            end

        elseif r==eps && v <  0
            % CW on the spot turn
            if endLeftTic < startLeftTic  && endLeftTic<minZone && startLeftTic>maxZone
                endLeftTic=endLeftTic+overflowTic;
                %disp('I just overflowed left')
            end
            if endRightTic > startRightTic  && endRightTic>maxZone && startRightTic<minZone
                startRightTic=startRightTic+overflowTic;
                %disp('I just overflowed right')
            end 
        end

    % Calculate Distance and Angle modified encoder values
    ds_left =ticDist*(endLeftTic -startLeftTic );
    ds_right=ticDist*(endRightTic-startRightTic);
    ds=     (ds_right+ds_left)/2;
    dtheta= (ds_right-ds_left)/b;
    end
catch
    disp('WARNING:  getOdometry did not terminate correctly.  Output may be unreliable.')
    LeftEncoderCount=startLeftTic;
    RightEncoderCount=startRightTic;
    ds=0;
    dtheta=0;
end
    
end