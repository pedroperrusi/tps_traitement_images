%% Troisieme TP du cours de Traitement des Images
%
% author : Pedro Henrique Suruagy Perrusi
%% Initial setup
clear all; close all;
data_folder_path = '../data/';

%% Exercise 1: 
% (a): charger l'image et convertissez-la en double
img = imread(strcat(data_folder_path, 'L.png'));
img_double = im2double(img);

% (b): Extraire gradients
[Gmag, Gdir] = imgradient(img, 'Sobel'); % default is sobel

% (c): Calculez le Laplacien


% Affichage...
figure
subplot(1,3,1)
imshow(img_double,[]);
title('Original Image')
subplot(1,3,2)
imshow(Gmag,[]);
title(['G Mag'])
subplot(1,3,3)
imshow(Gdir,[]);
title('G Dir')