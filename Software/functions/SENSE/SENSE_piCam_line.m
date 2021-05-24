function [curve] = SENSE_piCam_line(robotCam)

    
    img = snapshotCustom(robotCam);


    img = rgb2gray(img);
    
    
    
    img = edge(img,"Canny",.5,"horizontal");
    
    img = bwareaopen(img, 100);


    [H,theta,rho] = hough(img);
    P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
    lines = houghlines(img,theta,rho,P,'FillGap',5,'MinLength',7);
    
    if isempty(lines)
        curve = generateBellCurve(30);
    else
        max_len = 0;
        
         for k = 1:length(lines)
            xy = [lines(k).point1; lines(k).point2];
            len = norm(lines(k).point1 - lines(k).point2);
           if ( len > max_len)
              max_len = len;
              xy_long = xy;
           end
        end


        if xy_long(2,1) > xy_long(1,1)
            change = xy_long(2,:) - xy_long(1,:);
        else
            change = xy_long(1,:) - xy_long(2,:);
        end

        angle = atand(-change(2)/change(1));

        disp(angle)

        %figure
        %imshow(img), hold on
        %plot(xy_long(:,1),xy_long(:,2),'LineWidth',2,'Color','red');

        % -3.8141 % center
        center_angle = -6.7;

        if abs(angle - center_angle) < 2.5
            curve = createBellCurve(30);

        elseif angle < center_angle
            angle_offset = abs(angle - center_angle);
            curve = createBellCurve(30 + angle_offset);
        else
            angle_offset = abs(angle - center_angle);
            curve = createBellCurve(30 - angle_offset);
        end
        
    end
    
        
   


end
