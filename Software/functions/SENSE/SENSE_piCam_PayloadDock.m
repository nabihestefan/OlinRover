function [curve, reached] = SENSE_piCam_PayloadDock(robotCam)
    addpath('masks\')
    % Initial Position 0 degrees
    piImage = snapshotCustom(robotCam);  % take one image
    
    % Mask image to look for Dock
    [dockMask,dockImage] = dockMask(piImage);
    
    % Clean image and find centroids
    se = strel('disk',5);
    
    cleanDock = imopen(dockMask, se);
    targetDock = regionprops(cleanDock,'centroid');
    
    % Place coordinates into array, [0 0] if no centroid
    centroidsDock = cat(1,targetDock.Centroid);
    if isempty(centroidsDock)                       % if no target found
        centroidsDock = [0 0];                      % place centroids at the center
    end

    % Find area of centroids and place into array, if none [0 0]
    targetAreaDock = regionprops(cleanDock,'area');
    areasDock = cat(1,targetAreaDock.Area);
    if isempty(areasDock)
       areasDock = [0 0]; 
    end
    
    % Find biggest centroid and save coordinates
    results = zeros(1,2)
    [valDock, idxDock] = max(areasDock);
        if isempty(idxDock)
            results(1,:) = [0 0];
            curve = createBellCurve(-1);
            %reached = 0;
        else    
            results(1,:) = centroidsDock(idxPayload,:);
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