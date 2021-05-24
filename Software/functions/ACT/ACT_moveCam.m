function ACT_moveCam(roverServos,panAngle, tiltAngle)

% Input steerAngle is desired angle and velocity is desired rover velocity

% Output is motion of RC steering servo and the speed of the Rover wheels

    % scale panAngle into the bounds of the Servo
    if panAngle > 170 
        panAngle = 170;
    end
    if panAngle < 10
        panAngle = 10;
    end  
    
    %angle2pwm = @(panAngle) panAngle + 90;
    
    % convert tiltAngle to pulse duty cycle scale of 0-100
    
    %tiltPWM = angle2pwm(tiltAngle);
    
    % command servos to angle and speed
     roverServos.setServoPWM(5,panAngle);    % commands steering servo
     roverServos.setServoPWM(4,tiltAngle);
end
