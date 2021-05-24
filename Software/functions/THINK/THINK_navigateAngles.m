function [steerAngle, velocity, WPn] = THINK_navigateAngles(WPn, robotCam, adcDevice1, adcDevice2, piCamWindow, curvePlot)
    % base navigation function 
    % calculate values of steer, velocity and pickup using SENSE
    curveMove = SENSE_piCam_Waypoint(robotCam);
    

    % Calculate those same values for avoid
    curveIR = SENSE_IR(adcDevice1, adcDevice2);
    

    % Average avoid and move values for final value
    [M, indexM] = max(curveMove);
    [IR, indexIR] = max(curveIR);
    if IR == 0
       disp("No IR");
       IR = M;
       indexIR = indexM;
    end
    figure(curvePlot)
    plot(curveMove)
    hold on
    plot(curveIR)
    legend(move, "IR");
    hold off
    
    steerAngle = ((indexM)-30 + 3*((indexIR)-30))/4
    velocity = (M + 3*IR)/(8*0.0499)
    %Uncomment when testing/using docks
     WPn = WPn + 1;
end