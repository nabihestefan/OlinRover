function [WPn] = THINK_findDock(WPn, robotCam)
    addpath functions/SENSE
    addpath functions/ACT
    % Looks for the Dock
    % calculate values of steer, velocity and pickup using SENSE
    % Center PiCam to middle pose, take image, return centroids if any
    ACT_moveCam(robotServos,90,40);
    [curveCenter, reachedCenter] = SENSE_piCam_Dock(robotCam);
    pause(1);
    % Move PiCam to max left pose, take image, return centroids if any
    ACT_moveCam(robotServos,20,40);
    [curveLeft, reachedLeft] = SENSE_piCam_Dock(robotCam);
    pause(1);
    % Move PiCam to max right pose, take image, return centroids if any
    ACT_moveCam(robotServos,160,40);
    [curveRight, reachedRight] = SENSE_piCam_Dock(robotCam);
    pause(1);
    % return piCam to centered position
    ACT_moveCam(robotServos,90,40);
    
    % Find best direction
   [valCenter,idxCenter] = max(curveCenter)
   [valLeft,idxLeft] = max(curveLeft)
   [valRight,idxRight] = max(curveRight)
   
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