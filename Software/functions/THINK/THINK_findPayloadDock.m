function [WPn] = THINK_findPayloadDock(WPn)
   addpath functions/SENSE
   addpath functions/ACT
   % pause function for the rover to sit still and collect camera data and
   % decide what direction is the best to go in.
   
   % Center PiCam to middle pose, take image, return centroids if any
   ACT_moveCam(robotServos,90,40);
   [curveCenter] = SENSE_piCam_Payload(robotCam);
   % Move PiCam to max left pose, take image, return centroids if any
   Act_moveCam(robotServos,20,40);
   [curveLeft] = SENSE_piCam_Payload(robotCam);
   % Move PiCam to max right pose, take image, return centroids if any
   ACT_moveCam(robotServos,160,40);
   [curveRight] = SENSE_piCam_Payload(robotCam);
   % return piCam to centered position
   ACT_moveCam(robotServos,90,40);
   
   % Find best direction
   [valCenter,idxCenter] = max(curveCenter);
   [valLeft,idxLeft] = max(curveLeft);
   [valRight,idxRight] = max(curveRight);
   
  if valCenter ~= 0 && (valLeft == 0 && valRight == 0)
       ACT_moveRover(robotServos,0,0);
       if reachedCenter == 1
            WPn = WPn + 1;
       else
            WPn = WPn - 1;
       end
   elseif valLeft ~= 0 && (valCenter == 0 && valRight == 0)
       ACT_moveRover(robotServos,-30,.4)
       pause(1.5)
       ACT_moveRover(robotServos,0,0);
       if reachedLeft == 1
            WPn = WPn + 1;
       else
            WPn = WPn - 1;
       end
   elseif valRight ~= 0 && (valCenter == 0 && valLeft == 0)
       ACT_moveRover(robotServos,30,.4)
       pause(1.5)
       ACT_moveRover(robotServos,0,0)
       if reachedRight == 1
            WPn = WPn + 1;
       else
            WPn = WPn - 1;
       end
   else
       ACT_moveRover(roboServos,0,0)
       WPn = WPn - 1;
   end   
end