addpath functions/SETUP/
addpath functions/ACT/

clear all
clc

[robotPi, blinkLED]= SETUP_pi("192.168.16.68");
robotServos = I2C_Servo_pHAT(robotPi);


ACT_moveRover(robotServos,0,0,0)

joy = vrjoystick(1);

disp("Drive Safely!")


while 1

    velocity = -.35*axis(joy, 2);
    angle = 35*axis(joy,1);
    tilt = 70*axis(joy,5) + 90
    pan = 70*axis(joy,3)+90;
    %ACT_moveRover(robotServos,angle,velocity,0)
    %pan = 90*button(joy,12)+90
    ACT_moveCam(robotServos,pan,tilt);
    pause(.1)

end