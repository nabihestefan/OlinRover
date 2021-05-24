function [steerAngle, velocity, WPn] = THINK_go2Dock(WPn, robotCam, adcDevice1, adcDevice2)
   addpath functions/SENSE
   addpath functions/ACT
   % Go to dock once its been found 
   
   % calculate values of steer, velocity and pickup using SENSE
   [curveMove, reached] = SENSE_piCam_Dock(robotCam);
   
   [dist] = SENSE_IR_Dock(adcDevice1, adcDevice2);

   [M, indexM] = max(curveMove);
   
   steerAngle = (indexM)-30;
   velocity = M*10;
   
   if dist <= 23
      steerAngle = 0;
      velocity = 0;
   elseif reached == 1
      WPn = 1;
   else
      WPn = WPn;
   end
end