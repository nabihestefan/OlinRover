function [sharpDist] = SENSE_IR_Dock(adcDevice1, adcDevice2)
    % function to convert voltage to dist
    rawAdcData = SENSE_adc(adcDevice1, adcDevice2);
    % access sharp IR from channels 1-5
    sharpData = rawAdcData(1,3);
    
    
    % distance function
    f = @(V) 1./(0.02029.*V-0.0005032);
    
    % convert voltage to dist
    sharpDist = f(sharpData);
    
end

