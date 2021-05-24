function [neo] = SETUP_gps(robotPi)
%SETUP_gps sets up a GPS Class Instance called neo
neo = NEO_M8U(robotPi);            % Create a GPS Class Instance
pause(2);                          % Let GPS get up to speed
end

