function [roverX,roverY,roverHeading] = SENSE_gps(neo)
%SENSE_GPS returns GPS position and heading
% the function neo.getBasic()
% returns a struct with fields: longitude, lattitude, roll, pitch, and heading.
basic_data = neo.getBasic();
roverX = basic_data.longitude;
roverY = basic_data.lattitude;
roverHeading = basic_data.heading;
end

