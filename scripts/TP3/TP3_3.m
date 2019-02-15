%% TP3 Ex 3 du cours de Traitement des Images
%
% author : Pedro Henrique Suruagy Perrusi
%% Initial setup
clear all; close all;
data_folder_path = '../../data/';

% charger l'image et convertissez-la en double
img = imread(strcat(data_folder_path, 'L.png'));
img_double = im2double(img);

%% Exercise 2: 
% Detectino de Coins
corner01 = corner(img_double, 'SensitivityFactor', 0.1);
corner001 = corner(img_double, 'SensitivityFactor', 0.01);

%% Afficher
figure
subplot(1,3,1)
imshow(img_double, []);
title('Original')
subplot(1,3,2)
imshow(img_double, []); hold on;
plot(corner01(:,1),corner01(:,2),'r*');
title('K = 0.1')
subplot(1,3,3)
imshow(img_double, []); hold on;
plot(corner001(:,1),corner001(:,2),'r*');
title('K = 0.01')

% Corner metric
figure
subplot(1,3,1)
imshow(img_double, []);
title('Original')
subplot(1,3,2)
img_corners = imadjust(cornermetric(img_double, 'SensitivityFactor', 0.1));
imshow(img_corners, [])
title('K = 0.1')
subplot(1,3,3)
img_corners = imadjust(cornermetric(img_double, 'SensitivityFactor', 0.01));
imshow(img_corners, [])
title('K = 0.01')