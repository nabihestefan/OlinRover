function [IRCurve] = SENSE_IR(adcDevice1, adcDevice2)
    addpath functions/THINK
    
    
    % function to convert voltage to dist
    rawAdcData = SENSE_adc(adcDevice1, adcDevice2);
    % access sharp IR from channels 1-5
    sharpData = rawAdcData(1,1:5)
    
    sharpData(1,5) = .1;
    
    % distance function
    f = @(V) 1./(0.02029.*V-0.0005032);
    
    % convert voltage to dist
    sharpDist = f(sharpData)
    
    [dist,array] = min(sharpDist);

    % if distance is less than 20, stop immediately
    if dist < 20
        curve = createBellCurve(-1);

    % if right sensors pick up object
    elseif array < 3 && dist < 100
        % curve left
        curve = createBellCurve(3/8*dist-7.5);
    
    % if left sensors pick up object
    elseif array > 3 && dist < 100
        % curve right
        curve = createBellCurve(67.5-3/8*dist);

    % if middle sensor picks up an object
    elseif array == 3 && dist < 100
        % find out which sensor is the second closest
        [~,seccond_closest] = min(sharpDist(sharpDist>min(sharpDist)));
        % if right sensors are closer
        if seccond_closest <= 2
            % curve left
            curve = createBellCurve(3/8*dist-7.5);
        % if left sensors are closer
        elseif seccond_closest >= 3
            % curve right
            curve = createBellCurve(67.5-3/8*dist);
        end
    % if no objects are within 1m
    else
        % go straight
        curve = createBellCurve(30);
    end

    IRCurve = curve; 
end


% p1 = [sind(45)*rawDist(1)-9 cosd(45)*rawDist(1)-4];
% p2 = [sind(45/2)*rawDist(2)-5 cosd(45/2)*rawDist(2)-3];
% p3 = [0 rawDist(3)];
% p4 = [-sind(45/2)*rawDist(4)+5 cosd(45/2)*rawDist(4)-3];
% p5 = [-sind(45)*rawDist(5)+9 cosd(45)*rawDist(5)-4];
% 
% object = [p1; p2; p3; p4; p5];