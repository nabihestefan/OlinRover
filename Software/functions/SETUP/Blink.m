function [] = Blink(robotPi,led, n)
  % Blink toggles Raspberry Pi LED on and off to indicate program running
  % input n is number of blinks
  % no output is returned
  % dbarrett 1/14/20
    for bIndex = 1:n
      writeLED(robotPi, led, 1);
      pause(0.1);     
      writeLED(robotPi, led, 0);
      pause(0.1);
    end
end