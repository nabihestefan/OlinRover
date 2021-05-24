function [centroids, len] = detectAprilTags(image, tagloc)
    %input image and which april tag (payload or dock)

    %display image
    I = image;
%     I = imread(image)
%     imshow(I)

    %may need to be changed for piCam
    focalLength    = [2714.3, 2714.3]; 
    principalPoint = [160, 120];
    imageSize      = [240, 320];
    intrinsics = cameraIntrinsics(focalLength,principalPoint,imageSize);

    %type of april tag
    tagFamily = ["tag36h11"];

    if 1 == strcmp(tagloc, 'payload')
        %size of april tag
        %payload dock is 0.1135 m
        TagSize = 0.1135;
    else
        %size of april tag
        %rover dock is 0.1725 m
        TagSize = 0.1725;
    end
    
    %Undistort the input image using the camera intrinsic parameters.
    I = undistortImage(I,intrinsics,"OutputView","same");

    %estimate the tag poses.
    [id,loc,pose] = readAprilTag(I,tagFamily,intrinsics,TagSize);

    %Set the origin for the axes vectors and for the tag frames.
    worldPoints = [0 0 0; TagSize/2 0 0; 0 TagSize/2 0; 0 0 TagSize/2];
    imagePoints = 0;
    %Add the tag frames and IDs to the image.
    for i = 1:length(pose)
        % Get image coordinates for axes.
        imagePoints = worldToImage(intrinsics,pose(i).Rotation, ...
                      pose(i).Translation,worldPoints);

        % Draw colored axes.
        I = insertShape(I,"Line",[imagePoints(1,:) imagePoints(2,:); ...
            imagePoints(1,:) imagePoints(3,:); imagePoints(1,:) imagePoints(4,:)], ...
            "Color",["red","green","blue"],"LineWidth",7);

        I = insertText(I,loc(1,:,i),id(i),"BoxOpacity",1,"FontSize",25);
    end
    
    %Display the annotated image.
    imshow(I)
    if imagePoints == 0
        centroids = 0;
        len = 0;
        %should do color masking here
    else
        centroids = imagePoints(1,:);

        line = imagePoints(1,:) - imagePoints(3,:);
        len = sqrt(line(1)^2 + line(2)^2);
    end
end