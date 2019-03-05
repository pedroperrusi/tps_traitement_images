%% TP4 cours de Traitement des Images
%
% author : Pedro Henrique Suruagy Perrusi
%% Initial setup
clear all; close all;
data_folder_path = '../../data/';

%% Etape 1: Detecter les Pieces de monnaie dans les images
pieces1 = imread(strcat(data_folder_path, 'pieces1.jpg'));
pieces2 = imread(strcat(data_folder_path, 'pieces2.jpg'));
pieces3 = imread(strcat(data_folder_path, 'pieces3.jpg'));

% call detecter_pieces function
[out1, label1, count1] = detecter_pieces(pieces1);
[out2, label2, count2] = detecter_pieces(pieces2);
[out3, label3, count3] = detecter_pieces(pieces3);

% extract each piece characteristique
stat1 = regionprops(label1, 'Area', 'Centroid', 'MajorAxisLength');
stat2 = regionprops(label2, 'Area', 'Centroid', 'MajorAxisLength');
stat3 = regionprops(label3, 'Area', 'Centroid', 'MajorAxisLength');

figure
plot_regions(pieces1, out1, label1, stat1, 1, 3, 3);
plot_regions(pieces2, out2, label2, stat2, 4, 3, 3);
plot_regions(pieces3, out3, label3, stat3, 7, 3, 3);