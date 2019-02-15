%% TP3 Ex 2 du cours de Traitement des Images
%
% author : Pedro Henrique Suruagy Perrusi
%% Initial setup
clear all; close all;
data_folder_path = '../../data/';

% charger l'image et convertissez-la en double
img = imread(strcat(data_folder_path, 'L.png'));
img_double = im2double(img);

%% Exercise 2: 
% Extract edges
img_canny = edge(img_double, 'canny', [0.05 0.13]);
img_sobel = edge(img_double, 'sobel', 0.05);
img_log = edge(img_double, 'log', 0.0038);
%% Afficher
frame_w = 4;
frame_h = 1;
figure
% plot original
subplot(frame_h,frame_w,1)
imshow(img_double,[]); hold on;
title('Original Image')
% plot canny edges
subplot(frame_h,frame_w,2)
imshow(img_canny,[]); hold on;
title('Canny Edges')
% plot sobel edges
subplot(frame_h,frame_w,3)
imshow(img_sobel,[]); hold on;
title('Sobel Edges')
% plot canny edges
subplot(frame_h,frame_w,4)
imshow(img_log,[]); hold on;
title('Log Edges')
