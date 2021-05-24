function [curve, reached] = SENSE_piCam_Payload(robotCam)
    addpath('masks\')
    % Initial Position 0 degrees
    piImage = snapshotCustom(robotCam);  % take one image
    
    % Mask image to look for Dock
    [payloadMask,payloadImage] = payloadMask(piImage);
    
    % Clean image and find centroids
    se = strel('disk',5);
    
    cleanPayload = imopen(payloadMask, se);
    targetPayload = regionprops(cleanPayload,'centroid');
    
    % Place coordinates into array, [0 0] if no centroid
    centroidsPayload = cat(1,targetPayload.Centroid);
    if isempty(centroidsPayload)                       % if no target found
        centroidsPayload = [0 0];                      % place centroids at the center
    end

    % Find area of centroids and place into array, if none [0 0]
    targetAreaPayload = regionprops(cleanPayload,'area');
    areasPayload = cat(1,targetAreaPayload.Area);
    if isempty(areasPayload)
       areasPayload = [0 0]; 
    end
    
    % Find biggest centroid and save coordinates
    results = zeros(1,2)
    [valPayload, idxPayload] = max(areasPayload);
        if isempty(idxPayload)
            results(1,:) = [0 0];
            curve = createBellCurve(-1);
            %reached = 0;
        else    
            results(1,:) = centroidsPayload(idxPayload,:);
            curve = createBellCurve(results(1,2)*(3/16));
            %reached = 1
        end
    
    % Do The April tag shit
    [centroid,len] = detectAprilTags(piImage, 'dock');
    
    if len >= 35
        reached = 1;
        %curve = createBellCurve(-1);
    else
        reached = 0;
        %slice_num = (60/320)*centroid;
        %curve = createBellCurve(slice_num);
    end
end