function []= SETUP_piCam(robotCam)
    % creates and configures an Pi V2 Camera to be a simple robot 
    % vision system. It requires a standard Pi V2 cmaera attached to 
    % your Raspberry piand takes the picam object name as sole input
    % You need to set your cameras unique parameters to optimize picture
    % D. Barrett 2021 Rev A
    % Available resolutions: '160x120', '320x240', '640x480', '800x600', '1024x768', '1280x720', '1920x1080'
    % Available exposure modes: 'auto', 'night', 'nightpreview', 'backlight', 'spotlight', 'sports', 'snow', 
    % 'beach', 'verylong', 'fixedfps', 'antishake', 'fireworks'
    % Available AWB modes: 'off', 'auto', 'sun', 'cloud', 'shade', 'tungsten', 'fluorescent', 
    % 'incandescent', 'flash', 'horizon'
    % Available metering modes: 'average', 'spot', 'backlit', 'matrix'
    % Available image effects: 'none', 'negative', 'solarise', 'sketch', 'denoise', 
    % 'emboss', 'oilpaint', 'hatch', 'gpen', 'pastel', 'watercolour', 'film', 'blur', 'saturation', 'colourswap', 'washedout', 'posterise', 'colourpoint', 'colourbalance', 'cartoon'

    % Fix  exposure set it to respond quickly, set auto whitebalance to off
    robotCam.ExposureMode = 'sports';
    robotCam.AWBMode = 'fluorescent';
end