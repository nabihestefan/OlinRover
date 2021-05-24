function [sonarCurve] = SENSE_sonar(adcDevice1, adcDevice2)
    addpath functions/THINK
    % read all adc registers and and then turn the values into distance
    % array

    % Sense voltage values of ADC
    rawAdcData = SENSE_adc(adcDevice1, adcDevice2);
    sonarData = rawAdcData(6:7);
    distanceRight = -84.21*sonarData(1)^2 + 230.7*sonarData(1) - 15.39
    distanceLeft = -84.21*sonarData(2)^2 + 230.7*sonarData(2) - 15.39

    if distanceLeft <= 100
        curveLeft = createBellCurve(60-distanceLeft*.3);
    else
        curveLeft = createBellCurve(-1);
        distanceLeft = 200 - distanceRight;
    end
    
    if distanceRight <= 100
        curveRight = createBellCurve(distanceRight*0.3);
    else
        curveRight = createBellCurve(-1);
        distanceRight = 200 - distanceLeft;
    end


    % turn the distance array into a movement bell curve [1x2]
    sonarCurve = createBellCurve(((60-distanceLeft*0.3) + (distanceRight*0.3))/2);
end
