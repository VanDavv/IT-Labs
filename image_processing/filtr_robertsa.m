clc
clear all; 
close all;

x1 = imread('litery_1.png'); x = rgb2gray(x1); x = double(x);
% x = [1,2,3;
%      4,5,6;
%      7,8,9];
[row,col] = size(x);
obraz = zeros(row-1,col-1);

for i = 1 : row-1
    for j = 1 : col-1
        obraz(i,j) = floor(wartosc_piksela(x,i,j)/2);
    end
end

figure(1); 
subplot(1,2,1); imshow(uint8(x)); axis equal;
subplot(1,2,2); imshow(uint8(obraz)); axis equal;

function [piksel] = wartosc_piksela(obrazek,i,j)
    piksel = abs(obrazek(i,j) - obrazek(i+1,j+1)) + abs(obrazek(i+1,j) - obrazek(i,j+1)); 
end