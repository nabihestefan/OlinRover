function [adcDevice1, adcDevice2] = SETUP_adc(robotPi)
    adcDevice1 = ads1015(robotPi,'i2c-1','0x48');
    adcDevice2 = ads1015(robotPi,'i2c-1','0x49');
end