%% Deuxieme TP du cours de Traitement des Images
%
% author : Pedro Henrique Suruagy Perrusi

%% Initial setup
clear all; close all;
data_folder_path = '../data/';

%% Exercise 1: Debruitage des images

% (a): chargew limage et convertissez-la en double
img_toit = imread(strcat(data_folder_path, 'toit.jpg'));
double_img_toit = im2double(img_toit);

% appliquer de bruit sur l'image
img_length = numel(double_img_toit);
image_puissance= sum(sum(double_img_toit.^2))./img_length;
SNR = 20;
variance = 10^(-SNR/10).* image_puissance;
bruit = sqrt(variance)*randn(size(double_img_toit));
bruited_image = bruit + double_img_toit;

% bruited_image = awgn(double_img_toit, 20, 'measured');

matlab_snr = snr(double_img_toit, bruit); 

% on affiche et compare les images
image_diff = abs(bruited_image - double_img_toit );

figure
subplot(1,3,1)
imshow(double_img_toit,[]);
title('Original Image')
subplot(1,3,2)
imshow(bruited_image,[]);
title(['(SNR = ', num2str(matlab_snr), ')'])
subplot(1,3,3)
imshow(image_diff,[]);
title('Image difference')

% Call averaging filter over bruited image
figure
kernel_size = [1, 3, 5, 7];
SNR = zeros(size(kernel_size));
for i = 1:4
    h = fspecial('average',kernel_size(i));
    filt_img = imfilter(bruited_image, h);
    subplot(1,4,i)
    imshow(filt_img,[])
    title(['Avg kernel = ', num2str(kernel_size(i))])
    SNR(i) = snr(double_img_toit, filt_img-double_img_toit);
end
disp(['SNR: ', num2str(SNR)])

% Call gaussian filter
figure
sigma = [0.5, 1, 3, 5];
SNR = zeros(size(sigma));
for i = 1:4
    filt_img = imgaussfilt(bruited_image, sigma(i));
    subplot(1,4,i)
    imshow(filt_img,[])
    title(['Gaussian sigma = ', num2str(sigma(i))])
    SNR(i) = snr(double_img_toit, filt_img-double_img_toit);
end
disp(['SNR: ', num2str(SNR)])

% Call Median Filter
figure
kernel_size = [1, 3, 5, 7];
SNR = zeros(size(sigma));
for i = 1:4
    filt_img = medfilt2(bruited_image, [kernel_size(i), kernel_size(i)]);
    subplot(1,4,i)
    imshow(filt_img,[])
    title(['Median kernel = ', num2str(kernel_size(i))])
    SNR(i) = snr(double_img_toit, filt_img-double_img_toit);
end
disp(['SNR: ', num2str(SNR)])
