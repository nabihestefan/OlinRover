function ACT_movePayload(roverServos,payloadBool)

% Input steerAngle is desired angle and velocity is desired rover velocity

% Output is motion of RC steering servo and the speed of the Rover wheels

    % scale panAngle into the bounds of the Servo
    if payloadBool == 1 
        moveAngle = 70;
    end
    if payloadBool == 0
        moveAngle = 0;
    end  
    
    %angle2pwm = @(panAngle) panAngle + 90;
    
    % convert tiltAngle to pulse duty cycle scale of 0-100
    
    %tiltPWM = angle2pwm(tiltAngle);
    
    % command servos to angle and speed
     roverServos.setServoPWM(6,moveAngle);    % commands steering servo
     pause(.3)
     if payloadBool == 1
         roverServos.setServoPWM(6, 0);
     end
end
