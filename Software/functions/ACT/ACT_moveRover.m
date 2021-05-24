 function ACT_moveRover(roverServos,steerAngle,velocity) 
% Steerangle = -35 to 35
% velocity = -1 to 1
% claw stat = 0 or 1 (close or open)
% Controls the Rover speed and angle
% Need to run SETUP_PI function first to create a Raspberry-Pi and 
% position servo objects. 
% Input steerAngle is desired angle and velocity is desired rover velocity

% Output is motion of RC steering servo and the speed of the Rover wheels

    % convert steerAngle to a pulse duty cycle scale of 0-100
    if steerAngle > 35
        steerAngle = 35;
    elseif steerAngle < -35
        steerAngle = -35;
    end
    
    angle2pwm_pos = @(steerAngle) steerAngle*40/35 + 60;
    angle2pwm_neg = @(steerAngle) steerAngle*50/35 + 60;
    
    if steerAngle >= 0
        steerPWM = angle2pwm_pos(steerAngle);
    elseif steerAngle < 0
        steerPWM = angle2pwm_neg(steerAngle);
    end
    
    % convert velocity to pulse duty cycle scale of 0-100
    if velocity > 1
        velocity = 1;
    elseif velocity < -1
        velocity = -1;
    end
    
    velocity2pwm = @(velocity) -29*(velocity) + 50;
    drivePWM = velocity2pwm(velocity);
    
    

    % command servos to angle and speed
    roverServos.setServoPWM(3,steerPWM);    % commands steering servo
    roverServos.setServoPWM(2,drivePWM);    % commands drive speed controller

end