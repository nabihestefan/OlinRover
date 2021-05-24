function [steerAngle, velocity, WPn] = THINK_dropPayload(WPn, roverServos)
   % Takes care of dropping the payload once we have arrived to the payload dock  
   addpath('functions/ACT/');
   ACT_movePayload(roverServos, 1);
   steerAngle = 0;
   velocity = -0.5;
   WPn = WPn - 8;
end