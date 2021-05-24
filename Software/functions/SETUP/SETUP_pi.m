function [robotPi, blinkLED]= SETUP_pi(address)
% SETUP_Pi creates and configures a Raspberry  Pi to be a simple robot 
% controller. It requires no inputs and returns an Pi and Servo Pi objects
% D. Barrett 2021 Rev A

% Create a global raspberry PI object so that it can be used in functions
% Create a *raspi* object.
   robotPi = raspi(address);   % note: use your Pi's IP adress here
 
% There is a user LED on Raspberry Pi hardware that you can turn on and
% off. Execute the following command at the MATLAB prompt to turn the LED
% off and then turn it on again.
%
   blinkLED = robotPi.AvailableLEDs{1};    
end