function [net_angle] = SENSE_piCamBricks(robotCam)

piImage = snapshotCustom(robotCam);  % take one image

img = rgb2gray(piImage);

img = img(end-70:end,:);

img = edge(img,"Canny",.06);

img = bwareaopen(img, 100);

[H,theta,rho] = hough(img);
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
lines = houghlines(img,theta,rho,P,'FillGap',5,'MinLength',7);

length_array = zeros(length(lines),6);

for k = 1:length(lines)
    length_array(k,1) = norm(lines(k).point1 - lines(k).point2);

    angle = lines(k).point2 - lines(k).point1;

    if angle(2)/angle(1) > 0
        length_array(k,2) = 1;
    else
        length_array(k,2) = 0;
    end

    length_array(k,3:4) = lines(k).point1;
    length_array(k,5:6) = lines(k).point2;
end

    
pos_array = length_array(length_array(:,2)>0,:);
neg_array = length_array(length_array(:,2)<1,:);

[~, max_pos_idx] = max(pos_array(:,1));
[~, max_neg_idx] = max(neg_array(:,1));

xy_pos = [pos_array(max_pos_idx,3:4); pos_array(max_pos_idx,5:6)];
xy_neg = [neg_array(max_neg_idx,3:4); neg_array(max_neg_idx,5:6)];

change1 = xy_pos(2,:)-xy_pos(1,:);
angle1 = atand(change1(2)/change1(1));

change2 = xy_neg(2,:) - xy_neg(1,:);
angle2 = atand(change2(2)/change2(1));

net_angle = (angle1 + angle2)/2;

end

