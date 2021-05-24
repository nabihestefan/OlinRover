function [steerAngle, velocity, WPn] = THINK_go2PayloadDock(WPn, robotCam)
    % Go to dock once its been found 

    % calculate values of steer, velocity and pickup using SENSE
    [curveMove, reached] = SENSE_piCam_Payload(robotCam);
    
    [dist] = SENSE_IR_Dock(adcDevice1, adcDevice2);

    [M, indexM] = max(curveMove);

    steerAngle = (indexM)-30
    velocity = 0.4;
    if M == 0
        steerAngle = 0;
        velocity = 0;
        if reached == 0
            WPn = WPn + 1;
        end
        
    end

   if dist <= 23
      steerAngle = 0;
      velocity = 0;
      WPn = WPn + 1;
   elseif reached == 1
      WPn = 1;
   else
      WPn = WPn;
   end
end