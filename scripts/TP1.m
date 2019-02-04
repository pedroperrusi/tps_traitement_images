%% Premi?re TP du cours de Traitement des Images
%
% author : Pedro Henrique Suruagy Perrusi

%% Initial setup
clear all; close all;
data_folder_path = '../data/';

%% Exercise 1 : Visualisation d'une image

% load mandrill image (a)
img_mandrill = imread(strcat(data_folder_path, 'mandrill.jpg'));
% show image
figure;
imshow(img_mandrill)
title('Mandrill')

% convert image to grayscale (b)
gray_mandrill = rgb2gray(img_mandrill);
% show image
figure;
imshow(gray_mandrill)
title('Gray Mandrill')
% afficher les trois composants RGB de l'image
% create auxiliar zero image
zero_img = zeros(size(img_mandrill, 1), size(img_mandrill, 2)); % meme taille, mais 1 seule cha?ne
% cr?er des images 3 chaines, mais 
r_mandrill = cat(3, img_mandrill(:,:,1), zero_img, zero_img);
g_mandrill = cat(3, zero_img, img_mandrill(:,:,2), zero_img);
b_mandrill = cat(3, zero_img, zero_img, img_mandrill(:,:,3));
rgb_separe_mandrill = cat(2, r_mandrill, g_mandrill, b_mandrill);
figure;
imshow(rgb_separe_mandrill)
title('[Red, Green, Blue]')
% afficher composants de tainte, saturation et valeur (HSV) (d)
hsv_mandrill = rgb2hsv(img_mandrill);
% afficher l'image HSV
figure
imshow(hsv_mandrill)
title('Image HSV')
% separer les composants
% create auxiliar zero image
ones_img = ones(size(img_mandrill, 1), size(img_mandrill, 2)); % meme taille, mais 1 seule cha?ne
h_mandrill = hsv_mandrill(:,:,1);
s_mandrill = hsv_mandrill(:,:,2);
v_mandrill = hsv_mandrill(:,:,3);
hsv_separe_mandrill = cat(2, h_mandrill, s_mandrill, v_mandrill);
% afficher
figure
imshow(hsv_separe_mandrill)
title('[Hue, Saturation, Value]')
% convert to RGB
hue_mandrill = cat(3, h_mandrill, ones_img, ones_img);
rgb_hsv_mandrill = hsv2rgb(hue_mandrill);
figure;
imshow(rgb_hsv_mandrill)
title('HUE converted RBG')

% Representation 3D de l'image en niveau de gris (e)
img_gray_double = im2double(gray_mandrill);
[rows, cols] = size(img_gray_double);
x_axis = 0 : cols-1;
y_axis = 0 : rows-1;
figure;
mesh(x_axis, y_axis, img_gray_double)
title('3D Mandrill')
% affichez l'image en coleur fausse
figure
imshow(gray_mandrill, 'Colormap', jet);
colorbar;
title('Fausse color sur Gray Image')

% affichez l'image en nveaux de gris pour des differents plages
% d'intensit?
thresh1 = [0,1];
figure
imshow(gray_mandrill, thresh1)
title('Thresh [0, 1]')

thresh2 = [0,100];
figure
imshow(gray_mandrill, thresh2)
title('Thresh [0,100]')

thresh3 = [100,255];
figure
imshow(gray_mandrill, thresh3)
title('Thresh [100,255]')

thresh4 = [];
figure
imshow(gray_mandrill, thresh4)
title('Thresh []')

%% Exercise 2 : Histogramme et Am?lioration du Contraste
% charges ct.mat (a)
clear all;
data_folder_path = '../data/';
load(strcat(data_folder_path, 'ct.mat'));
figure
subplot(2,2,1)
imshow(img, [])
title('[]')

% afficher pour differents valeurs de seuillage
thresh1 = [0,1];
subplot(2,2,2)
imshow(img, thresh1)
title('Thresh [0, 1]')

thresh2 = [-150,250];
subplot(2,2,3)
imshow(img, thresh2)
title('Thresh [0,100]')

thresh3 = [-1400,200];
subplot(2,2,4)
imshow(img, thresh3)
title('Thresh [100,255]')

