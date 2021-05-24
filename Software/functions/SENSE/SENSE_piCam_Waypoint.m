function [curve] = SENSE_piCam_Waypoint(robotCam)
   addpath('masks\')
    % Captures an image from 3 different stationary positions and then
    % processes this data to find the desired waypoint

    % Initial Position 0 degrees
    piImage = snapshotCustom(robotCam);  % take one image
    
    % MASK PROCESSING
    [outerSunMask,outerSunImage]=sunnyOuterMask(piImage); % create mask from Border
    [centerSunMask,centerSunImage]=sunnyInnerMask(piImage); % create mask from Center
    
    [outerDarkMask,outerImage]=darkOuterMask(piImage); % create mask from Border
    [centerDarkMask,centerImage]=darkInnerMask(piImage); % create mask from Center
    
    
    % Crop off the top of the photo
    outerSunMask = outerSunMask(51:240,31:290);
    outerDarkMask = outerDarkMask(51:240,31:290);
    centerSunMask = centerSunMask(51:240,31:290);
    centerDarkMask = centerDarkMask(51:240,31:290);

     
    % Clean image of centroids with radius < 5 pixels and find centroids
    se = strel('disk',5);
    
    cleanSunOuter = imopen(outerSunMask, se);
    targetSunOuter = regionprops(cleanSunOuter,'centroid');
    %centroidsOuter = cell2mat(struct2cell(targetOuter)); 
    centroidsSunOuter = cat(1,targetSunOuter.Centroid);
    if isempty(centroidsSunOuter)                       % if no target found
        centroidsSunOuter = [121 161];                      % place centroids at the center
    end
    
    cleanDarkOuter = imopen(outerSunMask, se);
    targetDarkOuter = regionprops(cleanDarkOuter,'centroid');
    %centroidsOuter = cell2mat(struct2cell(targetOuter)); 
    centroidsDarkOuter = cat(1,targetDarkOuter.Centroid);
    if isempty(centroidsDarkOuter)                       % if no target found
        centroidsDarkOuter = [121 161];                      % place centroids at the center
    end
    
    cleanSunCenter = imopen(centerSunMask, se);
    targetSunCenter = regionprops(cleanSunCenter,'centroid');
    %centroidsCenter = cell2mat(struct2cell(targetCenter));
    centroidsSunCenter = cat(1,targetSunCenter.Centroid);
    if isempty(centroidsSunCenter)                       % if no target found
        centroidsSunCenter = [121 161];                      % place centroids at the center
    end
    
    cleanDarkCenter = imopen(centerMask, se);
    targetDarkCenter = regionprops(cleanDarkCenter,'centroid');
    %centroidsCenter = cell2mat(struct2cell(targetCenter));
    centroidsDarkCenter = cat(1,targetDarkCenter.Centroid);
    if isempty(centroidsDarkCenter)                       % if no target found
        centroidsDarkCenter = [121 161];                      % place centroids at the center
    end
    

    % Find area to determine biggest centroid
    targetSunAreaOuter = regionprops(cleanSunOuter, 'area');
    areaSunOuter = cell2mat(struct2cell(targetSunAreaOuter));
        if isempty(areaSunOuter)              %if no target found
            areaSunOuter = [0 0];                       % place centroids at 0 0
        end
    
    targetDarkAreaOuter = regionprops(cleanDarkOuter, 'area');
    areaDarkOuter = cell2mat(struct2cell(targetDarkAreaOuter));
        if isempty(areaDarkOuter)              %if no target found
            areaDarkOuter = [0 0];                       % place centroids at 0 0
        end
        
    targetSunAreaCenter = regionprops(cleanSunCenter, 'area');
    areaSunInner = cell2mat(struct2cell(targetSunAreaCenter));
        if isempty(areaSunInner)              %if no target found
            areaSunInner = [0 0];                       % place centroids at 0 0
        end
    
    targetDarkAreaCenter = regionprops(cleanDarkCenter, 'area');
    areaDarkInner = cell2mat(struct2cell(targetDarkAreaCenter));
        if isempty(areaDarkInner)              %if no target found
            areaDarkInner = [0 0];                       % place centroids at 0 0
        end
        
    %Find the biggest centroid that is closest to the center and return that coordinate
    results = zeros(1,2);
    resultsSunOut = zeros(1,2);
    resultsSunInn = zeros(1,2);
    resultsDarkOut = zeros(1,2);
    resultsDarkInn = zeros(1,2);
    
    
    [valSunOuter,idxSunOuter] = max(areaSunOuter);
        if isempty(idxSunOuter)
            resultsSunOut(1,:) = [121 161];
        else    
            resultsSunOut(1,:) = centroidsSunOuter(idxSunOuter,:);
        end
        
    [valDarkOuter,idxDarkOuter] = max(areaDarkOuter);
        if isempty(idxDarkOuter)
            resultsDarkOut(1,:) = [121 161];
        else    
            resultsDarkOut(1,:) = centroidsDarkOuter(idxDarkOuter,:);
        end

    [valSunInner,idxSunInner] = max(areaSunInner);
        if isempty(idxSunInner)
            resultsSunInn(1,:) = [121 161];
        else
            resultsSunInn(1,:) = centroidsSunCenter(idxSunInner,:);
        end   
        
    [valInner,idxDarkInner] = max(areaDarkInner);
        if isempty(idxDarkInner)
            resultsDarkInn(1,:) = [121 161];
        else
            resultsDarkInn(1,:) = centroidsDarkCenter(idxDarkInner,:);
        end 
        
    % distance from center
    distSunOuter = abs(161 - resultsSunOut(1,2)+30)
    distDarkOuter = abs(161 - resultsDarkOut(1,2)+30)
    % Determine which centroid to follow
    if abs(161 - resultsSunOut(1,2)) <= abs(161 - resultsSunInn(1,2))
        results(1,:) = resultsSunOut(1,:);
    else 
        results(1,:) = resultsSunInn(1,:);
    end
    
    %figure(piCamWindow);                         % go to camWindow for imshow           
% 	imshow(piImage,'Border','tight');
%     hold on
%     plot(results(1,1), results(1,2),'*b');
%     hold off
    %center = centroidsOuter - ((centroidsOuter + centroidsCenter)./2);
    results(1,2)
    point = (results(1,2)*(3/16));
    curve = createBellCurve(point);
    results(1,2);
    if results(1,1) == 0
        curve = createBellCurve(-1);
    end      
end