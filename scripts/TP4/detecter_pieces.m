function [ dst, labels, count ] = detecter_pieces( img_rgb )
%DETECTER_PIECES Summary of this function goes here
%   Detailed explanation goes here
    img_thresh = binarize(img_rgb);
    % fill blac spots on the coins
    dst = imfill(img_thresh, 'holes');
    % apply opening
    dst = imopen(dst, strel('disk', 5));
    
    % Analyse des composants connexes en 8 points
    labels = bwlabel(dst, 8);
    
    count = 0;
end

function [img_thresh] = binarize(img_rgb)

    img_gray = rgb2gray(img_rgb);
    % Otsu threshold
    thresh = graythresh(img_gray);
    img_thresh = imbinarize(img_gray, thresh);

end

