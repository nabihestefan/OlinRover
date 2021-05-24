function [rawAnalogRangeData] = SENSE_adc(adcDevice1, adcDevice2)
     % read all adc registers and return one raw volatge vector
     
     % create empty 1x3 array to hold 3 reads
        rawDataAvg = zeros(3,8);
        
     for j=1:3
         % Loop to collect raw volatage for each channel
         for i=1:4
            rawDataAvg(j,i) = readVoltage(adcDevice1,i-1); % adcDevice1
         end
         for k=1:4
            rawDataAvg(j,k) = readVoltage(adcDevice2,k-1); % adcDevice2
         end
     end
     rawAnalogRangeData = (rawDataAvg(1,:) + rawDataAvg(2,:) + rawDataAvg(3,:))/3;
end