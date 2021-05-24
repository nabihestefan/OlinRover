function [line] = createBellCurve(point)
    % Recieves a point from 1 to 60 and creates a bell curve on that point
    % as max
    if point == -1
        line = zeros(1,60);
    else
        x = [1:60];
        sd = 8;
        line = (1/(sd * sqrt(2*pi)))*exp(-0.5*((x - point(1,1))/sd).^2);
        %plot(x, line)
    end
end