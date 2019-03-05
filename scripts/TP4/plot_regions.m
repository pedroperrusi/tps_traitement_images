function plot_regions(img, bin, label, status, idx, rows, cols )
%PLOT_REGIONS Summary of this function goes here
%   Detailed explanation goes here
    subplot(rows, cols, idx)
    imshow(img)
    title(['Pieces ', num2str(idx)])
    subplot(rows, cols, idx+1)
    imshow(bin)
    title(['Bin ', num2str(idx)])
    subplot(rows, cols, idx+2)
    imshow(label2rgb(label))
    title(['Label ', num2str(idx)])
    display_info(status);
end

function display_info(status)
    for i = 1 : length(status)
        rad_4 = round(status(i).MajorAxisLength / 4);
        text(status(i).Centroid(1)-rad_4, status(i).Centroid(2),...
            [num2str(i), ' :', num2str(estimate_radius(status(i).Area))])
    end
end

function [r] = estimate_radius(area)
    r = sqrt(area/pi);
end

