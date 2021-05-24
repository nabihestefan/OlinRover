function [WPn] = THINK_pause(WPn, robotServos, robotCam)
   addpath functions/SENSE
   addpath functions/ACT
   % pause function for the rover to sit still and collect camera data and
   % decide what direction is the best to go in.
   
   % Center PiCam to middle pose, take image, return centroids if any
   ACT_moveCam(robotServos,90,40);
   [curveCenter] = SENSE_piCam_Waypoint(robotCam);
   pause(1);
   % Move PiCam to max left pose, take image, return centroids if any
   ACT_moveCam(robotServos,20,40);
   [curveLeft] = SENSE_piCam_Waypoint(robotCam);
   pause(1);
   % Move PiCam to max right pose, take image, return centroids if any
   ACT_moveCam(robotServos,160,40);
   [curveRight] = SENSE_piCam_Waypoint(robotCam);
   pause(1);
   % return piCam to centered position
   ACT_moveCam(robotServos,90,40);
   
   % Find best direction
   [valCenter,idxCenter] = max(curveCenter)
   [valLeft,idxLeft] = max(curveLeft)
   [valRight,idxRight] = max(curveRight)
   
   if (idxCenter ~= idxLeft && idxCenter ~= idxRight && idxLeft == idxRight) || (idxCenter == idxLeft && idxCenter == idxRight)
       ACT_moveRover(robotServos,0,0);
       
   elseif (idxLeft ~= idxCenter && idxLeft ~= idxRight) && idxCenter == idxRight
      % valLeft>valCenter && valLeft>valRight
       ACT_moveRover(robotServos,-30,.4)
       pause(1.5)
       ACT_moveRover(robotServos,0,0);
       
   elseif (idxRight ~= idxCenter && idxRight ~= idxLeft) && idxCenter == idxLeft
       ACT_moveRover(robotServos,30,.4)
       pause(1.5)
       ACT_moveRover(robotServos,0,0)
   else
       ACT_moveRover(robotServos,0,0);
   end
   
   WPn = WPn + 1;
end