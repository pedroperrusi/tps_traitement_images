%% TP3 Ex1 du cours de Traitement des Images
%
% author : Pedro Henrique Suruagy Perrusi
%% Initial setup
clear all; close all;
data_folder_path = '../../data/';

%% Exercise 1: 
% (a): charger l'image et convertissez-la en double
img = imread(strcat(data_folder_path, 'L.png'));
img_double = im2double(img);

% (e): pre filter gaussian?
img_filt = img_double;
prefilt = 1; % 1 = true; 0 = false
sigma = 3; % std deviation
if(prefilt == 1)
    img_filt = imgaussfilt(img_filt, sigma);
end

% (b): Extraire gradients
[Gmag, Gdir] = imgradient(img_filt, 'Sobel'); % default is sobel

% (c): Calculez le Laplacien
H = fspecial('laplacian');
imgL = imfilter(img_filt,H, 'replicate');

%% Affichage...
% figure gradients
frame_w = 3;
frame_h = 2;
figure
subplot(frame_h,frame_w,2)
imshow(img_filt,[]);
title('Original Image')
subplot(frame_h,frame_w,4)
imshow(Gmag,[]);
title(['G Mag'])
subplot(frame_h,frame_w,5)
imshow(Gdir,[]);
title('G Dir')
subplot(frame_h,frame_w,6)
imshow(imgL,[]);
title('Laplacian')

%% (d) afficher le profil de l'image
frame_w = 4;
frame_h = 2;
figure
% plot original
subplot(frame_h,frame_w,1)
imshow(img_filt,[]); hold on;
title('Original Image')
% get profile
[cx, cy, c] = improfile();
plot(cx, cy,'Color','r','LineWidth',2)
% plot profile
subplot(frame_h,frame_w,5)
plot(c,'Color','r','LineWidth',2)
title('Original Profile')
% plot Gradient
subplot(frame_h,frame_w,2)
imshow(Gmag,[]); hold on;
title('G mag')
% get profile
[cx, cy, c] = improfile();
plot(cx, cy,'Color','r','LineWidth',2)
% plot profile
subplot(frame_h,frame_w,6)
plot(c,'Color','r','LineWidth',2)
title('G mag profile')
% plot direction
subplot(frame_h,frame_w,3)
imshow(Gdir,[]); hold on;
title('Direction Image')
% get profile
[cx, cy, c] = improfile();
plot(cx, cy,'Color','r','LineWidth',2)
% plot profile
subplot(frame_h,frame_w,7)
plot(c,'Color','r','LineWidth',2)
title('Direction Profile')
% plot Gradient
subplot(frame_h,frame_w,4)
imshow(imgL,[]); hold on;
title('Laplacian')
% get profile
[cx, cy, c] = improfile();
plot(cx, cy,'Color','r','LineWidth',2)
% plot profile
subplot(frame_h,frame_w,8)
plot(c,'Color','r','LineWidth',2)
title('Laplacian profile')
