function [steerAngle, velocity, WPn] = THINK(WPn, roverBehavior, roverCam, roverServos, adcDevice1, adcDevice2, piCamWindow, curvePlot)
   % This function is the main THINK function taking care of 
   % Behavior = ['PauseDock______'; 'NavigationDock_'; 'FindDock_______'; 'Dock___________'; 
   % 'PauseNav_______'; 'NavPayload_____'; 'PayloadFindDock'; 'PayloadGoDock__'; 'PayloadDrop____';'PayloadFind____'; 'PayloadPickup__'];

   WPn = WPn +0;                           
  
   switch roverBehavior
       case 'PauseDock______'
           % stop and look around?
           [WPn] = THINK_pause(WPn, roverServos, roverCam);
       case 'NavigationDock_'
           % do pure pursuit to next waypoint
           [steerAngle, velocity, WPn] = THINK_navigateAngles(WPn, robotCam, adcDevice1, adcDevice2, piCamWindow, curvePlot);
%            [steerAngle, velocity, WPn] = THINK_navigate(WPn, roverCam, adcDevice1, adcDevice2, piCamWindow, curvePlot);
       case 'FindDock_______'
           % look for dock
           [WPn] = THINK_findDock(WPn, robotCam);
       case 'Dock___________'
           % drive to dock
           [steerAngle, velocity, WPn] = THINK_go2Dock(WPn, roverCam, adcDevice1, adcDevice2); 
 
       case 'PauseNav_______'
           % stop and look around
           [WPn] = THINK_pause(WPn, roverServos, roverCam);
       case 'NavPayload_____'
           % do pure pursuit to next waypoint
           [steerAngle, velocity, WPn] = THINK_navigate(WPn, roverCam, adcDevice1, adcDevice2, piCamWindow, curvePlot);
       case 'PayloadFindDock'
           % look for PayloadDock
           [WPn] = THINK_findPayloadDock(WPn);  
       case 'PayloadGoDock__'
           % drive to Payloaddock
           [steerAngle, velocity, WPn] = THINK_go2PayloadDock(WPn, roverCam); 
       case 'PayloadDrop____'
           % Drop Payload
           [steerAngle, velocity, WPn] = THINK_dropPayload(WPn, roverServos);   
       otherwise 
           % do pause behavior
           [steerAngle, velocity, WPn] = THINK_pause(WPn);
    end
end